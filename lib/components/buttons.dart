import 'package:chatty/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ToolsButton extends StatelessWidget {
  ToolsButton({this.colour, this.title, this.onPressed});
  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: RaisedButton(
        color: colour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: onPressed,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            )),
      ),
    );
  }
}

class EmojiButton extends StatelessWidget {
  EmojiButton({this.emoji, this.emojiCB});

  final String emoji;
  final Function emojiCB;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        emoji,
        style: TextStyle(fontSize: 30.0),
      ),
      onPressed: emojiCB,
    );
  }
}
