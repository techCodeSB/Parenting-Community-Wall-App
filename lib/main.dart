import 'package:app/controllers/post_controller.dart';
import 'package:app/controllers/signin_controller.dart';
import 'package:app/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SigninController()),
        ChangeNotifierProvider(create: (context) => PostController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Parenting Community Wall",
      home: Signin(),
    );
  }
}
