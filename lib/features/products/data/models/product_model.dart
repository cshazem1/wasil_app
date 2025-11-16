import 'package:json_annotation/json_annotation.dart';
import 'package:wasil_task/features/products/domain/entites/product_details_entity.dart';

import '../../domain/entites/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  num? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Reviews>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  List<String>? images;
  String? thumbnail;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  toEntity() {
    return ProductEntity(
      id: id ?? 0,
      description: description ?? '',
      title: title ?? '',
      price: price ?? 0,
      stock: stock ?? 0,
      image: images?[0] ?? '',
    );
  }

  ProductDetailsEntity toProductDetailsEntity() {
    return ProductDetailsEntity(
      id: id ?? 0,
      description: description ?? '',
      title: title ?? '',
      price: price ?? 0,
      stock: stock ?? 0,
      images: images ?? [],

      thumbnail: thumbnail ?? '',
      availabilityStatus: availabilityStatus ?? '',
      returnPolicy: returnPolicy ?? '',
      warrantyInformation: warrantyInformation ?? '',
      shippingInformation: shippingInformation ?? '',
      brand: brand ?? '',
      discountPercentage: discountPercentage?.toDouble() ?? 0,
      rating: rating ?? 0,
    );
  }
}

@JsonSerializable()
class Meta {
  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  Meta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@JsonSerializable()
class Dimensions {
  num? width;
  num? height;
  num? depth;

  Dimensions({this.width, this.height, this.depth});

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
}

@JsonSerializable()
class ProductsModel {
  List<ProductModel>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsModel({this.products, this.total, this.skip, this.limit});

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);
}

@JsonSerializable()
class Reviews {
  Reviews({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);
}
