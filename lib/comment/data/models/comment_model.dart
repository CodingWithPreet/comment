
// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';


class CommentModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  CommentModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
  @override
  String toString() {
    // return "Product is $title";
    return toJson().toString();
  }
}
