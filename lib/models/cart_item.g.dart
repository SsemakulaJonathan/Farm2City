// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<dynamic, dynamic> json) {
  return CartItem(
    productId: json['product_id'] as int,
    buyerId: json['buyer_id'] as int,
    quantity: json['quantity'] as int,
    product: Product.fromJson(json['product'] as Map<String, dynamic>),
    sellerId: json['seller_id'] as int,
  );
}

Map<dynamic, dynamic> _$CartItemToJson(CartItem instance) => <dynamic, dynamic>{
      'product_id': instance.productId,
      'buyer_id': instance.buyerId,
      'quantity': instance.quantity,
      'product': instance.product,
      'seller_id': instance.sellerId,
    };
