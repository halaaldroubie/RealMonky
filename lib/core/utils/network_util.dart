import 'dart:convert';

import 'package:food_ordering_sp1/core/data/network/network_config.dart';
import 'package:food_ordering_sp1/core/enums/message_type.dart';
import 'package:food_ordering_sp1/core/enums/request_type.dart';
import 'package:food_ordering_sp1/ui/shared/custom_widgets/custom_toast.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class NetworkUtil {
  static String baseUrl = 'training.owner-tech.com';
  static var client = http.Client();

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    try {
      //!--- Required for request ----
      //*--- Make full api url ------
      var uri = Uri.https(baseUrl, url, params);

      //?--- To Save api response ----
      late http.Response response;
      //?--- To Save api status code ----

      //!--- Required convert api response to Map ----
      Map<String, dynamic> jsonResponse = {};

      //*--- Make call correct request type ------
      switch (type) {
        case RequestType.GET:
          response = await client.get(uri, headers: headers);
          break;
        case RequestType.POST:
          response =
              await client.post(uri, body: jsonEncode(body), headers: headers);
          break;
        case RequestType.PUT:
          response =
              await client.put(uri, body: jsonEncode(body), headers: headers);
          break;
        case RequestType.DELETE:
          response = await client.delete(uri,
              body: jsonEncode(body), headers: headers);
          break;
        case RequestType.MULTIPART:
          break;
      }

      dynamic result;

      try {
        result = jsonDecode(Utf8Codec().decode(response.bodyBytes));
      } catch (e) {}

      jsonResponse.putIfAbsent(
          'response',
          () => result == null
              ? {'title': Utf8Codec().decode(response.bodyBytes)}
              : jsonDecode(Utf8Codec().decode(response.bodyBytes)));
      jsonResponse.putIfAbsent('statusCode', () => response.statusCode);

      print(jsonResponse);
      return jsonResponse;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> sendMultipartRequest({
    required String url,
    required RequestType type,
    Map<String, String>? headers = const {},
    Map<String, String>? fields = const {},
    Map<String, String>? files = const {},
    Map<String, dynamic>? params,
  }) async {
    assert(
        type == RequestType.GET || type == RequestType.MULTIPART, 'Foucs plz');
    try {
      var request = http.MultipartRequest(
          type.toString(), Uri.https(baseUrl, url, params));

      var _filesKeyList = files!.keys.toList();
      var _filesNameList = files.values.toList();

      for (int i = 0; i < _filesKeyList.length; i++) {
        if (_filesNameList[i].isNotEmpty) {
          var multipartFile = http.MultipartFile.fromPath(
            _filesKeyList[i],
            _filesNameList[i],
            filename: path.basename(_filesNameList[i]),
            contentType: getContentType(_filesNameList[i]),
          );
          request.files.add(await multipartFile);
        }
      }
      request.headers.addAll(headers!);
      request.fields.addAll(fields!);

      var response = await request.send();

      Map<String, dynamic> responseJson = {};
      var value = await response.stream.bytesToString();
      ;
      responseJson.putIfAbsent('statusCode', () => response.statusCode);
      responseJson.putIfAbsent('response', () => jsonDecode(value));

      return responseJson;
    } catch (error) {
      CustomToast.showMessage(
          message: error.toString(), messageType: MessageType.REJECTED);
    }
  }

  static MediaType getContentType(String name) {
    var ext = name.split('.').last;
    if (ext == "png" || ext == "jpeg") {
      return MediaType.parse("image/jpg");
    } else if (ext == 'pdf') {
      return MediaType.parse("application/pdf");
    } else {
      return MediaType.parse("image/jpg");
    }
  }
}
