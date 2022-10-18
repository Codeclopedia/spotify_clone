import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_clone/service/dataController.dart';
import 'package:spotify_clone/widgets/homeIcons.dart';
import 'package:spotify_clone/widgets/lastalbums.dart';
import 'package:spotify_clone/widgets/preview_Style2.dart';
import 'package:spotify_clone/widgets/previewstyle1.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            const LastAlbum(),
            recentAlbums(context),
            PreviewStyle1(
                headingTitle: "Your top mixes", data: controller.items),
            PreviewStyle1(
                headingTitle: "More of what you like", data: controller.items),
            PreviewStyle1(
                headingTitle: "Recently played", data: controller.items),
            const PreviewStyle2(
              headingTitle: "Your Favorite Artist",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget recentAlbums(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.05),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width * 0.009,
            mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
            crossAxisSpacing: MediaQuery.of(context).size.width * 0.03),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Obx(() => Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(127, 58, 58, 58),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: controller.items.isEmpty
                          ? CircularProgressIndicator()
                          : CachedNetworkImage(
                              imageUrl: controller.items[index].images[0].url,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Expanded(
                      child: Text(
                        controller.items.isEmpty
                            ? ""
                            : controller.items[index].name,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.032,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
