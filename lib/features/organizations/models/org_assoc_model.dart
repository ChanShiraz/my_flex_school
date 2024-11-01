class OrgAssoc {
  final int userid;
  final int orgid;
  OrgAssoc({
    required this.userid,
    required this.orgid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'orgid': orgid,
    };
  }

  factory OrgAssoc.fromMap(Map<String, dynamic> map) {
    return OrgAssoc(
      userid: map['userid'] as int,
      orgid: map['orgid'] as int,
    );
  }
}
