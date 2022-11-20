import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_clone/service/dataController.dart';
import 'package:spotify_clone/widgets/homeIcons.dart';

class LastAlbum extends StatelessWidget {
  LastAlbum({super.key});
  dataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
          Widget widget = controller.items.isEmpty
              ? Shimmer.fromColors(
                  highlightColor: Color.fromARGB(255, 71, 71, 71),
                  baseColor: const Color.fromARGB(127, 58, 58, 58),
                  child: Container(
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
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                )
              : Obx(() => Container(
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
                          child: CachedNetworkImage(
                            imageUrl: controller.items[index].images[0].url,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Expanded(
                          child: Text(
                            controller.items[index].name,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ));
          return widget;
        },
      ),
    );
  }
}
