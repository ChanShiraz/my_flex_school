// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SchoolAssocModel {
  final int userid;
  final int fsid;
  SchoolAssocModel({
    required this.userid,
    required this.fsid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'fsid': fsid,
    };
  }

  factory SchoolAssocModel.fromMap(Map<String, dynamic> map) {
    return SchoolAssocModel(
      userid: map['userid'] as int,
      fsid: map['fsid'] as int,
    );
  }
}
