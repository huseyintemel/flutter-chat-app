import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (BuildContext ctx, AsyncSnapshot futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
            builder: (BuildContext ctx, AsyncSnapshot chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = chatSnapshot.data.docs;
              return ListView.builder(
                reverse: true,
                itemCount: documents.length,
                itemBuilder: (ctx, i) {
                  return MessageBuble(
                    documents[i]['text'],
                    documents[i]['username'],
                    documents[i]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(DateTime.now().toString()),
                  );
                },
              );
            });
      },
    );
  }
}