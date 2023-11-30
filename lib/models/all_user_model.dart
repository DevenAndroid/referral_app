class AllUserModel {
  bool? status;
  String? message;
  List<UserList>? data;

  AllUserModel({this.status, this.message, this.data});

  AllUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserList>[];
      json['data'].forEach((v) {
        data!.add(new UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  int? otp;
  String? otpCreatedAt;
  int? otpVerified;
  String? profileImage;
  Null? deviceId;
  Null? deviceToken;
  int? status;
  int? isComplete;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  UserList(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.address,
        this.otp,
        this.otpCreatedAt,
        this.otpVerified,
        this.profileImage,
        this.deviceId,
        this.deviceToken,
        this.status,
        this.isComplete,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    otpVerified = json['otp_verified'];
    profileImage = json['profile_image'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
    status = json['status'];
    isComplete = json['is_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    data['otp_verified'] = this.otpVerified;
    data['profile_image'] = this.profileImage;
    data['device_id'] = this.deviceId;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['is_complete'] = this.isComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
