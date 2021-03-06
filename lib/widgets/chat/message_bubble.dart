import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {
  final String message;
  final String username;
  final String imageUrl;
  final bool currentUser;
  final Key? key;

  MessageBuble(this.message, this.username, this.imageUrl, this.currentUser,{this.key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              currentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                  color: currentUser
                      ? Colors.grey.shade300
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: currentUser
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomRight: currentUser
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  )),
              child: Column(
                  crossAxisAlignment: currentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: currentUser ? Colors.black : Colors.white),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          color: currentUser ? Colors.black : Colors.white,
                          fontSize: 16),
                      textAlign: currentUser ? TextAlign.end : TextAlign.start,
                    ),
                  ]),
            ),
          ],
        ),
        Positioned(
          top : 0,
          left: currentUser ? null : 158,
          right: currentUser ? 158 : null,
          child: CircleAvatar(backgroundImage:NetworkImage(imageUrl)),
        )
      ],
      clipBehavior: Clip.none,
    );
  }
}
