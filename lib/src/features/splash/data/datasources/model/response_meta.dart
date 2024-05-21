import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'meta_config.dart';
part 'firebase_config.dart';
part 'reclaim_config.dart';

part 'response_meta.g.dart';

@JsonSerializable()
class ResponseMeta {
  ResponseMeta(this.getConfig);

  factory ResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$ResponseMetaFromJson(json);

  MetaConfig getConfig;

  Map<String, dynamic> toJson() => _$ResponseMetaToJson(this);
}