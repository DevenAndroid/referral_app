import 'package:get/get.dart';
import 'package:referral_app/models/notification_count_model.dart';

import '../repositories/notificationCount_repo.dart';

class NotificationCountController extends GetxController {

  Rx<RxStatus> statusOfGetNotification = RxStatus.empty().obs;
  Rx<NotificationCountModel> getNotificationCountModel = NotificationCountModel().obs;

  getNotification(){
    statusOfGetNotification.value = RxStatus.empty();
    notificationCountRepo().then((value) {
      statusOfGetNotification.value = RxStatus.success();
      getNotificationCountModel.value = value;
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotification();
  }
}