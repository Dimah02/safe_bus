import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class KHTTP {
  late IOClient http;
  static final KHTTP instance = KHTTP._constructor();
  KHTTP._constructor() {
    // try {
    //   final ioc = HttpClient();
    //   ioc.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   http = IOClient(ioc);
    // } catch (_) {}
    http = IOClient();
  }

  String _baseURL() {
    String ipAddress = dotenv.env["IP_ADDRESS"] ?? '';
    String url = "https://$ipAddress:7149/api/";
    if (Platform.isAndroid || Platform.isIOS) {
      url = "https://$ipAddress:7149/api/";
    } else if (Platform.isWindows) {
      url = "https://localhost:7149/api/";
    }
    String baseURL = dotenv.env["BASEURL"] ?? '';
    url = baseURL;
    //url = "https://10.0.2.2:7149/api/";
    return url;
  }

  Future<dynamic> get({required String endpoint, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    String url = _baseURL();

    Response response = await http.get(
      Uri.parse('$url$endpoint'),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return await jsonDecode(response.body);
    } else {
      throw Exception('${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> post({
    required String endpoint,
    dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    headers.addAll({"Content-Type": "application/json"});
    body ??= {};

    String url = _baseURL();

    Response response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      dynamic data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        jsonDecode(response.body)['message'] ??
        'Failed to get data from the API ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }

  Future<dynamic> put({
    required String endpoint,
    dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    headers.addAll({"Content-Type": "application/json"});
    body ??= {};

    String url = _baseURL();

    Response response = await http.put(
      Uri.parse('$url$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        'Failed to get data from the API ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }

  Future<dynamic> patch({
    required String endpoint,
    dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    headers.addAll({"Content-Type": "application/json"});
    body ??= {};

    String url = _baseURL();

    Response response = await http.patch(
      Uri.parse('$url$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        'Failed to get data from the API ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }

  Future<dynamic> delete({required String endpoint, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    headers.addAll({"Content-Type": "application/json"});
    String url = _baseURL();

    Response response = await http.delete(
      Uri.parse('$url$endpoint'),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to get data from the API ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }
}
