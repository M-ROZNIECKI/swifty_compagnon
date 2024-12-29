import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '/classes/utils/my_list_tile.dart';
import '/classes/utils/my_rows.dart';
import '/classes/albums/user_album.dart';
import '/classes/provider/api_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {

  late Future<UserAlbum?> userData;

  @override
  void initState() {
    super.initState();
    userData = fetchData();
  }

  Future<UserAlbum?> fetchData() async {
    final profile = await Provider.of<ApiProvider>(context, listen: false).getProfile();
    if (profile == null) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            Navigator.of(context).pop();
          }
      );
      return null;
    }
    return profile;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(provider: provider),
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/default.jpeg"),
              fit: BoxFit.cover,
            )
        ),
        child: FutureBuilder<UserAlbum?>(
          future: userData,
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
              final profile = snapshot.data!;
              children = <Widget>[
                ShowProfile(provider: provider, profile: profile,),
                const Center(
                  child: Text(
                    "Skills",
                    style: TextStyle(
                      fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal
                    ),
                  ),
                ),
                SkillListTile(userSkills: profile.skills,),
                const Center(
                  child: Text(
                    "Projets",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal
                    ),
                  ),
                ),
                ProjectListTile(userProjects: profile.projects,)
              ];
            } else if (snapshot.connectionState == ConnectionState.done) {
              children = <Widget>[
                const Center(
                  child: Text('Try Again'),
                ),
              ];
            } else {
              children = <Widget>[
                Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.green,
                    size: 45
                  ),
                ),
              ];
            }
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 160, 20, 40),
              children: children,
            );
          }
        ),
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


class ShowProfile extends StatelessWidget {
  final ApiProvider provider;
  final UserAlbum profile;
  const ShowProfile({
    required this.provider,
    required this.profile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 40),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.9),
            blurRadius: 10,
            spreadRadius: 4
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.3),
            Colors.green.withValues(alpha: 0.3),
          ]
        )
      ),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: (profile.imageUrl != null)?
                NetworkImage(profile.imageUrl!):
                const AssetImage("assets/images/placeholder.png"),
                radius: 45,
              )
            ],
          ),
          BasicProfileRow(info: "Login: ${profile.login}"),
          BasicProfileRow(info: "Nom: ${profile.displayName}"),
          BasicProfileRow(info: "Email: ${profile.email}"),
          BasicProfileRow(info: "Téléphone: ${profile.phone}"),
          BasicProfileRow(info: "Location: ${profile.location}"),
          BasicProfileRow(info: "Wallet: ${profile.wallet}"),
          BasicProfileRow(info: "Point de correction: ${profile.correctionPoint}"),
          BasicProfileRow(info: "Level: ${profile.level}"),
          BasicProfileRow(info: profile.staff?'Staff':''),
        ],
      ),
    );
  }
}