import 'package:app/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(30.0),
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 167, 165, 165),
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  child: Icon(Icons.account_circle_rounded, size: 40.0),
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Welcome, Parenting Community Wall",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Join the community by entering your name below.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 10.0),
                ),
                const SizedBox(height: 20.0),

                TextField(
                  controller: Provider.of<SigninController>(
                    context,
                    listen: false,
                  ).authorName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFE0E2ED),
                    hintText: "Author name",
                    hintStyle: TextStyle(fontSize: 12.0),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                MaterialButton(
                  onPressed: () {
                    Provider.of<SigninController>(
                      context,
                      listen: false,
                    ).signin(context);
                  },
                  height: 43.0,
                  minWidth: double.infinity,
                  color: Color(0XFF3F5580),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text("Enter the Space"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
