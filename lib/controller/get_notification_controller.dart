import 'package:get/get.dart';
import '../models/get_notification_model.dart';
import '../repositories/get_notification_repo.dart';

class GetNotificationController extends GetxController{
  Rx<RxStatus> statusOfGetNotification = RxStatus.empty().obs;
  Rx<GetNotificationModel> getNotificationModel = GetNotificationModel().obs;

  getNotification(){
    statusOfGetNotification.value = RxStatus.empty();
    getNotificationRepo().then((value) {
      statusOfGetNotification.value = RxStatus.success();
      getNotificationModel.value = value;
    });
 }
 @override
  void onInit() {
    super.onInit();
    getNotification();
  }
}