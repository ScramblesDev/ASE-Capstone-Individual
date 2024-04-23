import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

//this is just for the colors
class AppColors {
  static const Color mintGreen = Color(0xFF3EB489); //mmm, mint green
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: AppColors.mintGreen,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mintGreen,
          ),
        ),
      ),
      home: MainScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 70,
              width: double.infinity,
              child: Image.asset('assets/logo.png', fit: BoxFit.contain),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mintGreen,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                minimumSize: Size(150, 50),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mintGreen,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                minimumSize: Size(150, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
