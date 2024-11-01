class SchoolNotification {
  final int fsnid;
  final String name;
  final String description;
  final DateTime createdTime;
  final int createdBy;
  final bool active;
  final int fsid;

  SchoolNotification({
    required this.fsnid,
    required this.name,
    required this.description,
    required this.createdTime,
    required this.createdBy,
    required this.active,
    required this.fsid,
  });

  factory SchoolNotification.fromMap(Map<String, dynamic> map) {
    return SchoolNotification(
      fsnid: map['fsnid'],
      name: map['name'],
      description: map['description'],
      createdTime: DateTime.parse(map['created_time']),
      createdBy: map['created_by'],
      active: map['active'],
      fsid: map['fsid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fsnid': fsnid,
      'name': name,
      'description': description,
      'created_time': createdTime.toIso8601String(),
      'created_by': createdBy,
      'active': active,
      'fsid': fsid,
    };
  }
}
