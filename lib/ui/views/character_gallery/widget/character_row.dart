import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';

class CharacterRow extends StatelessWidget {
  final String title;
  final String value;
  const CharacterRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18, color: kcBackgroundColor),
          children: [
            TextSpan(
                text: "$title: ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
