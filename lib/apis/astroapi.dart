import 'dart:convert';
import 'package:astronotapp/models/astronot.dart';
import 'package:http/http.dart' as http;

//APİ BURDA ÇAĞRILIYOR

Future<Astro> getAstroApi() async {
  final response =
      await http.get(Uri.parse("http://api.open-notify.org/astros.json"));

  if (response.statusCode == 200) {
    return Astro.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load Astronots.");
  }
}
