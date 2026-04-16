import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends ChangeNotifier {
  String authorName = "";
  TextEditingController newPost = TextEditingController();


  void get() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    authorName = pref.getString("author")!;
    authorName = authorName.split(" ")[0];

    notifyListeners();
  }

  void addPost(BuildContext context) async {
    final post = newPost.text.trim();

    if (post.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter message"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();


     print(post);
  }


  

 
}
