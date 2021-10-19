import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {

  Future<void> getInfo() async{
     await Firebase.initializeApp();
      FirebaseFirestore.instance.collection('chats/hsliijsRc1EdIqDoaxap/messages').snapshots().listen((data) {
        data.docs.forEach((document) {
          print(document['text']);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
      itemCount: 2,
      itemBuilder: (ctx,i){
      return Container(
        padding: const EdgeInsets.all(8),
        child: const Text('Chat Screen'),
      );
    }),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: (){
       getInfo();
      },
    ),
    );
  }
}