import 'package:flutter/material.dart';
import '/classes/albums/user_search_album.dart';


class SearchListTile extends StatelessWidget {
  final UserSearchAlbum userSearch;
  const SearchListTile({
    required this.userSearch,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: (userSearch.imageUrl != null)?
        NetworkImage(userSearch.imageUrl!):
        const AssetImage("assets/images/placeholder.png"),
        radius: 45,
      ),
      title: Text(
        userSearch.displayName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
      subtitle: Text(
        "pseudo: ${userSearch.login}",
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal
        ),
      ),
    );
  }
}