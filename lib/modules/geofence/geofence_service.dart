// import 'package:built_value/json_object.dart';
// import 'package:get/get.dart';
// import 'package:ferry/ferry.dart';
// import 'package:gql_exec/gql_exec.dart';
// import 'package:gql_http_link/gql_http_link.dart';
//
// import '../../services/graphql_client_services.dart';
// import '../../services/storage_services.dart';
// import 'geofence_constants.dart';
//
//
// import '../../graphql/schemas/__generated__/geofence.data.gql.dart';
// import '../../graphql/schemas/__generated__/geofence.req.gql.dart';
//
// class GeofenceNewService extends GetxService {
//   final allGeofenceData = Rxn<List<GlistAllGeoFencesData_listAllGeoFences_data>>();
//   final userGeofence = Rxn<GlistAllGeoFencesData_listAllGeoFences_data>();
//
//
//
//   GeofenceNewService();
//
//
//   Future<void> fetchGeofencesFromApi({
//     required String domain,
//     int page = 1,
//     int limit = 1000,
//     String order = 'desc',
//     String sortField = 'createdOn',
//     Map<String, dynamic>? searchFields,
//   }) async {
//     print('[GeofenceService] Calling fetchGeofencesFromApi for domain: $domain');
//     final token = await Get.find<StorageService>().getAuthToken();
//     print('[GeofenceNewService] Token being used: $token');
//     final effectiveSearchFields = <String, dynamic>{
//       'category': listAllGeofenceCategory,
//       ...?searchFields,
//     };
//     final req = GlistAllGeoFencesReq((b) {
//       b.vars.data.domain = domain;
//       b.vars.data.page = page;
//       b.vars.data.limit = limit;
//       b.vars.data.order = order;
//       b.vars.data.sortField = sortField;
//       b.vars.data.searchFields = JsonObject(effectiveSearchFields);
//     });
//      // Print the exact variables being sent
//     print('[GeofenceNewService] Variables passed to GraphQL: \\${req.vars.toJson()}');
//     // Create a temporary Ferry client with the Authorization header
//     final httpLink = HttpLink(
//       'https://assets.nectarit.com:444/api/graphql',
//       defaultHeaders: {
//         if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     );
//     final store = Get.find<GraphQLClientService>().client.cache.store;
//     final cache = Get.find<GraphQLClientService>().client.cache;
//     final tempClient = Client(
//       link: httpLink,
//       cache: cache,
//       addTypename: true,
//     );
//
//     print('[GeofenceNewService] Request headers: ${httpLink.defaultHeaders}');
//     final response = await tempClient.request(req).first;
//
//     if (response.hasErrors) {
//       print('[GeofenceService] Ferry error: \\${response.graphqlErrors}');
//       return;
//     }
//     print('[GeofenceNewService] Full API response: \\${response.data}');
//     final dataList = response.data?.listAllGeoFences?.data
//         ?.whereType<GlistAllGeoFencesData_listAllGeoFences_data>()
//         .toList();
//     print('[GeofenceService] API call completed. Data count: \\${dataList?.length ?? 0}');
//     if (dataList != null) {
//       allGeofenceData.value = dataList;
//     }
//   }
//   // Future<void> fetchGeofencesFromApi({
//   //   required String domain,
//   //   int page = 1,
//   //   int limit = 1000,
//   //   String order = 'desc',
//   //   String sortField = 'createdOn',
//   //   Map<String, dynamic>? searchFields,
//   // }) async {
//   //   print('[GeofenceService] Calling fetchGeofencesFromApi for domain: $domain');
//   //   final ferryClient = Get.find<GraphQLClientService>().client;
//   //   final token = await Get.find<StorageService>().getAuthToken();
//   //   print('[GeofenceNewService] Token being used: $token');
//   //   final effectiveSearchFields = <String, dynamic>{
//   //     'category': listAllGeofenceCategory,
//   //     ...?searchFields,
//   //   };
//   //   final req = GlistAllGeoFencesReq((b) {
//   //     b.vars.data.domain = domain;
//   //     b.vars.data.page = page;
//   //     b.vars.data.limit = limit;
//   //     b.vars.data.order = order;
//   //     b.vars.data.sortField = sortField;
//   //     b.vars.data.searchFields = JsonObject(effectiveSearchFields);
//   //   });
//   //
//   //   // Print the headers being sent
//   //   final opReq = req.execRequest;
//   //   final contextHeaders = opReq.context.entry<HttpLinkHeaders>()?.headers;
//   //   print('[GeofenceNewService] Request headers: $contextHeaders');
//   //   final response = await ferryClient.request(req).first;
//   //
//   //   if (response.hasErrors) {
//   //     print('[GeofenceService] Ferry error: \\${response.graphqlErrors}');
//   //     return;
//   //   }
//   //   print('[GeofenceNewService] Full API response: \\${response.data}');
//   //   final dataList = response.data?.listAllGeoFences?.data
//   //       ?.whereType<GlistAllGeoFencesData_listAllGeoFences_data>()
//   //       .toList();
//   //   print('[GeofenceService] API call completed. Data count: \\${dataList?.length ?? 0}');
//   //   if (dataList != null) {
//   //     allGeofenceData.value = dataList;
//   //   }
//   // }
//
//   /// Sets userGeofence to the matched geofence if found, or null and returns location/geofence name as empty if not.
//   void setUserGeofenceOrLocation({
//     required String? userGeofenceId,
//     required Map<String, dynamic> userLocationPoint, // e.g., {'lat': ..., 'lng': ...}
//   }) {
//     final geofenceList = allGeofenceData.value;
//     if (userGeofenceId != null && geofenceList != null) {
//       final matched = geofenceList.firstWhereOrNull((geo) {
//         final map = geo.data?.value as Map<String, dynamic>?;
//         return map != null && map['identifier'] == userGeofenceId;
//       });
//       if (matched != null) {
//         final map = matched.data?.value as Map<String, dynamic>?;
//         final geofenceName = map?['name'] ?? '';
//         userGeofence.value = matched;
//         print('User is in geofence: $geofenceName');
//         return;
//       }
//     }
//     userGeofence.value = null;
//     print('User is not in any geofence. Location: $userLocationPoint, Geofence name: ""');
//   }
// }
//
// /*
// USAGE EXAMPLE:
//
// import 'package:get/get.dart';
// import 'package:ferry/ferry.dart';
// import 'geofence_service.dart';
// import 'geofence_constants.dart';
//
// void exampleUsage(Client ferryClient) async {
//   // Register the service with GetX
//   final geofenceService = Get.put(GeofenceService(ferryClient));
//
//   // Fetch geofences from the API
//   await geofenceService.fetchGeofencesFromApi(
//     domain: "your_domain",
//     searchFields: {"category": listAllGeofenceCategory},
//   );
//
//   // Example user geofence ID and location point
//   String? userGeofenceId = "some-geofence-id";
//   Map<String, dynamic> userLocationPoint = {"lat": 12.9716, "lng": 77.5946};
//
//   // Match the user's geofence or set location fallback
//   geofenceService.setUserGeofenceOrLocation(
//     userGeofenceId: userGeofenceId,
//     userLocationPoint: userLocationPoint,
//   );
//
//   // Access the matched geofence (if any)
//   final matched = geofenceService.userGeofence.value;
//   if (matched != null) {
//     final map = matched.data?.value as Map<String, dynamic>?;
//     print('Matched geofence name: \\${map?['name']}');
//   } else {
//     print('No geofence matched, using location fallback.');
//   }
// }
// */
//
// // Example usage:
// // To fetch geofences with the GEOFENCE category:
// // import 'geofence_constants.dart';
// // await geofenceService.fetchGeofencesFromApi(
// //   domain: "your_domain",
// //   searchFields: {"category": listAllGeofenceCategory},
// // );