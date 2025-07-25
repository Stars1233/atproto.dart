// Copyright (c) 2023-2025, Shinya Kato.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

// Package imports:
import 'package:atproto_core/internals.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'input.freezed.dart';
part 'input.g.dart';

// **************************************************************************
// LexGenerator
// **************************************************************************

@freezed
abstract class ActorSearchActorsInput with _$ActorSearchActorsInput {
  static const knownProps = <String>['q', 'limit', 'cursor'];

  const factory ActorSearchActorsInput({
    /// Search query string. Syntax, phrase, boolean, and faceting is unspecified, but Lucene query syntax is recommended.
    String? q,
    @Default(25) int limit,
    String? cursor,

    Map<String, dynamic>? $unknown,
  }) = _ActorSearchActorsInput;

  factory ActorSearchActorsInput.fromJson(Map<String, Object?> json) =>
      _$ActorSearchActorsInputFromJson(json);
}

extension ActorSearchActorsInputExtension on ActorSearchActorsInput {
  bool get hasQ => q != null;
  bool get hasNotQ => !hasQ;
  bool get hasCursor => cursor != null;
  bool get hasNotCursor => !hasCursor;
}

final class ActorSearchActorsInputConverter
    extends JsonConverter<ActorSearchActorsInput, Map<String, dynamic>> {
  const ActorSearchActorsInputConverter();

  @override
  ActorSearchActorsInput fromJson(Map<String, dynamic> json) {
    return ActorSearchActorsInput.fromJson(
      translate(json, ActorSearchActorsInput.knownProps),
    );
  }

  @override
  Map<String, dynamic> toJson(ActorSearchActorsInput object) =>
      untranslate(object.toJson());
}
