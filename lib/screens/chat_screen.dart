import 'package:chatty/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();
    loggedInUser = _auth.currentUser;
  }

  void addEmojiToStream(String emoji) {
    print(emoji);
    _firestore.collection('messages').add({
      'text': emoji,
      'sender': loggedInUser.displayName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
        centerTitle: true,
        title: Text(
          'Chatty',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 30.0,
            color: Colors.teal[900],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MessagesStream(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (String value) {
                            messageText = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Type your message here',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.teal[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          _firestore.collection('messages').add({
                            'text': messageText,
                            'sender': loggedInUser.displayName,
                            'timestamp': FieldValue.serverTimestamp(),
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      child: Text(
                        '😊',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      onPressed: () {
                        _firestore.collection('messages').add(
                          {
                            'text': '😊',
                            'sender': loggedInUser.displayName,
                            'timestamp': FieldValue.serverTimestamp(),
                          },
                        );
                      },
                    ),
                    FlatButton(
                      child: Text(
                        '😭',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      onPressed: () {
                        _firestore.collection('messages').add(
                          {
                            'text': '😭',
                            'sender': loggedInUser.displayName,
                            'timestamp': FieldValue.serverTimestamp(),
                          },
                        );
                      },
                    ),
                    FlatButton(
                      child: Text(
                        '🥺',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      onPressed: () {
                        _firestore.collection('messages').add(
                          {
                            'text': '🥺',
                            'sender': loggedInUser.displayName,
                            'timestamp': FieldValue.serverTimestamp(),
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final messages = snapshot.data.docs;
        List<MessageFigure> messageFigures = [];
        for (var eachInfo in messages) {
          final messageText = eachInfo.data()['text'];
          final messageSender = eachInfo.data()['sender'];
          final currentUser = loggedInUser.displayName;
          print(messageText);
          final messageFigure = MessageFigure(
            sender: messageSender,
            text: messageText,
            isMe: (messageSender == currentUser),
          );
          messageFigures.add(messageFigure);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.all(10.0),
            children: messageFigures,
          ),
        );
      },
    );
  }
}

class MessageFigure extends StatelessWidget {
  MessageFigure({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(sender),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: (text == '😊' || text == '😭' || text == '🥺')
                      ? 32.0
                      : 16.0,
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (text == '😊' || text == '😭' || text == '🥺')
                  ? Colors.lightGreen[100]
                  : (isMe ? Colors.teal[600] : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
