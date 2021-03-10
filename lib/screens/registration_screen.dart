import 'package:chatty/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatty/components/buttons.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String nickname;
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
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter your nickname',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: 'Nickname *',
                      ),
                      onSaved: (String value) {
                        nickname = value;
                      },
                    ),
                    SizedBox(height: 15.0),
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
                colour: Colors.lightGreen[700],
                title: 'Register',
                onPressed: () async {
                  try {
                    _form.currentState.save();
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    final user = _auth.currentUser;
                    if (user != null) {
                      user.updateProfile(displayName: nickname).then((user) =>
                          {Navigator.pushNamed(context, ChatScreen.id)});
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
