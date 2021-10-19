import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot chatSnapshot){
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        final documents = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx,i){
            return Text(documents[i]['text']);
          },
        );
      },
    );
  }
}