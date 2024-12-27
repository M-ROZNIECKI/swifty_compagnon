import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '/classes/utils/my_list_tile.dart';
import '/classes/albums/user_search_album.dart';
import '/classes/utils/my_text_field.dart';
import '/classes/provider/api_provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  final String title = "search user";


  @override
  State<SearchView> createState() => _SearchView();
}

class _SearchView extends State<SearchView> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(title: widget.title),
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
  final ApiProvider provider;
  const MyBody({
    super.key,
    required this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 160, 20, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TypeAheadField(
              decorationBuilder: (context, child) {
                return Material(
                  type: MaterialType.card,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[300]?.withValues(alpha: 0),
                  child: child,
                );
              },
              builder: (context, controller, focusNode) {
                return SearchTextField(controller: controller, focusNode: focusNode);
              },
              onSelected: (UserSearchAlbum? value) {
                if (value?.login != null) {
                  provider.setLogin(value!.login);
                }
                Navigator.of(context).pushNamed('/profile');
              },
              itemBuilder: (BuildContext context, UserSearchAlbum value) {
                return SearchListTile(userSearch: value);
              },
              loadingBuilder: (context) => Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: Colors.green,
                  size: 45
                ),
              ),
              suggestionsCallback: (String search) {
                if (search.isNotEmpty) {
                  return provider.searchLogin(search);
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}