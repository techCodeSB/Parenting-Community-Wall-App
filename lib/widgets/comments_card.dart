import 'package:flutter/material.dart';

class CommentsCard extends StatefulWidget {
  final String author;
  final String text;
  const CommentsCard({super.key, required this.author, required this.text});

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(child: Icon(Icons.account_circle, size: 35.0)),
        const SizedBox(width: 10.0),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: Color(0XFFEDEDF6),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35.0),
                bottomLeft: Radius.circular(35.0),
                bottomRight: Radius.circular(35.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.author,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.text,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
