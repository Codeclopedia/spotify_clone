import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool isListViewEnabled = true;
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
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "Name",
                        style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
            isListViewEnabled ? recentAlbumListview() : recentAlbumGridView(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ],
        ),
      ),
    );
  }

  Widget recentAlbumListview() {
    return ListView.builder(
      itemCount: 30,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
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
                    imageUrl:
                        "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/f101ee52097223.590463d3471b4.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Text(
                      "Album name",
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget recentAlbumGridView() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: 30,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width * 0.0025,
            mainAxisSpacing: MediaQuery.of(context).size.height * 0.01,
            crossAxisSpacing: MediaQuery.of(context).size.width * 0.03),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
          );
        });
  }
}
