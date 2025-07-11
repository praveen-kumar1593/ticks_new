import 'package:ferry/ferry.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticks_new/graphql/__generated__/refresh.req.gql.dart';
import 'package:ticks_new/graphql/__generated__/refresh.data.gql.dart';
import 'package:ticks_new/graphql/__generated__/refresh.var.gql.dart';
import 'package:ticks_new/graphql/__generated__/serializers.gql.dart' as g;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_exec/gql_exec.dart' as gql;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:ticks_new/graphql/possible_types.dart';
import 'storage_services.dart';

class GraphQLClientService extends GetxService {
  late final String url;
  late final Client noTokenClient;
  late Client client; 
  final StorageService _storageService = Get.find<StorageService>();

  GraphQLClientService({this.url = 'https://assets.nectarit.com:444/api/graphql'});

  static Future<Client> createClient({String? token}) async {
    final httpLink = HttpLink('https://assets.nectarit.com:444/api/graphql');
    
    // Use a unique box for each temp client to avoid conflicts, or a generic one if state is not preserved.
    final box = await Hive.openBox("graphql_temp_client_${DateTime.now().millisecondsSinceEpoch}");
    final store = HiveStore(box);
    final cache = Cache(store: store, possibleTypes: possibleTypesMap);
    final storageService = Get.find<StorageService>();

    final authLink = Link.function((request, [forward]) async* {
      final authToken = token ?? await storageService.getAuthToken();
      debugPrint("------------------- Creating Client -------------------");
      debugPrint("Token passed directly: ${token != null ? 'Yes' : 'No'}");
      debugPrint("Final Auth Token used: $authToken");
      
      request = request.updateContextEntry<HttpLinkHeaders>(
        (headers) => HttpLinkHeaders(
          headers: {
            if (authToken != null && authToken.isNotEmpty) 'Authorization': 'Bearer $authToken',
            'Timezone': DateTime.now().timeZoneName,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      debugPrint("Authorization Header: Bearer $authToken");
      debugPrint("-------------------------------------------------------");
      yield* forward!(request);
    });

    return Client(
      link: authLink.concat(httpLink),
      cache: cache,
      addTypename: true,
    );
  }

  @override
  void onInit() {
    debugPrint("URL : $url");
    super.onInit();

    // Setup noTokenClient immediately. It's always needed.
    final httpLink = HttpLink(url);
    final store = HiveStore(Hive.box("graphql"));
    final cache = Cache(store: store, possibleTypes: possibleTypesMap);
    noTokenClient = Client(
      link: httpLink,
      cache: cache,
      addTypename: true,
    );

    // Initialize the main client to the unauthenticated one by default.
    // It will be rebuilt after login.
    client = noTokenClient;
    debugPrint("✅ GraphQL service initialized. Main client is currently unauthenticated.");
  }

  void rebuildAuthenticatedClient({String? token}) {
    debugPrint("🔄 Rebuilding authenticated GraphQL client...");
    final httpLink = HttpLink(url);
    final store = HiveStore(Hive.box("graphql"));
    final cache = Cache(store: store, possibleTypes: possibleTypesMap);

    // Main client's auth link with refresh logic
    final authLink = Link.function((request, [forward]) async* {
      // If a token is provided for this specific rebuild, use it.
      // Otherwise, fall back to the standard token retrieval logic.
      final authToken = token ?? await getToken();

      debugPrint("--- Authenticated Request ---");
      debugPrint("Attaching token: $authToken");
      request = request.updateContextEntry<HttpLinkHeaders>(
        (headers) => HttpLinkHeaders(
          headers: {
            if (authToken.isNotEmpty) 'Authorization': 'Bearer $authToken',
            'Timezone': DateTime.now().timeZoneName,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      yield* forward!(request);
    });

    final logLink = Link.function((request, [forward]) async* {
      debugPrint("📤 GraphQL Request: ${request.operation.operationName}");
      final stream = forward!(request);
      await for (final response in stream) {
        if (response.errors?.any((e) => e.message.toLowerCase().contains('unauthorized')) ?? false) {
          await _handleUnauthorized();
        }
        yield response;
      }
    });

    final authedLink = authLink.concat(logLink).concat(httpLink);

    client = Client(
      link: authedLink,
      cache: cache,
      addTypename: true,
      defaultFetchPolicies: const {
        OperationType.mutation: FetchPolicy.NetworkOnly,
        OperationType.query: FetchPolicy.NetworkOnly,
      },
    );
    debugPrint("✅ Authenticated GraphQL client is now active.");
  }

  Future<void> _handleUnauthorized() async {
   // await _storageService.clear();
    print('[GraphQLClientService] Unauthorized detected, deleting tokens and navigating to login');
    await _storageService.deleteAllTokens();
    Get.offAllNamed("/login");
  }

  Future<String> getToken() async {
    try {
      final token = await _storageService.getString('accessToken');
      final refreshToken = await _storageService.getString('refreshToken');
      final expireInStr = await _storageService.getString('expireIn');
      final lastTokenTimeStr = await _storageService.getString('lastTokenTime');
     // rebuildAuthenticatedClient(token: token);

      final expireIn = expireInStr != null ? int.tryParse(expireInStr) : null;
      final lastTokenTime = lastTokenTimeStr != null ? DateTime.tryParse(lastTokenTimeStr) : null;
      final now = DateTime.now();

      if (token == null || refreshToken == null || expireIn == null || lastTokenTime == null) {
        return '';
      }

      if (now.difference(lastTokenTime).inSeconds > expireIn) {
        try {
          final result = GRefreshReq((b) => b..vars.refreshToken = refreshToken);
          final response = await noTokenClient.request(result).first;

          if (response is OperationResponse && !response.hasErrors) {
            final refreshData = response.data?.refresh;
            if (refreshData == null || refreshData.value == null) {
              await _handleUnauthorized();
              return '';
            }

            final map = refreshData.value as Map<String, dynamic>;
            await _storageService.setString('accessToken', map['accessToken'] as String);
            await _storageService.setString('refreshToken', map['refreshToken'] as String);
            await _storageService.setString('expireIn', map['expireIn'].toString());
            await _storageService.setString('lastTokenTime', DateTime.now().toString());
            return map['accessToken'] as String;
          } else if (response is OperationResponse) {
            debugPrint("❌ Refresh Token Error: ${response.linkException}");
            await _handleUnauthorized();
          }
          return '';
        } catch (e) {
          debugPrint("❌ Refresh Token Failed: $e");
          await _handleUnauthorized();
          return '';
        }
      }
      return token;
    } catch (e) {
      debugPrint("❌ Get Token Error: $e");
      return '';
    }
  }

  Future<OperationResponse<TData, TVars>> request<TData, TVars>(
    OperationRequest<TData, TVars> request,
  ) async {
    try {
      final response = await client.request(request).timeout(
        const Duration(seconds: 30),
      ).first;

      if (response is! OperationResponse<TData, TVars>) {
        throw Exception('Invalid response type');
      }

      return response;
    } catch (e) {
      debugPrint("❌ Request Failed: $e");
      rethrow;
    }
  }
}

// Future<Client> createGraphQLClient() async {
//   final box = await Hive.openBox("graphql_standalone");
//   final store = HiveStore(box);
//   final cache = Cache(store: store, possibleTypes: g.possibleTypesMap);
//
//   final httpLink = HttpLink(
//     'https://assets.nectarit.com/api/graphql',
//   );
//
//   final client = Client(
//     link: httpLink,
//     cache: cache,
//   );
//
//   return client;
// }