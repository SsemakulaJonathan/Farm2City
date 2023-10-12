import 'package:json_annotation/json_annotation.dart';
part 'product_image.g.dart';

@JsonSerializable()
class ProductImage {
  @JsonKey(name: 'image_path')
  String imagePath;

  ProductImage({
    required this.imagePath,
  });

  Map toJson() {
    return _$ProductImageToJson(this);
  }

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return _$ProductImageFromJson(json);
  }
}
