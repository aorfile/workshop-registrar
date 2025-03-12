class Resource {
  final String id;
  final String title;
  final String description;
  final String type;
  final String fileUrl;
  final String fileSize;
  final String uploadDate;
  final String uploadedBy;
  final List<String> tags;
  final bool isDownloadable;
  final int downloadCount;
  final DateTime lastUpdated;

  const Resource({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.fileUrl,
    required this.fileSize,
    required this.uploadDate,
    required this.uploadedBy,
    required this.tags,
    required this.isDownloadable,
    required this.downloadCount,
    required this.lastUpdated,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      fileUrl: json['fileUrl'] as String,
      fileSize: json['fileSize'] as String,
      uploadDate: json['uploadDate'] as String,
      uploadedBy: json['uploadedBy'] as String,
      tags: List<String>.from(json['tags'] as List),
      isDownloadable: json['isDownloadable'] as bool,
      downloadCount: json['downloadCount'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'fileUrl': fileUrl,
      'fileSize': fileSize,
      'uploadDate': uploadDate,
      'uploadedBy': uploadedBy,
      'tags': tags,
      'isDownloadable': isDownloadable,
      'downloadCount': downloadCount,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}