// To parse this JSON data, do
//
//     final recentlyPlayed = recentlyPlayedFromJson(jsonString);

import 'dart:convert';

RecentlyPlayed5 recentlyPlayedFromJson(String str) =>
    RecentlyPlayed5.fromJson(json.decode(str));

String recentlyPlayedToJson(RecentlyPlayed5 data) => json.encode(data.toJson());

class RecentlyPlayed5 {
  RecentlyPlayed5({
    required this.items,
    required this.next,
    required this.cursors,
    required this.limit,
    required this.href,
  });

  List<Item5> items;
  String next;
  Cursors5 cursors;
  int limit;
  String href;

  factory RecentlyPlayed5.fromJson(Map<String, dynamic> json) =>
      RecentlyPlayed5(
        items: List<Item5>.from(json["items"].map((x) => Item5.fromJson(x))),
        next: json["next"],
        cursors: Cursors5.fromJson(json["cursors"]),
        limit: json["limit"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "next": next,
        "cursors": cursors.toJson(),
        "limit": limit,
        "href": href,
      };
}

class Cursors5 {
  Cursors5({
    required this.after,
    required this.before,
  });

  String after;
  String before;

  factory Cursors5.fromJson(Map<String, dynamic> json) => Cursors5(
        after: json["after"],
        before: json["before"],
      );

  Map<String, dynamic> toJson() => {
        "after": after,
        "before": before,
      };
}

class Item5 {
  Item5({
    required this.track,
    required this.playedAt,
    required this.context,
  });

  Track5 track;
  DateTime playedAt;
  Context5? context;

  factory Item5.fromJson(Map<String, dynamic> json) => Item5(
        track: Track5.fromJson(json["track"]),
        playedAt: DateTime.parse(json["played_at"]),
        context:
            json["context"] == null ? null : Context5.fromJson(json["context"]),
      );

  Map<String, dynamic> toJson() => {
        "track": track.toJson(),
        "played_at": playedAt.toIso8601String(),
        "context": context == null ? null : context!.toJson(),
      };
}

class Context5 {
  Context5({
    required this.type,
    required this.externalUrls,
    required this.href,
    required this.uri,
  });

  ContextType5? type;
  ExternalUrls5 externalUrls;
  String href;
  String uri;

  factory Context5.fromJson(Map<String, dynamic> json) => Context5(
        type: contextTypeValues.map[json["type"]],
        externalUrls: ExternalUrls5.fromJson(json["external_urls"]),
        href: json["href"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "type": contextTypeValues.reverse[type],
        "external_urls": externalUrls.toJson(),
        "href": href,
        "uri": uri,
      };
}

class ExternalUrls5 {
  ExternalUrls5({
    required this.spotify,
  });

  String spotify;

  factory ExternalUrls5.fromJson(Map<String, dynamic> json) => ExternalUrls5(
        spotify: json["spotify"],
      );

  Map<String, dynamic> toJson() => {
        "spotify": spotify,
      };
}

enum ContextType5 { ALBUM, ARTIST }

final contextTypeValues =
    EnumValues({"album": ContextType5.ALBUM, "artist": ContextType5.ARTIST});

class Track5 {
  Track5({
    required this.album,
    required this.artists,
    required this.availableMarkets,
    required this.discNumber,
    required this.durationMs,
    required this.explicit,
    required this.externalIds,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.isLocal,
    required this.name,
    required this.popularity,
    required this.previewUrl,
    required this.trackNumber,
    required this.type,
    required this.uri,
  });

  Album5 album;
  List<Artist5> artists;
  List<String> availableMarkets;
  int discNumber;
  int durationMs;
  bool explicit;
  ExternalIds externalIds;
  ExternalUrls5 externalUrls;
  String href;
  String id;
  bool isLocal;
  String name;
  int popularity;
  String previewUrl;
  int trackNumber;
  TrackType? type;
  String uri;

