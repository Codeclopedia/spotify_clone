import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_clone/service/dataController.dart';
import 'package:spotify_clone/widgets/homeIcons.dart';

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
            recentAlbums(context),
            previewStyle1("Your top mixes", context),
            previewStyle1("More of what you like", context),
            previewStyle1("Recently played", context),
            previewStyle2(
              "Your Favorite Artist",
              context,
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

  Widget firstrow(BuildContext context) {
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

  Widget previewStyle1(String headingTitle, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(headingTitle,
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/f101ee52097223.590463d3471b4.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Album name",
                                overflow: TextOverflow.fade,
                                maxLines: 3,
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget previewStyle2(String headingTitle, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(headingTitle,
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: const CachedNetworkImageProvider(
                                "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/f101ee52097223.590463d3471b4.jpg"),
                            radius: MediaQuery.of(context).size.width * 0.15,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Albu name",
                                overflow: TextOverflow.fade,
                                maxLines: 3,
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
