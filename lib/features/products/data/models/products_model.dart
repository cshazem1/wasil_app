import 'product_model.dart';

class ProductsModel {
  ProductsModel({
      this.products,
      this.total, 
      this.skip, 
      this.limit,});

  ProductsModel.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
  List<ProductModel>? products;
  int? total;
  int? skip;
  int? limit;



}