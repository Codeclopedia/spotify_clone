import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_clone/widgets/homeIcons.dart';

class LastAlbum extends StatelessWidget {
  const LastAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Good morning",
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * 0.065,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Row(
          children: const [
            HomeIcons(icon: Icons.notifications_outlined, color: Colors.white),
            HomeIcons(icon: Icons.timer_outlined, color: Colors.white),
            HomeIcons(icon: Icons.settings_outlined, color: Colors.white)
          ],
        )
      ],
    );
    ;
  }
}
