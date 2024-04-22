import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'firebase_options.dart'; // Import the Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// Define a class for your app's colors to organize them better
class AppColors {
  static const Color mintGreen = Color(0xFF3EB489); // Mint green color
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance App',
      theme: ThemeData(
        // Use the mint green as a primary swatch in your app's theme
        primarySwatch:
            Colors.green, // Adjust as needed or create a custom swatch
        primaryColor: AppColors.mintGreen,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                AppColors.mintGreen, // Use your custom mint color here
          ),
        ),
      ),
      home: MainScreen(),
      routes: {
        '/login': (context) =>
            LoginScreen(), // Assuming LoginScreen is in login.dart
        '/signup': (context) =>
            SignUpScreen(), // Assuming SignUpScreen is in signup.dart
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
