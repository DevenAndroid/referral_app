import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';

class SingleScreen extends StatefulWidget {
  const SingleScreen({super.key});

  @override
  State<SingleScreen> createState() =>
      _SingleScreenState();
}

class _SingleScreenState
    extends State<SingleScreen> {
  var image = Get.arguments[0];
  var title = Get.arguments[1];
  var review = Get.arguments[2];
  var id = Get.arguments[3];
  var link = Get.arguments[4];

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightt= MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.clear))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title.toString(),
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color(0xFF000000)),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        review.toString(),
                        style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFF162224)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          launchURL(link.toString(),);
                        },
                        child: Text(
                          link.toString(),
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF3797EF)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 400,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(image),)
                        ),
                        // child: Image.network(image,fit: BoxFit.fill,),
                      ),
                      // SizedBox(
                      //     //height: heightt * .40,
                      //     //width: size.width,
                      //     child: Image.network(image,fit: BoxFit.cover,height: heightt * .40,width: size.width,))
                    ]))));
  }
}
