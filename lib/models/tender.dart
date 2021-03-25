import 'package:fbpidi/models/company.dart';

class Tender {
  String id;
  Map<dynamic, dynamic> createdBy;
  Company company;
  String createdDate;
  String title;
  String titleAm;
  String description;
  String descriptionAm;
  String document;
  String tenderType;
  double documentPrice;
  String status;
  String startDate;
  String endDate;
  String lastUpdatedDate;
  bool expired;
  String lastUpdatedBy;
  List bankAccount;

  Tender({
    this.id,
    this.createdBy,
    this.company,
    this.createdDate,
    this.title,
    this.titleAm,
    this.description,
    this.descriptionAm,
    this.document,
    this.tenderType,
    this.documentPrice,
    this.status,
    this.startDate,
    this.endDate,
    this.lastUpdatedDate,
    this.expired,
    this.lastUpdatedBy,
    this.bankAccount,
  });

  Tender.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    createdBy = map["created_by"];
    company = Company.fromMap(map["company"]);
    createdDate = map["created_date"].toString();
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    document = map["document"].toString();
    tenderType = map["tender_type"].toString();
    documentPrice = map["document_price"];
    startDate = map["start_date"].toString();
    endDate = map["end_date"].toString();
    lastUpdatedBy = map["last_Updated_by"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    status = map["status"].toString();
    expired = map["expired"];
    bankAccount = map["bank_account"];
    title = map["title"].toString();
    titleAm = map["title_am"].toString();
  }
}
