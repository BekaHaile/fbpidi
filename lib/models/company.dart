class Company {
  String id;
  String user;
  String companyName;
  String companyNameAm;
  String location;
  String email;
  String phoneNumber;
  String detail;
  String detailAm;
  String companyLogo;
  String companyIntro;
  String companyType;
  String companyTypeAm;
  String numberOfEmployees;
  String establishedYear;
  String certification;
  String city;
  String postalCode;
  String productCategoryName;
  String productCategory;
  String color;
  String facebookLink;
  String twitterLink;
  String googleLink;
  String capital;
  String pintrestLink;
  String instagramLink;
  String linkedinLink;
  String incoterms;
  String incotermsAm;
  String averageLeadTime;
  String averageLeadTimeAm;
  String noTradingStaff;
  String termsOfPayment;
  String exportYr;
  String exportPercentage;
  String mainMarket;
  String mainMarketAm;
  String nearestPort;
  String nearestPortAm;
  String importExport;
  String rAndDCapacity;
  String rAndDCapacityAm;
  String noOfRndStaff;
  String noProductionLines;
  String anualOpValue;
  String anualOpMainProducts;
  String anualOpMainProductsAm;
  String timestamp;

  Company({
    this.id,
    this.user,
    this.companyName,
    this.companyNameAm,
    this.location,
    this.email,
    this.phoneNumber,
    this.detail,
    this.detailAm,
    this.companyLogo,
    this.companyIntro,
    this.companyType,
    this.companyTypeAm,
    this.numberOfEmployees,
    this.establishedYear,
    this.certification,
    this.city,
    this.postalCode,
    this.productCategoryName,
    this.productCategory,
    this.color,
    this.facebookLink,
    this.twitterLink,
    this.googleLink,
    this.capital,
    this.pintrestLink,
    this.instagramLink,
    this.linkedinLink,
    this.incoterms,
    this.incotermsAm,
    this.averageLeadTime,
    this.averageLeadTimeAm,
    this.noTradingStaff,
    this.termsOfPayment,
    this.exportYr,
    this.exportPercentage,
    this.mainMarket,
    this.mainMarketAm,
    this.nearestPort,
    this.nearestPortAm,
    this.importExport,
    this.rAndDCapacity,
    this.rAndDCapacityAm,
    this.noOfRndStaff,
    this.noProductionLines,
    this.anualOpValue,
    this.anualOpMainProducts,
    this.anualOpMainProductsAm,
    this.timestamp,
  });

  Company.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"];
    user = map["user"];
    companyName = map["company_name"];
    companyNameAm = map["company_name_am"];
    location = map["location"];
    email = map["email"];
    phoneNumber = map["phone_number"];
    detail = map["detail"];
    detailAm = map["detail_am"];
    companyLogo = map["company_logo"];
    companyIntro = map["company_intro"];
    companyType = map["company_type"];
    companyTypeAm = map["company_type_am"];
    numberOfEmployees = map["number_of_employees"];
    establishedYear = map["established_year"];
    certification = map["certification"];
    city = map["city"];
    postalCode = map["postal_code"];
    productCategoryName = map["product_category_name"];
    productCategory = map["product_category"];
    color = map["color"];
    facebookLink = map["facebook_link"];
    twitterLink = map["twiter_link"];
    googleLink = map["google_link"];
    capital = map["capital"];
    pintrestLink = map["pintrest_link"];
    instagramLink = map["instagram_link"];
    linkedinLink = map["linkedin_link"];
    incoterms = map["incoterms"];
    incotermsAm = map["incoterms_am"];
    averageLeadTime = map["average_lead_time"];
    averageLeadTimeAm = map["average_lead_time_am"];
    noTradingStaff = map["no_trading_staff"];
    termsOfPayment = map["terms_of_payment"];
    exportYr = map["export_yr"];
    exportPercentage = map["export_percentage"];
    mainMarket = map["main_market"];
    mainMarketAm = map["main_market_am"];
    nearestPort = map["nearest_port"];
    nearestPortAm = map["nearest_port_am"];
    importExport = map["import_export"];
    rAndDCapacity = map["r_and_d_capacity"];
    rAndDCapacityAm = map["r_and_d_capacity_am"];
    noOfRndStaff = map["no_of_rnd_staff"];
    noProductionLines = map["no_production_lines"];
    anualOpValue = map["anual_op_value"];
    anualOpMainProducts = map["anual_op_main_products"];
    anualOpMainProductsAm = map["anual_op_main_products_am"];
    timestamp = map["timestamp"];
  }
}
