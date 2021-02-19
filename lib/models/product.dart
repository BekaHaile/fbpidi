import 'package:fbpidi/models/company.dart';

class Product {
  String id;
  Category category;
  Company company;
  List<String> moreImages;
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
    this.company,
    this.moreImages,
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
    id = map["id"];
    category = Category.fromMap(map["category"]);
    company = Company.fromMap(map["company"]);
    moreImages = map["moreImages"];
    name = map["name"];
    nameAm = map["nameAm"];
    description = map["description"];
    descriptionAm = map["descriptionAm"];
    discount = map["discount"];
    image = map["image"];
    timestamp = map["timestamp"];
    user = map["user"];
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
    id = map["id"];
    subCategoryName = map["sub_category_name"];
    subCategoryNameAm = map["sub_category_name_am"];
    description = map["description"];
    descriptionAm = map["description_am"];
    image = map["image"];
    timestamp = map["timestamp"];
    user = map["user"];
    categoryName = map["category_name"];
  }
}
