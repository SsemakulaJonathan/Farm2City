// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  @JsonKey(name: 'firstname')
  String firstName;
  @JsonKey(name: 'lastname')
  String lastName;
  String email;
  String role;
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.phoneNumber,
  });
  Map toJson() {
    return _$UserToJson(this);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
}
