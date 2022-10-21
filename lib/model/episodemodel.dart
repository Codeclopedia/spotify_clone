// To parse this JSON data, do
//
//     final episodeModel = episodeModelFromJson(jsonString);

import 'dart:convert';

EpisodeModel6 episodeModelFromJson(String str) =>
    EpisodeModel6.fromJson(json.decode(str));

String episodeModelToJson(EpisodeModel6 data) => json.encode(data.toJson());

class EpisodeModel6 {
  EpisodeModel6({
    required this.href,
    required this.items,
    required this.limit,
    required this.next,
    required this.offset,
    required this.previous,
    required this.total,
  });

  String href;
  List<dynamic> items;
  int limit;
  dynamic next;
  int offset;
  dynamic previous;
  int total;

  factory EpisodeModel6.fromJson(Map<String, dynamic> json) => EpisodeModel6(
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
