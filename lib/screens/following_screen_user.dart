import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/models/FollowersList_model.dart';

import '../controller/bottomNav_controller.dart';
import '../controller/profile_controller.dart';
import '../models/followingList_model.dart';
import '../models/unfollow_model.dart';
import '../repositories/follower_list_repo.dart';
import '../repositories/following_list_repo.dart';
import '../repositories/unfollow_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';

class FollowingScreenUser extends StatefulWidget {
  const FollowingScreenUser({super.key});

  @override
  State<FollowingScreenUser> createState() => _FollowingScreenUserState();
}

class _FollowingScreenUserState extends State<FollowingScreenUser> {
  Rx<RxStatus> statusOfFollower = RxStatus.empty().obs;
  Rx<FollowerListModel> followerList = FollowerListModel().obs;
  final bottomController = Get.put(BottomNavBarController());
  // String followers = '';
  // String following = '';
  //

  listFollower() {
    getFollowersRepo(context: context, userid: id).then((value) {
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
    getFollowingRepo(context: context, userid: id).then((value) {
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
  var follower = Get.arguments[0];
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
          // backgroundColor: const Color(0xffEAEEF1),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: profileController.profileDrawer == 0
                  ? Text(
                "Followers",
                style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 18, color: const Color(0xFF262626)),
              )
                  : Text(
                "Following",
                style: GoogleFonts.mulish(fontWeight: FontWeight.w700, fontSize: 18, color: const Color(0xFF262626)),
              ),
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(AppAssets.arrowBack),
                ),
              ),
              bottom: TabBar(
                labelColor:  const Color(0xFF3797EF),
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.primaryColor,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
                // automaticIndicatorColorAdjustment: true,
                onTap: (value) {
                  profileController.profileDrawer = value;
                  setState(() {});
                },
                tabs: [
                  Tab(
                    child: Text("Followers $follower",
                      style:  GoogleFonts.mulish(
                          fontWeight: FontWeight.w400,  fontSize: 14),
                      // style: profileController.profileDrawer == 0
                      //     ? GoogleFonts.mulish(
                      //         fontWeight: FontWeight.w400,  fontSize: 14, color: const Color(0xFF3797EF))
                      //     : GoogleFonts.mulish(
                      //         fontWeight: FontWeight.w400,  fontSize: 14, color: Colors.black)
                    ),
                  ),
                  Tab(
                    child: Text("Following $following",
                      style:  GoogleFonts.mulish(
                          fontWeight: FontWeight.w400,  fontSize: 14),
                      // style: profileController.profileDrawer == 1
                      //     ? GoogleFonts.mulish(
                      //         fontWeight: FontWeight.w400, fontSize: 14, color: const Color(0xFF3797EF))
                      //     : GoogleFonts.mulish(
                      //         fontWeight: FontWeight.w400,  fontSize: 14, color: Colors.black)
                    ),
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
                                              if(followerList
                                                  .value.data![index].following!=null)
                                              GestureDetector(
                                                onTap : (){
                                                  followerList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followerList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followerList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followerList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followerList.value.data![index].myAccount == false ?
                                                  Get.toNamed(MyRouters.allUserProfileScreen, arguments: [followerList
                                                      .value.data![index].following!.id.toString()]) : bottomController.updateIndexValue(2);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
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
                                                            errorWidget: (context, url, error) =>  Container(
                                                                padding: const EdgeInsets.all(13),
                                                                decoration:
                                                                BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                                                                child: SvgPicture.asset('assets/icons/profile.svg'))
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
                                              ),
                                              const SizedBox(
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
                                    : const Center(child: Center(child: Center(child: CircularProgressIndicator())));
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
                                          "No following List Found",
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
                                              if(followingList
                                                  .value.data![index].following!=null)
                                              GestureDetector(
                                                onTap : (){
                                                  followingList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followingList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followingList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followingList
                                                      .value.data![index].myAccount == false ? null : Get.back();
                                                  followingList
                                                      .value.data![index].myAccount == false ?  Get.toNamed(MyRouters.allUserProfileScreen, arguments: [followingList
                                                      .value.data![index].following!.id.toString()]) : bottomController.updateIndexValue(2);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
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
                                                          errorWidget: (_, __, ___) => SizedBox(),
                                                          placeholder: (_, __) => SizedBox(),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),

                                                      Expanded(
                                                        child: Text(
                                                          maxLines: 2,
                                                          followingList.value.data![index].following!.name.toString(),
                                                          style: GoogleFonts.mulish(
                                                              fontWeight: FontWeight.w400,
                                                              // letterSpacing: 1,
                                                              fontSize: 17,
                                                              color: Colors.black),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              )
                                            ],
                                          );
                                        }),
                                  ],
                                )

                                    : const Center(child: Center(child: Center(child: CircularProgressIndicator())));
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
