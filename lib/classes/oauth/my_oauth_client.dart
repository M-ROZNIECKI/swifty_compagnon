import 'package:oauth2_client/oauth2_client.dart';

class MyOAuth2Client extends OAuth2Client {
  MyOAuth2Client(
      {
        required super.redirectUri,
        required super.customUriScheme
      }
    ): super(
      authorizeUrl: 'https://...', //Your service's authorization url
      tokenUrl: 'https://...'
  );
}