// To parse this JSON data, do
//
//     final browseCategories = browseCategoriesFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison

import 'dart:convert';

BrowseCategories browseCategoriesFromJson(String str) =>
    BrowseCategories.fromJson(json.decode(str));

String browseCategoriesToJson(BrowseCategories data) =>
    json.encode(data.toJson());

class BrowseCategories {
  BrowseCategories({
    required this.categories,
  });

  Categories2 categories;

  factory BrowseCategories.fromJson(Map<String, dynamic> json) =>
      BrowseCategories(
        categories: Categories2.fromJson(json["categories"]),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories.toJson(),
      };

  factory BrowseCategories.empty() {
    return BrowseCategories(categories: Categories2.empty());
  }
}

class Categories2 {
  Categories2({
    required this.href,
    required this.items,
    required this.limit,
    required this.next,
    required this.offset,
    required this.previous,
    required this.total,
  });

  String href;
  List<Item2> items;
  int limit;
  String next;
  int offset;
  dynamic previous;
  int total;

  factory Categories2.fromJson(Map<String, dynamic> json) => Categories2(
        href: json["href"],
        items: List<Item2>.from(json["items"].map((x) => Item2.fromJson(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
      };

  factory Categories2.empty() {
    return Categories2(
        href: "",
        items: [],
        limit: 0,
        next: "",
        offset: 0,
        previous: null,
        total: 0);
  }
}

class Item2 {
  Item2({
    required this.href,
    required this.icons,
    required this.id,
    required this.name,
  });

  String href;
  List<Icon> icons;
  String id;
  String name;

  factory Item2.fromJson(Map<String, dynamic> json) => Item2(
        href: json["href"],
        icons: List<Icon>.from(json["icons"].map((x) => Icon.fromJson(x))),
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "icons": List<dynamic>.from(icons.map((x) => x.toJson())),
        "id": id,
        "name": name,
      };
  factory Item2.empty() {
    return Item2(href: "", icons: [], id: "", name: "");
  }
}

class Icon {
  Icon({
    required this.height,
    required this.url,
    required this.width,
  });

  int height;
  String url;
  int width;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        height: json["height"] ?? 0,
        url: json["url"]?? "",
        width: json["width"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? 0 : height,
        "url": url,
        "width": width == null ? 0 : width,
      };

  factory Icon.empty() {
    return Icon(height: 0, url: "", width: 0);
  }
}
