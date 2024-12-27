import 'package:flutter/material.dart';


class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const SearchTextField({
    required this.controller,
    required this.focusNode,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: controller,
      focusNode: focusNode,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'login',
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[200]?.withValues(alpha: 0.6)
        ),
      ),
      onTapOutside: (event) => focusNode.unfocus(),
    );
  }
}