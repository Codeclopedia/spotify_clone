import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:spotify_clone/myHomePage.dart';
import 'package:spring/spring.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isDeviceConnected = false;

  @override
  void initState() {
    super.initState();
    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        isDeviceConnected ? onConnectionAvailable() : print("no connection");
        print(isDeviceConnected);
      }
    });
  }

  onConnectionAvailable() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() => const MyHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spring.fadeIn(
            child: Image.asset(
              "assets/images/logo.png",
              scale: 10,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Spring.fadeIn(
                delay: Duration(seconds: 1),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Lottie.asset(
                      "assets/lottie/82845-music-sound-equalizer-loader.json",
                      fit: BoxFit.fitWidth),
                )),
          )
        ],
      ),
    ));
  }
}
