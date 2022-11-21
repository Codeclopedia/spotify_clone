// ignore_for_file: file_names, depend_on_referenced_packages, camel_case_types, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone/model/albumsModel.dart';
import 'package:spotify_clone/model/albumtracks.dart';
import 'package:spotify_clone/model/artist_info.dart';
import 'package:spotify_clone/model/categories.dart';
import 'package:spotify_clone/model/dataModel.dart';
import 'package:spotify_clone/model/episodemodel.dart';
import 'package:spotify_clone/model/playlist1.dart';
import 'package:spotify_clone/model/recetlyplayed.dart';
import 'package:spotify_clone/model/showsModel.dart';
import 'package:spotify_clone/model/tracksModel.dart';

class dataController extends GetxController {
  Albums? data;
  Categories1? _data;

  Playlists? playlistdata;
  RxList<Item1> items = <Item1>[].obs;
  RxList<Item5>? recentlyPlayed5data = <Item5>[].obs;
  Rx<BrowseCategories>? categories;
  AlbumsModel? albums;
  TracksModel? tracks;
  EpisodeModel6? episodes;
  ShowsModel? shows;
  Albumstracks? albumtracks;
  RxList<ArtistInformation> relatedartist = <ArtistInformation>[].obs;

  RxList data_types = ["albums", "episodes", "shows", "tracks"].obs;

  String token =
      "BQCBbyjzo2q4-hsIvvmnd8VQog_tbHhTY9psDihI4anBgLYU1SIsWYgPiET8_IqeialG8ZlEX0BfRp_t6iLINYV2ZJbrYY3eJJlh4vTYz0fbVFT2_ByAtyk7YACtAnoQqpqgAzWIRmneEKL7Jk1ZWLNxD9CdIipPvAVb6eBatAN8Dn8zOPAErKlD8pKqkWcY8GXZICxfP6o2T05-";

