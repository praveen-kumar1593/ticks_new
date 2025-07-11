import 'dart:convert';

NectarAppTheme nectarAppThemeFromJson(String str) => NectarAppTheme.fromJson(json.decode(str));

String nectarAppThemeToJson(NectarAppTheme data) => json.encode(data.toJson());

class NectarAppTheme {
  final Map<String, dynamic>? asMap;
  final String? domain;
  final String? name;
  final List<String>? permissions;
  final List<String>? navigationItems;

  NectarAppTheme({
    this.asMap,
    this.domain,
    this.name,
    this.permissions,
    this.navigationItems,
  });

  factory NectarAppTheme.fromJson(Map<String, dynamic> json) => NectarAppTheme(
        asMap: json["asMap"] as Map<String, dynamic>?,
        domain: json["domain"],
        name: json["name"],
        permissions: json["permissions"] != null 
            ? List<String>.from(json["permissions"])
            : null,
        navigationItems: json["navigationItems"] != null 
            ? List<String>.from(json["navigationItems"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "asMap": asMap,
        "domain": domain,
        "name": name,
        "permissions": permissions,
        "navigationItems": navigationItems,
      };

  // Helper methods to get theme values from asMap
  String? get themeColor => asMap?["themeColor"] as String?;
  String? get primaryColor => asMap?["primaryColor"] as String?;
  String? get secondaryColor => asMap?["secondaryColor"] as String?;
  String? get accentColor => asMap?["accentColor"] as String?;
  String? get backgroundColor => asMap?["backgroundColor"] as String?;
  String? get textColor => asMap?["textColor"] as String?;
  String? get logoUrl => asMap?["logoUrl"] as String?;
  String? get appName => asMap?["appName"] as String?;
} 