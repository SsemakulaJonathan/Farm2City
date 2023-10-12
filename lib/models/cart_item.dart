// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:farm_city/models/product.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(name: 'product_id')
  int productId;
  @JsonKey(name: 'buyer_id')
  int buyerId;
  @JsonKey(name: 'seller_id')
  int sellerId;
  int quantity;
  Product product;

  CartItem({
    required this.productId,
    required this.buyerId,
    required this.quantity,
    required this.product,
    required this.sellerId,
  });
  Map toJson() {
    return _$CartItemToJson(this);
  }

  factory CartItem.fromJson(Map<dynamic, dynamic> json) {
    return _$CartItemFromJson(json);
  }
}
