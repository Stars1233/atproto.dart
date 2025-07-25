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

part 'log_accept_convo.freezed.dart';
part 'log_accept_convo.g.dart';

// **************************************************************************
// LexGenerator
// **************************************************************************

@freezed
abstract class LogAcceptConvo with _$LogAcceptConvo {
  static const knownProps = <String>['rev', 'convoId'];

  const factory LogAcceptConvo({
    @Default('chat.bsky.convo.defs#logAcceptConvo') String $type,
    required String rev,
    required String convoId,

    Map<String, dynamic>? $unknown,
  }) = _LogAcceptConvo;

  factory LogAcceptConvo.fromJson(Map<String, Object?> json) =>
      _$LogAcceptConvoFromJson(json);

  static bool validate(final Map<String, dynamic> object) {
    if (!object.containsKey('\$type')) return false;
    return object['\$type'] == 'chat.bsky.convo.defs#logAcceptConvo';
  }
}

final class LogAcceptConvoConverter
    extends JsonConverter<LogAcceptConvo, Map<String, dynamic>> {
  const LogAcceptConvoConverter();

  @override
  LogAcceptConvo fromJson(Map<String, dynamic> json) {
    return LogAcceptConvo.fromJson(translate(json, LogAcceptConvo.knownProps));
  }

  @override
  Map<String, dynamic> toJson(LogAcceptConvo object) =>
      untranslate(object.toJson());
}
