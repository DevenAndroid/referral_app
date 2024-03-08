import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/widgets/helper.dart';

import '../controller/profile_controller.dart';
import '../models/categories_model.dart';
import '../models/single_product_model.dart';
import '../repositories/categories_repo.dart';
import '../repositories/single_produc_repo.dart';
import '../widgets/app_assets.dart';


class CategoryViewAllScreen extends StatefulWidget {
  const CategoryViewAllScreen({super.key});

  @override
  State<CategoryViewAllScreen> createState() => _CategoryViewAllScreenState();
}

class _CategoryViewAllScreenState extends State<CategoryViewAllScreen> {

  Rx<CategoriesModel> categories = CategoriesModel().obs;
  Rx<RxStatus> statusOfCategories = RxStatus.empty().obs;
  final profileController = Get.put(ProfileController());

  chooseCategories1() {
    getCategoriesRepo().then((value) {
      categories.value = value;

      if (value.status == true) {
        statusOfCategories.value = RxStatus.success();
      } else {
        statusOfCategories.value = RxStatus.error();
      }
      setState(() {});
      // showToast(value.message.toString());
    });
  }
 @override
  void initState() {
    super.initState();
    chooseCategories1();
 //    profileController.getSingleData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Categories',
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
          return statusOfCategories.value.isSuccess ?
            SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 25),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.value.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 10, mainAxisExtent: 80),
                  itemBuilder: (BuildContext context, int index) {
                    final item = categories.value.data![index];
                    return InkWell(
                      onTap: () {
                        print("id::::${categories.value.data![index].id}");
                        print("id::::${profileController.modal.value.data!.user!.id.toString()}");
                        profileController.getSingleData(categoryId: categories.value.data![index].id.toString(),
                            userId: profileController.modal.value.data!.user!.id.toString()).then((value) {
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
                                  fit: BoxFit.cover,
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
