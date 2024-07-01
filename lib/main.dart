import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permitease/auth_pages/auth_page.dart';
import 'package:permitease/auth_pages/login.dart';
import 'package:permitease/auth_pages/signup.dart';
import 'package:permitease/blocs/bloc/auths_bloc.dart';
import 'package:permitease/blocs/bloc/profile_store_bloc.dart';
import 'package:permitease/main_chat.dart';
import 'package:permitease/screens/Profile_screen.dart';
import 'package:permitease/screens/chat_page.dart';
import 'package:permitease/screens/home.dart';
import 'package:permitease/screens/onboarding.dart';
import 'package:permitease/screens/start_page.dart';
import 'package:permitease/utils/auth_repo.dart';
import 'package:permitease/utils/profile_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthsBloc(authRepo: AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ProfileStoreBloc(profile_store: ProfileStore()),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/auth': (context) => const Auth(),
          '/onboard': (context) => const Onboarding(),
          '/login': (context) => const Login(),
          '/create': (context) => const Signup(),
          '/home': (context) => const Home(),
          '/profile':(context)=>const Profiless(),
          '/mainchat':(context)=>const MainChat(),
          
        },
        home: const Start(),
      ),
    );
  }
}
