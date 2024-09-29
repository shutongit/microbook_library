import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'galleries_model.g.dart';

// @JsonSerializable()
class GalleriesModel {
  final String? gallery_id, gallery_name, school_id;
  final int? gallery_type, status, sort_id, is_show_navigation_page;

  String? imgurl;
  int? bgColor;

  GalleriesModel(
      this.gallery_id,
      this.gallery_name,
      this.school_id,
      this.gallery_type,
      this.status,
      this.sort_id,
      this.is_show_navigation_page,
      this.imgurl,
      this.bgColor);

  factory GalleriesModel.fromJson(Map<String, dynamic> json) => GalleriesModel(
        json['gallery_id'] as String?,
        json['gallery_name'] as String?,
        json['school_id'] as String?,
        (json['gallery_type'] as num?)?.toInt(),
        (json['status'] as num?)?.toInt(),
        (json['sort_id'] as num?)?.toInt(),
        (json['is_show_navigation_page'] as num?)?.toInt(),
        json['imgurl'] as String?,
        (json['bgColor'] as num?)?.toInt(),
      );
  //     _$GalleriesModelFromJson(json);
  Map<String, dynamic> toJson() => <String, dynamic>{
        'gallery_id': gallery_id,
        'gallery_name': gallery_name,
        'school_id': school_id,
        'gallery_type': gallery_type,
        'status': status,
        'sort_id': sort_id,
        'is_show_navigation_page': is_show_navigation_page,
        'imgurl': imgurl,
        'bgColor': bgColor,
      };

  // factory GalleriesModel.fromJson(Map<String, dynamic> json) =>
  //     _$GalleriesModelFromJson(json);
  // Map<String, dynamic> toJson() => _$GalleriesModelToJson(this);
}
