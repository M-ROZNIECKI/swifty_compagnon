import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../albums/user_search_album.dart';
import '../albums/user_album.dart';

Future<List<UserSearchAlbum>> searchPseudo(String query, String token) async {
  final url = Uri.https("api.intra.42.fr", "v2/users", {
    "search[login]": query
  });

  try {
    final response = await http.get(url, headers: {
      "Authorization": "bearer $token"
    });
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      return users.map(
          (user) => UserSearchAlbum.fromJson(user)
      ).toList();
    }
  } catch (e) {
    log("Unknown error: $e");
  }
  return [];
}

Future<List<UserSearchAlbum>> getUser(String login, String token) async {
  final url = Uri.https("api.intra.42.fr", "v2/users/$login");

  try {
    final response = await http.get(url, headers: {
      "Authorization": "bearer $token"
    });
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      return users.map(
              (user) => UserAlbum.fromJson(user)
      ).toList();
    }
  } catch (e) {
    log("Unknown error: $e");
  }
  return [];
}