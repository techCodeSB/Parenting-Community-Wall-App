import 'package:app/controllers/post_controller.dart';
import 'package:app/widgets/add_post_card.dart';
import 'package:app/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostController>(context, listen: false).getPosts();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        Provider.of<PostController>(context, listen: false).getPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [IconButton(onPressed: () async {
          final SharedPreferences pref = await SharedPreferences.getInstance();
          pref.remove("id");
          pref.remove("author");

        }, icon: Icon(Icons.clear))],
      ),

      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(16), child: AddPostCard()),

          Expanded(
            child: Consumer<PostController>(
              builder: (context, controller, child) {
                return RefreshIndicator(
                  onRefresh: controller.refreshPost,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.allPost.length + 1,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < controller.allPost.length) {
                        final post = controller.allPost[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: PostCard(post: post, index: index),
                        );
                      }

                      return controller.hasMore
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox(height: 30);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
