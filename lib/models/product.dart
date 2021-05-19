// import 'package:fbpidi/models/company.dart';

import 'company.dart';

class Product {
  String id;
  String latestPrice;
  List category;
  Company company;
  String name;
  String nameAm;
  String description;
  String descriptionAm;
  Brand brand;
  String image;
  String therapeuticGroup;
  String dose;
  String createDate;

  Product({
    this.id,
    this.latestPrice,
    this.category,
    this.company,
    this.name,
    this.nameAm,
    this.description,
    this.descriptionAm,
    this.brand,
    this.image,
    this.therapeuticGroup,
    this.dose,
    this.createDate,
  });

  Product.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    latestPrice = map["latest_price"].toString();
    category = map["category"];
    company = Company.fromMap(map["company"]);
    name = map["name"].toString();
    nameAm = map["nameAm"].toString();
    therapeuticGroup = map["therapeutic_group"].toString();
    dose = map["dose"].toString();
    description = map["description"].toString();
    descriptionAm = map["descriptionAm"].toString();
    brand = Brand.fromMap(map["brand"]);
    image = map["image"].toString();
    createDate = map["created_date"].toString();
  }
}

class Brand {
  String id;
  String subCategoryName;
  String subCategoryNameAm;
  String brandName;
  String brandNameAm;
  Map<String, dynamic> productType;

  Brand(
      {this.id,
      this.subCategoryName,
      this.subCategoryNameAm,
      this.productType,
      this.brandName,
      this.brandNameAm});

  Brand.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    subCategoryName = map["sub_category_name"].toString();
    subCategoryNameAm = map["sub_category_name_am"].toString();
    productType = map["product_type"];
    brandName = map["brand_name"];
    brandNameAm = map["brand_name_am"];
  }
}
