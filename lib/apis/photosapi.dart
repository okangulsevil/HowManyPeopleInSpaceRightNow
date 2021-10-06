import 'dart:convert';
import 'package:astronotapp/models/photos.dart';
import 'package:http/http.dart' as http;

//APİ BURDA ÇAĞRILIYOR

Future<List<DailyPhoto>> fetchDailyPhoto() async {
  final response = await http.get(Uri.parse(
      "https://api.nasa.gov/planetary/apod?api_key=ULRJiJdNWYya7tnS9ZbcQNRArkDRysAPVvxwplLp&count=1"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return List<DailyPhoto>.from(
        jsonDecode(response.body).map((e) => DailyPhoto.fromJson(e)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load peoples');
  }
}
