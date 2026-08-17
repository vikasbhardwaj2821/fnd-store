class CmsModel {
  const CmsModel({
    this.id,
    this.type,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  final String? id;
  final int? type;
  final String? title;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  factory CmsModel.fromJson(Map<String, dynamic> json) => CmsModel(
    id: json['id']?.toString(),
    type: json['type'] is int
        ? json['type'] as int
        : int.tryParse('${json['type']}'),
    title: json['title']?.toString(),
    description: json['description']?.toString(),
    createdAt: _date(json['createdAt']),
    updatedAt: _date(json['updatedAt']),
    deletedAt: _date(json['deletedAt']),
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'title': title,
    'description': description,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'deletedAt': deletedAt?.toIso8601String(),
  };
}

DateTime? _date(dynamic value) =>
    value == null ? null : DateTime.tryParse(value.toString());
