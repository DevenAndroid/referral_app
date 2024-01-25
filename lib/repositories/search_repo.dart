

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';
import '../models/get_profile_model.dart';
import '../models/search_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<SearchModel> getSearchRepo({type,keyword}) async {
  try {
    http.Response response = await http.get(Uri.parse("http://3.131.10.217/api/search?type=$type&keyword=$keyword"),
      headers: await getAuthHeader(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return SearchModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return SearchModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return SearchModel(message: e.toString(), status: false, data: null);
  }
}
