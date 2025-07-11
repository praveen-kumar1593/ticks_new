// To parse this JSON data, do
//
//     final findLoggedInUser = findLoggedInUserFromJson(jsonString);

import 'dart:convert';

FindLoggedInUser findLoggedInUserFromJson(String str) =>
    FindLoggedInUser.fromJson(json.decode(str));

String findLoggedInUserToJson(FindLoggedInUser data) =>
    json.encode(data.toJson());

class FindLoggedInUser {
  ProfileUser profileUser;
  List<dynamic> siteGroups;

  FindLoggedInUser({required this.profileUser, required this.siteGroups});

  factory FindLoggedInUser.fromJson(Map<String, dynamic> json) =>
      FindLoggedInUser(
        profileUser: ProfileUser.fromJson(json["user"]),
        siteGroups: List<dynamic>.from(json["siteGroups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "user": profileUser.toJson(),
    "siteGroups": List<dynamic>.from(siteGroups.map((x) => x)),
  };
}

class ProfileUser {
  String type;
  Data data;
  String identifier;
  String domain;
  String status;

  ProfileUser({
    required this.type,
    required this.data,
    required this.identifier,
    required this.domain,
    required this.status,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
    type: json["type"],
    data: Data.fromJson(json["data"]),
    identifier: json["identifier"],
    domain: json["domain"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data.toJson(),
    "identifier": identifier,
    "domain": domain,
    "status": status,
  };
}

class Data {
  String? lastName;
  String? identifier;
  String? siteGroupAccess;
  String? typeName;
  String? description;
  String? emailId;
  String? profileImage;
  String? type;
  String? locale;
  String? userName;
  String? createdOn;
  String? firstName;
  String? isId;
  String? createdBy;
  String? domain;
  String? contactNumber;
  String? roleName;
  String? name;
  String? appAccess;
  String? status;

  Data({
    this.lastName,
    this.identifier,
    this.siteGroupAccess,
    this.typeName,
    this.description,
    this.emailId,
    this.profileImage,
    this.type,
    this.locale,
    this.userName,
    this.createdOn,
    this.firstName,
    this.isId,
    this.createdBy,
    this.domain,
    this.contactNumber,
    this.roleName,
    this.name,
    this.appAccess,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lastName: json["lastName"] as String?,
    identifier: json["identifier"] as String?,
    siteGroupAccess: json["siteGroupAccess"] as String?,
    typeName: json["typeName"] as String?,
    description: json["description"] as String?,
    emailId: json["emailId"] as String?,
    profileImage: json["profileImage"] as String?,
    type: json["type"] as String?,
    locale: json["locale"] as String?,
    userName: json["userName"] as String?,
    createdOn: json["createdOn"] as String?,
    firstName: json["firstName"] as String?,
    isId: json["isId"] as String?,
    createdBy: json["createdBy"] as String?,
    domain: json["domain"] as String?,
    contactNumber: json["contactNumber"] as String?,
    roleName: json["roleName"] as String?,
    name: json["name"] as String?,
    appAccess: json["appAccess"] as String?,
    status: json["status"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "lastName": lastName,
    "identifier": identifier,
    "siteGroupAccess": siteGroupAccess,
    "typeName": typeName,
    "description": description,
    "emailId": emailId,
    "profileImage": profileImage,
    "type": type,
    "locale": locale,
    "userName": userName,
    "createdOn": createdOn,
    "firstName": firstName,
    "isId": isId,
    "createdBy": createdBy,
    "domain": domain,
    "contactNumber": contactNumber,
    "roleName": roleName,
    "name": name,
    "appAccess": appAccess,
    "status": status,
  };
}
