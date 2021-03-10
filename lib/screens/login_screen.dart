import 'package:flutter/material.dart';
import 'package:chatty/components/buttons.dart';
import 'package:chatty/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chatty',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 70.0,
                  color: Colors.teal[900],
                ),
              ),
              SizedBox(height: 50.0),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelText: 'Email *',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@')
                      ? null
                      : 'You need contain @ char.';
                },
              ),
              SizedBox(height: 15.0),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelText: 'Password *',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 30.0),
              ToolsButton(
                colour: Colors.lightGreen,
                title: 'Log In',
                onPressed: () {
                  Navigator.pushNamed(context, ChatScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
