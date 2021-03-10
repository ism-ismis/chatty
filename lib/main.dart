import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:chatty/screens/welcome_screen.dart';
import 'package:chatty/screens/registration_screen.dart';
import 'package:chatty/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Chatty());
}

class Chatty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: WelcomeScreen.id, routes: {
      RegistrationScreen.id: (context) => RegistrationScreen(),
      ChatScreen.id: (context) => ChatScreen(),
      WelcomeScreen.id: (context) => WelcomeScreen()
    });
  }
}
