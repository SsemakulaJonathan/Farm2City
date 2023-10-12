// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductUpload _$ProductUploadFromJson(Map<String, dynamic> json) {
  return ProductUpload(
    productName: json['product_name'] as String,
    price: json['price'] as int,
    description: json['description'] as String,
    categoryId: json['category_id'] as int,
  );
}

Map<String, dynamic> _$ProductUploadToJson(ProductUpload instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'price': instance.price,
      'description': instance.description,
      'category_id': instance.categoryId,
    };
