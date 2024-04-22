import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'auth.dart'; // Assuming AuthService is correctly set up and includes necessary methods
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  final String userId;

  HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<BudgetBarChartModel, String>> seriesList;
  final bool animate;

  SimpleBarChart({required this.seriesList, this.animate = false});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.StaticNumericTickProviderSpec([
          charts.TickSpec(0, label: 'Low'), // Represents 0%
          charts.TickSpec(50, label: 'Middle'), // Represents 50%
          charts.TickSpec(100, label: 'High'), // Represents 100%
        ]),
      ),
    );
  }

  static List<charts.Series<BudgetBarChartModel, String>> createData(
      List<BudgetBarChartModel> data) {
    return [
      charts.Series<BudgetBarChartModel, String>(
        id: 'Budget',
        colorFn: (_, __) => charts.Color.fromHex(code: '#3EB489'), // Mint green
        domainFn: (BudgetBarChartModel sales, _) => sales.budgetName,
        measureFn: (BudgetBarChartModel sales, _) => sales.percentage,
        data: data,
      ),
    ];
  }
}

class BudgetBarChartModel {
  final String budgetName;
  final double percentage;

  BudgetBarChartModel(this.budgetName, this.percentage);
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService =
      AuthService(); // Assuming AuthService includes necessary methods
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String insightMessage = "Loading insight...";
  int overallAmount = 0; // To hold the user's overall amount
  List<BudgetBarChartModel> budgetItems = [];

  @override
  void initState() {
    super.initState();
    updateFinancialInsight();
    fetchUserData();
    fetchBudgetItems();
  }

  Future<void> fetchUserData() async {
    final userDoc =
        await _firestore.collection('users').doc(widget.userId).get();
    if (userDoc.exists) {
      setState(() {
        overallAmount = userDoc.data()?['overall_amount'] as int? ?? 0;
        updateFinancialInsight();
      });
    }
  }

  Future<void> fetchBudgetItems() async {
    final budgetListDoc =
        await _firestore.collection('budget_lists').doc(widget.userId).get();
    if (budgetListDoc.exists) {
      final items = List<Map<String, dynamic>>.from(
          budgetListDoc.data()?['budget_items'] ?? []);
      setState(() {
        budgetItems = items.map((item) {
          int goal = item['budget_goal'];
          double percentage =
              overallAmount > 0 ? (overallAmount / goal) * 100 : 0;
          percentage =
              min(percentage, 100); // Ensure percentage does not exceed 100
          return BudgetBarChartModel(item['budget_name'], percentage);
        }).toList();
      });
    }
  }

  Future<void> updateFinancialInsight() async {
    final message = await getFinancialInsight();
    if (mounted) {
      setState(() {
        insightMessage = message;
      });
    }
  }

  Future<String> getFinancialInsight() async {
    final userDoc =
        await _firestore.collection('users').doc(widget.userId).get();
    final overallAmount = userDoc.data()?['overall_amount'] as int? ?? 0;

    final budgetListDoc =
        await _firestore.collection('budget_lists').doc(widget.userId).get();
    final budgetItems = List<Map<String, dynamic>>.from(
        budgetListDoc.data()?['budget_items'] ?? []);

    if (budgetItems.isEmpty) {
      return "No budget items found.";
    }

    final randomItem = budgetItems[Random().nextInt(budgetItems.length)];
    final budgetName = randomItem['budget_name'] as String;
    final budgetGoal = randomItem['budget_goal'] as int;
    final percentage = (overallAmount / budgetGoal) * 100;

    if (percentage >= 100) {
      return "Hey! Looks like your goal for $budgetName is met. Great job!";
    } else if (percentage >= 50) {
      return "Looks like you're getting closer to $budgetName's goal. Keep it up!";
    } else if (percentage > 0) {
      return "Heya! Looks like $budgetName's budget appears to be low.";
    } else {
      return "No progress yet towards $budgetName.";
    }
  }

  void _changeAccountAmount(BuildContext context) {
    final TextEditingController _amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Account Amount'),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(hintText: "Enter new total funds"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final newAmount = int.tryParse(_amountController.text) ?? 0;
                await _authService.updateOverallAmount(
                    widget.userId, newAmount);
                Navigator.pop(context);
                // Fetch user data and budget items again after updating the amount
                await fetchUserData(); // Updates overallAmount and calls updateFinancialInsight
                await fetchBudgetItems(); // Updates budgetItems which in turn updates the chart
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _addNewBudget(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _goalController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Budget'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Enter budget item name"),
              ),
              TextField(
                controller: _goalController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration:
                    InputDecoration(hintText: "Enter budget goal amount"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String budgetName = _nameController.text;
                int budgetGoal = int.tryParse(_goalController.text) ?? 0;
                await _authService.addBudgetItem(
                    widget.userId, budgetName, budgetGoal);
                Navigator.pop(context);
                await fetchUserData(); // Refresh overallAmount
                await fetchBudgetItems(); // Refresh budget items list and update the chart
                updateFinancialInsight(); // Optionally update insights here too
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var seriesList = SimpleBarChart.createData(budgetItems);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("\$${overallAmount}",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3EB489))),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _changeAccountAmount(context),
                  child: Text('Change Account Amount'),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF3EB489)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addNewBudget(context),
                  child: Text('Add New Budget'),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF3EB489)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(insightMessage,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3EB489))),
            SizedBox(height: 30),
            SizedBox(
              height: 250, // Adjust this value to change the chart size
              width: 350,
              child: SimpleBarChart(seriesList: seriesList, animate: true),
            ),
          ],
        ),
      ),
    );
  }
}
