import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permitease/main_chat.dart';

class Chat extends StatelessWidget {
  Chat({required this.userMap, required this.chatRoomID});

  final TextEditingController _msg = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Map<String, dynamic> userMap;
  final String chatRoomID;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(userMap['name']),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseFirestore
                  .collection('chatRoom')
                  .doc(chatRoomID)
                  .collection('chats')
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map =
                        snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return Message(
                      size: size,
                      map: map,
                      currentUser: _auth.currentUser,
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: size.height / 10,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 12,
              width: size.width / 1.1,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msg,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          onSendMsg();
                        },
                        icon: Icon(Icons.send),
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: _firebaseFirestore.collection('users').doc(_auth.currentUser?.uid).get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasData && snapshot.data!['admin_stat'] == true) {
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await onDonePressed();
                                  },
                                  icon: Icon(Icons.done),
                                ),
                                IconButton(onPressed: (){
                                  onthumbsup();
                                }, icon: Icon(Icons.thumb_up_alt_sharp)),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MainChat()));
                                }, icon: Icon(Icons.chat))
                                
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSendMsg() async {
    if (_msg.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "sendBy": _auth.currentUser?.displayName,
        "message": _msg.text,
        "time": FieldValue.serverTimestamp(),
      };
      await _firebaseFirestore
          .collection('chatRoom')
          .doc(chatRoomID)
          .collection('chats')
          .add(message);
      _msg.clear();
    }
  }

  Future<void> onDonePressed() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final message = {
        "sendBy": currentUser.displayName,
        "message": "Permission is alloted ",
        "time": FieldValue.serverTimestamp(),
      };

      // Add message to chat room
      await _firebaseFirestore
          .collection('chatRoom')
          .doc(chatRoomID)
          .collection('chats')
          .add(message);

      // Add message to mainChat collection
      await _firebaseFirestore
          .collection('mainChat')
          .add(message);
    }
  }
  Future<void> onthumbsup()async{
        final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final message = {
        "sendBy": currentUser.displayName,
        "message": "Permission is alloted to student",
        "time": FieldValue.serverTimestamp(),
      };

      // Add message to chat room
      await _firebaseFirestore
          .collection('chatRoom')
          .doc(chatRoomID)
          .collection('chats')
          .add(message);

      // Add message to mainChat collection
    }
  }
}


class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.size,
    required this.map,
    required this.currentUser,
  }) : super(key: key);

  final Size size;
  final Map<String, dynamic> map;
  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      alignment: map['sendBy'] == currentUser?.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: map['sendBy'] == currentUser?.displayName
              ? Colors.blue
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            fontSize: 16,
            color: map['sendBy'] == currentUser?.displayName ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
