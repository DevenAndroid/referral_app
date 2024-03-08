class GetUpdateModel {
  bool? status;
  String? message;
  Data? data;

  GetUpdateModel({this.status, this.message, this.data});

  GetUpdateModel.fromJson(Map<String, dynamic> json) {
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
  String? link;
  bool? isUpdate;

  Data({this.link, this.isUpdate});

  Data.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    isUpdate = json['is_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['is_update'] = this.isUpdate;
    return data;
  }
}
