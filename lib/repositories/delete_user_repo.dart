import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/delete_user_model.dart';
import '../models/get_profile_model.dart';
import '../models/logout_Model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<DeleteUserModel> deleteUserRepo() async {
  try {
    http.Response response = await http.post(
      Uri.parse(ApiUrls.deleteUser),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return DeleteUserModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return DeleteUserModel(
        message: jsonDecode(response.body)["message"],
        status: false,
      );
    }
  } catch (e) {
    return DeleteUserModel(message: e.toString(), status: false, );
  }
}
