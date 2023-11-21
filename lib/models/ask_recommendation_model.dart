class AskRecommendationModel {
  bool? status;
  String? message;
  Data? data;

  AskRecommendationModel({this.status, this.message, this.data});

  AskRecommendationModel.fromJson(Map<String, dynamic> json) {
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
 dynamic id;
 dynamic title;
 dynamic description;
 dynamic minPrice;
 dynamic maxPrice;
 dynamic image;
 dynamic postViewersType;

  Data(
      {this.id,
        this.title,
        this.description,
        this.minPrice,
        this.maxPrice,
        this.image,
        this.postViewersType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['title'] = this.title;
    data['description'] = this.description;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['image'] = this.image;
    data['post_viewers_type'] = this.postViewersType;
    return data;
  }
}
