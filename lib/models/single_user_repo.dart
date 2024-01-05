import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../models/model_user_profile.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';
import 'model_single_user.dart';

Future<ModelSingleUser> singleUserRepo({recommandation_id,context}) async {

  // try {
    http.Response response = await http.get(
      Uri.parse("https://referral-app.eoxyslive.com/api/singel-recommandation?recommandation_id=$recommandation_id"),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelSingleUser.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelSingleUser(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  }
  // catch (e) {
  //   return ModelSingleUser(message: e.toString(), status: false, data: null);
  // }
// }
