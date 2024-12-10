import 'package:flutter/material.dart';
import '../classes/form_connect.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  //final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(title: title),
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
      backgroundColor: Colors.black.withOpacity(0.6),
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