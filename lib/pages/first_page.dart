import 'package:flutter/material.dart';
import 'package:oauth2_client/access_token_response.dart';
import '../classes/form_connect.dart';
import '../classes/oauth/my_oauth_client.dart';


Future<AccessTokenResponse> fetchAppAccessToken(MyOAuth2Client client) async {
  final response = await client.getTokenWithClientCredentialsFlow(
      clientId: 'XXX', //Your client id
      clientSecret: 'XXX'
  );

  if (response.httpStatusCode == 200) {
    // If the server did return a 200 OK response,
    // then we return the access token.
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception("http status code: ${response.httpStatusCode}\nerror: ${response.error}\nerror description: ${response.errorDescription}");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  MyOAuth2Client client = MyOAuth2Client(redirectUri: '', customUriScheme: '');
  late Future<AccessTokenResponse> tknResp;

  //void _incrementCounter() {
  //  setState(() {
  //  });
  //}

  @override
  void initState() async {
    super.initState();
    tknResp = fetchAppAccessToken(client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(title: widget.title),
      body: const DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/default.jpeg"),
            fit: BoxFit.cover,
          )
        ),
        child: MyBody(),
      ),
      //bottomNavigationBar: const MyBottomBar(),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title
  });
  
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withValues(alpha: 0.6),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
      ),
      centerTitle: true,
    );
  }
}


class MyBody extends StatelessWidget {
  const MyBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: FormConnect(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BtnConnect(),
            ],
          )
        ],
      ),
    );
  }
}

/*
class MyBottomBar extends StatelessWidget {
  const MyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: Colors.blue,
      child:
    );
  }
}
*/