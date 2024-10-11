import 'package:json_annotation/json_annotation.dart';

part 'micro_model.g.dart';

@JsonSerializable()
class MicroModel {
  final String? gallery_id,
      school_id,
      micro_book_cover,
      micro_book_id,
      micro_book_url;
  final int? sort_id, publish, status;

  MicroModel(this.micro_book_url,
      {required this.gallery_id,
      required this.school_id,
      required this.micro_book_cover,
      required this.micro_book_id,
      required this.sort_id,
      required this.publish,
      required this.status});

  factory MicroModel.fromJson(Map<String, dynamic> json) =>
      _$MicroModelFromJson(json);
  Map<String, dynamic> toJson() => _$MicroModelToJson(this);
}
