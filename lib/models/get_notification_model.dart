class GetNotificationModel {
  bool? status;
  dynamic message;
  Data? data;

  GetNotificationModel({this.status, this.message, this.data});

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<NotificationData>? notificationData;
  dynamic notification;

  Data({this.notificationData, this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notificationData'] != null) {
      notificationData = <NotificationData>[];
      json['notificationData'].forEach((v) {
        notificationData!.add(new NotificationData.fromJson(v));
      });
    }
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationData != null) {
      data['notificationData'] =
          this.notificationData!.map((v) => v.toJson()).toList();
    }
    data['notification'] = this.notification;
    return data;
  }
}

class NotificationData {
  dynamic id;
  dynamic userId;
  dynamic postId;
  dynamic postType;
  dynamic parentId;
  dynamic title;
  dynamic body;
  dynamic seen;
  dynamic time;

  NotificationData(
      {this.id,
        this.userId,
        this.postId,
        this.postType,
        this.parentId,
        this.title,
        this.body,
        this.seen,
        this.time});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    postType = json['post_type'];
    parentId = json['parent_id'];
    title = json['title'];
    body = json['body'];
    seen = json['seen'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['post_type'] = this.postType;
    data['parent_id'] = this.parentId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['seen'] = this.seen;
    data['time'] = this.time;
    return data;
  }
}
