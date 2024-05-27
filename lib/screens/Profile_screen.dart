import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permitease/blocs/bloc/profile_store_bloc.dart';

class Profiless extends StatefulWidget {
  const Profiless({super.key});

  @override
  State<Profiless> createState() => _ProfilessState();
}

class _ProfilessState extends State<Profiless> {
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  String? _profileImageUrl;
  final ImagePicker _picker = ImagePicker();
  late bool _isadmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 223, 238),
        body: BlocListener<ProfileStoreBloc, ProfileStoreState>(
          listener: (context, state) {
            if(state is ProfilecreateSuccess){
              Navigator.popAndPushNamed(context, '/home');
            }
            else if(state is ProfilecreateFailed){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
            }
          },
          child: SingleChildScrollView(
              child: Center(
                  child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 110,
                ),
                Text("Add Ur Profile", style: TextStyle(fontSize: 30)),
                SizedBox(
                  height: 30,
                ),
                _profileImageUrl == null
                    ? CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.person),
                        radius: 100,
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(_profileImageUrl!),
                      ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone",
                        prefixIcon: Icon(Icons.phone)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email)),
                  ),
                ),
                CheckboxListTile(
                  title: Text('Are u Admin ??'),
                  value: _isadmin,
                  onChanged: (bool? value) {
                    setState(() {
                      _isadmin = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<ProfileStoreBloc>().add(ProfileAdd(
                      name: _username.text,
                      phno: _phone.text,
                      email: _email.text,
                      admin_stat: _isadmin
                      ));
                    },
                    child: Text("Submit")),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "- Make sure to add the profile picture",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20),
                ),
                Text("- Pass the Name",
                    textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),
                Text("- And Pass the Email too...",
                    textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),
              ],
            ),
          ))),
        ));
  }
}
