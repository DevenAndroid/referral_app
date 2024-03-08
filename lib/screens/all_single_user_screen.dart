import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/profile_controller.dart';
import '../models/model_user_profile.dart';
import '../widgets/app_assets.dart';
import '../widgets/common_error_widget.dart';

class SingleProfilePost extends StatefulWidget {
  const SingleProfilePost({super.key});

  @override
  State<SingleProfilePost> createState() => _SingleProfilePostState();
}

class _SingleProfilePostState extends State<SingleProfilePost> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
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
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(AppAssets.arrowBack),
          ),
        ),

      ),
      body: Obx(() {
        return profileController.userProfile.value.data!= null ?
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: size.height * .15,
                    child: Obx(() {
                      return ListView.builder(
                          itemCount: profileController.userProfile.value.data!.myCategories!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // profileController.categoriesController.text = item.name.toString();
                                      // profileController.idController.text = item.id.toString();
                                      // Get.back();
                                    },
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.fill,
                                        imageUrl: profileController.userProfile.value.data!.myCategories![index].image.toString(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    profileController.userProfile.value.data!.myCategories![index].name.toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w300,
                                        // letterSpacing: 1,
                                        fontSize: 14,
                                        color: Color(0xFF26282E)),
                                  )
                                ],
                              ),
                            );
                          });
                    })),
                Column(
                  children: [

                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        // Number of columns
                        crossAxisSpacing: 8.0,
                        // Spacing between columns
                        mainAxisSpacing: 2.0, // Spacing between rows
                      ),
                      itemCount: profileController.userProfile.value.data!.myRecommandation!.length,
                      // Total number of items
                      itemBuilder: (BuildContext context, int index) {
                        // You can replace the Container with your image widget
                        return CachedNetworkImage(
                          imageUrl: profileController.userProfile.value.data!.myRecommandation![index].image.toString(),
                          width: 50,
                          height: 50,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ) : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
