import 'package:flutter/material.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/classes/albums/user_album.dart';
import 'package:swifty_companion/classes/albums/user_search_album.dart';
import '../oauth/my_oauth_client.dart';
import '../services/api_request.dart';

class ApiProvider with ChangeNotifier{

  MyOAuth2Client client = MyOAuth2Client(redirectUri: '', customUriScheme: '');
  AccessTokenResponse? tknResp;
  String? selectedLogin;

  Future<void> fetchAppAccessToken() async {
    final response = await client.getTokenWithClientCredentialsFlow(
        clientId: dotenv.env['clientId'] ?? "", //Your client id
        clientSecret: dotenv.env['clientSecret'] ?? ""
    );

    if (response.httpStatusCode == 200) {
      // If the server did return a 200 OK response,
      // then we return the access token.
      tknResp = response;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception("http status code: ${response.httpStatusCode}\nerror: ${response.error}\nerror description: ${response.errorDescription}");
    }
  }

  Future<void> checkToken() async {
    if (tknResp?.isExpired() ?? true) {
      await fetchAppAccessToken();
    }
  }

  Future<List<UserSearchAlbum>> searchLogin(String query) async{
    await checkToken();
    String? token = tknResp?.accessToken;
    return await searchPseudo(query, token!);
  }

  Future<UserAlbum?> getProfile() async{
    if (selectedLogin == null) {
      return null;
    }
    await checkToken();
    String? token = tknResp?.accessToken;
    return await getUser(selectedLogin!, token!);
  }

  void setLogin(String login) {
    selectedLogin = login;
    notifyListeners();
  }
}