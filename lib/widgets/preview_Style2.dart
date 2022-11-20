import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_clone/service/dataController.dart';

class PreviewStyle2 extends StatelessWidget {
  final String headingTitle;
  final data;
  PreviewStyle2({super.key, required this.headingTitle, required this.data});
  dataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
          child: Obx(() => SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: data.isEmpty ? 100 : data.length,
                  cacheExtent: 20,
                  itemBuilder: (context, index) {
                    Widget widget = data.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Shimmer.fromColors(
                              highlightColor: Color.fromARGB(255, 71, 71, 71),
                              baseColor: const Color.fromARGB(127, 58, 58, 58),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius:
                                    MediaQuery.of(context).size.width * 0.15,
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Center(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FutureBuilder<String>(
                                        future: controller.getIdArtistImage(
                                            data[index].artists[0].id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      snapshot.data!),
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                            );
                                          }
                                          return const CircularProgressIndicator();
                                        }),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          data[index].artists[0].name,
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
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
                    return widget;
                  },
                ),
              )),
        ),
      ],
    );
  }
}
