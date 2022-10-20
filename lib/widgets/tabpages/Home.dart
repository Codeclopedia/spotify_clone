import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_clone/service/dataController.dart';
import 'package:spotify_clone/widgets/homeIcons.dart';
import 'package:spotify_clone/widgets/lastalbums.dart';
import 'package:spotify_clone/widgets/preview_Style2.dart';
import 'package:spotify_clone/widgets/previewstyle1.dart';

class Home extends StatelessWidget {
  Home({super.key});

  dataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.1, 0.3, 0.7],
        colors: [
          Color.fromARGB(255, 161, 59, 59),
          Color.fromARGB(255, 110, 36, 34),
          Color.fromARGB(255, 41, 14, 14),
          Color.fromARGB(255, 20, 7, 7),
        ],
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            firstrow(context),
            LastAlbum(),
            PreviewStyle1(
                headingTitle: "Your top mixes", data: controller.items),
            // PreviewStyle1(
            //     headingTitle: "Albums",
            //     data: controller.playlistdata?.playlists.items),
            PreviewStyle1(
                headingTitle: "Recently played",
                data: controller.recentlyPlayed5data),
            PreviewStyle2(
              headingTitle: "Your Favorite Artist",
              data: controller.items,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget firstrow(
    BuildContext context,
  ) {
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
  }
}
