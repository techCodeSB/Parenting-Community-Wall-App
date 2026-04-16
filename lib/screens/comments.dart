import 'package:app/controllers/post_controller.dart';
import 'package:app/widgets/add_comment.dart';
import 'package:app/widgets/comments_card.dart';
import 'package:app/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final String postId;

  const Comments({super.key, required this.postId});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<PostController>(
        context,
        listen: false,
      ).getSinglePost(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text(
          "Parenting Community Wall",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFF3F5580),
          ),
        ),
        centerTitle: true,
        elevation: 5.0,
      ),

      body: Consumer<PostController>(
        builder: (context, controller, child) {
          final post = controller.singlePost;

          if (post == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final comments = post['comments'] ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔥 POST
                  PostCard(post: post, index: 0),

                  const SizedBox(height: 15),

                  const Text(
                    "Comments",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  // 🔥 INPUT (normal position, NOT bottom fixed)
                  AddComment(postId: widget.postId),

                  const SizedBox(height: 10),

                  // 🔥 COMMENTS LIST (inside scroll)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];

                      return CommentsCard(
                        author: comment['author'],
                        text: comment['text'],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
