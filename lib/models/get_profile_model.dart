class GetProfileModel {
  bool? status;
  dynamic message;
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
  List<MyCategories>? myCategories;
  dynamic notificationCount;

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
    if (this.myCategories != null) {
      data['my_categories'] =
          this.myCategories!.map((v) => v.toJson()).toList();
    }
    data['notification_count'] = this.notificationCount;
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
  bool? isDriverOnline;
  bool? isVendorOnline;
  dynamic deliveryRange;
  bool? selfDelivery;
  dynamic countryCode;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? asMarketingManagerVerified;
  bool? isComplete;
  dynamic followingCount;
  dynamic followersCount;
  dynamic postCount;
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
        this.countryCode,
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
    countryCode = json['country_code'];
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
    data['country_code'] = this.countryCode;
    data['post_count'] = this.postCount;
    data['is_follow'] = this.isFollow;
    return data;
  }
}

class MyRequest {
  dynamic id;
  User? userId;
  dynamic title;
  dynamic description;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic image;
  dynamic postViewersType;
  bool? wishlist;
  dynamic noBudget;
  dynamic reviewCount;
  bool? isEditable;
  dynamic commentCount;
  dynamic date;

  MyRequest(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.minPrice,
        this.maxPrice,
        this.image,
        this.postViewersType,
        this.wishlist,
        this.noBudget,
        this.reviewCount,
        this.isEditable,
        this.commentCount,
        this.date});

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
    noBudget = json['no_budget'];
    reviewCount = json['review_count'];
    isEditable = json['is_editable'];
    commentCount = json['comment_count'];
    date = json['date'];
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
    data['wishlist'] = this.wishlist;
    data['no_budget'] = this.noBudget;
    data['review_count'] = this.reviewCount;
    data['is_editable'] = this.isEditable;
    data['comment_count'] = this.commentCount;
    data['date'] = this.date;
    return data;
  }
}

class MyRecommandation {
  dynamic id;
  User? user;
  dynamic askrecommandationId;
  dynamic title;
  dynamic review;
  dynamic link;
  dynamic categoryId;
  dynamic image;
  dynamic status;
  bool? wishlist;
  dynamic isComment;
  dynamic date;
  dynamic  isLike;
  dynamic likeCount;

  MyRecommandation(
      {this.id,
        this.user,
        this.askrecommandationId,
        this.title,
        this.review,
        this.link,
        this.categoryId,
        this.image,
        this.status,
        this.wishlist,
        this.isComment,
        this.likeCount,
        this.isLike,
        this.date});

  MyRecommandation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    askrecommandationId = json['askrecommandation_id'];
    title = json['title'];
    review = json['review'];
    link = json['link'];
    categoryId = json['category_id'];
    image = json['image'];
    status = json['status'];
    wishlist = json['wishlist'];
    isComment = json['is_comment'];
    isLike = json['is_like'];
    likeCount = json['like_count'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['askrecommandation_id'] = this.askrecommandationId;
    data['title'] = this.title;
    data['review'] = this.review;
    data['link'] = this.link;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['wishlist'] = this.wishlist;
    data['is_comment'] = this.isComment;
    data['is_like'] = this.isLike;
    data['like_count'] = this.likeCount;
    data['date'] = this.date;
    return data;
  }
}

class SaveRecommandation {
  dynamic id;
  Post? post;
  dynamic date;

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
  dynamic id;
  User? user;
  dynamic askrecommandationId;
  dynamic title;
  dynamic review;
  dynamic link;
  dynamic categoryId;
  dynamic image;
  dynamic status;
  bool? wishlist;
  dynamic date;
  dynamic description;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic noBudget;
  dynamic postViewersType;

  Post(
      {this.id,
        this.user,
        this.askrecommandationId,
        this.title,
        this.review,
        this.link,
        this.categoryId,
        this.image,
        this.status,
        this.wishlist,
        this.date,
        this.description,
        this.minPrice,
        this.maxPrice,
        this.noBudget,
        this.postViewersType});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    askrecommandationId = json['askrecommandation_id'];
    title = json['title'];
    review = json['review'];
    link = json['link'];
    categoryId = json['category_id'];
    image = json['image'];
    status = json['status'];
    wishlist = json['wishlist'];
    date = json['date'];
    description = json['description'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    noBudget = json['no_budget'];
    postViewersType = json['post_viewers_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['askrecommandation_id'] = this.askrecommandationId;
    data['title'] = this.title;
    data['review'] = this.review;
    data['link'] = this.link;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['wishlist'] = this.wishlist;
    data['date'] = this.date;
    data['description'] = this.description;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['no_budget'] = this.noBudget;
    data['post_viewers_type'] = this.postViewersType;
    return data;
  }
}

class MyCategories {
  dynamic id;
  dynamic taxPercent;
  dynamic name;
  dynamic slug;
  dynamic image;

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
    data['id'] = this.id;
    data['tax_percent'] = this.taxPercent;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    return data;
  }
}
