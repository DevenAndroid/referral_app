import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../widgets/app_assets.dart';
import '../widgets/common_error_widget.dart';

class ProfilePost extends StatefulWidget {
  const ProfilePost({super.key});

  @override
  State<ProfilePost> createState() => _ProfilePostState();
}

class _ProfilePostState extends State<ProfilePost> {
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:
           Text(
          "Posts",
          style: GoogleFonts.mulish(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFF262626)),
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

      ),
      body:           SingleChildScrollView(
        physics:
        const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                  height: size.height * .15,
                  child: Obx(() {
                    return profileController
                        .statusOfProfile
                        .value
                        .isSuccess
                        ? ListView.builder(
                        itemCount:   profileController.modal.value.data!.myCategories!.length,
                        shrinkWrap: true,
                        scrollDirection:
                        Axis.horizontal,
                        physics:
                        const AlwaysScrollableScrollPhysics(),
                        itemBuilder:
                            (context, index) {
                          return Padding(
                            padding:
                            const EdgeInsets
                                .all(8.0),
                            child: Column(
                              children: [

                                InkWell(
                                  onTap: () {
                                    // profileController.categoriesController.text = item.name.toString();
                                    // profileController.idController.text = item.id.toString();
                                    // Get.back();
                                  },
                                  child:
                                  ClipOval(
                                    child:
                                    CachedNetworkImage(
                                      width: 70,
                                      height:
                                      70,
                                      fit: BoxFit
                                          .fill,
                                      imageUrl:    profileController.modal.value.data!.myCategories![index].image.toString(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  profileController.modal
                                      .value
                                      .data!.myCategories![index]
                                      .name
                                      .toString(),
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w300,
                                      // letterSpacing: 1,
                                      fontSize: 14,
                                      color: Color(0xFF26282E)),
                                )
                              ],
                            ),
                          );
                        })
                        : profileController
                        .statusOfProfile
                        .value
                        .isError
                        ? CommonErrorWidget(
                      errorText: "",
                      onTap: () {},
                    )
                        : const Center(
                        child:
                        CircularProgressIndicator());
                  })),
              Column(
                children: [
                  if(profileController
                      .modal
                      .value
                      .data!
                      .myRecommandation!.isEmpty)
                    Text("No data found "),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // Number of columns
                      crossAxisSpacing: 10.0,
                      // Spacing between columns
                      mainAxisSpacing:
                      10.0, // Spacing between rows
                    ),
                    itemCount: profileController
                        .modal
                        .value
                        .data!
                        .myRecommandation!
                        .length,
                    // Total number of items
                    itemBuilder: (BuildContext context,
                        int index) {

                      // You can replace the Container with your image widget
                      return  Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: profileController
                              .modal
                              .value
                              .data!
                              .myRecommandation![index]
                              .image
                              .toString(),
                         fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
