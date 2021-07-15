// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

List<CommentsModel> commentsModelFromJson(String str) => List<CommentsModel>.from(json.decode(str).map((x) => CommentsModel.fromJson(x)));

String commentsModelToJson(List<CommentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsModel {
    CommentsModel({
        this.albumId,
        this.id,
        this.title,
        this.url,
        this.thumbnailUrl,
    });

    int? albumId;
    int? id;
    String? title;
    String? url;
    String? thumbnailUrl;

    factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
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
}
