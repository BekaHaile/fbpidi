class ResearchCategory {
  String id;
  String categoryName;
  String categoryNameAm;
  String detail;

  ResearchCategory(
      {this.id, this.categoryName, this.categoryNameAm, this.detail});

  ResearchCategory.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'].toString();
    categoryName = map['cateoryname'].toString();
    categoryNameAm = map['cateoryname_am'].toString();
    detail = map['detail'].toString();
  }
}
