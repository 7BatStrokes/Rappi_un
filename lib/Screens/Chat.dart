import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rappi_un/Constants/AllModels.dart';
import 'package:rappi_un/Constants/FirebaseRepository.dart';

final _firestore = FirebaseFirestore.instance;
FireRepo _firerepo = FireRepo();
User user = FirebaseAuth.instance.currentUser!;
String someuser = "eUV9T7YUxDYPwabuPCxe77gaXTR2";

const kSendButtonTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

InputDecoration kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(
    color: Colors.green[900],
  ),
  border: InputBorder.none,
);

BoxDecoration kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.green, width: 2),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class Chat extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String messageText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                print(DateFormat('kk:mm').format(DateTime.now().toLocal()));
              }),
        ],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              backgroundColor: lesCols[6],
            ),
            SizedBox(width: 15),
            Text(user.displayName!),
          ],
        ),
        centerTitle: true,
        backgroundColor: lesCols[6],
      ),
      backgroundColor: lesCols[5],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore
                          .collection('users')
                          .doc(user.uid)
                          .collection("chats")
                          .doc(someuser)
                          .collection("messages")
                          .add({
                        'text': messageText,
                        'sender': user.uid,
                        'timestamp': DateTime.now().toLocal(),
                      });
                      _firestore
                          .collection('users')
                          .doc(someuser)
                          .collection("chats")
                          .doc(user.uid)
                          .collection("messages")
                          .add({
                        'text': messageText,
                        'timestamp': DateTime.now().toLocal(),
                        'sender': user.uid,
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      size: 25,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          .collection('users')
          .doc(user.uid)
          .collection('chats')
          .doc(someuser)
          .collection('messages')
          .orderBy("timestamp")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green[900],
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['text'];
          final messageSender = message['sender'];

          final currentUser = user.uid;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            time: message['timestamp'],
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.sender,
      required this.text,
      required this.isMe,
      required this.time});

  final String sender;
  final String text;
  final Timestamp time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateFormat('kk:mm').format(time.toDate()),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.green[900],
            ),
          ),
          Padding(
            padding:
                isMe ? EdgeInsets.only(left: 80) : EdgeInsets.only(right: 80),
            child: Material(
              elevation: 5,
              shadowColor: isMe ? Colors.green[900] : Colors.green,
              color: isMe ? Colors.green[900] : Colors.transparent,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Material(
                  color: isMe ? Colors.white : Colors.green,
                  borderRadius: isMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.green[900] : Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
