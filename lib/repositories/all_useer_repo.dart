import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/all_user_model.dart';
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<AllUserModel> getUserRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.allUsers),
      headers: await getAuthHeader(),
    );
    print('Reason Phrase--${response.reasonPhrase}');
    print('status code--${response.statusCode}');
    print('AllUsers--${response.body}');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('AllUsers Repository>>>>>>>>>>>>--${response.body.toString()}');
      return AllUserModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return AllUserModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    //throw Exception(e);
    return AllUserModel(message: e.toString(), status: false, data: null);
  }
}


Future<AllUserModel> getUserPaginateRepo({required pagination,required pa}) async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.allUsers),
      headers: await getAuthHeader(),
    );
    print('Reason Phrase--${response.reasonPhrase}');
    print('status code--${response.statusCode}');
    print('AllUsers--${response.body}');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('AllUsers Repository>>>>>>>>>>>>--${response.body.toString()}');
      return AllUserModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return AllUserModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    //throw Exception(e);
    return AllUserModel(message: e.toString(), status: false, data: null);
  }
}
