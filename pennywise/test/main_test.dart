import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pennywise/signup.dart';
import 'package:pennywise/login.dart';

void main() {
  // UI Tests for Login Screen
  group('Login Screen Tests', () {
    testWidgets('Finds Email and Password TextFields',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('Login button is found and can be tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      var loginButton = find.text('Login');
      expect(loginButton, findsOneWidget);

      // Simulate a tap and rebuild the widget
      await tester.tap(loginButton);
      await tester.pump();

      // Assume something happens after tap, like a Snackbar appears
    });

    testWidgets('Displays error message if login fails',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Simulating a failed login scenario
      await tester.tap(find.text('Login'));
      await tester.pump(); // Rebuild the widget after the state has changed

      // Assuming an error message is shown in a Snackbar
      expect(find.text('Login Failed'), findsOneWidget);
    });
  });

  // UI Tests for Signup Screen
  group('Signup Screen Tests', () {
    testWidgets('Finds Name, Email, and Password TextFields',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpScreen()));
      expect(find.byType(TextField), findsNWidgets(3));
    });

    testWidgets('Sign Up button is found and can be tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

      var signUpButton = find.text('Sign Up!');
      expect(signUpButton, findsOneWidget);

      // Simulate a tap
      await tester.tap(signUpButton);
      await tester.pump();

      // Check for any expected outcomes post-tap if there are any
    });

    testWidgets('Checks for navigation to new screen after successful sign up',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

      // Here, you might want to check if after signing up, the app navigates away from the signup screen
      // This is just a placeholder since actual navigation would depend on your app's navigation logic
      await tester.tap(find.text('Sign Up!'));
      await tester.pumpAndSettle(); // Wait for all animations and settlements

      // You can check if the current widget is no longer SignUpScreen
      // For example, assuming the navigation pushes a new route which is HomeScreen
      expect(find.byType(SignUpScreen), findsNothing);
    });
  });
}
