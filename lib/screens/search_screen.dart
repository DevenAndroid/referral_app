import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../resourses/api_constant.dart';
import '../../widgets/common_error_widget.dart';
import '../controller/profile_controller.dart';
import '../models/all_recommendation_model.dart';
import '../models/categories_model.dart';
import '../models/search_model.dart';
import '../repositories/all_recommendation_repo.dart';
import '../repositories/categories_repo.dart';
import '../repositories/search_repo.dart';
import '../routers/routers.dart';
import '../widgets/common_textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Rx<RxStatus> statusOfAllRecommendation = RxStatus.empty().obs;
  Rx<AllRecommendationModel> allRecommendation = AllRecommendationModel().obs;
  all() {
    getAllRepo().then((value) {
      allRecommendation.value = value;

      if (value.status == true) {
        statusOfAllRecommendation.value = RxStatus.success();
      } else {
        statusOfAllRecommendation.value = RxStatus.error();
      }

      // showToast(value.message.toString());
    });
  }






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    all();
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
          leading: InkWell(
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
            "Search",
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
                            child: Icon(Icons.search)
                        ),
                        onTap: (){
                          setState(() {

                          });
                        },
                        onChanged: (gt){

                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        List<AllRecommendation> searchData=[];
                        if(statusOfAllRecommendation.value.isSuccess && allRecommendation.value.data!= null){
                          String search = search1Controller.text.trim().toLowerCase();
                          if(search.isNotEmpty) {
                            searchData = allRecommendation.value.data!.where((element) => element.title.toString().toLowerCase().contains(search)
                            ).toList();
                          } else {
                            searchData = allRecommendation.value.data!;
                          }
                        }
                        return   statusOfAllRecommendation.value.isSuccess
                            ? GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // Number of columns
                            crossAxisSpacing: 8.0,
                            // Spacing between columns
                            mainAxisSpacing: 2.0, // Spacing between rows
                          ),
                          itemCount: searchData.length,
                          // Total number of items
                          itemBuilder: (BuildContext context, int index) {
                            final item = searchData[index];
                            // You can replace the Container with your image widget
                            return CachedNetworkImage(
                              imageUrl: item.image.toString(),
                              width: 50,
                              height: 50,
                            );
                          },
                        )
                            : statusOfAllRecommendation.value.isError
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
