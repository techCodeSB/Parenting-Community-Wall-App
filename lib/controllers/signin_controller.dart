import 'package:app/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SigninController extends ChangeNotifier {
  TextEditingController authorName = TextEditingController();
  var uuid = Uuid();

  void signin(BuildContext context) async {
    final name = authorName.text.trim();
    var id = uuid.v1();


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
    pref.setString("id", id);

    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Feed()),
    );
  }
}
