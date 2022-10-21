// ignore_for_file: file_names, depend_on_referenced_packages, camel_case_types, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/model/artist_info.dart';
import 'package:spotify_clone/model/categories.dart';
import 'package:spotify_clone/model/dataModel.dart';
import 'package:spotify_clone/model/playlist1.dart';
import 'package:spotify_clone/model/recetlyplayed.dart';

class dataController extends GetxController {
  late Albums data;
  late Categories1 _data;
  // Playlists? playlistdata;
  RxList<Item1> items = <Item1>[].obs;
  RxList<Item5>? recentlyPlayed5data = <Item5>[].obs;
  Rx<BrowseCategories> categories = BrowseCategories.empty().obs;

  String token =
      "BQBhFOyGShDRtijGl4RR4YZaRN83FVCZIu8Si5LLvOU0iAPZXeDLK4r4JJ_Q6Ri2ZebPYtAinwaQleTpFluloDn0Oe0GXBQB-Y92JGesT4VwJk-h4-Ou25rBHGtaYVdg1nZ4gvEzWVxUG31phDOqSUTVM6AMWQsF5QtaFqxNSYs9gzY9Bre2qWH-EEGfTpwNgXM";

  Future getLibraryDataModel(String linktype) async {
    var headers = {
      'Authorization':
          'Bearer BQDXhYyzW2h7gvb2UnNT2dWm76DJ_ydnGUDBDW-XvkCkMuB8Y63mXObsfkPjq2SDY9e3M-WhNqrq0_ukOEUO4nH07R9pTpOWEtE6AuB5SJQs5PgVOUErajb7Aw5ZxfxwRCcxQPYn8HGv7yXAd9qzt8YixnBDKzqlSQq0wsBnhiWu1S6IPT1iHcAgqJ1Ev5KJf0pUb00ZeT3c3Srs'
    };
    var request = http.Request(
        'GET', Uri.parse('https://api.spotify.com/v1/me/$linktype'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  librarydata() {
    List data_types = ["albums", "episodes", "shows", "tracks"];
    for (int i = 0; i < data_types.length; i++) {
      getLibraryDataModel(data_types[i]);
    }
  }

  Future datarequest() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://api.spotify.com/v1/browse/new-releases'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      _data = categoriesFromJson(body);
      data = _data.albums;

      data.items.forEach((element) {
        items.add(element);
      });
    } else {
      print(response.reasonPhrase);
    }
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
      print("error 2");
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
