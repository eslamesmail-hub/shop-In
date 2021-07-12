class HomeModel {
  bool status;
  HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int id;
  String image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

// import 'dart:convert';

// HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

// String homeModelToJson(HomeModel data) => json.encode(data.toJson());

// class HomeModel {
//     HomeModel({
//         this.status,
//         this.message,
//         this.data,
//     });

//     bool status;
//     dynamic message;
//     Data data;

//     factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     Data({
//         this.banners,
//         this.products,
//         this.ad,
//     });

//     List<Banner> banners;
//     List<Product> products;
//     String ad;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
//         products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
//         ad: json["ad"],
//     );

//     Map<String, dynamic> toJson() => {
//         "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
//         "products": List<dynamic>.from(products.map((x) => x.toJson())),
//         "ad": ad,
//     };
// }

// class Banner {
//     Banner({
//         this.id,
//         this.image,
//         this.category,
//         this.product,
//     });

//     int id;
//     String image;
//     Category category;
//     dynamic product;

//     factory Banner.fromJson(Map<String, dynamic> json) => Banner(
//         id: json["id"],
//         image: json["image"],
//         category: Category.fromJson(json["category"]),
//         product: json["product"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "category": category.toJson(),
//         "product": product,
//     };
// }

// class Category {
//     Category({
//         this.id,
//         this.image,
//         this.name,
//     });

//     int id;
//     String image;
//     String name;

//     factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         image: json["image"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "name": name,
//     };
// }

// class Product {
//     Product({
//         this.id,
//         this.price,
//         this.oldPrice,
//         this.discount,
//         this.image,
//         this.name,
//         this.description,
//         this.images,
//         this.inFavorites,
//         this.inCart,
//     });

//     int id;
//     double price;
//     double oldPrice;
//     int discount;
//     String image;
//     String name;
//     String description;
//     List<String> images;
//     bool inFavorites;
//     bool inCart;

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         price: json["price"].toDouble(),
//         oldPrice: json["old_price"].toDouble(),
//         discount: json["discount"],
//         image: json["image"],
//         name: json["name"],
//         description: json["description"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         inFavorites: json["in_favorites"],
//         inCart: json["in_cart"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "price": price,
//         "old_price": oldPrice,
//         "discount": discount,
//         "image": image,
//         "name": name,
//         "description": description,
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "in_favorites": inFavorites,
//         "in_cart": inCart,
//     };
// }
