import 'package:app/screens/comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 225, 225, 225),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 15.0,
                child: Icon(Icons.account_circle, size: 25.0),
              ),
              const SizedBox(width: 5.0),
              Text(
                "Sourav Bishai",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Feed Message
          Text(
            "Creativity is the natural extension of our enthusiasm.\" — A little reminder for everyone starting their weekend projects!",
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 20.0),
          Divider(
            color: const Color.fromARGB(255, 225, 224, 224),
            thickness: 1,
            height: 5,
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
              Text("50"),

              const SizedBox(width: 20.0),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Comments()),
                  );
                },
                icon: Icon(Icons.chat_bubble_outline),
              ),
              Text("50"),
            ],
          ),
        ],
      ),
    );
  }
}
