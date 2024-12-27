import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/classes/provider/api_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MyAppBar(),
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/default.jpeg"),
              fit: BoxFit.cover,
            )
        ),
        child: MyBody(provider: provider),
      ),
      //bottomNavigationBar: const MyBottomBar(),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ApiProvider provider;
  const MyAppBar({
    required this.provider,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withValues(alpha: 0.6),
      title: Text(
        provider.selectedLogin ?? "error",
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
  final ApiProvider provider;
  const MyBody({
    super.key,
    required this.provider
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
                child: Text("placeholder"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("placeholder"),
            ],
          )
        ],
      ),
    );
  }
}