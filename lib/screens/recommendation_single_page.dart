import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/homeController.dart';
import '../models/home_page_model.dart';
import '../models/remove_reomeendation.dart';
import '../repositories/remove_bookmark_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/routers.dart';
import '../widgets/app_assets.dart';
import '../widgets/app_theme.dart';
import '../widgets/custome_textfiled.dart';

class RecommendationSingleScreen extends StatefulWidget {
  const RecommendationSingleScreen({super.key});

  @override
  State<RecommendationSingleScreen> createState() =>
      _RecommendationSingleScreenState();
}

class _RecommendationSingleScreenState
    extends State<RecommendationSingleScreen> {

  final homeController = Get.put(HomeController());
  RxList<Recommandation> recommandationList = <Recommandation>[].obs;

  Rx<RxStatus> statusOfRemove = RxStatus.empty().obs;

  Rx<RemoveRecommendationModel> modalRemove = RemoveRecommendationModel().obs;
  var image = Get.arguments[0];
  var title = Get.arguments[1];
  var review = Get.arguments[2];
  var id = Get.arguments[3];
  var link = Get.arguments[4];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightt= MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {

                              },
                             child: const Icon(Icons.more_vert) ),
                          const SizedBox(width: 15,),
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.clear))

                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title.toString(),
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: const Color(0xFF000000)),
                          ),
                          InkWell(onTap: (){

                            Get.toNamed(MyRouters.userProfileScreen,arguments: [id]);
                          },
                            child: const Image(
                                height: 40,
                                width: 40,
                                image: AssetImage(
                                    'assets/icons/chat.png')

                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                           review.toString(),
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: const Color(0xFF162224)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Obx(() {
                              return InkWell(
                                onTap: () {
                                  // home.value.data!.discover![index].wishlist.toString();

                                  bookmarkRepo(
                                    context: context,
                                    post_id:id,
                                    type: "recommandation",
                                  ).then((value) async {
                                    modalRemove.value = value;
                                    if (value.status == true) {
                                      print('wishlist-----');
                                      homeController.getData();
                                      statusOfRemove.value = RxStatus.success();
                                      //homeController.getPaginate();

                                      // like=true;
                                      showToast(value.message.toString());
                                    } else {
                                      statusOfRemove.value = RxStatus.error();
                                      // like=false;
                                      showToast(value.message.toString());
                                    }
                                  });
                                  setState(() {});
                                },
                                child: homeController.homeModel.value.data!
                                    .recommandation![0].wishlist ==
                                    true
                                    ? SvgPicture.asset(
                                  AppAssets.bookmark1,
                                  height: 20,
                                )
                                    : SvgPicture.asset(AppAssets.bookmark),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        link.toString(),
                        style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: const Color(0xFF3797EF)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                       Container(
                         height: 400,
                         width: size.width,
                         decoration: BoxDecoration(
                           image: DecorationImage(image: NetworkImage(image),)
                         ),
                         // child: Image.network(image,fit: BoxFit.fill,),
                       ),
                        // SizedBox(
                        //     //height: heightt * .40,
                        //     //width: size.width,
                        //     child: Image.network(image,fit: BoxFit.cover,height: heightt * .40,width: size.width,))
                    ]))));
  }

}
