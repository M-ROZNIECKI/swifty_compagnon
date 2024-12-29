import 'package:flutter/material.dart';

class BasicProfileRow extends StatelessWidget {
  final String info;
  const BasicProfileRow({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          info,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
        )
      ],
    );
  }

}