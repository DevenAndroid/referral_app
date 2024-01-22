class GetSingleRequestModel {
  dynamic status;
  dynamic message;
  Data? data;

  GetSingleRequestModel({this.status, this.message, this.data});

  GetSingleRequestModel.fromJson(Map<String, dynamic> json) {
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
  AskRecommandation? askRecommandation;
  List<TagFriends>? tagFriends;

  Data({this.askRecommandation, this.tagFriends});

  Data.fromJson(Map<String, dynamic> json) {
    askRecommandation = json['askRecommandation'] != null
        ? new AskRecommandation.fromJson(json['askRecommandation'])
        : null;
    if (json['tagFriends'] != null) {
      tagFriends = <TagFriends>[];
      json['tagFriends'].forEach((v) {
        tagFriends!.add(new TagFriends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.askRecommandation != null) {
      data['askRecommandation'] = this.askRecommandation!.toJson();
    }
    if (this.tagFriends != null) {
      data['tagFriends'] = this.tagFriends!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AskRecommandation {
 dynamic id;
  User? user;
  dynamic title;
  dynamic description;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic noBudget;
  dynamic image;
  dynamic postViewersType;
  dynamic date;

  AskRecommandation(
      {this.id,
        this.user,
        this.title,
        this.description,
        this.minPrice,
        this.maxPrice,
        this.noBudget,
        this.image,
        this.postViewersType,
        this.date});

  AskRecommandation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    title = json['title'];
    description = json['description'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    noBudget = json['no_budget'];
    image = json['image'];
    postViewersType = json['post_viewers_type'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['no_budget'] = this.noBudget;
    data['image'] = this.image;
    data['post_viewers_type'] = this.postViewersType;
    data['date'] = this.date;
    return data;
  }
}

class User {
 dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic profileImage;
  dynamic address;
  dynamic referalCode;
  dynamic countryCode;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic asMarketingManagerVerified;
  dynamic isComplete;
 dynamic followingCount;
 dynamic followersCount;
 dynamic postCount;
  dynamic isFollow;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.walletBalance,
        this.earnedBalance,
        this.profileImage,
        this.address,
        this.referalCode,
        this.countryCode,
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
        this.postCount,
        this.isFollow});

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
    countryCode = json['country_code'];
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
    isFollow = json['is_follow'];
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
    data['country_code'] = this.countryCode;
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
    data['is_follow'] = this.isFollow;
    return data;
  }
}

class TagFriends {
 dynamic askRecommandationId;
 dynamic userId;

  TagFriends({this.askRecommandationId, this.userId});

  TagFriends.fromJson(Map<String, dynamic> json) {
    askRecommandationId = json['ask_recommandation_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask_recommandation_id'] = this.askRecommandationId;
    data['user_id'] = this.userId;
    return data;
  }
}
