import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resourses/api_constant.dart';
import '../../widgets/common_error_widget.dart';
import '../controller/profile_controller.dart';
import '../models/categories_model.dart';
import '../repositories/categories_repo.dart';
import '../routers/routers.dart';
import '../widgets/common_textfield.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Rx<RxStatus> statusOfCategories = RxStatus.empty().obs;

  Rx<CategoriesModel> categories = CategoriesModel().obs;

  chooseCategories() {
    getCategoriesRepo().then((value) {
      categories.value = value;

      if (value.status == true) {
        statusOfCategories.value = RxStatus.success();
      } else {
        statusOfCategories.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseCategories();
  }

  final profileController = Get.put(ProfileController());

  // final controller = Get.put(registerController());
  final TextEditingController search1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              // color: AppTheme.primaryColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Choose Catrgories",
            style: GoogleFonts.poppins(
                color: const Color(0xFF1D1D1D),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextfield(
                        controller: search1Controller,
                        obSecure: false,
                        hintText: "Search for a catrgories",
                        prefix: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Icon(Icons.search)),
                        onTap: () {
                          setState(() {});
                        },
                        onChanged: (gt) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        List<Data> searchData = [];
                        if (statusOfCategories.value.isSuccess &&
                            categories.value.data != null) {
                          String search =
                              search1Controller.text.trim().toLowerCase();
                          if (search.isNotEmpty) {
                            searchData = categories.value.data!
                                .where((element) => element.name
                                    .toString()
                                    .toLowerCase()
                                    .contains(search))
                                .toList();
                          } else {
                            searchData = categories.value.data!;
                          }
                        }
                        return statusOfCategories.value.isSuccess
                            ? ListView.builder(
                                itemCount: searchData.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item = searchData[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            profileController
                                                .categoriesController
                                                .text = item.name.toString();
                                            profileController.idController
                                                .text = item.id.toString();
                                            Get.back();
                                          },
                                          child: Text(
                                            item.name.toString(),
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xFF1D1D1D),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                      ],
                                    ),
                                  );
                                })
                            : statusOfCategories.value.isError
                                ? CommonErrorWidget(
                                    errorText: "",
                                    onTap: () {},
                                  )
                                : const Center(
                                    child: CircularProgressIndicator());
                      })
                    ]))));
  }
}
