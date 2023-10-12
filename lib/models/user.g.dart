// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    firstName: json['firstname'] as String,
    lastName: json['lastname'] as String,
    email: json['email'] as String,
    role: json['role'] as String,
    phoneNumber: json['phone_number'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstName,
      'lastname': instance.lastName,
      'email': instance.email,
      'status': instance.role,
      'phone_number': instance.phoneNumber,
    };
