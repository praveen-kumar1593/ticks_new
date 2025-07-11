import 'package:get/get.dart';
import '../models/api_response.dart';
import '../services/graphql_client_services.dart';
import '../graphql/__generated__/get_form_template.req.gql.dart';
import '../services/storage_services.dart';
import 'package:ferry/ferry.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/exception/r_exception.dart';

class ApiServices extends GetxService {
  final GraphQLClientService _graphQLService = Get.find<GraphQLClientService>();

  Future<ApiResponse> getFormTemplate({
    required String domain,
    required String name,
  }) async {
    final ApiResponse apiResponse = ApiResponse();
    try {
      final storageService = Get.find<StorageService>();
      final token = await storageService.getAuthToken();
      print('[getFormTemplate] Token: $token');
      print('[getFormTemplate] Domain: $domain, Name: $name');
      final getFormTemplateVars = GgetFormTemplateReq((b) {
        b.vars.domain = domain;
        b.vars.name = name;
      });

      // Always use the main, global client.
      print('[getFormTemplate] Sending request with client: $_graphQLService');
      final response = await _graphQLService.client.request(getFormTemplateVars).first;
      print('[getFormTemplate] Response received. Has errors: ${response.hasErrors}');
      if (response.hasErrors) {
        print('[getFormTemplate] GraphQL Errors: ${response.graphqlErrors}');
      } else {
        print('[getFormTemplate] Data: ${response.data}');
      }
      
      if (!response.hasErrors) {
        apiResponse.success = true;
        apiResponse.data = response.data;
      } else {
        apiResponse.success = false;
        RException.errorHandler(
            erroMessage:
                "❌ GraphQL Errors getFormTemplate: \\${response.graphqlErrors}");
      }
    } catch (e, stackTrace) {
      print('[getFormTemplate] Exception: $e');
      apiResponse.success = false;
      RException.exceptionHandler(
          exceptionMessage: "❌ Exception getFormTemplate: $e",
          stackTrace: stackTrace);
    }
    return apiResponse;
  }

  Future<void> testDirectGraphQL() async {
    final storageService = Get.find<StorageService>();
    final token = await storageService.getAuthToken();
    final url = Uri.parse('https://assets.nectarit.com:444/api/graphql');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'query': 'query getFormTemplate(\$domain: String!, \$name: String!) { getFormTemplate(domain: \$domain, name: \$name) }',
      'variables': {
        'domain': 'buildingdemo',
        'name': 'APP_THEME',
      }
    });
    print('[Direct HTTP POST] body: $body');
    print('[Direct HTTP POST] headers: $headers');
    final response = await http.post(url, headers: headers, body: body);
    print('[Direct HTTP POST] status: ${response.statusCode}');
    print('[Direct HTTP POST] response: ${response.body}');
  }

  /// Fetches the app theme using a direct HTTP POST (not Ferry)
  Future<Map<String, dynamic>?> fetchAppThemeDirect({
    required String domain,
    required String name,
  }) async {
    final storageService = Get.find<StorageService>();
    final token = await storageService.getAuthToken();
    final url = Uri.parse('https://assets.nectarit.com:444/api/graphql');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'query': 'query getFormTemplate(\$domain: String!, \$name: String!) { getFormTemplate(domain: \$domain, name: \$name) }',
      'variables': {
        'domain': domain,
        'name': name,
      }
    });
    print('[fetchAppThemeDirect] body: $body');
    print('[fetchAppThemeDirect] headers: $headers');
    final response = await http.post(url, headers: headers, body: body);
    print('[fetchAppThemeDirect] status: ${response.statusCode}');
    print('[fetchAppThemeDirect] response: ${response.body}');
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      final themeData = responseJson['data']?['getFormTemplate']?['data'];
      return themeData;
    }
    return null;
  }
} 