import 'package:flutter/material.dart';

class CustomBarIcons extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  const CustomBarIcons(
      {super.key,
      required this.icon,
      required this.title,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey,
            size: MediaQuery.of(context).size.width * 0.07,
          ),
          Text(
            title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.grey),
          )
        ],
      ),
    );
  }
}
