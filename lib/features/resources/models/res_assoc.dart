class ResAssoc {
  final int userid;
  final int resid;
  ResAssoc({
    required this.userid,
    required this.resid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'resid': resid,
    };
  }

  factory ResAssoc.fromMap(Map<String, dynamic> map) {
    return ResAssoc(
      userid: map['userid'] as int,
      resid: map['resid'] as int,
    );
  }
}
