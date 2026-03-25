import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_message_model.g.dart';

@JsonSerializable()
class ContactMessageModel {
  const ContactMessageModel({
    required this.name,
    required this.email,
    required this.message,
    required this.locale,
  });

  final String name;
  final String email;
  final String message;
  final String locale;

  Map<String, dynamic> toFirestore() => {
        ...toJson(),
        'created_at': FieldValue.serverTimestamp(),
      };

  factory ContactMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ContactMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactMessageModelToJson(this);
}