  Future getLibraryDataModel(linktype) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET',
          Uri.parse('https://api.spotify.com/v1/me/${linktype.toString()}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var body = await response.stream.bytesToString();
        switch (linktype) {
          case "albums":
            {
              albums = albumsModelFromJson(body);
              var data = albums;
              sharedPreferencesinstance.setString(
                  "albumsData", albumsModelToJson(data!));
            }
            break;
          case "tracks":
            {
              tracks = tracksModelFromJson(body);
              var data = tracks;
              sharedPreferencesinstance.setString(
                  "tracksData", jsonEncode(data));
            }
            break;
          case "episodes":
            {
              episodes = episodesModelFromJson(body);
              var data = episodes;
              sharedPreferencesinstance.setString(
                  "episodesData", jsonEncode(data));
            }
            break;
          default:
            {
              shows = showsModelFromJson(body);
              var data = shows;
              sharedPreferencesinstance.setString(
                  "showsData", jsonEncode(data));
            }
            break;
        }
      } else {
        print("getLibraryDataModel" + response.reasonPhrase.toString());
      }
    } catch (e) {
      switch (linktype) {
        case "albums":
          {
            getalbumofflinedata();
          }
          break;
        case "tracks":
          {
            gettrackofflinedata();
          }
          break;
        case "episodes":
          {
            getepisodeofflinedata();
          }
          break;
        default:
          {
            getshowsofflinedata();
          }
          break;
      }
    }
  }

  librarydata() async {
    for (int i = 0; i < data_types.length; i++) {
      await getLibraryDataModel(data_types[i]);
    }
    if (albums.isNull) {
      getalbumofflinedata();
    }
    if (tracks.isNull) {
      gettrackofflinedata();
    }
    if (episodes.isNull) {
      getepisodeofflinedata();
    }
    if (shows.isNull) {
      getshowsofflinedata();
    }
  }

  getalbumofflinedata() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var data = await sharedPreferencesinstance.getString("albumsData");
    albums = albumsModelFromJson(data!);
  }

  gettrackofflinedata() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var data = sharedPreferencesinstance.getString("tracksData");

    tracks = tracksModelFromJson(data!);
  }

  getepisodeofflinedata() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var data = sharedPreferencesinstance.getString("episodesData");
    episodes = episodesModelFromJson(data!);
  }

  getshowsofflinedata() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var data = sharedPreferencesinstance.getString("showsData");
    shows = showsModelFromJson(data!);
  }

  Future datarequest() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://api.spotify.com/v1/browse/new-releases'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      _data = categoriesFromJson(body);
      data = _data?.albums;
      sharedPreferencesinstance.setString("dataAlbumsData", jsonEncode(data));

      data?.items.forEach((element) {
        items.add(element);
      });
    } else {
      print("datarequest" + response.reasonPhrase.toString());
    }
    await Future.delayed(Duration(seconds: 1));
    data.isNull ? getdataoffline() : null;
  }

  getdataoffline() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var localdata = sharedPreferencesinstance.getString("dataAlbumsData");

    data = Albums.fromJson(jsonDecode(localdata!));
    data?.items.forEach((element) {
      items.add(element);
    });
  }

  Future<String> getIdArtistImage(String artistId) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://api.spotify.com/v1/artists/${artistId.toString()}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      ArtistInformation information = artistInformationFromJson(body);
      sharedPreferencesinstance.setString(
          "${artistId}information", jsonEncode(information));

      return information.images[0].url;
    } else {
      print("getIdArtistImage" + response.reasonPhrase.toString());
    }
    var localdata =
        sharedPreferencesinstance.getString("${artistId}information");
    var data = ArtistInformation.fromJson(jsonDecode(localdata!));

    return data.images[0].url;
  }

  Future getcategories() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://api.spotify.com/v1/browse/categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      categories = browseCategoriesFromJson(body).obs;
      var data = categories;
      sharedPreferencesinstance.setString("categoriesData", jsonEncode(data));
    } else {
      print(" getcategories " + response.reasonPhrase.toString());
    }
    categories.isNull ? getcategoriesdataoffline() : print("has data");
  }

  getcategoriesdataoffline() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var data = sharedPreferencesinstance.getString("categoriesData");
    categories = browseCategoriesFromJson(data!).obs;
  }

  Future recentlyplayed() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://api.spotify.com/v1/me/player/recently-played'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var data = RecentlyPlayed5.fromJson(jsonDecode(body));
      data.items.forEach(
        (element) {
          recentlyPlayed5data!.add(element);
        },
      );
      sharedPreferencesinstance.setString(
          "recentlyPlayed5Data", jsonEncode(recentlyPlayed5data));
    } else {
      print("recentlyplayed" + response.reasonPhrase.toString());
    }

    recentlyPlayed5data!.isEmpty ? getrecentlydataoffline() : null;
  }

  getrecentlydataoffline() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var localrecentlydata =
        sharedPreferencesinstance.getString("recentlyPlayed5Data");

    List listofdata = jsonDecode(localrecentlydata!);
    listofdata.forEach((element) {
      recentlyPlayed5data!.add(Item5.fromJson(element));
    });
  }

  getAlbumstracks(String albumId) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://api.spotify.com/v1/albums/$albumId/tracks'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      albumtracks = albumstracksFromJson(body);
      var data = albumtracks;
      sharedPreferencesinstance.setString(
          "${albumId}tracksData", albumstracksToJson(data!));
      return albumtracks;
    } else {
      print("getAlbumstracks" + response.reasonPhrase.toString());
    }
    var localdata = sharedPreferencesinstance.getString("${albumId}tracksData");
    Albumstracks data = albumstracksFromJson(localdata!);
    albumtracks = data;
    return albumtracks;
  }

  getrelatedartists(String artistid) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.spotify.com/v1/artists/$artistid/related-artists'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      relatedartist.clear();
      var data = await response.stream.bytesToString();
      var newdata = jsonDecode(data);

      newdata["artists"].forEach((element) {
        relatedartist.add(ArtistInformation.fromJson(element));
      });

      sharedPreferencesinstance.setString(
          "${artistid}relatedArtistData", jsonEncode(relatedartist));
    } else {
      print("relatedartists" + response.reasonPhrase.toString());
    }
    var localdata =
        sharedPreferencesinstance.getString("${artistid}relatedArtistData");
    List data = jsonDecode(localdata!);
    relatedartist.clear();
    data.forEach((element) {
      relatedartist.add(ArtistInformation.fromJson(element));
    });
    return relatedartist;
  }

  getdata() async {
    await datarequest();
    await getcategories();
    await recentlyplayed();
    await librarydata();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getdata();
  }
}
