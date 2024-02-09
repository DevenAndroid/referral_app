import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/screens/home_screen.dart';
import 'package:referral_app/screens/profile_screen.dart';
import '../controller/bottomNav_controller.dart';
import '../controller/get_comment_controller.dart';
import '../controller/get_recommendation_controller.dart';
import '../controller/homeController.dart';
import '../controller/profile_controller.dart';
import '../widgets/app_theme.dart';
import '../widgets/notification_service.dart';
import 'ask_recommendation_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final bottomController = Get.put(BottomNavBarController());
  final getRecommendationController = Get.put(GetRecommendationController());
  final getCommentController = Get.put(GetCommentController());
  final profileController = Get.put(ProfileController(), permanent: true);
  final homeController = Get.put(HomeController());
  manageNotification() {
    print("functionnnnn callll");
    NotificationService().initializeNotification();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Notification issss${event.notification!.title.toString()}');
      print('Notification issss${event.data['post_id']}');
      switch (event.notification!.title) {
        case 'Following':
          Get.toNamed(MyRouters.allUserProfileScreen, arguments: [event.data['post_id'].toString()]);
          break;
        case 'Tag':
          bottomController.updateIndexValue(0);
          profileController.getData();
          profileController.check = false;
          homeController.getData();
          break;
        case 'Recommendation':
          getRecommendationController.idForReco = event.data['post_id'].toString();
          getRecommendationController.idForAskReco = event.data['post_id'].toString();
          profileController.getData();
          profileController.check = false;
          homeController.getData();
          getRecommendationController.settingModalBottomSheet(context);
          break;
        case 'Like':
          getRecommendationController.idForReco = event.data['parent_id'].toString();
          getRecommendationController.idForAskReco = event.data['parent_id'].toString();
          profileController.getData();
          profileController.check = false;
          homeController.getData();
          getRecommendationController.settingModalBottomSheet(context);
          break;
        case 'Comment':
          if (event.data['post_type'] == 'askrecommandation') {
            profileController.getData();
            profileController.check = false;
            homeController.getData();
            getCommentController.id = event.data['post_id'].toString();
            getCommentController.type = 'askrecommandation';
            getRecommendationController.commentBottomSheet(context);
          } else if (event.data['post_type'] == 'recommandation') {
            profileController.getData();
            profileController.check = false;
            homeController.getData();
            getRecommendationController.getComments(event.data['post_id'].toString(), context);
            getRecommendationController.postId = event.data['post_id'].toString();
            getRecommendationController.commentBottomSheetReco(context);
          }
          break;
      }
    });
  }

  // Future<void> setBatchNum(int count, BuildContext context) async {
  //   try {
  //     print('Setting badge number: $count');
  //     await FlutterDynamicIcon.setApplicationIconBadgeNumber(count);
  //     print('Badge number set successfully');
  //   } on PlatformException catch (e) {
  //     print('PlatformException: ${e.message}');
  //   } catch (e) {
  //     print('Exception: $e');
  //   }
  // }

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
                        // setBatchNum(5,context);
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
                          const SizedBox(
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
