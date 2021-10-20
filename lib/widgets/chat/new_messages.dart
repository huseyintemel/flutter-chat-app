import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var enteredMessage = '';
  final controller = TextEditingController();

  void sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text' : enteredMessage,
      'createdAt' : Timestamp.now(),
      'userId': user.uid,
      'username' : userData['username'],
      'userImage' : userData['imageUrl'],
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration : const InputDecoration(labelText:'Send a message...'),
              onChanged: (value){
                setState(() {
                  enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(icon:const Icon(Icons.send,color: Colors.blue,),onPressed: enteredMessage.trim().isEmpty ? null : sendMessage,)
        ],
      ),
    );
  }
}