// ignore_for_file: file_names, depend_on_referenced_packages, camel_case_types, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone/model/albumsModel.dart';
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
  // Playlists? playlistdata;
  RxList<Item1> items = <Item1>[].obs;
  RxList<Item5>? recentlyPlayed5data = <Item5>[].obs;
  Rx<BrowseCategories> categories = BrowseCategories.empty().obs;
  AlbumsModel? albums;
  TracksModel? tracks;
  EpisodeModel6? episodes;
  ShowsModel? shows;

  RxList data_types = ["albums", "episodes", "shows", "tracks"].obs;

  String token =
      "BQC0zkeCm7fAqqg4ZbsLPuFlXa6Q2PgSpXMEIkA4Z_0JFNARITYgTVMmXVb-l06uOgWJLR94v4xAxkSaiAhqzk1AjwjhHns7m48dQgLRxp56Ek3kcN2o_G7xO0DowABhidaJnNOnJb5gGJgOBa_VU7-djbZYSmYSloR55iwMmtpwLHpK1ppSE-TBPfoby43dhPzWL-S4ZUDpxITZpYQ";

  Future getLibraryDataModel(linktype) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    try {
      print("inside try");
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request('GET',
          Uri.parse('https://api.spotify.com/v1/me/${linktype.toString()}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print("inside try 2");

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
        print("inside try 3");
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("on error: ");
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
      await Future.delayed(Duration(seconds: 1));
      data.isNull ? getdataoffline() : null;
    }
  }

  getdataoffline() async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    var localdata = sharedPreferencesinstance.getString("dataAlbumsData");
    data = jsonDecode(localdata!);
    data?.items.forEach((element) {
      items.add(element);
    });
  }

  Future<String> getIdArtistImage(String artistId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://api.spotify.com/v1/artists/${artistId.toString()}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      ArtistInformation information = artistInformationFromJson(body);

      return information.images[0].url;
    } else {
      print(response.reasonPhrase);
    }
    return "";
  }

  Future getcategories() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://api.spotify.com/v1/browse/categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      categories.value = browseCategoriesFromJson(body);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future recentlyplayed() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://api.spotify.com/v1/me/player/recently-played'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      var data = RecentlyPlayed5.fromJson(jsonDecode(body));

      print(data);
      data.items.forEach(
        (element) {
          recentlyPlayed5data!.add(element);
        },
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  // Future getplaylist() async {
  //   var headers = {'Authorization': 'Bearer $token'};
  //   var request = http.Request('GET',
  //       Uri.parse('https://api.spotify.com/v1/browse/featured-playlists'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(response.stream.bytesToString());
  //     var body = await response.stream.bytesToString();
  //     playlistdata = playlistsFromJson(body);
  //     print(playlistdata);
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

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
