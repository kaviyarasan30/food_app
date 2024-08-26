class Product {
  // ignore: unused_field
  int? _totalSize;
  // ignore: unused_field
  int? _typeId;
  // ignore: unused_field
  int? _offset;
  late List<ProductModel> _products; // Update: Use non-nullable list
  List<ProductModel> get products => _products;

  Product({
    required int totalSize, // Update: Add required keyword
    required int typeId, // Update: Add required keyword
    required int offset, // Update: Add required keyword
    required List<ProductModel> products, // Update: Add required keyword
  }) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset']; // Update: Use _offset = json['offset'] instead of _offset = json['_offset']
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.typeId,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson(){
    return{
      "id":id,
      "name":name,
      "price":price,
      "img":img,
      "location":location,
      "createdAt":createdAt,
      "updatedAt":updatedAt,
      "typeId":typeId,

    };
  }
}