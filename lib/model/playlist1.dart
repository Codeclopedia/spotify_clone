// To parse this JSON data, do
//
//     final playlists = playlistsFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

Playlists playlistsFromJson(String str) => Playlists.fromJson(json.decode(str));

String playlistsToJson(Playlists data) => json.encode(data.toJson());

class Playlists {
  Playlists({
    required this.message,
    required this.playlists,
  });

  String message;
  PlaylistsClass playlists;

  factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
        message: json["message"],
        playlists: PlaylistsClass.fromJson(json["playlists"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "playlists": playlists.toJson(),
      };
}

class PlaylistsClass {
  PlaylistsClass({
    required this.href,
    required this.items,
    required this.limit,
    required this.next,
    required this.offset,
    required this.previous,
    required this.total,
  });

  String href;
  List<Item4> items;
  int limit;
  dynamic next;
  int offset;
  dynamic previous;
  int total;

  factory PlaylistsClass.fromJson(Map<String, dynamic> json) => PlaylistsClass(
        href: json["href"],
        items: List<Item4>.from(json["items"].map((x) => Item4.fromJson(x))),
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
}

class Item4 {
  Item4({
    required this.collaborative,
    required this.description,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.owner,
    required this.primaryColor,
    required this.public,
    required this.snapshotId,
    required this.tracks,
    required this.type,
    required this.uri,
  });

  bool collaborative;
  String description;
  ExternalUrls externalUrls;
  String href;
  String id;
  List<Image> images;
  String name;
  Owner owner;
  dynamic primaryColor;
  dynamic public;
  String snapshotId;
  Tracks tracks;
  ItemType? type;
  String uri;

  factory Item4.fromJson(Map<String, dynamic> json) => Item4(
        collaborative: json["collaborative"],
        description: json["description"],
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
        primaryColor: json["primary_color"],
        public: json["public"],
        snapshotId: json["snapshot_id"],
        tracks: Tracks.fromJson(json["tracks"]),
        type: itemTypeValues.map[json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "collaborative": collaborative,
        "description": description,
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "owner": owner.toJson(),
        "primary_color": primaryColor,
        "public": public,
        "snapshot_id": snapshotId,
        "tracks": tracks.toJson(),
        "type": itemTypeValues.reverse[type],
        "uri": uri,
      };
}

class ExternalUrls {
  ExternalUrls({
    required this.spotify,
  });

  String spotify;

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
      );

  Map<String, dynamic> toJson() => {
        "spotify": spotify,
      };
}

class Image {
  Image({
    this.height,
    required this.url,
    this.width,
  });

  dynamic height;
  String url;
  dynamic width;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
      };
}

class Owner {
  Owner({
    required this.displayName,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.type,
    required this.uri,
  });

  DisplayName? displayName;
  ExternalUrls externalUrls;
  String href;
  Id? id;
  OwnerType? type;
  Uri1? uri;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        displayName: displayNameValues.map[json["display_name"]],
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: idValues.map[json["id"]],
        type: ownerTypeValues.map[json["type"]],
        uri: uriValues.map[json["uri"]],
      );

  Map<String, dynamic> toJson() => {
        "display_name": displayNameValues.reverse[displayName],
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": idValues.reverse[id],
        "type": ownerTypeValues.reverse[type],
        "uri": uriValues.reverse[uri],
      };
}

enum DisplayName { SPOTIFY }

final displayNameValues = EnumValues({"Spotify": DisplayName.SPOTIFY});

enum Id { SPOTIFY }

final idValues = EnumValues({"spotify": Id.SPOTIFY});

enum OwnerType { USER }

final ownerTypeValues = EnumValues({"user": OwnerType.USER});

enum Uri1 { SPOTIFY_USER_SPOTIFY }

final uriValues =
    EnumValues({"spotify:user:spotify": Uri1.SPOTIFY_USER_SPOTIFY});

class Tracks {
  Tracks({
    required this.href,
    required this.total,
  });

  String href;
  int total;

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        href: json["href"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "total": total,
      };
}

enum ItemType { PLAYLIST }

final itemTypeValues = EnumValues({"playlist": ItemType.PLAYLIST});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
