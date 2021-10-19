import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  final String message;
  final bool currentUser;
  final Key? key;

  MessageBuble(this.message,this.currentUser,{this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: currentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children :[
        Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
        margin: const  EdgeInsets.symmetric(vertical: 4,horizontal: 8),
        decoration : BoxDecoration(
          color: currentUser ? Colors.grey.shade300 : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: currentUser ? const Radius.circular(0) : const Radius.circular(12),
            bottomRight: currentUser ?  const Radius.circular(0) : const Radius.circular(12),
          )
        ),
        child: Text(message,style: TextStyle(color:currentUser ? Colors.black : Colors.white,fontSize: 16)),
      ), 
      ],
    );  
  }
}