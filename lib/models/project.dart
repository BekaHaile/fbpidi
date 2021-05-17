import 'package:fbpidi/models/company.dart';

class Project {
  String id;
  String projectName;
  String projectNameAm;
  String geoLocation;
  Company company;
  Map<String, dynamic> contactPerson;
  List productType;
  String image;
  String establishedYr;
  String ownerShare;
  String bankShare;
  String capitalInDollary;
  String ownersNationality;
  String investmentLicense;
  String issuedDate;
  String description;
  String descriptionAm;
  String sector;
  String siteLocationName;
  String distanceFStrt;
  String remainingWork;
  String remainingWorkAm;
  String majorProblems;
  String majorProblemsAm;
  String operationalTime;
  String annualRawMaterial;
  String annualRawMaterialAm;
  String powerNeed;
  String waterSuply;
  String condProvidedForWy;
  String condProvidedForWyAm;
  String targetMarket;
  String envImpacAssDoc;
  String capitalUtilization;
  bool projectComplete;
  bool isActive;
  String reserveAttr0;
  String reserveAttr1;
  String reserveAttr2;
  String createdDate;
  String lastUpdatedDate;
  bool expired;
  String ownershipForm;
  String landAcquisition;
  String projectClassification;
  String technology;
  String automation;
  String modeOfProject;
  String facilityDesign;
  String createdBy;
  String lastUpdatedBy;

  Project({
    this.id,
    this.projectName,
    this.projectNameAm,
    this.geoLocation,
    this.company,
    this.contactPerson,
    this.productType,
    this.image,
    this.establishedYr,
    this.ownerShare,
    this.bankShare,
    this.capitalInDollary,
    this.ownersNationality,
    this.investmentLicense,
    this.issuedDate,
    this.description,
    this.descriptionAm,
    this.sector,
    this.siteLocationName,
    this.distanceFStrt,
    this.remainingWork,
    this.remainingWorkAm,
    this.majorProblems,
    this.majorProblemsAm,
    this.operationalTime,
    this.annualRawMaterial,
    this.annualRawMaterialAm,
    this.powerNeed,
    this.waterSuply,
    this.condProvidedForWy,
    this.condProvidedForWyAm,
    this.targetMarket,
    this.envImpacAssDoc,
    this.capitalUtilization,
    this.projectComplete,
    this.isActive,
    this.reserveAttr0,
    this.reserveAttr1,
    this.reserveAttr2,
    this.createdDate,
    this.lastUpdatedDate,
    this.expired,
    this.ownershipForm,
    this.landAcquisition,
    this.projectClassification,
    this.technology,
    this.automation,
    this.modeOfProject,
    this.facilityDesign,
    this.createdBy,
    this.lastUpdatedBy,
  });

  Project.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    projectName = map["project_name"].toString();
    projectNameAm = map["project_name_am"].toString();
    geoLocation = map["geo_location"].toString();
    company = Company.fromMap(map["company"]);
    contactPerson = map["contact_person"];
    productType = map["product_type"];
    image = map["image"].toString();
    establishedYr = map["established_yr"].toString();
    ownerShare = map["owner_share"].toString();
    bankShare = map["bank_share"].toString();
    capitalInDollary = map["capital_in_dollary"].toString();
    ownersNationality = map["owners_nationality"].toString();
    investmentLicense = map["investment_license"].toString();
    issuedDate = map["issued_date"].toString();
    description = map["description"].toString();
    descriptionAm = map["description_am"].toString();
    sector = map["sector"].toString();
    siteLocationName = map["site_location_name"].toString();
    distanceFStrt = map["distance_f_strt"].toString();
    remainingWork = map["remaining_work"].toString();
    remainingWorkAm = map["remaining_work_am"].toString();
    majorProblems = map["major_problems"].toString();
    majorProblemsAm = map["major_problems_am"].toString();
    operationalTime = map["operational_time"].toString();
    annualRawMaterial = map["annual_raw_material"].toString();
    annualRawMaterialAm = map["annual_raw_material_am"].toString();
    powerNeed = map["power_need"].toString();
    waterSuply = map["water_suply"].toString();
    condProvidedForWy = map["cond_provided_for_wy"].toString();
    condProvidedForWyAm = map["cond_provided_for_wy_am"].toString();
    targetMarket = map["target_market"].toString();
    envImpacAssDoc = map["env_impac_ass_doc"].toString();
    capitalUtilization = map["capital_utilization"].toString();
    projectComplete = map["project_complete"];
    isActive = map["is_active"];
    reserveAttr0 = map["reserve_attr0"].toString();
    reserveAttr1 = map["reserve_attr1"].toString();
    reserveAttr2 = map["reserve_attr2"].toString();
    createdDate = map["created_date"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"];
    ownershipForm = map["ownership_form"].toString();
    landAcquisition = map["land_acquisition"].toString();
    projectClassification = map["project_classification"].toString();
    technology = map["technology"].toString();
    automation = map["automation"].toString();
    modeOfProject = map["mode_of_project"].toString();
    facilityDesign = map["facility_design"].toString();
    createdBy = map["created_by"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
  }
}
