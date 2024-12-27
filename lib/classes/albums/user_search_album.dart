class UserSearchAlbum {
  final int id;
  final String login;
  final String displayName;
  final String? imageUrl;

  const UserSearchAlbum({
    required this.id,
    required this.login,
    required this.displayName,
    this.imageUrl
  });

  factory UserSearchAlbum.fromJson(Map<String, dynamic> json) {
    return UserSearchAlbum(
      id: json['id'],
      login: json['login'],
      displayName: json['displayname'],
      imageUrl: json['image']['link']
    );
  }
}
