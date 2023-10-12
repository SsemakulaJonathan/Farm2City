// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'product_name')
  String productName;
  String description;
  int price;
  @JsonKey(name: 'seller_id')
  int sellerId;
  @JsonKey(name: 'is_featured')
  int isFeatured;
  @JsonKey(name: 'large_thumbnail')
  String largeThumbnail;
  @JsonKey(name: 'category_id')
  int categoryId;
  @JsonKey(name: 'medium_thumbnail')
  String mediumThumbnail;

  Product({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.sellerId,
    required this.isFeatured,
    required this.mediumThumbnail,
    required this.categoryId,
    required this.largeThumbnail,
  });
  Map toJson() {
    return _$ProductToJson(this);
  }

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return _$ProductFromJson(json);
  }
}
