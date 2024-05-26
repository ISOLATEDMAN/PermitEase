import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permitease/blocs/bloc/auths_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 223, 238),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: BlocListener<AuthsBloc, AuthsState>(
          listener: (context, state) {
            if(state is AuthSucces){
              Navigator.popAndPushNamed(context, '/home');
            }
            else if(state is AuthFailed){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
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
                    return const CircularProgressIndicator();
                  },
                ),
                const Text(
                  "Welcome back!!",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _pass,
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
                      print("Login button clicked!");
                      context.read<AuthsBloc>().add(AuthLoginReq(email: _email.text,pass: _pass.text));
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?  "),
                    InkWell(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/create');
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
