import 'dart:convert';

import 'package:gtrack_retailer_portal/constants/app_preferences.dart';
import 'package:gtrack_retailer_portal/constants/app_urls.dart';
import 'package:gtrack_retailer_portal/models/IDENTIFY/gtin_model.dart';
import 'package:http/http.dart' as http;

class GTINController {
  static Future<GTINModel> getProducts() async {
    const String url = '${AppUrls.domain}/api/member/products';

    final userId = await AppPreferences.getUserId();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({'user_id': userId}),
        headers: {
          'Content-Type': 'application/json',
          'Host': AppUrls.host,
        },
      );

      if (response.statusCode == 200) {
        final GTINModel gtinModel =
            GTINModel.fromJson(jsonDecode(response.body));
        return gtinModel;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}
