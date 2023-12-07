class ModelReviewList {
  bool? status;
  String? message;
  List<Data>? data;

  ModelReviewList({this.status, this.message, this.data});

  ModelReviewList.fromJson(Map<String, dynamic> json) {
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
  String? review;
  bool? favourite;

  Data({this.id, this.review, this.favourite});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['favourite'] = this.favourite;
    return data;
  }
}
