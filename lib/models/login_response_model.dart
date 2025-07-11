import 'dart:convert';

// Main entry point for the entire response
class LoginResponseModel {
  final LoginData? login;

  LoginResponseModel({this.login});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      login: json['login'] != null ? LoginData.fromJson(json['login']) : null,
    );
  }

  Map<String, dynamic> toJson() => {'login': login?.toJson()};
}

// Represents the main 'login' object
class LoginData {
  final String? tokenType;
  final String? expireIn;
  final String? accessToken;
  final String? refreshToken;
  final User? user;
  final Tenant? tenant;
  final Permissions? permissions;

  LoginData({
    this.tokenType,
    this.expireIn,
    this.accessToken,
    this.refreshToken,
    this.user,
    this.tenant,
    this.permissions,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      tokenType: json['tokenType'],
      expireIn: json['expireIn']?.toString(),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant']) : null,
      permissions: json['permissions'] != null ? Permissions.fromJson(json['permissions']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'tokenType': tokenType,
        'expireIn': expireIn,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'user': user?.toJson(),
        'tenant': tenant?.toJson(),
        'permissions': permissions?.toJson(),
      };
}

// Represents the 'user' object
class User {
  final String? entity;
  final String? type;
  final UserDetails? data;
  final String? identifier;
  final String? domain;
  final String? status;

  User({
    this.entity,
    this.type,
    this.data,
    this.identifier,
    this.domain,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      entity: json['entity'],
      type: json['type'],
      data: json['data'] != null ? UserDetails.fromJson(json['data']) : null,
      identifier: json['identifier'],
      domain: json['domain'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'entity': entity,
        'type': type,
        'data': data?.toJson(),
        'identifier': identifier,
        'domain': domain,
        'status': status,
      };
}

// Represents the nested 'data' object inside 'user'
class UserDetails {
  final String? lastName;
  final String? identifier;
  final String? siteGroupAccess;
  final String? typeName;
  final String? emailId;
  final String? userName;
  final String? createdOn;
  final String? firstName;
  final String? domain;
  final String? contactNumber;
  final String? roleName;
  final String? status;

  UserDetails({
    this.lastName,
    this.identifier,
    this.siteGroupAccess,
    this.typeName,
    this.emailId,
    this.userName,
    this.createdOn,
    this.firstName,
    this.domain,
    this.contactNumber,
    this.roleName,
    this.status,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      lastName: json['lastName'],
      identifier: json['identifier'],
      siteGroupAccess: json['siteGroupAccess'],
      typeName: json['typeName'],
      emailId: json['emailId'],
      userName: json['userName'],
      createdOn: json['createdOn'],
      firstName: json['firstName'],
      domain: json['domain'],
      contactNumber: json['contactNumber'],
      roleName: json['roleName'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'lastName': lastName,
        'identifier': identifier,
        'siteGroupAccess': siteGroupAccess,
        'typeName': typeName,
        'emailId': emailId,
        'userName': userName,
        'createdOn': createdOn,
        'firstName': firstName,
        'domain': domain,
        'contactNumber': contactNumber,
        'roleName': roleName,
        'status': status,
      };
}

// Represents the 'tenant' object
class Tenant {
  final String? entity;
  final String? type;
  final TenantDetails? data;
  final String? identifier;
  final String? domain;
  final String? status;

  Tenant({
    this.entity,
    this.type,
    this.data,
    this.identifier,
    this.domain,
    this.status,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      entity: json['entity'],
      type: json['type'],
      data: json['data'] != null ? TenantDetails.fromJson(json['data']) : null,
      identifier: json['identifier'],
      domain: json['domain'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'entity': entity,
        'type': type,
        'data': data?.toJson(),
        'identifier': identifier,
        'domain': domain,
        'status': status,
      };
}

// Represents the nested 'data' object inside 'tenant'
class TenantDetails {
  final String? clientName;
  final String? timeZone;

  TenantDetails({this.clientName, this.timeZone});

  factory TenantDetails.fromJson(Map<String, dynamic> json) {
    return TenantDetails(
      clientName: json['clientName'],
      timeZone: json['timeZone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'clientName': clientName,
        'timeZone': timeZone,
      };
}

// Represents the 'permissions' object
class Permissions {
  final List<String> featureGroupCodes;
  final List<String> featureCodes;
  final List<String> permissionCodes;

  Permissions({
    required this.featureGroupCodes,
    required this.featureCodes,
    required this.permissionCodes,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      featureGroupCodes: List<String>.from(json['featureGroupCodes'] ?? []),
      featureCodes: List<String>.from(json['featureCodes'] ?? []),
      permissionCodes: List<String>.from(json['permissionCodes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'featureGroupCodes': featureGroupCodes,
        'featureCodes': featureCodes,
        'permissionCodes': permissionCodes,
      };
} 