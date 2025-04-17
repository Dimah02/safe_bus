import 'dart:convert';

import 'package:http/http.dart' as http;

class KHTTP {
  static const String _baseURL = "";

  static Future<dynamic> get({required String endpoint, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }

    http.Response response = await http.get(
      Uri.parse('$_baseURL$endpoint'),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return await jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to get data from the API ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }

  static Future<dynamic> post({
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
    http.Response response = await http.post(
      Uri.parse('$_baseURL$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      dynamic data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
        'Failed to get data from the API ${response.statusCode} with body ${jsonDecode(response.body)}',
      );
    }
  }

  static Future<dynamic> put({
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

    http.Response response = await http.put(
      Uri.parse('$_baseURL$endpoint'),
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

  static Future<dynamic> delete({
    required String endpoint,
    String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    headers.addAll({"Content-Type": "application/json"});

    http.Response response = await http.delete(
      Uri.parse('$_baseURL$endpoint'),
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
