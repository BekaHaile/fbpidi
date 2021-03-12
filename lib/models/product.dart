// import 'package:fbpidi/models/company.dart';

class Product {
  String id;
  String category;
  String categoryName;
  String company;
  // List<String> moreImages;
  String name;
  String nameAm;
  String description;
  String descriptionAm;
  String discount;
  String image;
  String timestamp;
  String user;

  Product({
    this.id,
    this.category,
    this.categoryName,
    this.company,
    // this.moreImages,
    this.name,
    this.nameAm,
    this.description,
    this.descriptionAm,
    this.discount,
    this.image,
    this.timestamp,
    this.user,
  });

  Product.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    category = map["category"].toString();
    categoryName = map["category_name"].toString();
    // Category.fromMap(map["category"]);
    company = map["company"].toString();
    // Company.fromMap(map["company"]);
    // moreImages = map["moreImages"];
    name = map["name"].toString();
    nameAm = map["nameAm"].toString();
    description = map["description"].toString();
    descriptionAm = map["descriptionAm"].toString();
    discount = map["discount"].toString();
    image = map["image"].toString();
    timestamp = map["timestamp"].toString();
    user = map["user"].toString();
  }
}

class Category {
  String id;
  String subCategoryName;
  String subCategoryNameAm;
  String description;
  String descriptionAm;
  String image;
  String timestamp;
  String user;
  String categoryName;

  Category({
    this.id,
    this.subCategoryName,
    this.subCategoryNameAm,
    this.description,
    this.descriptionAm,
    this.image,
    this.timestamp,
    this.user,
    this.categoryName,
  });

  Category.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    subCategoryName = map["sub_category_name"].toString();
    subCategoryNameAm = map["sub_category_name_am"].toString();
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    image = map["image"].toString();
    timestamp = map["timestamp"].toString();
    user = map["user"].toString();
    categoryName = map["category_name"].toString();
  }
}
