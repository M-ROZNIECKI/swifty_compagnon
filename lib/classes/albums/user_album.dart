import 'user_search_album.dart';

const maxSkillLevel = 20;

class UserAlbum extends UserSearchAlbum {
  final String email;
  final String phone;
  final String level;
  final String location;
  final int wallet;
  final String kind;
  final bool staff;
  final int correctionPoint;
  final List<Skill> skills;
  final List<Project> projects;

  const UserAlbum({
    required super.id,
    required super.login,
    required super.displayName,
    super.imageUrl,
    required this.email,
    required this.phone,
    required this.location,
    required this.wallet,
    required this.kind,
    required this.staff,
    required this.correctionPoint,
    required this.level,
    this.skills = const [],
    this.projects = const []
  });

  factory UserAlbum.fromJson(Map<String, dynamic> user) {
    final allCursus = user['cursus_users'] as List<dynamic>;
    Map<String, dynamic>? mainCursus;
    if (allCursus.isNotEmpty) {
      mainCursus = allCursus.firstWhere(
              (cursus) => cursus['cursus']['kind'] == 'main',
          orElse: () => null
      );
    }

    final level = mainCursus == null ? null : mainCursus['level'] as double;

    List<Skill> skills = mainCursus == null ?
    [] :
    (mainCursus['skills'] as List<dynamic>).map(
        (skill) => Skill.fromJson(skill)
    ).toList();

    List<dynamic> projectsList = (user['projects_users'] as List<dynamic>)
    .where((project) => project['status'] == 'finished')
    .toList();
    projectsList.sort(
        (a, b) => DateTime.parse(b['updated_at']).compareTo(DateTime.parse(a['updated_at']))
    );
    List<Project> projects = projectsList.map(
        (project) => Project.fromJson(project)
    ).toList();

    return UserAlbum(
        id: user['id'],
        login: user['login'],
        displayName: user['displayname'],
        imageUrl: user['image']['link'],
        email: user['email'],
        phone: user['phone'],
        location: user['location'] ?? "Unavailable",
        wallet: user['wallet'],
        kind: user['kind'],
        staff: user['staff?'],
        correctionPoint: user['correction_point'],
        level: level?.toStringAsFixed(2) ?? "Unavailable",
        skills: skills,
        projects: projects
    );
  }
}

class Skill {
  final int id;
  final String name;
  final String level;
  final int percentage;

  const Skill({
    required this.id,
    required this.name,
    required this.level,
    required this.percentage
  });

  factory Skill.fromJson(Map<String, dynamic> skill) {
    final level = (skill['level'] as double) > 20? 20:skill['level'] as double;// protection contre staff
    final percentage = (level * 100) ~/ maxSkillLevel; //~/ Divide, returning an integer result
    return Skill(id: skill['id'], name: skill['name'], level: level.toStringAsFixed(2), percentage: percentage);
  }
}

class Project {
  final int id;
  final String name;
  final bool validated;
  final int finalMark;

  const Project({
    required this.id,
    required this.name,
    required this.validated,
    required this.finalMark
  });

  factory Project.fromJson(Map<String, dynamic> project) {
    return Project(
        id: project['project']['id'],
        name: project['project']['name'],
        validated: project['validated?']??false,
        finalMark: (project['final_mark']??0) > 125?125:project['final_mark']??0 // protection contre staff
    );
  }
}