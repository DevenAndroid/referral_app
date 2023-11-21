class AddRecommendationModel {
  bool? status;
  String? message;
  Data? data;

  AddRecommendationModel({this.status, this.message, this.data});

  AddRecommendationModel.fromJson(Map<String, dynamic> json) {
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
  dynamic review;
  dynamic link;
  dynamic categoryId;
  dynamic image;
  dynamic status;

  Data(
      {this.id,
        this.title,
        this.review,
        this.link,
        this.categoryId,
        this.image,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
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
