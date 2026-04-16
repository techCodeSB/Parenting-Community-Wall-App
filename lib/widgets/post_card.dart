import 'package:app/controllers/post_controller.dart';
import 'package:app/screens/comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  final Map post;
  final int index;

  const PostCard({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<PostController>(context, listen: false);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Color.fromARGB(255, 225, 225, 225), blurRadius: 5.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                maxRadius: 15.0,
                child: Icon(Icons.account_circle, size: 25.0),
              ),
              const SizedBox(width: 5.0),
              Text(
                post['author'] ?? "Unknown",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),
          Text(post['msg'] ?? "", style: const TextStyle(fontSize: 14.0)),

          const SizedBox(height: 20.0),

          const Divider(
            color: Color.fromARGB(255, 225, 224, 224),
            thickness: 1,
            height: 5,
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<PostController>(
                    context,
                    listen: false,
                  ).toggleLike(index);
                },
                icon: Icon(
                  (post['likedUsers'] ?? []).contains(controller.id) || post['isLiked'] == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:  (post['likedUsers'] ?? []).contains(controller.id) || post['isLiked'] == true ? Colors.red : Colors.black,
                ),
              ),

              Text("${post['like'] ?? 0}"),

              const SizedBox(width: 20.0),

              IconButton(
                onPressed: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Comments(postId: post['_id'],)),
                  );

                  Provider.of<PostController>(context, listen: false).refreshPost();
                },
                icon: const Icon(Icons.chat_bubble_outline),
              ),
              Text("${post['comments']?.length ?? 0}"),
            ],
          ),
        ],
      ),
    );
  }
}
