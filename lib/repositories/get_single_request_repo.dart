import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/get_single_request_model.dart';
import '../models/model_user_profile.dart';
import '../resourses/api_constant.dart';

Future<GetSingleRequestModel> getMyRequestEditRepo({recommandationId}) async {
  try {
    http.Response response = await http.get(
      Uri.parse("https://referral-app.eoxyslive.com/api/ask-recommandation?askrecommandation_id=$recommandationId"),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return GetSingleRequestModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return GetSingleRequestModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return GetSingleRequestModel(message: e.toString(), status: false, data: null);
  }
}
