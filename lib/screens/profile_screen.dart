import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/app_assets.dart';
import 'package:share_plus/share_plus.dart';

import '../controller/profile_controller.dart';
import '../models/home_page_model.dart';
import '../repositories/home_pafe_repo.dart';
import '../widgets/app_theme.dart';
import '../widgets/common_error_widget.dart';
import '../widgets/custome_textfiled.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Rx<RxStatus> statusOfHome = RxStatus.empty().obs;

  Rx<HomeModel> home = HomeModel().obs;

  chooseCategories() {
    getHomeRepo().then((value) {
      home.value = value;

      if (value.status == true) {
        statusOfHome.value = RxStatus.success();
      } else {
        statusOfHome.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseCategories();
  }
  var currentDrawer = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFEAEEF1),
        body: SingleChildScrollView(
          child:Obx(() {
            return profileController.statusOfProfile.value.isSuccess?
              Column(
              children: [
                Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        Text("My Profile",
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: const Color(0xFF262626)
                            )),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppTheme.secondaryColor,width: 1),
                                  shape: BoxShape.circle

                              ),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppTheme.secondaryColor,width: 1),
                                  shape: BoxShape.circle

                                ),
                                child: ClipOval(

                                  child: CachedNetworkImage(
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    imageUrl: profileController
                                        .modal.value.data!.user!.profileImage
                                        .toString(),
                                    placeholder: (context, url) =>
                                    const SizedBox(),
                                    errorWidget: (context, url, error) =>
                                    const SizedBox(),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(profileController.modal.value.data!.user!.postCount.toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: const Color(0xFF000000)
                                    )),
                                const SizedBox(height: 7,),
                                Text("Posts",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: const Color(0xFF262626)
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                Text(profileController.modal.value.data!.user!.followersCount.toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: const Color(0xFF000000)
                                    )),
                                const SizedBox(height: 7,),
                                Text("Followers",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: const Color(0xFF262626)
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                Text(profileController.modal.value.data!.user!.followingCount.toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: const Color(0xFF000000)
                                    )),
                                const SizedBox(height: 7,),
                                Text("Following",
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: const Color(0xFF262626)
                                    )),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(profileController.modal.value.data!.user!.name.toString(),
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: const Color(0xFF262626)
                            )),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.call),
                            SizedBox(width: 6,),
                            Text(profileController.modal.value.data!.user!.phone.toString(),
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: const Color(0xFF262626)
                                )),
                            const Spacer(),
                            SizedBox(
                                width: 70,
                                height: 30,
                                child: CommonButton(title: "Edit",onPressed: (){
                                  Get.toNamed(MyRouters.editAccount);
                                },))
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.location1),
                            SizedBox(width: 6,),
                            Text(profileController.modal.value.data!.user!.address.toString(),
                                style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: const Color(0xFF262626)
                                )),


                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            padding: EdgeInsets.zero,
                            isScrollable: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            // indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: AppTheme.primaryColor,
                            indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
                            // automaticIndicatorColorAdjustment: true,
                            onTap: (value) {
                              currentDrawer = value;
                              setState(() {});
                              print(currentDrawer);
                            },
                            tabs: [
                              Tab(
                                child: Text(
                                    "My Requests",
                                    style: currentDrawer == 0
                                        ? GoogleFonts.mulish(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                        fontSize: 15,
                                        color: const Color(0xFF3797EF))
                                        :GoogleFonts.mulish(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                        fontSize: 15,
                                        color: Colors.black)
                                ),
                              ),
                              Tab(
                                child: Text(
                                    "My recommendations",
                                    style: currentDrawer == 1
                                        ?
                                    GoogleFonts.mulish(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                        fontSize: 15,
                                        color: const Color(0xFF3797EF))
                                        : GoogleFonts.mulish(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                        fontSize: 15,
                                        color: Colors.black)
                                ),
                              ),
                              Tab(
                                child: Text(
                                    "Saved recommendations",
                                    style: currentDrawer == 2
                                        ?
                                    GoogleFonts.mulish(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                        fontSize: 15,
                                        color: const Color(0xFF3797EF))
                                        : GoogleFonts.mulish(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                        fontSize: 15,
                                        color: Colors.black)
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Obx(() {

                                return statusOfHome.value.isSuccess ?

                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:  home.value.data!.discover!.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return
                                        Column(
                                          children: [
                                            Container(
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
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipOval(
                                                        child: CachedNetworkImage(
                                                          width: 30,
                                                          height: 30,
                                                          fit: BoxFit.cover,
                                                          imageUrl: home.value.data!.discover![index].userId!.profileImage.toString(),
                                                          placeholder: (context, url) =>
                                                              Image.asset(AppAssets.girl),
                                                          errorWidget: (context, url, error) =>
                                                              Image.asset(AppAssets.girl),
                                                        ),
                                                      ),

                                                      const SizedBox(width: 20,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          home.value.data!.discover![index].userId!.name ==""? Text("Name..."  , style: GoogleFonts.mulish(
                                                              fontWeight: FontWeight.w700,
                                                              // letterSpacing: 1,
                                                              fontSize: 14,
                                                              color: Colors.black),): Text(
                                                            home.value.data!.discover![index].userId!.name.toString(),
                                                            style: GoogleFonts.mulish(
                                                                fontWeight: FontWeight.w700,
                                                                // letterSpacing: 1,
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                          ),
                                                          Row(
                                                            children: [
                                                              home.value.data!.discover![index].userId!.address ==""? Text("address..."  , style: GoogleFonts.mulish(
                                                                  fontWeight: FontWeight.w400,
                                                                  // letterSpacing: 1,
                                                                  fontSize: 14,
                                                                  color: const Color(0xFF878D98)),): Text(
                                                                home.value.data!.discover![index].userId!.address.toString(),
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w400,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 14,
                                                                    color: const Color(0xFF878D98)),
                                                              ),

                                                              const SizedBox(
                                                                height: 11,
                                                                child: VerticalDivider(
                                                                  width: 8,
                                                                  thickness: 1,
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                              Text(
                                                                "3 Hour",
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w300,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 12,
                                                                    color: const Color(0xFF878D98)),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(AppAssets.bookmark),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Stack(children: [
                                                    CachedNetworkImage(
                                                      width: size.width,
                                                      height: 200,
                                                      fit: BoxFit.fill,

                                                      imageUrl:home.value.data!.discover![index].image.toString(),
                                                      placeholder: (context, url) =>
                                                          Image.asset(AppAssets.picture),
                                                      errorWidget: (context, url, error) =>
                                                          Image.asset(AppAssets.picture),
                                                    ),

                                                    Positioned(
                                                        right: 10,
                                                        top: 15,
                                                        child:
                                                        Container(
                                                          padding: const EdgeInsets.all(6),
                                                          decoration: (
                                                              BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(15),
                                                              )

                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(Icons.remove_red_eye_outlined,size: 20,),
                                                              Text(
                                                                " Views  7.5k",
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w500,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 14,
                                                                    color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                        ))

                                                  ]),
                                                  const SizedBox(height: 10,),
                                                  Text(
                                                    home.value.data!.discover![index].title.toString(),
                                                    style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w700,
                                                        // letterSpacing: 1,
                                                        fontSize: 17,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Text(
                                                    home.value.data!.discover![index].description.toString(),
                                                    style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w300,
                                                        // letterSpacing: 1,
                                                        fontSize: 14,
                                                        color: const Color(0xFF6F7683)),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Container(
                                                    padding: const EdgeInsets.all(5),
                                                    width: 150,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF3797EF).withOpacity(.09),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(AppAssets.message),
                                                        const SizedBox(width: 6,),
                                                        Text(
                                                          "Recommendations: 120",
                                                          style: GoogleFonts.mulish(
                                                              fontWeight: FontWeight.w500,
                                                              // letterSpacing: 1,
                                                              fontSize: 12,
                                                              color: const Color(0xFF3797EF)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15,)
                                          ],
                                        );

                                    })
                                    : statusOfHome.value.isError
                                    ? CommonErrorWidget(
                                  errorText: "",
                                  onTap: () {},
                                )
                                    : const Center(
                                    child: CircularProgressIndicator());
                              })
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Stack(
                            children:[ Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height*.15,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:  5,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return
                                            Row(
                                              children: [
                                                Column(
                                                    children: [
                                                      Image.asset(AppAssets.office),
                                                      Text("My office",
                                                          style: GoogleFonts.mulish(
                                                              fontWeight: FontWeight.w300,
                                                              fontSize: 14,
                                                              color: const Color(0xFF26282E)
                                                          ))

                                                    ]),
                                                SizedBox(width: 10,)
                                              ],
                                            );}),
                                  ),
                                  GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, // Number of columns
                                      crossAxisSpacing: 8.0, // Spacing between columns
                                      mainAxisSpacing: 2.0, // Spacing between rows
                                    ),
                                    itemCount: 9, // Total number of items
                                    itemBuilder: (BuildContext context, int index) {
                                      // You can replace the Container with your image widget
                                      return Image.asset(AppAssets.laptop);
                                    },
                                  ),
                                ],
                              ),
                            ),
                              Positioned(
                                  bottom: 80,right: 10,
                                  child: InkWell(
                                      onTap: (){
                                        Get.toNamed(MyRouters.addRecommendationScreen);
                                      },
                                      child: SvgPicture.asset(AppAssets.add1)))
                            ]),
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Obx(() {

                                return statusOfHome.value.isSuccess ?

                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:  home.value.data!.discover!.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return
                                        Column(
                                          children: [
                                            Container(
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
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipOval(
                                                        child: CachedNetworkImage(
                                                          width: 30,
                                                          height: 30,
                                                          fit: BoxFit.cover,
                                                          imageUrl: home.value.data!.discover![index].userId!.profileImage.toString(),
                                                          placeholder: (context, url) =>
                                                              Image.asset(AppAssets.girl),
                                                          errorWidget: (context, url, error) =>
                                                              Image.asset(AppAssets.girl),
                                                        ),
                                                      ),

                                                      const SizedBox(width: 20,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          home.value.data!.discover![index].userId!.name ==""? Text("Name..."  , style: GoogleFonts.mulish(
                                                              fontWeight: FontWeight.w700,
                                                              // letterSpacing: 1,
                                                              fontSize: 14,
                                                              color: Colors.black),): Text(
                                                            home.value.data!.discover![index].userId!.name.toString(),
                                                            style: GoogleFonts.mulish(
                                                                fontWeight: FontWeight.w700,
                                                                // letterSpacing: 1,
                                                                fontSize: 14,
                                                                color: Colors.black),
                                                          ),
                                                          Row(
                                                            children: [
                                                              home.value.data!.discover![index].userId!.address ==""? Text("address..."  , style: GoogleFonts.mulish(
                                                                  fontWeight: FontWeight.w400,
                                                                  // letterSpacing: 1,
                                                                  fontSize: 14,
                                                                  color: const Color(0xFF878D98)),): Text(
                                                                home.value.data!.discover![index].userId!.address.toString(),
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w400,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 14,
                                                                    color: const Color(0xFF878D98)),
                                                              ),

                                                              const SizedBox(
                                                                height: 11,
                                                                child: VerticalDivider(
                                                                  width: 8,
                                                                  thickness: 1,
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                              Text(
                                                                "3 Hour",
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w300,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 12,
                                                                    color: const Color(0xFF878D98)),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(AppAssets.bookmark),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Stack(children: [
                                                    CachedNetworkImage(
                                                      width: size.width,
                                                      height: 200,
                                                      fit: BoxFit.fill,

                                                      imageUrl:home.value.data!.discover![index].image.toString(),
                                                      placeholder: (context, url) =>
                                                          Image.asset(AppAssets.picture),
                                                      errorWidget: (context, url, error) =>
                                                          Image.asset(AppAssets.picture),
                                                    ),

                                                    Positioned(
                                                        right: 10,
                                                        top: 15,
                                                        child:
                                                        Container(
                                                          decoration: (
                                                              BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                              )

                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(Icons.remove_red_eye_outlined),
                                                              Text(
                                                                "Views  7.5k",
                                                                style: GoogleFonts.mulish(
                                                                    fontWeight: FontWeight.w400,
                                                                    // letterSpacing: 1,
                                                                    fontSize: 10,
                                                                    color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                        ))

                                                  ]),
                                                  const SizedBox(height: 10,),
                                                  Text(
                                                    home.value.data!.discover![index].title.toString(),
                                                    style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w700,
                                                        // letterSpacing: 1,
                                                        fontSize: 17,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Text(
                                                    home.value.data!.discover![index].description.toString(),
                                                    style: GoogleFonts.mulish(
                                                        fontWeight: FontWeight.w300,
                                                        // letterSpacing: 1,
                                                        fontSize: 14,
                                                        color: const Color(0xFF6F7683)),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Container(
                                                    padding: const EdgeInsets.all(5),
                                                    width: 150,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF3797EF).withOpacity(.09),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(AppAssets.message),
                                                        const SizedBox(width: 6,),
                                                        Text(
                                                          "Recommendations: 120",
                                                          style: GoogleFonts.mulish(
                                                              fontWeight: FontWeight.w500,
                                                              // letterSpacing: 1,
                                                              fontSize: 12,
                                                              color: const Color(0xFF3797EF)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15,)
                                          ],
                                        );

                                    })
                                    : statusOfHome.value.isError
                                    ? CommonErrorWidget(
                                  errorText: "",
                                  onTap: () {},
                                )
                                    : const Center(
                                    child: CircularProgressIndicator());
                              })
                            ],
                          ),
                        ),
                      ),





                    ]),
                  ),
                ),
              ],
            ): profileController.statusOfProfile.value.isError
                ? CommonErrorWidget(
              errorText: "",
              onTap: () {},
            )
                : const Center(
                child: Center(child: CircularProgressIndicator()));
          })

        ),
      ),
    );
  }
}
