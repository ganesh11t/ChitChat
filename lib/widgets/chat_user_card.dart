import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/models/chat_user.dart';
import 'package:chitchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.04, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));
        },
        child: ListTile(
          // leading: CircleAvatar(child: const Icon(Icons.person),

          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
                width: mq.height * .055,
                height: mq.height * .055,
                imageUrl: widget.user.image,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                      child: const Icon(Icons.person),
                    )),
          ),
          // radius: 30,
          // backgroundImage: const NetworkImage(
          //     'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'),),

          title: Text(widget.user.name),
          subtitle: Text(widget.user.about, maxLines: 1),
          trailing: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                borderRadius: BorderRadius.circular(10)),
          ),
          // trailing: const Text(
          //   '12:00 PM',
          //   style: TextStyle(color: Colors.black54),
          // ),
        ),
      ),
    );
  }
}
