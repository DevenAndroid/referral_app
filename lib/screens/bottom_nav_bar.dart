import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:referral_app/screens/home_screen.dart';
import 'package:referral_app/screens/profile_screen.dart';

import '../controller/bottomNav_controller.dart';
import '../widgets/app_theme.dart';
import 'add_recommadtion_screen.dart';
import 'all_user_screen.dart';
import 'ask_recommendation_screen.dart';
import 'edit_account_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final bottomController = Get.put(BottomNavBarController());

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
        body: Center(
          child: Obx(() {
            return IndexedStack(
              index: bottomController.pageIndex.value,
              children: [
                if (bottomController.page1Index.value == 0)
                  HomeScreen(),
                if (bottomController.page1Index.value == 1)
                  AllUserProfileScreen(),
                const AskRecommendationScreen(),
                const ProfileScreen(),
              ],
            );
          }),
        ),
        extendBody: true,
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.white,
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(elevation: 0)),
                child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    unselectedLabelStyle: const TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                    selectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.primaryColor),
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/home.svg',
                              color: AppTheme.secondaryColor,
                            )),
                        label: '',
                      ),
                      // BottomNavigationBarItem(
                      //      icon: Padding(
                      //        padding: EdgeInsets.only(
                      //          bottom: 06,
                      //        ),
                      //        child: ImageIcon(
                      //          AssetImage(AppAssets.coupon),
                      //          size: 20,
                      //        ),
                      //      ),
                      //      label: '     My\nCoupons'),
                      BottomNavigationBarItem(
                          icon: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/add.svg',
                              )),
                          label: ''),
                      BottomNavigationBarItem(
                          icon: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 06,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/profile.svg',
                                color: AppTheme.secondaryColor,
                              )),
                          label: ''),
                    ],
                    type: BottomNavigationBarType.fixed,
                    currentIndex: bottomController.pageIndex.value,
                    selectedItemColor: AppTheme.primaryColor,
                    unselectedItemColor: Colors.grey.shade400,
                    onTap: bottomController.updateIndexValue,
                    elevation: 0))),
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
                        // bottomController.updateIndexValue;
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
                        // bottomController.updateIndexValue(1);
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
                          // bottomController.updateIndexValue(2);
                        },
                        child: Column(
                          children: [
                            const SizedBox(
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
