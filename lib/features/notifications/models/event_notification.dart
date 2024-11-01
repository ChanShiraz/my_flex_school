class EventNotification {
  final int enid;
  final String name;
  final String description;
  final DateTime createdTime;
  final int createdBy;
  final bool active;
  final int eventid;

  EventNotification({
    required this.enid,
    required this.name,
    required this.description,
    required this.createdTime,
    required this.createdBy,
    required this.active,
    required this.eventid,
  });

  factory EventNotification.fromMap(Map<String, dynamic> map) {
    return EventNotification(
      enid: map['enid'],
      name: map['name'],
      description: map['description'],
      createdTime: DateTime.parse(map['created_time']),
      createdBy: map['created_by'],
      active: map['active'],
      eventid: map['eventid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enid': enid,
      'name': name,
      'description': description,
      'created_time': createdTime.toIso8601String(),
      'created_by': createdBy,
      'active': active,
      'eventid': eventid,
    };
  }
}
