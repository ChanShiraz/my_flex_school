class UserModel {
  final String uid;
  final int? userid;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final int role;
  final String avatar;
  final String about;
  final int createdBy;
  final DateTime createdDate;
  final bool active;
  final String address;

  UserModel({
    this.userid,
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
    required this.about,
    required this.createdBy,
    required this.createdDate,
    required this.active,
    required this.address,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      userid: map['userid'],
      firstName: map['first'],
      lastName: map['last'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
      avatar: map['avatar'],
      about: map['about'],
      createdBy: map['created_by'],
      createdDate: DateTime.parse(map['created_date']),
      active: map['active'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      //'userid': userid,
      'first': firstName,
      'last': lastName,
      'email': email,
      'password': password,
      'role': role,
      'avatar': avatar,
      'about': about,
      'created_by': createdBy,
      'created_date': createdDate.toIso8601String(),
      'active': active,
      'address': address,
    };
  }
}
