import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/widgets/helper.dart';
import '../controller/profile_controller.dart';
import '../models/categories_model.dart';
import '../repositories/categories_repo.dart';
import '../widgets/app_assets.dart';


class UsersCategoryList extends StatefulWidget {
  const UsersCategoryList({super.key});

  @override
  State<UsersCategoryList> createState() => _UsersCategoryListState();
}

class _UsersCategoryListState extends State<UsersCategoryList> {

  Rx<CategoriesModel> categories = CategoriesModel().obs;
  Rx<RxStatus> statusOfCategories = RxStatus.empty().obs;
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
      // profileController.getUserCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '${profileController.userProfile.value.data!.user!.name.toString().toUpperCase()} Categories',
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
        ),
        body: Obx(() {
          return profileController.statusOfUser.value.isSuccess ?
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Column(
              children: [
                if( profileController.userProfile.value.data!.myCategories!.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 3),
                    child: Center(
                        child: Text(
                          'No Data Found',
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        )),
                  ),
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 25),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileController.userProfile.value.data!.myCategories!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 10, mainAxisExtent: 80),
                  itemBuilder: (BuildContext context, int index) {
                    final item =  profileController.userProfile.value.data!.myCategories![index];
                    return InkWell(
                      onTap: () {
                        print('id is${profileController.userProfile.value.data!.myCategories![index].id.toString()}');
                        print('id is${profileController.userProfile.value.data!.user!.id.toString()}');
                        profileController.getUserCategory(categoryId: profileController.userProfile.value.data!.myCategories![index].id.toString(),
                            userId: profileController.userProfile.value.data!.user!.id.toString()).then((value) {
                          Get.back();
                          setState(() {
                          });
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffEBF1F4).withOpacity(.5)),
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: context.getSize.width * .5 * .3,
                              child: Material(
                                color: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                child: CachedNetworkImage(
                                  imageUrl: item.image.toString(),
                                  height: 50,
                                  errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red,),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                item.name.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ) : const Center(child: CircularProgressIndicator());
        })
    );
  }
}
