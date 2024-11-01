class Video {
  final int wellVidId;
  final String name;
  final String description;
  final String path;
  final DateTime createdDate;
  final int createdBy;
  final bool active;

  Video({
    required this.wellVidId,
    required this.name,
    required this.description,
    required this.path,
    required this.createdDate,
    required this.createdBy,
    required this.active,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      wellVidId: map['well_vid_id'],
      name: map['name'],
      description: map['description'],
      path: map['path'],
      createdDate: DateTime.parse(map['created_date']),
      createdBy: map['created_by'],
      active: map['active'],
    );
  }
}
