import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SmallRoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backroundColor;
  final Color textColor;
  const SmallRoundButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.backroundColor = Pallete.whiteColor,
      this.textColor = Pallete.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(color: textColor, fontSize: 16.0),
        ),
        backgroundColor: backroundColor,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
      ),
    );
  }
}
