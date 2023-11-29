import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';
import '../widgets/dimenestion.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);
  static var thankYouVendorScreen = "/thankYouVendorScreen";

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        width: AddSize.screenWidth,
        height: AddSize.screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppAssets.thankYou,
                ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AddSize.size125,
            ),
            Image(
              height: AddSize.size110,
              width: double.maxFinite,
              image: const AssetImage(AppAssets.tick),
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: AddSize.size40,
            ),
            Center(
              child: Text(
                "Your Account Has Been \nSuccessfully Updated",
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Colors.white,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Center(
              child: Text(
                "Lorem Ipsum is simply dummy text of \nthe printing",
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
          ],
        ),
      )),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16, vertical: AddSize.size40),
          child: CommonButton(
            title: 'Continue',
            onPressed: () {
              Get.toNamed(MyRouters.bottomNavbar);
            },
          )),
    );
  }
}
