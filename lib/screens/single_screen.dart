import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/screens/recommendation_single_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/profile_controller.dart';
import '../models/delete_recomm.dart';
import '../repositories/repo_delete_recomm.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';

class SingleScreen extends StatefulWidget {
  const SingleScreen({super.key});

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  var image = Get.arguments[0];
  var title = Get.arguments[1];
  var review = Get.arguments[2];
  var id = Get.arguments[3];
  var link = Get.arguments[4];

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  }

  Rx<ModelDeleteRecomm> deleteRecommendation = ModelDeleteRecomm().obs;
  final profileController = Get.put(ProfileController());
  Rx<RxStatus> statusOfDelete = RxStatus.empty().obs;
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightt = MediaQuery.of(context).size.height;
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
                          PopupMenuButton<SampleItem>(
                            initialValue: selectedMenu,
                            // Callback that sets the selected popup menu item.
                            onSelected: (SampleItem item) {
                              setState(() {
                                selectedMenu = item;
                              });
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemOne,
                                onTap:  () {
                                  print("object");
                                  Get.toNamed(MyRouters.addRecommendationScreen1, arguments: [id]);
                                },
                                child: InkWell(
                                    onTap: () {
                                      print("object");
                                      Get.toNamed(MyRouters.addRecommendationScreen1, arguments: [id]);
                                    },
                                    child: Text('Edit')),
                              ),
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemTwo,
                                onTap: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                        'Are you sure to delete recommendation',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      actions: <Widget>[
                                        InkWell(
                                            onTap: () {
                                              Get.back();
                                              Get.back();
                                              Get.back();
                                            },
                                            child: Text("Cancel ")),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              deleteRecommRepo(
                                                context: context,
                                                recommandation_id: id.toString(),
                                              ).then((value) async {
                                                if (value.status == true) {
                                                  deleteRecommendation.value = value;
                                                  profileController.getData();
                                                  Get.back();
                                                  Get.back();
                                                  Get.back();
                                                  print('wishlist-----');
                                                  statusOfDelete.value = RxStatus.success();

                                                  // like=true;
                                                  showToast(value.message.toString());
                                                } else {
                                                  statusOfDelete.value = RxStatus.error();
                                                  // like=false;
                                                  showToast(value.message.toString());
                                                }
                                              });
                                            },
                                            child: const Text('OK')),
                                      ],
                                    ),
                                  );
                                },
                                child: InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text(
                                            'Are you sure to delete recommendation',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          actions: <Widget>[
                                            InkWell(
                                                onTap: () {
                                                  Get.back();
                                                  Get.back();
                                                  Get.back();
                                                },
                                                child: Text("Cancel ")),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  deleteRecommRepo(
                                                    context: context,
                                                    recommandation_id: id.toString(),
                                                  ).then((value) async {
                                                    if (value.status == true) {
                                                      deleteRecommendation.value = value;
                                                      profileController.getData();
                                                      Get.back();
                                                      Get.back();
                                                      Get.back();
                                                      print('wishlist-----');
                                                      statusOfDelete.value = RxStatus.success();

                                                      // like=true;
                                                      showToast(value.message.toString());
                                                    } else {
                                                      statusOfDelete.value = RxStatus.error();
                                                      // like=false;
                                                      showToast(value.message.toString());
                                                    }
                                                  });
                                                },
                                                child: const Text('OK')),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Text('Delete')),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                Get.back();
                                setState(() {});
                              },
                              child: const Icon(Icons.clear))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title.toString(),
                              style: GoogleFonts.mulish(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xFF000000)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        review.toString(),
                        style: GoogleFonts.mulish(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF162224)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          launchURL(
                            link.toString(),
                          );
                        },
                        child: Text(
                          link.toString(),
                          style: GoogleFonts.mulish(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF3797EF)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 400,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(image),
                        )),
                        // child: Image.network(image,fit: BoxFit.fill,),
                      ),
                      // SizedBox(
                      //     //height: heightt * .40,
                      //     //width: size.width,
                      //     child: Image.network(image,fit: BoxFit.cover,height: heightt * .40,width: size.width,))
                    ]))));
  }
}
