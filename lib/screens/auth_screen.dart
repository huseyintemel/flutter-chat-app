import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  var isLoading = false;

  void submitAuthForm(String email,String password,String username,File image,bool isLogin,BuildContext ctx) async{
    UserCredential authResult;
    try{
      setState(() {
        isLoading = true;
      });
      if(isLogin){
      authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid + '.jpg');

        await ref.putFile(image).catchError((error){
          print(error);
        });

        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
          'username' : username,
          'email' : email,
          'imageUrl' : imageUrl,
        });

      }
    }on FirebaseAuthException catch(e){
      var errorMessage = 'An error ocurred. Please check your credentials.';
      if (e.message != null) {
        errorMessage = e.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(errorMessage),backgroundColor: Theme.of(ctx).errorColor,));
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e);
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuthForm,isLoading)
    );
  }
}
