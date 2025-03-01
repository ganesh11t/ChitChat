import 'package:chitchat/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // For accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static ChatUser me = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I'm using We Chat!",
      image: user.photoURL.toString(),
      createdAt: '',
      isOnline: false,
      lastActive: '',
      pushToken: '');

  // To return current user
  static User get user => auth.currentUser!;

  // For checking if user exists or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for getting current users info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        log('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: 'Hey there! I am using ChitChat',
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

// for getting all users firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

//       List<String> userIds) {
//     log('\nUserIds: $userIds');

//     return firestore
//         .collection('users')
//         .where('id',
//             whereIn: userIds.isEmpty
//                 ? ['']
//                 : userIds) //because empty list throws an error
//         // .where('id', isNotEqualTo: user.uid)
//         .snapshots();
//   }
}
