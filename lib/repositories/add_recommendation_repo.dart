import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../models/add_recommendation_model.dart';
import '../models/updateProfile_molde.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';

Future<AddRecommendationModel> addRecommendationRepo({
  required mapData,
  required fieldName1,
  required File file1,
  required context,
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  // var header = {
  //   HttpHeaders.contentTypeHeader: "application/json",
  //   HttpHeaders.acceptHeader: "application/json",
  //   HttpHeaders.authorizationHeader:
  //  " Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5OTgwYzYwMy1iNTk2LTQyOWItOTkzOS1jNTE3YjdlZWZiY2EiLCJqdGkiOiJmNjU0OGUyOTI4YmQ1MDVhNTMzYmFhNTAxNDMwZjg2ODNiOTQ2Njk1NjExNzNhYmY2ZTU1MThhZDhmZDc1Yzc5ZDAxYTkzYzM1ZTA5MTZiMiIsImlhdCI6MTY4ODQ1MTQ2OC45NDQ3NTIsIm5iZiI6MTY4ODQ1MTQ2OC45NDQ3NTYsImV4cCI6MTcyMDA3Mzg2OC45NDE5MTMsInN1YiI6IjE3MyIsInNjb3BlcyI6W119.m2Wn3QujvlUM2fpXI2EZJCO1FhtOcg7CLNRtdwHAsTnsjYgGVQefk6GaePlWalq4rxRyYINjTg6ztTrjnIxgObcDKC67HyxvyUNX8KycFriL7LJpiE9IfLT3mfkTcmQ8RIQOTu4dYib6q1rqVN-iwRyMgLT-0HLDpyFDfhOOJ_K_tjVWuVnKG4tCZaZ87oLjU41UiDkIgEnkYF3zpvvPoNZtq2ySLq-LSSkohMSffWjQoCvjCaWNd3W45ID5QzqSMRbO7xFouNn0jcPazdpi9RR8lQxLTIIJVzcZ2VTY0GG9KP_U7q2DV2exaz71SRa9q0cGcrtvuZ-tbVlcULzQNaDmjC7UTaIP4gnJwZvYK_1uRRjYPQYN3Knx2AYjIa4OFt8OPHMpcXEcKoJO-jNVtH8SXr2r9I7rqaAyur63zkWe5fVJLY5s0KrvO-JVg7iUBOUv4bYX6fARcr2VJymMnLrZFBj-tVhvL4IcmvaEl2859CKGBSpe-zwBedDEdziaauHV0fbq4kbTE9A51J_6mbdbGp667zXDbdhn_KlH8ZVVp7ZVQ6qnxUcR3BAhOgxXKKjTkrfVaY30xYCbCjQt" };
  try {
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrls.addRecommandation));

    request.headers.addAll(await getAuthHeader());

    request.fields.addAll(mapData);

    if (file1.path != "")
      request.files.add(await multipartFile(fieldName1, file1));

    log(request.fields.toString());
    log(request.files.toString());

    final response = await request.send();
    Helpers.hideLoader(loader);
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      // log(jsonDecode(response.body)["message"]);
      return AddRecommendationModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      Helpers.hideLoader(loader);
      return AddRecommendationModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return AddRecommendationModel(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return AddRecommendationModel(message: e.toString(), status: false);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}
