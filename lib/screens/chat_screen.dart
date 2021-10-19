import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat/messages.dart';
import 'package:flutter_chat_app/widgets/chat/new_messages.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions:[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButton(
              icon: const Icon(Icons.more_vert,color: Colors.white,),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app,color: Colors.red,),
                      SizedBox(width: 10,),
                      Text('Logout')
                    ],
                  ),
                )),
              ],
              onChanged: (identifier){
                if(identifier == 'logout'){
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          )
        ]
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages()
            ),
            NewMessages(),
          ],
        ),
      ), 
    );
  }
}