import 'package:app/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddComment extends StatefulWidget {
  final String postId;
  const AddComment({super.key, required this.postId});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostController>(context, listen: false).get();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostController>(context, listen: false);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 226, 225, 225),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(child: Icon(Icons.account_circle, size: 35.0)),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                  controller: provider.newComment,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFE0E2ED),
                    hintText: "Share your thoughts...",
                    hintStyle: TextStyle(fontSize: 12.0),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5.0),
          Align(
            alignment: AlignmentGeometry.topEnd,
            child: MaterialButton(
              onPressed: () {
                provider.addComment(widget.postId, context);
              },
              height: 40.0,
              color: Color(0XFF3F5580),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text("Comment"),
            ),
          ),
        ],
      ),
    );
  }
}
