import 'package:chatty/components/buttons.dart';
import 'package:chatty/screens/chat_screen.dart';
import 'package:chatty/screens/registration_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  final _form = GlobalKey<FormState>();

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
              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Email *',
                      ),
                      onSaved: (String value) {
                        email = value;
                      },
                      validator: (String value) {
                        return value.contains('@')
                            ? null
                            : 'You need contain @ char.';
                      },
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        hintText: 'Enter your password',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Password *',
                      ),
                      onSaved: (String value) {
                        password = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              ToolsButton(
                colour: Colors.lightGreen,
                title: 'Log In',
                onPressed: () async {
                  try {
                    _form.currentState.save();
                    print(email);
                    print(password);
                    await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    final user = _auth.currentUser;
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(height: 60.0),
              ToolsButton(
                colour: Colors.lightGreen[700],
                title: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
