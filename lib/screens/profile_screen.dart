import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/helper/dialogs.dart';
import 'package:chitchat/main.dart';
import 'package:chitchat/models/chat_user.dart';
import 'package:chitchat/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/apis.dart';

// Profile screen -- to show sign in user information
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // app bar
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),

        //floating action button to add new user
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            onPressed: () async {
              // for showing progress dialog
              Dialogs.showProgressbar(context);

              // sign out from app
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  // for hiding progress dialog
                  Navigator.pop(context);
                  // for going back to login screen
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              });
            },
            icon: const Icon(Icons.logout),
            // label: Text('Logout'),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        // body
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
          child: Column(
            children: [
              // for adding space
              SizedBox(width: mq.width, height: mq.height * .03),
              // user profile picture
              Stack(
                children: [
                  // profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                        width: mq.height * .2,
                        height: mq.height * .2,
                        fit: BoxFit.fill,
                        imageUrl: widget.user.image,
                        errorWidget: (context, url, error) => CircleAvatar(
                              child: const Icon(Icons.person),
                            )),
                  ),
                  // edit button
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      elevation: 1,
                      onPressed: () {},
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: Icon(Icons.edit, color: Colors.blue),
                    ),
                  )
                ],
              ),

              // for adding space
              SizedBox(height: mq.height * .03),

              Text(widget.user.email,
                  style: TextStyle(color: Colors.black54, fontSize: 16)),

              // for adding space
              SizedBox(height: mq.height * .05),

              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.person, color: Colors.purple.shade700),
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              // for adding space
              SizedBox(height: mq.height * .02),

              TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.info_outline, color: Colors.purple.shade700),
                    labelText: 'About',
                    hintText: 'eg: Feeling Happy',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              // for adding space
              SizedBox(height: mq.height * .05),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: Size(mq.width * .4, mq.height * .06)),
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 26,
                ),
                label: Text(
                  'UPDATE',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}

// leading: CircleAvatar(child: const Icon(Icons.person),
