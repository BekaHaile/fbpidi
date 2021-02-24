class Event {
  String id;
  String image;
  List<String> companyInfo;
  String eventName;
  String eventNameAm;
  String description;
  String descriptionAm;
  String timeStamp;
  String startDate;
  String endDate;
  String status;
  String company;

  Event({
    this.id,
    this.image,
    this.companyInfo,
    this.eventName,
    this.eventNameAm,
    this.description,
    this.descriptionAm,
    this.timeStamp,
    this.startDate,
    this.endDate,
    this.status,
    this.company,
  });

  Event.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"];
    image = map["image"];
    companyInfo = map["company_info"];
    eventName = map["event_name"];
    eventNameAm = map["event_name_am"];
    description = map["description"];
    descriptionAm = map["description_am"];
    timeStamp = map["time_stamp"];
    startDate = map["start_date"];
    endDate = map["end_date"];
    status = map["status"];
    company = map["company"];
  }
}
