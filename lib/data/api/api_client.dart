// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fourfiles/data/model/response/error_response_model.dart';
import 'package:fourfiles/data/repository/auth_repo.dart';
import 'package:fourfiles/helper/route_helper.dart';
import 'package:fourfiles/util/app_constants.dart';

class ApiClient extends GetxService {
  final String tag = "ApiClient";
  final String appBaseUrl = AppConstants.baseUrl;
  final AuthRepo authRepo;
  static const String noInternetMessage = 'Connection to API server failed';
  final int timeoutInSeconds = 30;
  late Map<String, String> _mainHeaders;

  bool _isConnected = false;
  bool _establishedConnection = false;
  StreamSubscription<ConnectivityResult>? subscription;
  final Connectivity connectivity = Connectivity();

  bool get isNetworkConnected => _isConnected;
  bool get establishedConnection => _establishedConnection;

  ApiClient({required this.authRepo});

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    subscription =
        connectivity.onConnectivityChanged.listen(_onConnectionChanged);
  }

  void _onConnectionChanged(ConnectivityResult result) {
    _isConnected = result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
    _establishedConnection = true;
  }

  void checkConnection() {
    connectivity.checkConnectivity().then((value) {
      _isConnected = value == ConnectivityResult.wifi ||
          value == ConnectivityResult.mobile ||
          value == ConnectivityResult.vpn;
      _establishedConnection = true;
    });
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }

  Future<void> updateHeader() async {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'X-localization': 'en',
    };
    var authToken = await authRepo.getAuthToken();
    if (authToken != null) {
      _mainHeaders["Authorization"] = authToken;
    }
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    if (!_isConnected) {
      throw Exception(noInternetMessage);
    }
    try {
      await updateHeader();
      http.Response response0 = await http
          .get(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      Response response = await handleResponse(response0);

      return response;
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: noInternetMessage,
      );
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    if (!_isConnected) {
      throw Exception(noInternetMessage);
    }
    try {
      await updateHeader();
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response);
    } on Exception {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    if (!_isConnected) {
      throw Exception(noInternetMessage);
    }
    try {
      await updateHeader();
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (kIsWeb) {
          Uint8List list = await multipart.file.readAsBytes();
          http.MultipartFile part = http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            list.length,
            filename: multipart.file.path,
          );
          request.files.add(part);
        } else {
          File file = File(multipart.file.path);
          request.files.add(http.MultipartFile(
            multipart.key,
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response);
    } on Exception {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    if (!_isConnected) {
      throw Exception(noInternetMessage);
    }
    try {
      await updateHeader();
      http.Response response = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response);
    } on Exception {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    if (!_isConnected) {
      throw Exception(noInternetMessage);
    }
    try {
      await updateHeader();
      http.Response response = await http
          .delete(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response);
    } on Exception {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> handleResponse(http.Response response) async {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } on Exception {
      //
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode == 401) {
      Get.offAllNamed(RouteHelper.auth);
    }
    if (response0.statusCode != 201 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{status: error')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 201 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    return response0;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}

class CustomServerException implements Exception {
  final String message;
  CustomServerException(this.message);

  @override
  String toString() => "CustomException: $message";
}
