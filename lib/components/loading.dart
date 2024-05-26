import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permitease/blocs/bloc/auths_bloc.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthsBloc, AuthsState>(
        builder: (context, state) {
          if(state is AuthSucces){
            Navigator.popAndPushNamed(context, '/home');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
