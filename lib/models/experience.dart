import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Portfolio experience synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    required this.title,
    required this.description,
    required this.category,
    this.id,
    this.thumbnail = '',
    this.startedAt,
    this.endedAt,
    this.isOngoing = false,
    this.starCount = 0,
    this.isStarred = false,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String category;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  @JsonKey(includeToJson: false)
  final DateTime? startedAt;
  final DateTime? endedAt;

  @JsonKey(includeToJson: false)
  final bool isOngoing;

  @JsonKey(includeToJson: false)
  final int starCount;

  @JsonKey(includeToJson: false)
  final bool isStarred;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
