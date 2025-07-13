
import 'package:dukascan_go/domain/models/product.dart';

class ProductsTopHomeResponse {

  final bool resp;
  final String msg;
  final List<Product> products;

  ProductsTopHomeResponse({
    required this.resp,
    required this.msg,
    required this.products,
  });

  factory ProductsTopHomeResponse.fromJson(Map<String, dynamic> json) => ProductsTopHomeResponse(
    resp: json["resp"],
    msg: json["msg"],
    products: json["products"] != null ? List<Product>.from(json["products"].map((x) => Product.fromJson(x))).toList() : [],
  );
}
