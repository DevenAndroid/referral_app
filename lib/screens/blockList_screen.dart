import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:referral_app/widgets/custome_textfiled.dart';

import '../models/block_list_model.dart';
import '../repositories/addblock_remove_repo.dart';
import '../repositories/get_block_list_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/app_assets.dart';


class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class _BlockUserScreenState extends State<BlockUserScreen> {

  Rx<RxStatus> statusOfBlockList = RxStatus
      .empty()
      .obs;
  Rx<ModelBlockList> modelBlockList = ModelBlockList().obs;

  blockList() {
    getBlockListRepo(context: context).then((value) {
      modelBlockList.value = value;

      if (value.status == true) {
        statusOfBlockList.value = RxStatus.success();
      } else {
        statusOfBlockList.value = RxStatus.error();
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    blockList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Block User List',
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
        body: SafeArea(
          child: Obx(() {
            return  statusOfBlockList.value.isSuccess ?
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: modelBlockList.value.data!.isNotEmpty && modelBlockList.value.data!= null ?
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: modelBlockList.value.data!.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = modelBlockList.value.data![index].blockUserId!;
                    return Column(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        imageUrl: item.profileImage.toString(),
                                        errorWidget: (context, url, error) =>
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset('assets/icons/profile.svg'),
                                              ],
                                            )
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    item.name.toString(),
                                    style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w400,
                                        // letterSpacing: 1,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.black
                                    )
                                ),
                                child: GestureDetector(
                                  child: Text('Unblock', style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),),
                                  onTap: () {
                                    addRemoveBlockRepo(blockUserId: item.id.toString(), context: context).then((value) {
                                      if (value.status == true) {
                                        showToast(value.message.toString());
                                        blockList();
                                      }
                                      else {
                                        showToast(value.message.toString());
                                      }
                                    });
                                  },),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  }) :  Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height / 3),
                  child: Center(
                      child: Text(
                        'No Data Found',
                        style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      )),
                ),
              ) : const Center(child: CircularProgressIndicator());
          }),
        )
    );
  }
}
