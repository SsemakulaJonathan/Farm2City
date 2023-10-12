// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    quantity: json['quantity'] as int,
    productId: json['product_id'] as int,
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'product_id': instance.productId,
    };
