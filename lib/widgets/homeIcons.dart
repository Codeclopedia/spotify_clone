import 'package:flutter/material.dart';

class HomeIcons extends StatelessWidget {
  final IconData icon;
  final Color color;
  const HomeIcons({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.015),
      child: Icon(
        icon,
        color: color,
        size: MediaQuery.of(context).size.width * 0.08,
      ),
    );
  }
}
