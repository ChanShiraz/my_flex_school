class OrgType {
  final int id;
  final String name;
  OrgType({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'org_type_id': id,
      'name': name,
    };
  }

  factory OrgType.fromMap(Map<String, dynamic> map) {
    return OrgType(
      id: map['org_type_id'] as int,
      name: map['name'] as String,
    );
  }
}
