import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/get_profile_model.dart';
import '../resourses/api_constant.dart';

Future<GetProfileModel> getProfileRepo() async {
  // try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.userProfile),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      log(jsonDecode(response.body).toString());
      return GetProfileModel.fromJson(jsonDecode(response.body));
    } else {
      log(jsonDecode(response.body).toString());
      return GetProfileModel.fromJson(jsonDecode(response.body));
    }
  }
  // catch (e) {
  //   return GetProfileModel(message: e.toString(), status: false, data: null);
  // }
// }
