// ignore_for_file: file_names, depend_on_referenced_packages, camel_case_types, avoid_function_literals_in_foreach_calls

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/model/artist_info.dart';
import 'package:spotify_clone/model/categories.dart';
import 'package:spotify_clone/model/dataModel.dart';
import 'package:spotify_clone/model/playlist1.dart' as pl1;

class dataController extends GetxController {
  late Albums data;
  late Categories1 _data;
  pl1.Playlists? playlistdata;
  RxList<Item1> items = <Item1>[].obs;
  late BrowseCategories categories;

  String token =
      "BQBNVp6ctZax2vqoLXmdzg2t7EWQ-xbPBxojMuq0WeIVqm9aYzYlbn27YXn_Rhzx9K5NzMSKvGM97T8CFtYJpqCEmibnbgCxKQFet9tQMdG0gunXRaSWjpI3hvM9ofQLyjypgGCEK8_wufHdPjzfeRI7W7em8xC3sTrIoQnsnXW4PpHviIjAYdVzdQBmEidKyvQ";

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

  Future<String> getIdArtistInformation(String artistId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://api.spotify.com/v1/artists/$artistId'));

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
      categories = browseCategoriesFromJson(body);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getplaylist() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://api.spotify.com/v1/browse/featured-playlists'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.stream.bytesToString());
      var body = await response.stream.bytesToString();
      playlistdata = pl1.playlistsFromJson(body);
      print(playlistdata);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getplaylist();
    datarequest();
    getcategories();
  }
}
