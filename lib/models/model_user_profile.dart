class ModelUserProfile {
  bool? status;
  String? message;
  Data? data;

  ModelUserProfile({this.status, this.message, this.data});

  ModelUserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
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
  List<MyCategories>? myCategories;
  int? notificationCount;

  Data(
      {this.user,
        this.myRequest,
        this.myRecommandation,
        this.saveRecommandation,
        this.myCategories,
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
    if (json['my_categories'] != null) {
      myCategories = <MyCategories>[];
      json['my_categories'].forEach((v) {
        myCategories!.add(new MyCategories.fromJson(v));
      });
    }
    notificationCount = json['notification_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (myRequest != null) {
      data['my_request'] = myRequest!.map((v) => v.toJson()).toList();
    }
    if (myRecommandation != null) {
      data['my_recommandation'] =
          myRecommandation!.map((v) => v.toJson()).toList();
    }
    if (saveRecommandation != null) {
      data['save_recommandation'] =
          saveRecommandation!.map((v) => v.toJson()).toList();
    }
    if (myCategories != null) {
      data['my_categories'] =
          myCategories!.map((v) => v.toJson()).toList();
    }
    data['notification_count'] = notificationCount;
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
  bool? isFollow;

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
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['wallet_balance'] = walletBalance;
    data['earned_balance'] = earnedBalance;
    data['profile_image'] = profileImage;
    data['address'] = address;
    data['referal_code'] = referalCode;
    data['is_driver_online'] = isDriverOnline;
    data['is_vendor_online'] = isVendorOnline;
    data['delivery_range'] = deliveryRange;
    data['self_delivery'] = selfDelivery;
    data['as_driver_verified'] = asDriverVerified;
    data['as_vendor_verified'] = asVendorVerified;
    data['as_marketing_manager_verified'] = asMarketingManagerVerified;
    data['is_complete'] = isComplete;
    data['following_count'] = followingCount;
    data['followers_count'] = followersCount;
    data['post_count'] = postCount;
    data['is_follow'] = isFollow;
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
  bool? wishlist;

  MyRequest(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.minPrice,
        this.maxPrice,
        this.image,
        this.postViewersType,
        this.wishlist});

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
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (userId != null) {
      data['user_id'] = userId!.toJson();
    }
    data['title'] = title;
    data['description'] = description;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['image'] = image;
    data['post_viewers_type'] = postViewersType;
    data['wishlist'] = wishlist;
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
  bool? wishlist;

  MyRecommandation(
      {this.id,
        this.user,
        this.title,
        this.review,
        this.link,
        this.categoryId,
        this.image,
        this.status,
        this.wishlist});

  MyRecommandation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    title = json['title'];
    review = json['review'];
    link = json['link'];
    categoryId = json['category_id'];
    image = json['image'];
    status = json['status'];
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['title'] = title;
    data['review'] = review;
    data['link'] = link;
    data['category_id'] = categoryId;
    data['image'] = image;
    data['status'] = status;
    data['wishlist'] = wishlist;
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
    data['id'] = id;
    if (post != null) {
      data['post'] = post!.toJson();
    }
    data['date'] = date;
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

  Post(
      {this.id,
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
    data['id'] = id;
    data['title'] = title;
    data['review'] = review;
    data['link'] = link;
    data['category_id'] = categoryId;
    data['image'] = image;
    data['status'] = status;
    return data;
  }
}

class MyCategories {
  int? id;
  String? taxPercent;
  String? name;
  Null? slug;
  String? image;

  MyCategories({this.id, this.taxPercent, this.name, this.slug, this.image});

  MyCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxPercent = json['tax_percent'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['tax_percent'] = taxPercent;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    return data;
  }
}
