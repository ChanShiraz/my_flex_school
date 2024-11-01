class EventAssoc {
  final int userid;
  final int eventid;
  EventAssoc({
    required this.userid,
    required this.eventid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'eventid': eventid,
    };
  }

  factory EventAssoc.fromMap(Map<String, dynamic> map) {
    return EventAssoc(
      userid: map['userid'] as int,
      eventid: map['eventid'] as int,
    );
  }
}
