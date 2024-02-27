import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:referral_app/models/notification_count_model.dart';
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../models/model_user_profile.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<NotificationCountModel> notificationCountRepo() async {

  try {
    http.Response response = await http.get(
      Uri.parse("http://3.131.10.217/api/notification-count"),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return NotificationCountModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return NotificationCountModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return NotificationCountModel(message: e.toString(), status: false, data: null);
  }
}
