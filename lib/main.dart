import 'package:buts_conductor_app/Controller/provider.dart';
import 'package:buts_conductor_app/View/home.dart';
import 'package:buts_conductor_app/View/scanner.dart';
import 'package:buts_conductor_app/View/session.dart';
import 'package:buts_conductor_app/View/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'UniGo',
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: SignInScreen(),
      ),
    );
  }
}

