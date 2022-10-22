// To parse this JSON data, do
//
//     final albumsModel = albumsModelFromJson(jsonString);

import 'dart:convert';

AlbumsModel albumsModelFromJson(String str) =>
    AlbumsModel.fromJson(json.decode(str));

String albumsModelToJson(AlbumsModel data) => json.encode(data.toJson());

class AlbumsModel {
  AlbumsModel({
    required this.href,
    required this.items,
    required this.limit,
    this.next,
    required this.offset,
    required this.previous,
    required this.total,
  });

  String href;
  List<AlbumsModelItem> items;
  int limit;
  dynamic next;
  int offset;
  dynamic previous;
  int total;

  factory AlbumsModel.fromJson(Map<String, dynamic> json) => AlbumsModel(
        href: json["href"],
        items: List<AlbumsModelItem>.from(
            json["items"].map((x) => AlbumsModelItem.fromJson(x))),
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

class AlbumsModelItem {
  AlbumsModelItem({
    required this.addedAt,
    required this.album,
  });

  DateTime addedAt;
  Album album;

  factory AlbumsModelItem.fromJson(Map<String, dynamic> json) =>
      AlbumsModelItem(
        addedAt: DateTime.parse(json["added_at"]),
        album: Album.fromJson(json["album"]),
      );

  Map<String, dynamic> toJson() => {
        "added_at": addedAt.toIso8601String(),
        "album": album.toJson(),
      };
}

class Album {
  Album({
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.copyrights,
    required this.externalIds,
    required this.externalUrls,
    required this.genres,
    required this.href,
    required this.id,
    required this.images,
    required this.label,
    required this.name,
    required this.popularity,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.totalTracks,
    required this.tracks,
    required this.type,
    required this.uri,
  });

  String albumType;
  List<Artist> artists;
  List<String> availableMarkets;
  List<Copyright> copyrights;
  ExternalIds externalIds;
  ExternalUrls externalUrls;
  List<dynamic> genres;
  String href;
  String id;
  List<Image> images;
  String label;
  String name;
  int popularity;
  DateTime releaseDate;
  String releaseDatePrecision;
  int totalTracks;
  Tracks tracks;
  String type;
  String uri;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumType: json["album_type"],
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        availableMarkets:
            List<String>.from(json["available_markets"].map((x) => x)),
        copyrights: List<Copyright>.from(
            json["copyrights"].map((x) => Copyright.fromJson(x))),
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        genres: List<dynamic>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        label: json["label"],
        name: json["name"],
        popularity: json["popularity"],
        releaseDate: DateTime.parse(json["release_date"]),
        releaseDatePrecision: json["release_date_precision"],
        totalTracks: json["total_tracks"],
        tracks: Tracks.fromJson(json["tracks"]),
        type: json["type"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "album_type": albumType,
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
        "copyrights": List<dynamic>.from(copyrights.map((x) => x.toJson())),
        "external_ids": externalIds.toJson(),
        "external_urls": externalUrls.toJson(),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "label": label,
        "name": name,
        "popularity": popularity,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "release_date_precision": releaseDatePrecision,
        "total_tracks": totalTracks,
        "tracks": tracks.toJson(),
        "type": type,
        "uri": uri,
      };
}

class Artist {
  Artist({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    this.type,
    required this.uri,
  });

  ExternalUrls externalUrls;
  String href;
  String id;
  String name;
  ArtistType? type;
  String uri;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: artistTypeValues.map[json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "name": name,
        "type": artistTypeValues.reverse[type],
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

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({"artist": ArtistType.ARTIST});

class Copyright {
  Copyright({
    required this.text,
    required this.type,
  });

  String text;
  String type;

  factory Copyright.fromJson(Map<String, dynamic> json) => Copyright(
        text: json["text"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type,
      };
}

class ExternalIds {
  ExternalIds({
    required this.upc,
  });

  String upc;

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        upc: json["upc"],
      );

  Map<String, dynamic> toJson() => {
        "upc": upc,
      };
}

class Image {
  Image({
    required this.height,
    required this.url,
    required this.width,
  });

  int height;
  String url;
  int width;

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

class Tracks {
  Tracks({
    required this.href,
    required this.items,
    required this.limit,
    this.next,
    required this.offset,
    this.previous,
    required this.total,
  });

  String href;
  List<TracksItem> items;
  int limit;
  dynamic next;
  int offset;
  dynamic previous;
  int total;

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        href: json["href"],
        items: List<TracksItem>.from(
            json["items"].map((x) => TracksItem.fromJson(x))),
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

class TracksItem {
  TracksItem({
    required this.artists,
    required this.availableMarkets,
    required this.discNumber,
    required this.durationMs,
    required this.explicit,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.isLocal,
    required this.name,
    required this.previewUrl,
    required this.trackNumber,
    required this.type,
    required this.uri,
  });

  List<Artist> artists;
  List<String> availableMarkets;
  int discNumber;
  int durationMs;
  bool explicit;
  ExternalUrls externalUrls;
  String href;
  String id;
  bool isLocal;
  String name;
  String previewUrl;
  int trackNumber;
  ItemType? type;
  String uri;

  factory TracksItem.fromJson(Map<String, dynamic> json) => TracksItem(
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        availableMarkets:
            List<String>.from(json["available_markets"].map((x) => x)),
        discNumber: json["disc_number"],
        durationMs: json["duration_ms"],
        explicit: json["explicit"],
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        isLocal: json["is_local"],
        name: json["name"],
        previewUrl: json["preview_url"] == null ? null : json["preview_url"],
        trackNumber: json["track_number"],
        type: itemTypeValues.map[json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
        "disc_number": discNumber,
        "duration_ms": durationMs,
        "explicit": explicit,
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "is_local": isLocal,
        "name": name,
        "preview_url": previewUrl,
        "track_number": trackNumber,
        "type": itemTypeValues.reverse[type],
        "uri": uri,
      };
}

enum ItemType { TRACK }

final itemTypeValues = EnumValues({"track": ItemType.TRACK});

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
