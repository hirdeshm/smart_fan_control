import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fan.dart';

class ApiService {
  final String baseUrl = "https://example-smartfan-api.com/api";

  String? apiKey;
  String? refreshToken;

  ApiService({this.apiKey, this.refreshToken});

  Map<String, String> authHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
      "Refresh-Token": refreshToken ?? "",
    };
  }

  Future<List<Fan>> getFans() async {
    final url = Uri.parse("$baseUrl/fans");
    final res = await http.get(url, headers: authHeaders());

    final body = jsonDecode(res.body);
    return (body["fans"] as List)
        .map((fan) => Fan.fromJson(fan))
        .toList();
  }

  Future<bool> setPower(String id, bool value) async {
    final url = Uri.parse("$baseUrl/fans/$id/power");
    final res = await http.post(url,
        headers: authHeaders(), body: jsonEncode({"power": value}));

    return res.statusCode == 200;
  }

  Future<bool> setSpeed(String id, int speed) async {
    final url = Uri.parse("$baseUrl/fans/$id/speed");
    final res = await http.post(url,
        headers: authHeaders(), body: jsonEncode({"speed": speed}));

    return res.statusCode == 200;
  }
}
