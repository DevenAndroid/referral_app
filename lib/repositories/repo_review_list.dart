

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/review_list_,model.dart';
import '../models/single_product_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<ModelReviewList> getReviewListRepo({required BuildContext context, required String id}) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.reviewList),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelReviewList.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelReviewList(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return ModelReviewList(message: e.toString(), status: false, data: null);
  }
}
