// class SingleProduct {
//   bool? status;
//   dynamic message;
//   List<Data>? data;
//   Meta? meta;
//   Link? link;
//
//   SingleProduct({this.status, this.message, this.data, this.meta, this.link});
//
//   SingleProduct.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//     link = json['link'] != null ? new Link.fromJson(json['link']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta!.toJson();
//     }
//     if (this.link != null) {
//       data['link'] = this.link!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic id;
//   User? user;
//   dynamic title;
//   dynamic review;
//   dynamic link;
//   dynamic categoryId;
//   dynamic image;
//   dynamic status;
//   bool? wishlist;
//
//   Data(
//       {this.id,
//         this.user,
//         this.title,
//         this.review,
//         this.link,
//         this.categoryId,
//         this.image,
//         this.status,
//         this.wishlist});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     title = json['title'];
//     review = json['review'];
//     link = json['link'];
//     categoryId = json['category_id'];
//     image = json['image'];
//     status = json['status'];
//     wishlist = json['wishlist'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['title'] = this.title;
//     data['review'] = this.review;
//     data['link'] = this.link;
//     data['category_id'] = this.categoryId;
//     data['image'] = this.image;
//     data['status'] = this.status;
//     data['wishlist'] = this.wishlist;
//     return data;
//   }
// }
//
// class User {
//   dynamic id;
//   dynamic name;
//   dynamic email;
//   dynamic phone;
//   dynamic walletBalance;
//   dynamic earnedBalance;
//   dynamic profileImage;
//   dynamic address;
//   dynamic referalCode;
//   bool? isDriverOnline;
//   bool? isVendorOnline;
//   dynamic deliveryRange;
//   bool? selfDelivery;
//   bool? asDriverVerified;
//   bool? asVendorVerified;
//   bool? asMarketingManagerVerified;
//   bool? isComplete;
//   dynamic followingCount;
//   dynamic followersCount;
//   dynamic postCount;
//
//   User(
//       {this.id,
//         this.name,
//         this.email,
//         this.phone,
//         this.walletBalance,
//         this.earnedBalance,
//         this.profileImage,
//         this.address,
//         this.referalCode,
//         this.isDriverOnline,
//         this.isVendorOnline,
//         this.deliveryRange,
//         this.selfDelivery,
//         this.asDriverVerified,
//         this.asVendorVerified,
//         this.asMarketingManagerVerified,
//         this.isComplete,
//         this.followingCount,
//         this.followersCount,
//         this.postCount});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     walletBalance = json['wallet_balance'];
//     earnedBalance = json['earned_balance'];
//     profileImage = json['profile_image'];
//     address = json['address'];
//     referalCode = json['referal_code'];
//     isDriverOnline = json['is_driver_online'];
//     isVendorOnline = json['is_vendor_online'];
//     deliveryRange = json['delivery_range'];
//     selfDelivery = json['self_delivery'];
//     asDriverVerified = json['as_driver_verified'];
//     asVendorVerified = json['as_vendor_verified'];
//     asMarketingManagerVerified = json['as_marketing_manager_verified'];
//     isComplete = json['is_complete'];
//     followingCount = json['following_count'];
//     followersCount = json['followers_count'];
//     postCount = json['post_count'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['wallet_balance'] = this.walletBalance;
//     data['earned_balance'] = this.earnedBalance;
//     data['profile_image'] = this.profileImage;
//     data['address'] = this.address;
//     data['referal_code'] = this.referalCode;
//     data['is_driver_online'] = this.isDriverOnline;
//     data['is_vendor_online'] = this.isVendorOnline;
//     data['delivery_range'] = this.deliveryRange;
//     data['self_delivery'] = this.selfDelivery;
//     data['as_driver_verified'] = this.asDriverVerified;
//     data['as_vendor_verified'] = this.asVendorVerified;
//     data['as_marketing_manager_verified'] = this.asMarketingManagerVerified;
//     data['is_complete'] = this.isComplete;
//     data['following_count'] = this.followingCount;
//     data['followers_count'] = this.followersCount;
//     data['post_count'] = this.postCount;
//     return data;
//   }
// }
//
// class Meta {
//   dynamic totalPage;
//   dynamic currentPage;
//   dynamic totalItem;
//   dynamic perPage;
//
//   Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     totalPage = json['total_page'];
//     currentPage = json['current_page'];
//     totalItem = json['total_item'];
//     perPage = json['per_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_page'] = this.totalPage;
//     data['current_page'] = this.currentPage;
//     data['total_item'] = this.totalItem;
//     data['per_page'] = this.perPage;
//     return data;
//   }
// }
//
// class Link {
//   bool? next;
//   bool? prev;
//
//   Link({this.next, this.prev});
//
//   Link.fromJson(Map<String, dynamic> json) {
//     next = json['next'];
//     prev = json['prev'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['next'] = this.next;
//     data['prev'] = this.prev;
//     return data;
//   }
// }


class SingleProduct {
  bool? status;
  dynamic message;
  Data? data;
  Meta? meta;
  Link? link;

  SingleProduct({this.status, this.message, this.data, this.meta, this.link});

  SingleProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (link != null) {
      data['link'] = link!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic categoryName;
  dynamic categoryImage;
  List<Details>? details;

  Data({this.categoryName, this.categoryImage, this.details});

  Data.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
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

  Details(
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
        this.date});

  Details.fromJson(Map<String, dynamic> json) {
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
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['askrecommandation_id'] = askrecommandationId;
    data['title'] = title;
    data['review'] = review;
    data['link'] = link;
    data['category_id'] = categoryId;
    data['image'] = image;
    data['status'] = status;
    data['wishlist'] = wishlist;
    data['is_comment'] = isComment;
    data['date'] = date;
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

class Meta {
  dynamic totalPage;
  dynamic currentPage;
  dynamic totalItem;
  dynamic perPage;

  Meta({this.totalPage, this.currentPage, this.totalItem, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    totalItem = json['total_item'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['total_item'] = totalItem;
    data['per_page'] = perPage;
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
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}
