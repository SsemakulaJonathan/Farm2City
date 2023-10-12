// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<dynamic, dynamic> json) {
  return Product(
    id: json['id'] as int,
    productName: json['product_name'] as String,
    description: json['description'] as String,
    //image: json['image'] as String,
    price: json['price'] as int,
    mediumThumbnail: json['medium_thumbnail'] as String,
    largeThumbnail: json['large_thumbnail'] as String,
    categoryId: json['category_id'] as int,
    sellerId: json['seller_id'] as int,
    isFeatured: json['is_featured'] as int,
  );
}

Map<dynamic, dynamic> _$ProductToJson(Product instance) => <dynamic, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'description': instance.description,
      //'image': instance.image,
      'price': instance.price,
      'is_featured': instance.isFeatured,
      'large_thumbnail': instance.largeThumbnail,
      'medium_thumbnail': instance.mediumThumbnail,
      'category_id': instance.categoryId,
      'seller_id': instance.sellerId,
    };
