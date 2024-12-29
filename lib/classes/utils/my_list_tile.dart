import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '/classes/albums/user_album.dart';
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

class SkillListTile extends StatelessWidget {
  final List<Skill> userSkills;
  const SkillListTile({
    required this.userSkills,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 40),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: userSkills.length,
      itemBuilder: (context, index) {
        final userSkill = userSkills[index];

        return Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          padding: const EdgeInsets.all(8),
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
          child: ListTile(
            leading: CircularPercentIndicator(
              radius: 28,
              lineWidth: 8,
              animation: true,
              percent: userSkill.percentage/100,
              center: Text(
                "${userSkill.percentage}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              userSkill.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal
              ),
            ),
            subtitle: Text(
              "lvl: ${userSkill.level}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProjectListTile extends StatelessWidget {
  final List<Project> userProjects;
  const ProjectListTile({
    required this.userProjects,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 40),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: userProjects.length,
      itemBuilder: (context, index) {
        final userProject = userProjects[index];

        return Container(
          margin: const EdgeInsets.fromLTRB(0, 4, 0, 8),
          padding: const EdgeInsets.all(8),
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
          child: ListTile(
            leading: CircularPercentIndicator(
              radius: 28,
              lineWidth: 8,
              animation: true,
              percent: userProject.finalMark/125,
              center: Text(
                "${userProject.finalMark}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              userProject.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal
              ),
            ),
            subtitle: Text(
              userProject.validated?"Validé":"échoué",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: userProject.validated?Colors.teal:Colors.red
              ),
            ),
          ),
        );
      },
    );
  }
}