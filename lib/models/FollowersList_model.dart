class FollowerListModel {
  bool? status;
  String? message;
  List<Data>? data;

  FollowerListModel({this.status, this.message, this.data});

  FollowerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? userId;
  Following? following;
  String? date;
  bool? myAccount;

  Data({this.id, this.userId, this.following, this.date,this.myAccount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    following = json['following'] != null
        ? new Following.fromJson(json['following'])
        : null;
    date = json['date'];
    myAccount = json['my_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.following != null) {
      data['following'] = this.following!.toJson();
    }
    data['date'] = this.date;
    data['my_account'] = this.myAccount;
    return data;
  }
}

class Following {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic profileImage;
  dynamic address;
  dynamic referalCode;
  dynamic  isDriverOnline;
  dynamic  isVendorOnline;
  dynamic  deliveryRange;
  dynamic  selfDelivery;
  dynamic  asDriverVerified;
  dynamic  asVendorVerified;
  dynamic  asMarketingManagerVerified;
  dynamic  isComplete;
  dynamic followingCount;
  dynamic followersCount;
  dynamic postCount;

  Following(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.walletBalance,
      this.earnedBalance,
      this.profileImage,
      this.address,
      this.referalCode,
      this.isDriverOnline,
      this.isVendorOnline,
      this.deliveryRange,
      this.selfDelivery,
      this.asDriverVerified,
      this.asVendorVerified,
      this.asMarketingManagerVerified,
      this.isComplete,
      this.followingCount,
      this.followersCount,
      this.postCount});

  Following.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    profileImage = json['profile_image'];
    address = json['address'];
    referalCode = json['referal_code'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    asMarketingManagerVerified = json['as_marketing_manager_verified'];
    isComplete = json['is_complete'];
    followingCount = json['following_count'];
    followersCount = json['followers_count'];
    postCount = json['post_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    data['referal_code'] = this.referalCode;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['as_marketing_manager_verified'] = this.asMarketingManagerVerified;
    data['is_complete'] = this.isComplete;
    data['following_count'] = this.followingCount;
    data['followers_count'] = this.followersCount;
    data['post_count'] = this.postCount;
    return data;
  }
}
