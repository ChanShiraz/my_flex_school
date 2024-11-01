class Event {
  final int eventid;
  final String name;
  final int orgid;
  final int spaid;
  final String description;
  final String address1;
  final String? address2;
  final String state;
  final String city;
  final int zip;
  final String website;
  final DateTime start;
  final DateTime end;
  final String contactPerson;
  final String contactPhone;
  final DateTime createdDate;
  final int createdBy;
  final bool active;

  Event({
    required this.eventid,
    required this.name,
    required this.orgid,
    required this.spaid,
    required this.description,
    required this.address1,
    this.address2,
    required this.state,
    required this.city,
    required this.zip,
    required this.website,
    required this.start,
    required this.end,
    required this.contactPerson,
    required this.contactPhone,
    required this.createdDate,
    required this.createdBy,
    required this.active,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventid: map['eventid'],
      name: map['name'],
      orgid: map['orgid'],
      spaid: map['spaid'],
      description: map['description'],
      address1: map['address1'],
      address2: map['address2'], // Nullable field
      state: map['state'],
      city: map['city'],
      zip: map['zip'],
      website: map['website'],
      start: DateTime.parse(map['start']),
      end: DateTime.parse(map['end']),
      contactPerson: map['contact_person'],
      contactPhone: map['contact_phone'],
      createdDate: DateTime.parse(map['created_date']),
      createdBy: map['created_by'],
      active: map['active'],
    );
  }
}
