// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'micro_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MicroModel _$MicroModelFromJson(Map<String, dynamic> json) => MicroModel(
      gallery_id: json['gallery_id'] as String,
      school_id: json['school_id'] as String,
      micro_book_cover: json['micro_book_cover'] as String,
      micro_book_id: json['micro_book_id'] as String,
      sort_id: (json['sort_id'] as num).toInt(),
      publish: (json['publish'] as num).toInt(),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$MicroModelToJson(MicroModel instance) =>
    <String, dynamic>{
      'gallery_id': instance.gallery_id,
      'school_id': instance.school_id,
      'micro_book_cover': instance.micro_book_cover,
      'micro_book_id': instance.micro_book_id,
      'sort_id': instance.sort_id,
      'publish': instance.publish,
      'status': instance.status,
    };
