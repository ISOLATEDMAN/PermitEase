import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permitease/blocs/bloc/auths_bloc.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nemail = TextEditingController();
  final TextEditingController _npass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color.fromARGB(255, 235, 223, 238),
      body: SingleChildScrollView(
        child: BlocListener<AuthsBloc, AuthsState>(
          listener: (context, state) {
            if (state is AuthSucces) {
              Navigator.popAndPushNamed(context, '/profile');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 30,
                  content: Text("Successfully account created"),
                ),
              );
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  elevation: 30,
                  content: Text(state.msg),
                ),
              );
            }
          },
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/log.png',
                  width: 200,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return CircularProgressIndicator();
                  },
                ),
                const Text(
                  "Welcome👋👋👋",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _nemail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 350,
                  child: TextFormField(
                    controller: _npass,
                    obscureText: obs,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: InkWell(
                        child: obs
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onTap: () {
                          setState(() {
                            obs = !obs;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 300,
                  height: 50,
                  color: Colors.amber,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthsBloc>().add(
                            AuthCreateReq(
                              email: _nemail.text,
                              pass: _npass.text,
                            ),
                          );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?  "),
                    InkWell(
                      child: const Text(
                        "Log In",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
