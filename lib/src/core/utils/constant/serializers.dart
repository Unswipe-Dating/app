import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:unswipe/src/core/utils/constant/token_response.dart';
import 'package:unswipe/src/core/utils/constant/user_and_token_entity.dart';

part 'serializers.g.dart';

@SerializersFor([
  UserAndTokenEntity,
  TokenResponse,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
