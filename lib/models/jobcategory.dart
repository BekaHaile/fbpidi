class JobCategory {
  String id;
  String categoryName;
  String categoryNameAm;

  JobCategory({this.id, this.categoryName, this.categoryNameAm});

  JobCategory.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'].toString();
    categoryName = map['category_name'].toString();
    categoryNameAm = map['category_name_am'].toString();
  }
}
