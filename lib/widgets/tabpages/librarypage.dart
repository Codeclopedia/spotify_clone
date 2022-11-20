import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_clone/service/dataController.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  dataController controller = Get.find();
  bool isListViewEnabled = true;
  int currentindex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
        title: Text(
          "Your Library",
          style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: Icon(
              Icons.search_outlined,
              size: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: Icon(
              Icons.add,
              size: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Obx((() => ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ListView.builder(
                    itemCount: controller.data_types.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          currentindex == index
                              ? currentindex = -1
                              : currentindex = index;
                        }),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.01),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: currentindex == index
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(color: Colors.grey)),
                            child: Text(
                              controller.data_types[index],
                              style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: currentindex == index
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: const Icon(
                              Icons.swap_vert,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Most recent",
                            style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: (() {
                            setState(() {
                              isListViewEnabled = !isListViewEnabled;
                            });
                          }),
                          icon: Icon(
                            isListViewEnabled
                                ? Icons.table_rows_outlined
                                : Icons.grid_view,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                for (int i = 0; i < controller.data_types.length; i++)
                  isListViewEnabled
                      ? currentindex == -1
                          ? recentAlbumListview(controller.data_types[i])
                          : currentindex == i
                              ? recentAlbumListview(controller.data_types[i])
                              : Container()
                      : recentAlbumGridView(controller.data_types[i]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
              ],
            ))),
      ),
    );
  }

  Widget recentAlbumListview(dataType) {
    switch (dataType) {
      case "albums":
        {
          return ListView.builder(
            itemCount:
                controller.albums.isNull ? 10 : controller.albums?.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Widget widget = controller.albums.isNull
                  ? listshimmerbox()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: CachedNetworkImage(
                                imageUrl: controller
                                    .albums!.items[index].album.images[0].url,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                child: Text(
                                  controller.albums!.items[index].album.name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
              return widget;
            },
          );
        }

      case "tracks":
        {
          return ListView.builder(
            itemCount:
                controller.tracks.isNull ? 10 : controller.tracks?.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Widget widget = controller.tracks.isNull
                  ? listshimmerbox()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: CachedNetworkImage(
                                imageUrl: controller.tracks!.items[index].track
                                    .album.images[0].url,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                child: Text(
                                  controller.tracks!.items[index].track.name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
              return widget;
            },
          );
        }

      case "episodes":
        {
          return ListView.builder(
            itemCount: controller.episodes.isNull
                ? 10
                : controller.episodes?.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Widget widget = controller.episodes.isNull
                  ? listshimmerbox()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: CachedNetworkImage(
                                imageUrl: controller.episodes!.items[index]
                                    .episode.album.images[0].url,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                child: Text(
                                  controller
                                      .episodes!.items[index].episode.name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
              return widget;
            },
          );
        }

      default:
        {
          print("shows");
        }
        break;
    }
    return Container();
  }

  Widget recentAlbumGridView(dataType) {
    switch (dataType) {
      case "albums":
        {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.albums.isNull
                  ? 10
                  : controller.albums?.items.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width * 0.0025,
                  mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.03),
              itemBuilder: (context, index) {
                Widget widget = controller.albums.isNull
                    ? gridshimmerbox()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                                imageUrl: controller
                                    .albums!.items[index].album.images[0].url),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Center(
                                child: Text(
                                  controller.albums!.items[index].album.name,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                return widget;
              });
        }

      case "tracks":
        {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.tracks.isNull
                  ? 10
                  : controller.tracks?.items.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width * 0.0025,
                  mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.03),
              itemBuilder: (context, index) {
                Widget widget = controller.tracks.isNull
                    ? gridshimmerbox()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: controller.tracks!.items[index].track
                                  .album.images[0].url,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Center(
                                child: Text(
                                  controller.tracks!.items[index].track.name,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      const Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                return widget;
              });
        }

      case "episodes":
        {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.episodes.isNull
                  ? 10
                  : controller.episodes?.items.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width * 0.0025,
                  mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.03),
              itemBuilder: (context, index) {
                Widget widget = controller.episodes.isNull
                    ? gridshimmerbox()
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: controller.episodes!.items[index]
                                  .episode.album.images[0].url,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Center(
                                child: Text(
                                  controller
                                      .episodes!.items[index].episode.name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                return widget;
              });
        }

      default:
        {
          print("shows on library page");
        }
        break;
    }
    return Container();
  }

  Widget listshimmerbox() {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01),
        child: Shimmer.fromColors(
          highlightColor: Color.fromARGB(255, 71, 71, 71),
          baseColor: const Color.fromARGB(127, 58, 58, 58),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
          ),
        ));
  }

  Widget gridshimmerbox() {
    return Shimmer.fromColors(
      highlightColor: Color.fromARGB(255, 71, 71, 71),
      baseColor: const Color.fromARGB(127, 58, 58, 58),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
