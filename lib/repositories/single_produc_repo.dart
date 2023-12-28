

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/single_product_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<SingleProduct> getSingleRepo({category_id,userId}) async {
  try {
    http.Response response = await http.get(Uri.parse("https://referral-app.eoxyslive.com/api/single-category?category_id=$category_id&user_id=$userId"),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return SingleProduct.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return SingleProduct(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return SingleProduct(message: e.toString(), status: false, data: null);
  }
}

Future<SingleProduct> getSingleRepoWithOut({category_id,userId}) async {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    //  HttpHeaders.authorizationHeader: 'Bearer ${userInfo.}'
  };
  try {
    http.Response response = await http.get(Uri.parse("https://referral-app.eoxyslive.com/api/single-category?category_id=$category_id&user_id=$userId"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return SingleProduct.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return SingleProduct(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return SingleProduct(message: e.toString(), status: false, data: null);
  }
}
