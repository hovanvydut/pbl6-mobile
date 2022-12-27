import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue(1)
  admin,
  @JsonValue(2)
  host,
  @JsonValue(3)
  guest,
  @JsonValue(4)
  hostAndGuest,
}
