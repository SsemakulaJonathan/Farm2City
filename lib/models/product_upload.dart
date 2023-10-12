import 'package:json_annotation/json_annotation.dart';
part 'product_upload.g.dart';

@JsonSerializable()
class ProductUpload {
  @JsonKey(name: 'product_name')
  String productName;
  int price;
  String description;
  @JsonKey(name: 'category_id')
  int categoryId;
  List<String>? images;
  ProductUpload({
    required this.productName,
    required this.price,
    required this.description,
    required this.categoryId,
    this.images,
  });
  factory ProductUpload.fromJson(Map<String, dynamic> json) {
    return _$ProductUploadFromJson(json);
  }
  Map toJson() {
    return _$ProductUploadToJson(this);
  }
}
