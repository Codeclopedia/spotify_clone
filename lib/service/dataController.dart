import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/model/artist_info.dart';
import 'package:spotify_clone/model/dataModel.dart';

class dataController extends GetxController {
  late Albums data;
  late Categories _data;
  RxList<Item> items = <Item>[].obs;
  String token =
      "BQCAtA4_yLL8wwf8tNJEto2KAKU44adoym7vXx8DBWcNe5Ps7klZaSgQqx4HBetUkJeAd-FVO27NWmdL9EVBPz-8BKFSLI9MHqBqLoCdF5oCjYn-nvrC-mS7Uu5Dq_M0N66vVEsJLSsgFrr8l6srVMKFzbku1nybPtL3FYyVOtkYTgfqSViJ-3szMg5J4JohzWE";

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    datarequest();
  }
}
