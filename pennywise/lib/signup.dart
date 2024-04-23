import 'package:flutter/material.dart';
import 'auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _name;
  final AuthService _authService = AuthService();

  void _trySubmitForm() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();
      try {
        final user = await _authService.signUpWithEmailAndPassword(
            _email!, _password!, _name!);
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Please enter at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _trySubmitForm,
                    child: Text('Sign Up!'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
