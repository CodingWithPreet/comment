import 'dart:convert';

import 'package:addcomments/comment/data/models/comment_model.dart';
import 'package:addcomments/debug/app_observer.dart';

import '../repo/comment_repo.dart';
import 'package:http/http.dart' as http;

class CommentRepoImpl extends CommentRepo {
  @override
  Future<CommentModel?> addComment(CommentModel comment) async {
    String encodedComment = jsonEncode(comment.toJson());
    logger.d(encodedComment);
    var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/photos'),
        headers: {
          "content-type": "application/json"
        },
        body: encodedComment
    );
    logger.d(response.statusCode);
    if (response.statusCode == 201) {
      dynamic decodedComment = response.body;
      logger.d(decodedComment);
      return comment;
    }
    return null;
  }

  @override
  Future<List<CommentModel>> getComment() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if (response.statusCode == 200) {
      List<dynamic> decodedList = jsonDecode(response.body);
      return List<CommentModel>.from(decodedList.map((x) =>
          CommentModel.fromJson(x)));
          }else{
          return [];
          }
      }

}