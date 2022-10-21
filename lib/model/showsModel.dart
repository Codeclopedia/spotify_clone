// To parse this JSON data, do
//
//     final tracksModel = tracksModelFromJson(jsonString);

import 'dart:convert';

TracksModel tracksModelFromJson(String str) =>
    TracksModel.fromJson(json.decode(str));

String tracksModelToJson(TracksModel data) => json.encode(data.toJson());

class TracksModel {
  TracksModel({
    required this.href,
    required this.items,
    required this.limit,
    this.next,
    required this.offset,
    this.previous,
    required this.total,
  });

  String href;
  List<dynamic> items;
  int limit;
  dynamic next;
  int offset;
  dynamic previous;
  int total;

  factory TracksModel.fromJson(Map<String, dynamic> json) => TracksModel(
        href: json["href"],
        items: List<dynamic>.from(json["items"].map((x) => x)),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "items": List<dynamic>.from(items.map((x) => x)),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
      };
}
