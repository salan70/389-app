import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, Object> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Object fieldValue) => (fieldValue as Timestamp).toDate();

  @override
  String toJson(DateTime dateTime) => dateTime.toLocal().toString();
}
