import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:project_ocr/data/model/id_model.dart';

class OcrRemoteDatasource {
  final http.Client client;

  OcrRemoteDatasource({required this.client});

  Future<IdcardModel?> scan(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final url = Uri.parse(
      "https://api.aigen.online/aiscript/idcard/v2"
      "?aigen_key=AGtr51yf7caki9c6uvtag6e0mo7ukv6zzn",
    );

    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"image": base64Image}),
    );

    switch (response.statusCode) {
      case 200:
        break;

      case 400:
        throw Exception("Bad request (400)");
      case 401:
        throw Exception("Unauthorized (401)");
      case 403:
        throw Exception("Forbidden (403)");
      case 404:
        throw Exception("Not found (404)");
      case 500:
        throw Exception("Internal server error (500)");
      case 502:
        throw Exception("Bad gateway (502)");
      case 503:
        throw Exception("Service unavailable (503)");
      default:
        throw Exception("Unexpected error: ${response.statusCode}");
    }
    final json = jsonDecode(response.body);
    final list = json["data"] as List?;

    if (list == null || list.isEmpty) return null;

    return IdcardModel.fromAigenJson(list[0]);
  }
}
