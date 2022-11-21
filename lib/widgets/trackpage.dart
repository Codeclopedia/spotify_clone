import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_clone/service/dataController.dart';

import '../model/dataModel.dart';

class TracksPage extends StatelessWidget {
  final Item1 data;
  TracksPage({super.key, required this.data});
  dataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.08,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: data.images[0].url,
                              fit: BoxFit.cover,
                            ),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    data.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.white),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Row(
                children: [
                  FutureBuilder<String>(
                      future: controller.getIdArtistImage(data.artists[0].id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(snapshot.data!),
                            radius: MediaQuery.of(context).size.width * 0.03,
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: Text(
                      data.artists[0].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.03,
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Row(
                children: [
                  Text(
                    data.type.toString().replaceRange(0, 14, ""),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color: const Color.fromARGB(255, 134, 134, 134)),
                  ),
                  Text(
                    "." + data.releaseDate.year.toString(),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color: const Color.fromARGB(255, 134, 134, 134)),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.04),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 21, 170, 88),
                    radius: MediaQuery.of(context).size.width * 0.06,
                    child: Icon(
                      Icons.play_arrow,
                      size: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: FutureBuilder(
                future: controller.getAlbumstracks(data.id),
                builder: (futurecontext, snapshot) {
                  Widget widget = snapshot.hasData
                      ? ListView.builder(
                          itemCount: controller.albumtracks!.items.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller
                                            .albumtracks!.items[index].name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      controller.albumtracks!.items[index]
                                              .explicit
                                          ? const Icon(
                                              Icons.explicit_rounded,
                                              color: Colors.white,
                                            )
                                          : Container(),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.albumtracks!
                                              .items[index].artists.length,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder:
                                              (context, artistnameindex) {
                                            Widget widget = controller
                                                        .albumtracks!
                                                        .items[index]
                                                        .artists
                                                        .length >
                                                    1
                                                ? Text(
                                                    "${controller.albumtracks!.items[index].artists[artistnameindex].name},",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03),
                                                  )
                                                : Text(
                                                    controller
                                                        .albumtracks!
                                                        .items[index]
                                                        .artists[
                                                            artistnameindex]
                                                        .name,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  );
                                            return widget;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                highlightColor:
                                    const Color.fromARGB(255, 71, 71, 71),
                                baseColor:
                                    const Color.fromARGB(127, 58, 58, 58),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width: MediaQuery.of(context).size.width,
                                ));
                          },
                        );
                  return widget;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                data.releaseDate.toString().replaceRange(11, 23, ""),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Row(
                children: [
                  FutureBuilder<String>(
                      future: controller.getIdArtistImage(data.artists[0].id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(snapshot.data!),
                            radius: MediaQuery.of(context).size.width * 0.06,
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: Text(
                      data.artists[0].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You might also like",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          color: Colors.white)),
                  FutureBuilder(
                    future: controller
                        .getrelatedartists(data.artists[0].id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                            itemCount: controller.relatedartist.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(controller
                                              .relatedartist[index]
                                              .images[0]
                                              .url),
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          controller.relatedartist[index].name,
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
                              );
                            },
                          ),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// return CircleAvatar(
//                                               backgroundImage:
//                                                   CachedNetworkImageProvider(
//                                                       snapshot.data!),
//                                               radius: MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.15,
//                                             );