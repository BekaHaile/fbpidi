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
    id = map["id"].toString();
    user = map["user"].toString();
    companyName = map["company_name"].toString();
    companyNameAm = map["company_name_am"].toString();
    location = map["location"].toString();
    email = map["email"].toString();
    phoneNumber = map["phone_number"].toString();
    detail = map["detail"].toString();
    detailAm = map["detail_am"].toString();
    companyLogo = map["company_logo"].toString();
    companyIntro = map["company_intro"].toString();
    companyType = map["company_type"].toString();
    companyTypeAm = map["company_type_am"].toString();
    numberOfEmployees = map["number_of_employees"].toString();
    establishedYear = map["established_year"].toString();
    certification = map["certification"].toString();
    city = map["city"].toString();
    postalCode = map["postal_code"].toString();
    productCategoryName = map["product_category_name"].toString();
    productCategory = map["product_category"].toString();
    color = map["color"].toString();
    facebookLink = map["facebook_link"].toString();
    twitterLink = map["twiter_link"].toString();
    googleLink = map["google_link"].toString();
    capital = map["capital"].toString();
    pintrestLink = map["pintrest_link"].toString();
    instagramLink = map["instagram_link"].toString();
    linkedinLink = map["linkedin_link"].toString();
    incoterms = map["incoterms"].toString();
    incotermsAm = map["incoterms_am"].toString();
    averageLeadTime = map["average_lead_time"].toString();
    averageLeadTimeAm = map["average_lead_time_am"].toString();
    noTradingStaff = map["no_trading_staff"].toString();
    termsOfPayment = map["terms_of_payment"].toString();
    exportYr = map["export_yr"].toString();
    exportPercentage = map["export_percentage"].toString();
    mainMarket = map["main_market"].toString();
    mainMarketAm = map["main_market_am"].toString();
    nearestPort = map["nearest_port"].toString();
    nearestPortAm = map["nearest_port_am"].toString();
    importExport = map["import_export"].toString();
    rAndDCapacity = map["r_and_d_capacity"].toString();
    rAndDCapacityAm = map["r_and_d_capacity_am"].toString();
    noOfRndStaff = map["no_of_rnd_staff"].toString();
    noProductionLines = map["no_production_lines"].toString();
    anualOpValue = map["anual_op_value"].toString();
    anualOpMainProducts = map["anual_op_main_products"].toString();
    anualOpMainProductsAm = map["anual_op_main_products_am"].toString();
    timestamp = map["timestamp"].toString();
  }
}
