import 'package:json_annotation/json_annotation.dart';

enum Sentiment {
  @JsonValue('NEG')
  negative,
  @JsonValue('POS')
  positive,
  @JsonValue('NEU')
  neutral
}
