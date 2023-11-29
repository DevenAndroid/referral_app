import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routers/routers.dart';
import '../widgets/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  userCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('cookie') != null) {
      if (pref.getBool('complete') == true) {
        Get.toNamed(MyRouters.bottomNavbar);
      } else {
        Get.toNamed(MyRouters.createAccountScreen);
      }
    } else {
      Get.offAllNamed(MyRouters.loginScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () async {
      userCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Social Network",
              style: GoogleFonts.monomaniacOne(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3,
                  fontSize: 40,
                  color: const Color(0xFF262626)),
            ),
          )
        ],
      ),
    );
  }
}
