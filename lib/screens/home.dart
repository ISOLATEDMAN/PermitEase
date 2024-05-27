import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permitease/screens/chat_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  Map<String, dynamic>? userMap;
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 223, 238),
      body: isLoading
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  CircularProgressIndicator(),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text("Stop"))
                ]))
          : Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 350,
                    height: 45,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            onSearch();
                          },
                          child: Icon(Icons.search, size: 25),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                userMap != null
                    ? ListTile(
                      onTap: () {
                        User? currentUser = _auth.currentUser;
                        if (currentUser != null && currentUser.displayName != null) {
                          String roomId = ChatroomId(currentUser.displayName!, userMap!['name']);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat(userMap: userMap!, chatRoomID: roomId)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("User display name is not set."),
                          ));
                        }
                      },
                      leading: Icon(Icons.person),
                      title: Text(userMap!['name']),
                      subtitle: Text(userMap!['email']),
                      trailing: Icon(Icons.chat),
                    )
                    : Container(),
              ],
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){
              
            },child: Icon(Icons.logout),),
    );
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      await _firestore
          .collection('users')
          .where('email', isEqualTo: _search.text)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          setState(() {
            userMap = value.docs[0].data();
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("No user found with this email"),
          ));
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $e"),
      ));
    }
  }

  String ChatroomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2[0].toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
}
