// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoView {
  final int? wvvid;
  final int well_vid_id;
  final int userid;
  final DateTime date_viewed;
  VideoView({
    this.wvvid,
    required this.well_vid_id,
    required this.userid,
    required this.date_viewed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'well_vid_id': well_vid_id,
      'userid': userid,
      'date_viewed': date_viewed.toIso8601String(),
    };
  }

  factory VideoView.fromMap(Map<String, dynamic> map) {
    return VideoView(
      wvvid: map['wvvid'] as int,
      well_vid_id: map['well_vid_id'] as int,
      userid: map['userid'] as int,
      date_viewed:
          DateTime.fromMillisecondsSinceEpoch(map['date_viewed'] as int),
    );
  }
}
