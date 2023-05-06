import 'package:flutter/material.dart';

final utils = Utilities();

class Utilities {
  Utilities._internal();

  static final Utilities _instance = Utilities._internal();
  factory Utilities() => _instance;

  void noAction() {}

  String jsonString(dynamic data) =>
      data.toString().trim().toLowerCase() == "null" ? "" : data.toString();

  int jsonInt(dynamic data) => int.tryParse((data ?? 0).toString()) ?? 0;

  double jsonDouble(dynamic data) =>
      double.tryParse((data ?? 0.0).toString()) ?? 0.0;

  bool jsonBool(dynamic data) => data is bool ? data : false;

  Map<String, dynamic> jsonMap(dynamic data) {
    try {
      return Map<String, dynamic>.from(data ?? {});
    } catch (_) {
      return {};
    }
  }

  List<dynamic> jsonList(dynamic data) {
    try {
      return List<dynamic>.from(data ?? []);
    } catch (_) {
      return [];
    }
  }

  double getFullWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  double getFullHeight(BuildContext context) =>
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

  double getSizeConstraint(BuildContext context, double value) =>
      getFullWidth(context) * (value / 1080);
}
