class VideoAssoc {
  final int userid;
  final int well_vid_id;
  VideoAssoc({
    required this.userid,
    required this.well_vid_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'well_vid_id': well_vid_id,
    };
  }

  factory VideoAssoc.fromMap(Map<String, dynamic> map) {
    return VideoAssoc(
      userid: map['userid'] as int,
      well_vid_id: map['well_vid_id'] as int,
    );
  }
}
