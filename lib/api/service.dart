import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:bheya_network_example/provider/app_provider.dart';

import 'models/reponse.dart';

class ServiceApi {
  static fetchIPInformation(var context) async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Provider.of<AppProvider>(context, listen: false).setResponseData =
            ResponseData.fromJson(data);
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
