import 'package:app/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends ChangeNotifier {
  TextEditingController authorName = TextEditingController();

  void signin(BuildContext context) async {
    final name = authorName.text.trim();

    if (name.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Author name is required"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("author", name);

    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Feed()),
    );
  }
}
