import 'dart:math';

import '../models/get_notification_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../resourses/api_constant.dart';

Future<GetNotificationModel>  getNotificationRepo() async{

  http.Response response = await http.get(
    Uri.parse(ApiUrls.getNotification),
    headers: await getAuthHeader(),
  );

  if(response.statusCode == 200){
    print(jsonDecode(response.body));
    return GetNotificationModel.fromJson(jsonDecode(response.body));
  }
  else {
    print(jsonDecode(response.body));
    return GetNotificationModel(
        message: jsonDecode(response.body)["message"],
        status: false,
        data: null);
  }

}