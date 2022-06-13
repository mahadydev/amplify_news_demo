/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: prefer_const_literals_to_create_immutables, public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the News type in your schema. */
@immutable
class News extends Model {
  static const classType = const _NewsModelType();
  final String id;
  final String? _title;
  final String? _content;
  final String? _image;
  final String? _video;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  String? get title {
    return _title;
  }

  String? get content {
    return _content;
  }

  String? get image {
    return _image;
  }

  String? get video {
    return _video;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const News._internal(
      {required this.id, title, content, image, video, createdAt, updatedAt})
      : _title = title,
        _content = content,
        _image = image,
        _video = video,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory News(
      {String? id,
      String? title,
      String? content,
      String? image,
      String? video}) {
    return News._internal(
        id: id == null ? UUID.getUUID() : id,
        title: title,
        content: content,
        image: image,
        video: video);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is News &&
        id == other.id &&
        _title == other._title &&
        _content == other._content &&
        _image == other._image &&
        _video == other._video;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("News {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("video=" + "$_video" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  News copyWith(
      {String? id,
      String? title,
      String? content,
      String? image,
      String? video}) {
    return News._internal(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        image: image ?? this.image,
        video: video ?? this.video);
  }

  News.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _title = json['title'],
        _content = json['content'],
        _image = json['image'],
        _video = json['video'],
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': _title,
        'content': _content,
        'image': _image,
        'video': _video,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  static final QueryField ID = QueryField(fieldName: "news.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField IMAGE = QueryField(fieldName: "image");
  static final QueryField VIDEO = QueryField(fieldName: "video");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "News";
    modelSchemaDefinition.pluralName = "News";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: AuthRuleProvider.USERPOOLS,
          operations: [
            ModelOperation.CREATE,
            ModelOperation.DELETE,
            ModelOperation.UPDATE
          ]),
      AuthRule(
          authStrategy: AuthStrategy.PRIVATE, operations: [ModelOperation.READ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.TITLE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.CONTENT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.IMAGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.VIDEO,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _NewsModelType extends ModelType<News> {
  const _NewsModelType();

  @override
  News fromJson(Map<String, dynamic> jsonData) {
    return News.fromJson(jsonData);
  }
}
