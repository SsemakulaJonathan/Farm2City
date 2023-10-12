// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int quantity;
  @JsonKey(name: 'product_id')
  int? productId;

  Cart({
    required this.quantity,
    this.productId,
  });
  Map toJson() {
    return _$CartToJson(this);
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return _$CartFromJson(json);
  }
}
