import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/utils/constants.dart';

class PostController extends ChangeNotifier {
  TextEditingController newPost = TextEditingController();
  TextEditingController newComment = TextEditingController();

  String authorName = "";
  String id = "";
  List<dynamic> allPost = [];
  Map<String, dynamic>? singlePost; //Single post for comment screen

  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  void get() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    authorName = pref.getString("author")!;
    id = pref.getString("id")!;
    authorName = authorName.split(" ")[0];

    notifyListeners();
  }

  Future<void> getPosts() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse("${Constant.apiUrl}/posts?page=$page&limit=10");
      final res = await http.get(url);
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        List newPosts = data['data'];

        if (newPosts.isEmpty) {
          hasMore = false;
        } else {
          allPost.addAll(newPosts);
          page++;

          if (newPosts.length < 10) {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getSinglePost(String postId) async {
    try {
      final url = Uri.parse("${Constant.apiUrl}/posts/$postId");
      final res = await http.get(url);
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        singlePost = data['data'];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> refreshPost() async {
    allPost.clear();
    page = 1;
    hasMore = true;
    await getPosts();
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

    try {
      final Map<String, String> data = {
        "author": authorName,
        "msg": newPost.text.trim(),
      };
      final Uri url = Uri.parse("${Constant.apiUrl}/posts");

      final req = await http.post(
        url,
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      final res = jsonDecode(req.body);

      if (req.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['err']),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
          ),
        );

        return;
      }

      allPost.insert(0, res['data']);
      notifyListeners();
      newPost.text = "";
    } catch (er) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> toggleLike(int index) async {
    final post = allPost[index];
    final bool liked = post['isLiked'] ?? false;

    post['isLiked'] = !liked;
    post['likedUsers'] ??= [];

    if (post['likedUsers'].contains(id)) {
      post['likedUsers'].remove(id);
      post['like'] = (post['like'] ?? 0) - 1;
    } else {
      post['likedUsers'].add(id);
      post['like'] = (post['like'] ?? 0) + 1;
    }
    notifyListeners();

    try {
      final Uri url = Uri.parse("${Constant.apiUrl}/posts/likes");

      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"postId": post['_id'], "userId": id}),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        throw Exception("Failed");
      }

      post['isLiked'] = data['liked'];
    } catch (e) {
      post['isLiked'] = liked;
      post['like'] = (post['like'] ?? 0) + (liked ? 1 : -1);
    }

    notifyListeners();
  }

  Future<void> addComment(String postId, BuildContext context) async {
    final text = newComment.text.trim();
    if (text.isEmpty) return;

    if (singlePost != null) {
      singlePost!['comments'] ??= [];

      singlePost!['comments'].insert(0, {
        "author": authorName,
        "text": text,
        "createdAt": DateTime.now().toString(),
      });

      notifyListeners();
    }

    newComment.text = "";

    try {
      final url = Uri.parse("${Constant.apiUrl}/posts/comment");

      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "postId": postId,
          "text": text,
          "author": authorName,
        }),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        throw Exception(data['err'] ?? "Failed");
      }
    } catch (e) {
      if (singlePost != null && singlePost!['comments'] != null) {
        singlePost!['comments'].removeAt(0);
        notifyListeners();
      }
    }
  }
}
