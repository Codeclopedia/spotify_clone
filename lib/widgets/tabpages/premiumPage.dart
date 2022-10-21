import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotify_clone/widgets/premiumPlans.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumPage extends StatelessWidget {
  PremiumPage({super.key});

  final List benifitsofPremiumdata = [
    "Download to listen offline without wifi",
    "Music without ad interruptions",
    "2x higher sound quality than our free plan",
    "Play songs in any order, with unlimited skips",
    "Cancel monthly plans online anytime"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: false,
                pinned: false,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    //Text
                    background: CachedNetworkImage(
                      imageUrl:
                          "https://techcrunch.com/wp-content/uploads/2021/03/Spotify-Mix-Image-2.jpg",
                      fit: BoxFit.fitHeight,
                    ) //Images.network
                    ), //FlexibleSpaceBar
                expandedHeight: MediaQuery.of(context).size.height * 0.3,

                backgroundColor: Colors.black,
                leadingWidth: MediaQuery.of(context).size.width * 0.33,
                leading: Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        "assets/images/logo.png",
                        color: Colors.white,
                      ),
                      tooltip: 'Menu',
                      onPressed: () {},
                    ),
                    Text(
                      "Premium",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.044),
                    )
                  ],
                ), //IconButton
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Text("FREE TRIAL",
                          style: GoogleFonts.montserrat(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Text("Try Premium free for 1 month",
                          style: GoogleFonts.montserrat(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final Uri _url = Uri.parse(
                              'https://www.spotify.com/in-en/premium/');
                          await launchUrl(_url);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.02)),
                            fixedSize: MaterialStateProperty.all(
                              Size.fromWidth(
                                  MediaQuery.of(context).size.width * 0.9),
                            )),
                        child: Text(
                          "Get Premium",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                            children: const [
                          TextSpan(
                              text:
                                  "From ₹119/month after. Offer only for users who are new to premium."),
                          TextSpan(
                              text: "Terms and condition apply.",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ])),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.04),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Text("Why join Premium?",
                                    style: GoogleFonts.montserrat(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              ListView.builder(
                                itemCount: benifitsofPremiumdata.length,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        benifitsofPremiumdata[index],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      child: Text("Pick your premium",
                          style: GoogleFonts.montserrat(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    const PremiumPlans(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                  ],
                ),
              ),
              //SliverList
              //Scaffold
            ],
          ),
        ),
      ),
    );
  }
}
