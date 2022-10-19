import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_clone/service/dataController.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  dataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: false,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            hintText: "What do you want to listen to?",
                            contentPadding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.022),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            hintStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03)),
                      ),
                    ), //Text

                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Search",
                          style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ) //Images.network
                    ), //FlexibleSpaceBar
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                backgroundColor: Colors.black,
              ), //SliverAppBar
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Browse",
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Stack(children: [
                        CachedNetworkImage(
                            imageUrl: controller.categories.categories
                                .items[index].icons[0].url),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 00.001,
                          left: MediaQuery.of(context).size.width * 00.01,
                          child: Text(
                            controller.categories.categories.items[index].name,
                            style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ]),
                    );
                  },
                  childCount: controller.categories.categories.items.length,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ), //SliverList
            ], //<Widget>[]
          ),
        ),
      ),
    );
  }
}
