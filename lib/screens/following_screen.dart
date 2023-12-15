import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/main.dart';
import 'package:referral_app/models/FollowersList_model.dart';
import 'package:referral_app/routers/routers.dart';

import '../controller/profile_controller.dart';
import '../models/followingList_model.dart';
import '../models/unfollow_model.dart';
import '../repositories/follower_list_repo.dart';
import '../repositories/following_list_repo.dart';
import '../repositories/unfollow_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  Rx<RxStatus> statusOfFollower = RxStatus.empty().obs;
  Rx<FollowerListModel> followerList = FollowerListModel().obs;
  // String followers = '';
  // String following = '';
  //

  listFollower() {
    getFollowersRepo(context: context, userid:id ).then((value) {
      followerList.value = value;
      if (value.status == true) {
        statusOfFollower.value = RxStatus.success();
      } else {
        statusOfFollower.value = RxStatus.error();
      }
    });
  }

  Rx<RxStatus> statusOfFollowing = RxStatus.empty().obs;
  Rx<FollowingListModel> followingList = FollowingListModel().obs;

  listFollowing() {
    getFollowingRepo(context: context, userid:  id).then((value) {
      followingList.value = value;

      if (value.status == true) {
        statusOfFollowing.value = RxStatus.success();
      } else {
        statusOfFollowing.value = RxStatus.error();
      }
    });
  }

  Rx<RxStatus> statusOfUnfollow = RxStatus.empty().obs;
  Rx<UnfollowModel> unfollowModel = UnfollowModel().obs;
  var follower  = Get.arguments[0];
  var following = Get.arguments[1];
  var id = Get.arguments[2];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getData();

    listFollowing();
    listFollower();
  }

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: profileController.profileDrawer == 0
                  ? Text(
                      "Followers",
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xFF262626)),
                    )
                  : Text(
                      "Following",
                      style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xFF262626)),
                    ),
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(AppAssets.arrowBack),
                ),
              ),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.primaryColor,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                // automaticIndicatorColorAdjustment: true,
                onTap: (value) {
                  profileController.profileDrawer = value;
                  setState(() {});
                },
                tabs: [
                  Tab(
                    child: Text("Followers $follower",
                        style: profileController.profileDrawer == 0
                            ? GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: Color(0xFF3797EF))
                            : GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: Colors.black)),
                  ),
                  Tab(
                    child: Text("Following $following",
                        style: profileController.profileDrawer == 1
                            ? GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: Color(0xFF3797EF))
                            : GoogleFonts.mulish(
                                fontWeight: FontWeight.w700, letterSpacing: 1, fontSize: 15, color: Colors.black)),
                  ),
                ],
              ),
            ),
            body: RefreshIndicator(
              color: Colors.white,
              backgroundColor: AppTheme.primaryColor,
              onRefresh: () async {
                listFollowing();
                listFollower();
                profileController.getData();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: size.height,
                    child: TabBarView(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Obx(() {
                                return statusOfFollower.value.isSuccess
                                    ? Column(
                                        children: [
                                          if (followerList.value.data!.isEmpty)
                                            Center(
                                              child: Text(
                                                "No Followers Found",
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w400,
                                                    // letterSpacing: 1,
                                                    fontSize: 17,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: followerList.value.data!.length,
                                              physics: const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(0xFF5F5F5F).withOpacity(0.2),
                                                              offset: const Offset(0.0, 0.2),
                                                              blurRadius: 2,
                                                            ),
                                                          ]),
                                                      child: Row(
                                                        children: [
                                                          ClipOval(
                                                            child: CachedNetworkImage(
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                              imageUrl: followerList
                                                                  .value.data![index].following!.profileImage
                                                                  .toString(),
                                                              errorWidget: (_, __, ___) => Image.asset(
                                                                AppAssets.img,
                                                                color: Colors.grey.shade200,
                                                              ),
                                                              placeholder: (_, __) => Image.asset(
                                                                AppAssets.img,
                                                                color: Colors.grey.shade200,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            followerList.value.data![index].following!.name.toString(),
                                                            style: GoogleFonts.mulish(
                                                                fontWeight: FontWeight.w400,
                                                                // letterSpacing: 1,
                                                                fontSize: 17,
                                                                color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                );
                                              }),
                                        ],
                                      )
                                    : statusOfFollower.value.isError
                                        ? CommonErrorWidget(
                                            errorText: "",
                                            onTap: () {},
                                          )
                                        : const Center(child: Center(child: CircularProgressIndicator()));
                              }),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Obx(() {
                                return statusOfFollowing.value.isSuccess
                                    ? Column(
                                        children: [
                                          if (followingList.value.data!.isEmpty)
                                            Center(
                                              child: Text(
                                                "No followingList Found",
                                                style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w400,
                                                    // letterSpacing: 1,
                                                    fontSize: 17,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: followingList.value.data!.length,
                                              physics: const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(0xFF5F5F5F).withOpacity(0.2),
                                                              offset: const Offset(0.0, 0.2),
                                                              blurRadius: 2,
                                                            ),
                                                          ]),
                                                      child: Row(
                                                        children: [
                                                          ClipOval(
                                                            child: CachedNetworkImage(
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                              imageUrl: followingList
                                                                  .value.data![index].following!.profileImage
                                                                  .toString(),
                                                              errorWidget: (_, __, ___) => Image.asset(
                                                                AppAssets.man,
                                                                color: Colors.grey.shade200,
                                                              ),
                                                              placeholder: (_, __) => Image.asset(
                                                                AppAssets.man,
                                                                color: Colors.grey.shade200,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            followingList.value.data![index].following!.name.toString(),
                                                            style: GoogleFonts.mulish(
                                                                fontWeight: FontWeight.w400,
                                                                // letterSpacing: 1,
                                                                fontSize: 17,
                                                                color: Colors.black),
                                                          ),
                                                          Spacer(),
                                                          InkWell(
                                                            onTap: () {
                                                              unFollowRepo(
                                                                context: context,
                                                                following_id: followingList.value.data![index].following!.id
                                                                    .toString(),
                                                              ).then((value) async {
                                                                unfollowModel.value = value;
                                                                if (value.status == true) {
                                                                  statusOfUnfollow.value = RxStatus.success();
                                                                  listFollowing();
                                                                  showToast(value.message.toString());
                                                                } else {
                                                                  statusOfUnfollow.value = RxStatus.error();
                                                                  showToast(value.message.toString());
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                                  border: Border.all(color: AppTheme.secondaryColor)),
                                                              child: Text(
                                                                "Unfollow",
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w500,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 15,
                                                                    color: AppTheme.secondaryColor),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    )
                                                  ],
                                                );
                                              }),
                                        ],
                                      )
                                    : statusOfFollowing.value.isError
                                        ? CommonErrorWidget(
                                            errorText: "",
                                            onTap: () {},
                                          )
                                        : const Center(child: Center(child: CircularProgressIndicator()));
                              }),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            )));
  }
}
