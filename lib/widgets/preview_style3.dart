import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_clone/model/recetlyplayed.dart';
import 'package:spotify_clone/service/dataController.dart';

class PreviewStyle3 extends StatelessWidget {
  final String headingTitle;
  final RxList<Item5> data;
  PreviewStyle3({super.key, required this.headingTitle, required this.data});
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  cacheExtent: 20,
                  itemCount: data.isEmpty ? 100 : data.length,
                  itemBuilder: (context, index) {
                    Widget widget = data.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.02),
                            child: Shimmer.fromColors(
                              highlightColor:
                                  const Color.fromARGB(255, 71, 71, 71),
                              baseColor: const Color.fromARGB(127, 58, 58, 58),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
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
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: CachedNetworkImage(
                                        imageUrl: data[index]
                                                .track
                                                .album
                                                .images[0]
                                                .url ??
                                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          data[index].track.name,
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
                )),
          ),
        ),
      ],
    );
  }
}
