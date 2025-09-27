// Copyright (c) 2023-2025, Shinya Kato.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: invalid_annotation_target

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation.freezed.dart';
part 'operation.g.dart';

@freezed
abstract class Operation with _$Operation {
  /// Creates an instance of [Operation].
  @JsonSerializable(includeIfNull: false)
  const factory Operation({
    required String sig,
    @Default('plc_operation') String type,
    required Map<String, dynamic> services,
    required List<String> alsoKnownAs,
    required List<String> rotationKeys,
    required Map<String, dynamic> verificationMethods,
    String? prev,
  }) = _Operation;

  /// Creates an instance of [Operation] from a map of
  /// [String, Object?].
  ///
  /// This factory constructor is used for deserializing JSON data into an
  /// [Operation] object.
  factory Operation.fromJson(Map<String, Object?> json) =>
      _$OperationFromJson(json);
}
