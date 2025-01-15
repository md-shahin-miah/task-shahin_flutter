import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shahin_appify_task/core/constants/end_points.dart';
import 'package:shahin_appify_task/core/themes/styles/app_colors.dart';
import 'package:shahin_appify_task/core/utils/snackbar/snackbar_service.dart';
import 'package:shahin_appify_task/core/utils/utils.dart';
import 'package:shahin_appify_task/data/share_preference/shared_preference_service.dart';



class NetworkService {
  static String noInternetMessage = "Check your connection!";

  static getRequest(String endPoint,
      {bool requireToken = true,
      bool noBaseUrl = false}) async {
    Response response;

    var accessToken = await SharePreferenceUtil.getUserToken();

    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    if (requireToken) {
      var header = {"Authorization": "Bearer $accessToken"};
      headers.addAll(header);
    }

    debugPrint('\nURL: ${EndPoints.baseUrl}$endPoint');
    debugPrint("Headers: $headers\n");
    if (requireToken) {

        response =
            await get(Uri.parse(EndPoints.baseUrl + endPoint), headers: headers);

    } else {

        response = await get(Uri.parse(EndPoints.baseUrl + endPoint));


    }
log("url ->> ${EndPoints.baseUrl}$endPoint ->>>>> $response");
    return response;
  }

  static Future<Response> deleteRequest(String endPoint,
      {bool requireToken = true, bool noBaseUrl = false}) async {
    Response response;

    var accessToken = await SharePreferenceUtil.getUserToken();

    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    if (requireToken) {
      var header = {"Authorization": "Bearer $accessToken"};
      headers.addAll(header);
    }

    debugPrint('\nURL (DELETE): ${EndPoints.baseUrl}$endPoint');
    debugPrint("Headers: $headers\n");

    if (requireToken) {
      response = await delete(Uri.parse(EndPoints.baseUrl + endPoint), headers: headers);
    } else {
      response = await delete(Uri.parse(EndPoints.baseUrl + endPoint));
    }

    return response;
  }

  static postRequest(String endPoint, body, {bool requireToken = true}) async {
    var accessToken = await SharePreferenceUtil.getUserToken();

    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    if (requireToken) {
      var header = {"Authorization": "Bearer $accessToken"};
      headers.addAll(header);
    }

    debugPrint('\nURL: ${EndPoints.baseUrl}$endPoint');
    debugPrint("Headers: $headers");
    debugPrint("body: post -------- $body");
    debugPrint('Request Body: ${jsonEncode(body)}\n');

    Response response = await post(Uri.parse(EndPoints.baseUrl + endPoint),
        body: jsonEncode(body), headers: headers);
    print("-----------------sts >${response.statusCode}");
    return response;
  }
  static postRequestWithPath(String endPoint, body,String path, {bool requireToken = true}) async {
    var accessToken = await SharePreferenceUtil.getUserToken();

    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Accept': 'application/json',
    };

    if (requireToken) {
      var header = {"Authorization": "Bearer $accessToken"};
      headers.addAll(header);
    }

    debugPrint('\nURL: ${EndPoints.baseUrl}$endPoint');
    debugPrint("Headers: $headers");
    debugPrint("body: post -------- $body");
    debugPrint('Request Body: ${jsonEncode(body)}\n');

    Response response = await post(Uri.parse(EndPoints.baseUrl + endPoint),
        body: jsonEncode(body), headers: headers);
    print("-----------------sts >${response.statusCode}");
    return response;
  }

  static multiPartRequest(String endPoint, String methodName,
      {Map<String, String>? body,
      List<File>? files,
      String filedName = 'images'}) async {
    var request = MultipartRequest(
      "POST",
      Uri.parse('${EndPoints.baseUrl}' '$endPoint'),
      // Uri.parse('https://a287-103-142-80-90.ngrok-free.app/upload/multiple/image'),
    );
    debugPrint('URL: ${EndPoints.baseUrl}$endPoint');
    // debugPrint('URL:https://a287-103-142-80-90.ngrok-free.app/upload/multiple/image');

    print('-----file len---> ${files!.length}-fn---> $filedName');
    var accessToken = SharePreferenceUtil.getUserToken();

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
    };



    if (body != null) {
      request.fields.addAll((body));
    }
    if (files.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      files.forEach((file) async {
        final key=Utils.getCustomUniqueId();
        print("---------key------>$key");
        request.files.add(await MultipartFile.fromPath(
          key,
          file.path,
          contentType: MediaType(
            mime(file.path)!.split('/')[0],
            mime(file.path)!.split('/')[1],
          ),
        ));
      });
    }
    debugPrint('Request Files: ${request.files}');

    request.headers.addAll(headers);

    debugPrint('Headers: ${request.headers}');
    debugPrint('Request Fields: ${request.fields}');
    StreamedResponse streamedResponse = await request.send();
    Response response = await Response.fromStream(streamedResponse);
    return response;
  }

  static handleResponse(Response response) async {
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      debugPrint('\nSuccessCode: ${response.statusCode}');
      debugPrint('SuccessResponse: ${response.body}\n');
      if (response.body.isNotEmpty) {
        debugPrint('isNotEmpty: -------');
        return json.decode(response.body);
      } else {
        debugPrint('is Empty: --------------------');

        return response.body;
      }
    } else {
      debugPrint('\nErrorCode: ${response.statusCode}');
      debugPrint("ErrorResponse: ${response.body}\n");

      if (response.statusCode == 403) {
        /// Session expired

        ToastService.showToast(
            title: "Session expired! Login to continue...",
            backgroundColor: AppColors.colorError);

        // SharedPreferencesUtil.setValue(key: "", value: false);
        // NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (_) => const LoginScreen()));
      } else if (response.statusCode == 422) {
        /// Custom validation message

        ToastService.showToast(
            title: "${jsonDecode(response.body)['errors'][0]['message']}",
            backgroundColor: AppColors.colorError);
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        /// Custom message

        ToastService.showToast(
            title: "${jsonDecode(response.body)['msg']}",
            backgroundColor: AppColors.colorError);
        if (jsonDecode(response.body)['unverified'] != null) {
          if (jsonDecode(response.body)['unverified']) {
            if (response.body.isNotEmpty) return json.decode(response.body);
          }
        }
      } else {
        ToastService.showToast(
            title: "Something went wrong!",
            backgroundColor: AppColors.colorError);
      }
    }
  }
}
