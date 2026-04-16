import 'package:app/widgets/add_post_card.dart';
import 'package:app/widgets/post_card.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          AddPostCard(),
          const SizedBox(height: 20.0),
          PostCard(),
          PostCard(),
          PostCard(),
          PostCard(),
          const SizedBox(height: 30.0,)
        ],
      ),
    );
  }
}
