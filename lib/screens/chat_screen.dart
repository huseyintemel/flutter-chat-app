import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      body: StreamBuilder(
      stream:FirebaseFirestore.instance.collection('chats/hsliijsRc1EdIqDoaxap/messages').snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot snapshotData){
        if(snapshotData.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        final documents = snapshotData.data.docs;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (ctx,i){
          return Container(
            padding: const EdgeInsets.all(8),
            child: Text(documents[i]['text']),
          );
        });
      } ,
    ), 
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: (){
        FirebaseFirestore.instance.collection('chats/hsliijsRc1EdIqDoaxap/messages').add({
          'text':'This text added by button',
        });
      },
    ),
    );
  }
}