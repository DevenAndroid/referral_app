import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/friendlist_model.dart';
import '../models/get_comment_model.dart';
import '../models/model_review_list.dart';

import '../models/single_product_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<FriendListModel> getFriendListRepo({context}) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.getFriendList),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return FriendListModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return FriendListModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return FriendListModel(message: e.toString(), status: false, data: null);
  }
}
