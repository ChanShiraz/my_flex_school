class ServType {
  final int id;
  final String name;
  ServType({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serv_type_id': id,
      'name': name,
    };
  }

  factory ServType.fromMap(Map<String, dynamic> map) {
    return ServType(
      id: map['serv_type_id'] as int,
      name: map['name'] as String,
    );
  }
}
