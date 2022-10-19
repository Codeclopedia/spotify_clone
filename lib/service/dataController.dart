// ignore_for_file: file_names, depend_on_referenced_packages, camel_case_types, avoid_function_literals_in_foreach_calls

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
  late BrowseCategories categories;

  String token =
      "BQDPRzbbqbHOn7KumPAzqu_v5AexJqQ4b1x3CJYiKlBFaomcVIiuxZh1CqMQp_aSZT83yUmcYdqsBHInweW6mfdp2F7FR3BvDz3kv4ieT6CQn-NeKZ1Pc6FyKSsq_kQ60twHIL98ILgnMxhrS3wpy9_xTX6Yb3xS69P4BhDWHx9ftQyYbhwj2PPF48dew1bhx2w";

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
      print(information.images[0].url);
      return information.images[0].url;
    } else {
      print("error here");
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

  Future recentlyplayed() async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://api.spotify.com/v1/me/player/recently-played'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("1");
      var body = await response.stream.bytesToString();
      var data = recentlyPlayedFromJson(body);
      data.items.forEach(
        (element) {
          recentlyPlayed5data!.add(element);
          print(element);
        },
      );
      print(recentlyPlayed5data);
      print("2");
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getplaylist();
    datarequest();
    getcategories();
    recentlyplayed();
  }
}
