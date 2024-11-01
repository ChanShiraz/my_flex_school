class Organization {
  final int orgid;
  final String name;
  final int spaid;
  final String description;
  final String address1;
  final String? address2;
  final String city;
  final String state;
  final int zip;
  final String website;
  final String avatar;
  final String contactPerson;
  final String contactPhone;
  final DateTime createdDate;
  final int createdBy;
  final bool fsStatus;
  final bool active;

  Organization({
    required this.orgid,
    required this.name,
    required this.spaid,
    required this.description,
    required this.address1,
    this.address2,
    required this.city,
    required this.state,
    required this.zip,
    required this.website,
    required this.avatar,
    required this.contactPerson,
    required this.contactPhone,
    required this.createdDate,
    required this.createdBy,
    required this.fsStatus,
    required this.active,
  });

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      orgid: map['orgid'],
      name: map['name'],
      spaid: map['spaid'],
      description: map['description'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      state: map['state'],
      zip: map['zip'],
      website: map['website'],
      avatar: map['avatar'],
      contactPerson: map['contact_person'],
      contactPhone: map['contact_phone'],
      createdDate: DateTime.parse(map['created_date']),
      createdBy: map['created_by'],
      fsStatus: map['fs_status'],
      active: map['active'],
    );
  }
}
