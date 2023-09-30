import 'dart:convert';

import 'package:gtrack_retailer_portal/constants/app_urls.dart';
import 'package:gtrack_retailer_portal/models/share/product_information/safety_information_model.dart';
import 'package:http/http.dart' as http;

class SafetyInfromationController {
  static Future<List<SafetyInfromationModel>> getSafeInfromation(
      String gtin) async {
    List<SafetyInfromationModel> safetyInfromations = [];
    try {
      var response = await http.get(Uri.parse(
          '${AppUrls.baseUrlWithPort}/getSafetyInformationByGtin/$gtin'));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        responseBody.forEach((data) {
          safetyInfromations.add(SafetyInfromationModel.fromJson(data));
        });
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
    return safetyInfromations;
  }
}
