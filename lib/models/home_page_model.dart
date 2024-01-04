class HomeModel {
  bool? status;
  String? message;
  Data? data;
  Meta? meta;
  Link? link;

  HomeModel({this.status, this.message, this.data, this.meta, this.link});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.link != null) {
      data['link'] = this.link!.toJson();
    }
    return data;
  }
}

class Data {
  List<Discover>? discover;
  List<Recommandation>? recommandation;

  Data({this.discover, this.recommandation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['discover'] != null) {
      discover = <Discover>[];
      json['discover'].forEach((v) {
        discover!.add(new Discover.fromJson(v));
      });
    }
    if (json['recommandation'] != null) {
      recommandation = <Recommandation>[];
      json['recommandation'].forEach((v) {
        recommandation!.add(new Recommandation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discover != null) {
      data['discover'] = this.discover!.map((v) => v.toJson()).toList();
    }
    if (this.recommandation != null) {
      data['recommandation'] =
          this.recommandation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Discover {
  int? id;
  UserId? userId;
  String? title;
  String? description;
  String? minPrice;
  String? maxPrice;
  String? image;
  String? postViewersType;
  bool? wishlist;
  int? noBudget;
  int? reviewCount;
  String? date;
  bool? isEditable;
  int? commentCount;

  Discover(
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

  Discover.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
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
    data['date'] = this.date;
    data['comment_count'] = this.commentCount;
    data['is_editable'] = this.isEditable;
    return data;
  }
}

class UserId {
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
  dynamic deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? asMarketingManagerVerified;
  bool? isComplete;
  int? followingCount;
  int? followersCount;
  int? postCount;
  bool? isFollow;

  UserId(
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

  UserId.fromJson(Map<String, dynamic> json) {
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
    data['is_follow'] = this.isFollow;
    return data;
  }
}

class Recommandation {
  int? id;
  UserId? user;
  int? askrecommandationId;
  String? title;
  String? review;
  String? link;
  String? categoryId;
  String? image;
  String? status;
  bool? wishlist;
  bool? isEditable;
  String? date;
  int? commentCount;

  Recommandation(
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
        this.isEditable,
        this.commentCount,
        this.date});

  Recommandation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new UserId.fromJson(json['user']) : null;
    askrecommandationId = json['askrecommandation_id'];
    title = json['title'];
    review = json['review'];
    link = json['link'];
    categoryId = json['category_id'];
    image = json['image'];
    status = json['status'];
    wishlist = json['wishlist'];
    isEditable = json['is_editable'];
    commentCount = json['comment_count'];
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
    data['is_editable'] = this.isEditable;
    data['comment_count'] = this.commentCount;
    data['date'] = this.date;
    return data;
  }
}

class Meta {
  int? totalPage;
  int? currentPage;
  int? totalItem;
  int? perPage;

  Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    totalItem = json['total_item'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['total_item'] = this.totalItem;
    data['per_page'] = this.perPage;
    return data;
  }
}

class Link {
  bool? next;
  bool? prev;

  Link({this.next, this.prev});

  Link.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}
