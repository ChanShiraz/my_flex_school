class ResType {
  final int id;
  final String name;
  ResType({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'res_type_id': id,
      'name': name,
    };
  }

  factory ResType.fromMap(Map<String, dynamic> map) {
    return ResType(
      id: map['res_type_id'] as int,
      name: map['name'] as String,
    );
  }
}
