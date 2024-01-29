import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/screens/home_screen.dart';
import 'package:referral_app/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/bottomNav_controller.dart';
import '../controller/get_comment_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../widgets/app_theme.dart';
import '../widgets/notification_service.dart';
import 'add_recommadtion_screen.dart';
import 'ask_recommendation_screen.dart';
import 'edit_account_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final bottomController = Get.put(BottomNavBarController());
  final getRecommendationController = Get.put(GetRecommendationController());
  final getCommentController = Get.put(GetCommentController());

  manageNotification() {
    print("functionnnnn callll");
    NotificationService().initializeNotification();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Notification issss${event.notification!.title.toString()}');
      print('Notification issss${event.data['post_id']}');
      if(event.notification!.title == 'Following'){
         Get.toNamed(MyRouters.allUserProfileScreen,arguments: [event.data['post_id'].toString()]);
      }else if(event.notification!.title == 'Tag'){
        bottomController.updateIndexValue(0);
      }else if(event.notification!.title == 'Recommendation'){
        getRecommendationController.idForReco = event.data['post_id'].toString();
        getRecommendationController.idForAskReco = event.data['post_id'].toString();
        getRecommendationController.settingModalBottomSheet(context);
      }else if(event.notification!.title == 'Like'){
        getRecommendationController.idForReco = event.data['post_id'].toString();
        getRecommendationController.idForAskReco = event.data['post_id'].toString();
        getRecommendationController.settingModalBottomSheet(context);
      }else if(event.notification!.title == 'Comment' && event.data['post_type'] == 'askrecommandation'){
        getCommentController.id = event.data['post_id'].toString();
        getCommentController.type = 'askrecommandation';
        getRecommendationController.commentBottomSheet(context);
      }else if(event.notification!.title == 'Comment' && event.data['post_type'] == 'recommandation') {
        getRecommendationController.getComments(event.data['post_id'].toString(),context);
        getRecommendationController.postId = event.data['post_id'].toString();
        getRecommendationController.commentBottomSheetReco(context);
      }
    });
  }


@override
  void initState() {
    super.initState();
    manageNotification();
  }
  final pages = [
    const HomeScreen(),
    const AskRecommendationScreen(),

    // const AddRecommendationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages.elementAt(bottomController.pageIndex.value),
        extendBody: true,
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: buildMyNavBar(context),
      );
    });
  }

  buildMyNavBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: MaterialButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          bottomController.pageIndex.value == 0
                              ? SvgPicture.asset(
                                  'assets/icons/home.svg',
                                  color: AppTheme.secondaryColor,
                                )
                              : SvgPicture.asset(
                                  'assets/icons/home.svg',
                                ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: MaterialButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(1);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          bottomController.pageIndex.value == 1
                              ? SvgPicture.asset(
                                  'assets/icons/add.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/icons/add.svg',
                                ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: MaterialButton(
                        padding: const EdgeInsets.only(bottom: 10),
                        onPressed: () {
                          bottomController.updateIndexValue(2);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            bottomController.pageIndex.value == 2
                                ? SvgPicture.asset(
                                    'assets/icons/profile.svg',
                                    color: AppTheme.secondaryColor,
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/profile.svg',
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
