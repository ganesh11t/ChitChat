// import 'dart:convert';
// import 'dart:developer';

import 'package:chitchat/models/chat_user.dart';
import 'package:chitchat/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart';
import '../main.dart';
import '../widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: const Text('ChitChat'),
        actions: [
          // Search user button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          // More options button
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfileScreen(user: list[0])));
            },
            icon: Icon(Icons.more_vert),
          )
        ],
      ),

      //floating action button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),

      // body
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );

            // if some or all data is loaded
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                  // modified line
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index]);
                    // return Text('name: $list');
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'No data found!',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
          }
        },
      ),
    );

    // body: StreamBuilder(
    //   stream: APIs.firestore.collection('users').snapshots(),
    //   builder: (context, snapshot) {
    //     final list = [];

    //     if (snapshot.hasData) {
    //       final data = snapshot.data?.docs;
    //       for (var i in data!) {
    //         log('Data: ${i.data()}');
    //         list.add(i.data()['name']);
    //       }
    //     }

    //     return ListView.builder(
    //         itemCount: list.length,
    //         padding: EdgeInsets.only(top: mq.height * 0.02),
    //         physics: const BouncingScrollPhysics(),
    //         itemBuilder: (context, index) {
    //           // return ChatUserCard();
    //           return Text('Name:${list[index]}');
    //         });
    //   },
    // ));
  }
}
