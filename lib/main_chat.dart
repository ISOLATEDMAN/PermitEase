import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainChat extends StatefulWidget {
  const MainChat({super.key});

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseFirestore.collection('mainChat').orderBy('time', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet"));
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return MessageTile(map: map);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.map}) : super(key: key);

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(map['sendBy'][0]), // Display the first letter of the sender's name
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  map['sendBy'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  map['message'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  map['time'] != null
                      ? (map['time'] as Timestamp).toDate().toString()
                      : 'Time not available',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
