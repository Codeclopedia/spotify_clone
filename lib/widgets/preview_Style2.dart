import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_clone/service/dataController.dart';

class PreviewStyle2 extends StatelessWidget {
  final String headingTitle;
  final data;
  PreviewStyle2({super.key, required this.headingTitle, required this.data});
  dataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget widget = data.length == null
        ? const CircularProgressIndicator.adaptive()
        : Column(
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
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var artistImageUrl;
                          controller
                              .getIdArtistImage(data[index].artists[0].id)
                              .then(
                            (value) async {
                              artistImageUrl = await value;
                              print(artistImageUrl);
                            },
                          );

                          return Padding(
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
                                    // CircleAvatar(
                                    //   backgroundImage:
                                    //       CachedNetworkImageProvider(
                                    //           artistImageUrl),
                                    //   radius:
                                    //       MediaQuery.of(context).size.width *
                                    //           0.15,
                                    // ),
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
                        },
                      ),
                    )),
              ),
            ],
          );
    return widget;
  }
}
