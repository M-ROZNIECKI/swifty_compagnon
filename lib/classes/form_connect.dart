import 'package:flutter/material.dart';

class FormConnect extends StatelessWidget {
  const FormConnect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[300]?.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: const Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "pseudo :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "pseudo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "passwd :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "passwd",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BtnConnect extends StatelessWidget {
  const BtnConnect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[300]?.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: const Text(
          "connect",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}