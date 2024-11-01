// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServicePlanningArea {
  final int spaid;
  final String name;
  ServicePlanningArea({
    required this.spaid,
    required this.name,
  });

  factory ServicePlanningArea.fromMap(Map<String, dynamic> map) {
    return ServicePlanningArea(
      spaid: map['spaid'] as int,
      name: map['name'] as String,
    );
  }

  factory ServicePlanningArea.fromJson(String source) =>
      ServicePlanningArea.fromMap(json.decode(source) as Map<String, dynamic>);
}
