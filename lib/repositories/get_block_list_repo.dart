import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/block_list_model.dart';
import '../resourses/api_constant.dart';

Future<ModelBlockList> getBlockListRepo({context}) async {
  try {
    http.Response response = await http.get(Uri.parse(ApiUrls.getBlockList),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ModelBlockList.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ModelBlockList(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return ModelBlockList(message: e.toString(), status: false, data: null);
  }
}
