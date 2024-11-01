class ServAssoc {
  final int userid;
  final int servid;
  ServAssoc({
    required this.userid,
    required this.servid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'servid': servid,
    };
  }

  factory ServAssoc.fromMap(Map<String, dynamic> map) {
    return ServAssoc(
      userid: map['userid'] as int,
      servid: map['servid'] as int,
    );
  }
}