  factory Track5.fromJson(Map<String, dynamic> json) => Track5(
        album: Album5.fromJson(json["album"]),
        artists:
            List<Artist5>.from(json["artists"].map((x) => Artist5.fromJson(x))),
        availableMarkets:
            List<String>.from(json["available_markets"].map((x) => x)),
        discNumber: json["disc_number"],
        durationMs: json["duration_ms"],
        explicit: json["explicit"],
        externalIds: ExternalIds.fromJson(json["external_ids"]),
        externalUrls: ExternalUrls5.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        isLocal: json["is_local"],
        name: json["name"],
        popularity: json["popularity"],
        previewUrl: json["preview_url"] == null ? null : json["preview_url"],
        trackNumber: json["track_number"],
        type: trackTypeValues.map[json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "album": album.toJson(),
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
        "disc_number": discNumber,
        "duration_ms": durationMs,
        "explicit": explicit,
        "external_ids": externalIds.toJson(),
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "is_local": isLocal,
        "name": name,
        "popularity": popularity,
        "preview_url": previewUrl == null ? null : previewUrl,
        "track_number": trackNumber,
        "type": trackTypeValues.reverse[type],
        "uri": uri,
      };
}

class Album5 {
  Album5({
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.totalTracks,
    required this.type,
    required this.uri,
  });

  AlbumType5? albumType;
  List<Artist5> artists;
  List<String> availableMarkets;
  ExternalUrls5 externalUrls;
  String href;
  String id;
  List<Image5> images;
  String name;
  DateTime releaseDate;
  ReleaseDatePrecision5? releaseDatePrecision;
  int totalTracks;
  ContextType5? type;
  String uri;

  factory Album5.fromJson(Map<String, dynamic> json) => Album5(
        albumType: albumTypeValues.map[json["album_type"]],
        artists:
            List<Artist5>.from(json["artists"].map((x) => Artist5.fromJson(x))),
        availableMarkets:
            List<String>.from(json["available_markets"].map((x) => x)),
        externalUrls: ExternalUrls5.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images:
            List<Image5>.from(json["images"].map((x) => Image5.fromJson(x))),
        name: json["name"],
        releaseDate: DateTime.parse(json["release_date"]),
        releaseDatePrecision:
            releaseDatePrecisionValues.map[json["release_date_precision"]],
        totalTracks: json["total_tracks"],
        type: contextTypeValues.map[json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "album_type": albumTypeValues.reverse[albumType],
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "release_date_precision":
            releaseDatePrecisionValues.reverse[releaseDatePrecision],
        "total_tracks": totalTracks,
        "type": contextTypeValues.reverse[type],
        "uri": uri,
      };
}

enum AlbumType5 { ALBUM, SINGLE }

final albumTypeValues =
    EnumValues({"album": AlbumType5.ALBUM, "single": AlbumType5.SINGLE});

class Artist5 {
  Artist5({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });

  ExternalUrls5 externalUrls;
  String href;
  String id;
  String name;
  ContextType5? type;
  String uri;

  factory Artist5.fromJson(Map<String, dynamic> json) => Artist5(
        externalUrls: ExternalUrls5.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: contextTypeValues.map[json["type"]],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "name": name,
        "type": contextTypeValues.reverse[type],
        "uri": uri,
      };
}

class Image5 {
  Image5({
    required this.height,
    required this.url,
    required this.width,
  });

  int height;
  String url;
  int width;

  factory Image5.fromJson(Map<String, dynamic> json) => Image5(
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

enum ReleaseDatePrecision5 { DAY }

final releaseDatePrecisionValues =
    EnumValues({"day": ReleaseDatePrecision5.DAY});

class ExternalIds {
  ExternalIds({
    required this.isrc,
  });

  String isrc;

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        isrc: json["isrc"],
      );

  Map<String, dynamic> toJson() => {
        "isrc": isrc,
      };
}

enum TrackType { TRACK }

final trackTypeValues = EnumValues({"track": TrackType.TRACK});

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
