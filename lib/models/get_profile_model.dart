class GetProfileModel {
  bool? status;
  String? message;
  Data? data;

  GetProfileModel({this.status, this.message, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  List<MyRequest>? myRequest;
  List<MyRecommandation>? myRecommandation;
  List<SaveRecommandation>? saveRecommandation;
  int? notificationCount;

  Data({this.user,
    this.myRequest,
    this.myRecommandation,
    this.saveRecommandation,
    this.notificationCount});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['my_request'] != null) {
      myRequest = <MyRequest>[];
      json['my_request'].forEach((v) {
        myRequest!.add(new MyRequest.fromJson(v));
      });
    }
    if (json['my_recommandation'] != null) {
      myRecommandation = <MyRecommandation>[];
      json['my_recommandation'].forEach((v) {
        myRecommandation!.add(new MyRecommandation.fromJson(v));
      });
    }
    if (json['save_recommandation'] != null) {
      saveRecommandation = <SaveRecommandation>[];
      json['save_recommandation'].forEach((v) {
        saveRecommandation!.add(new SaveRecommandation.fromJson(v));
      });
    }
    notificationCount = json['notification_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.myRequest != null) {
      data['my_request'] = this.myRequest!.map((v) => v.toJson()).toList();
    }
    if (this.myRecommandation != null) {
      data['my_recommandation'] =
          this.myRecommandation!.map((v) => v.toJson()).toList();
    }
    if (this.saveRecommandation != null) {
      data['save_recommandation'] =
          this.saveRecommandation!.map((v) => v.toJson()).toList();
    }
    data['notification_count'] = this.notificationCount;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? walletBalance;
  String? earnedBalance;
  String? profileImage;
  String? address;
  String? referalCode;
  bool? isDriverOnline;
  bool? isVendorOnline;
  Null? deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? asMarketingManagerVerified;
  bool? isComplete;
  int? followingCount;
  int? followersCount;
  int? postCount;

  User({this.id,
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

  User.fromJson(Map<String, dynamic> json) {
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

class MyRequest {
  int? id;
  User? userId;
  String? title;
  String? description;
  String? minPrice;
  String? maxPrice;
  String? image;
  String? postViewersType;

  MyRequest({this.id,
    this.userId,
    this.title,
    this.description,
    this.minPrice,
    this.maxPrice,
    this.image,
    this.postViewersType});

  MyRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
    json['user_id'] != null ? new User.fromJson(json['user_id']) : null;
    title = json['title'];
    description = json['description'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    image = json['image'];
    postViewersType = json['post_viewers_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['image'] = this.image;
    data['post_viewers_type'] = this.postViewersType;
    return data;
  }
}

class MyRecommandation {
  int? id;
  User? user;
  String? title;
  String? review;
  String? link;
  String? categoryId;
  String? image;
  String? status;

  MyRecommandation({this.id,
    this.user,
    this.title,
    this.review,
    this.link,
    this.categoryId,
    this.image,
    this.status});

  MyRecommandation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    title = json['title'];
    review = json['review'];
    link = json['link'];
    categoryId = json['category_id'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['title'] = this.title;
    data['review'] = this.review;
    data['link'] = this.link;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class SaveRecommandation {
  int? id;
  Post? post;
  String? date;

  SaveRecommandation({this.id, this.post, this.date});

  SaveRecommandation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    data['date'] = this.date;
    return data;
  }
}

class Post {
  int? id;
  String? title;
  String? review;
  String? link;
  String? categoryId;
  String? image;
  String? status;

  Post({this.id,
    this.title,
    this.review,
    this.link,
    this.categoryId,
    this.image,
    this.status});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    review = json['review'];
    link = json['link'];
    categoryId = json['category_id'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['review'] = this.review;
    data['link'] = this.link;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
