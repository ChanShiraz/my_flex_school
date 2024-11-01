class School {
  final int fsid;
  final String name;
  final int orgid;
  final int spaid;
  final String description;
  final String address1;
  final String? address2;
  final String state;
  final String city;
  final int zip;
  final int startGrade;
  final int endGrade;
  final String? instructionalMethods;
  final String website;
  final String? contactPerson;
  final String contactPhone;
  final DateTime createdDate;
  final int createdBy;
  final bool active;
  final String? logo;

  // Constructor
  School({
    this.logo,
    required this.fsid,
    required this.name,
    required this.orgid,
    required this.spaid,
    required this.description,
    required this.address1,
    this.address2,
    required this.state,
    required this.city,
    required this.zip,
    required this.startGrade,
    required this.endGrade,
    this.instructionalMethods,
    required this.website,
    this.contactPerson,
    required this.contactPhone,
    required this.createdDate,
    required this.createdBy,
    required this.active,
  });

  factory School.fromMap(Map<String, dynamic> data) {
    return School(
      fsid: data['fsid'],
      logo: data['logo'],
      name: data['name'],
      orgid: data['orgid'],
      spaid: data['spaid'],
      description: data['description'],
      address1: data['address1'],
      address2: data['address2'],
      state: data['state'],
      city: data['city'],
      zip: data['zip'],
      startGrade: data['start_grade'],
      endGrade: data['end_grade'],
      instructionalMethods: data['instructional_methods'],
      website: data['website'],
      contactPerson: data['contact_person'],
      contactPhone: data['contact_phone'].toString(),
      createdDate: DateTime.parse(data['created_date']),
      createdBy: data['created_by'],
      active: data['active'],
    );
  }
}
