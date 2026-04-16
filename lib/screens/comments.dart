import 'package:app/widgets/add_comment.dart';
import 'package:app/widgets/comments_card.dart';
import 'package:app/widgets/post_card.dart';
import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Parenting Community Wall",
          style: TextStyle(
            color: Color(0XFF3E547F),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 10.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          PostCard(),
          const SizedBox(height: 10.0),
          Text("Comments", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15.0),
          AddComment(),

          const SizedBox(height: 15.0),
          CommentsCard(),
          CommentsCard(),
          CommentsCard(),
          CommentsCard(),
          const SizedBox(height: 35.0),
        ],
      ),
    );
  }
}
