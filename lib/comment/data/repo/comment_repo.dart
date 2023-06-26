

import 'package:addcomments/comment/data/models/comment_model.dart';

abstract class CommentRepo{
  Future <List<CommentModel>>getComment();
  Future<void>addComment(CommentModel comments);
}