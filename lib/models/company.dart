class Company {
  String id;
  String createdBy;
  Map<dynamic, dynamic> companyAddress;
  String mainCategory;
  String name;
  String nameAm;
  String logo;
  String geoLocation;
  String establishedYear;
  String detail;
  String detailAm;
  String expansionPlan;
  String expansionPlanAm;
  String tradeLicense;
  String orgnStrct;
  String labTestAnalysis;
  String labTestAnalysisAm;
  String labEquipment;
  String labEquipmentAm;
  String outsourcedTestParam;
  String outsourcedTestParamAm;
  String conductedResearch;
  String conductedResearchAm;
  String newProductDeveloped;
  String newProductDevelopedAm;
  bool electricPower;
  bool waterSupply;
  bool telecom;
  bool marketingDepartment;
  bool eCommerce;
  bool activeDatabase;
  String wasteTrtmntSystem;
  String wasteTrtmntSystemAm;
  bool efluentTreatmentPlant;

  String envMgmtPlan;
  String gasCarbEmision;
  String gasCarbEmisionAm;
  String compoundAllot;
  String comunityCompliant;
  String comunityCompliantAm;
  bool envFocalPerson;
  bool safetyProfesional;
  bool notificationProcedure;
  String universityLinkage;
  String universityLinkageAm;
  bool recallSystem;
  String qualityDefectsAm;
  String qualityDefects;
  String gasWasteMgmntMeasure;
  String gasWasteMgmntMeasureAm;
  String createdDate;
  String lastUpdatedDate;
  bool expired;
  String ownershipForm;
  String contactPerson;
  String workingHours;
  String sourceOfEnergy;
  String supportRequired;
  String companyCondition;
  String lastUpdatedBy;
  List category;
  List certification;
  List managementTools;
  List companyCertificates;

  Company(
      {this.id,
      this.createdBy,
      this.companyAddress,
      this.mainCategory,
      this.name,
      this.nameAm,
      this.geoLocation,
      this.expansionPlan,
      this.expansionPlanAm,
      this.tradeLicense,
      this.orgnStrct,
      this.labTestAnalysis,
      this.labTestAnalysisAm,
      this.labEquipment,
      this.labEquipmentAm,
      this.outsourcedTestParam,
      this.outsourcedTestParamAm,
      this.conductedResearch,
      this.conductedResearchAm,
      this.newProductDeveloped,
      this.newProductDevelopedAm,
      this.electricPower,
      this.waterSupply,
      this.telecom,
      this.marketingDepartment,
      this.activeDatabase,
      this.wasteTrtmntSystem,
      this.wasteTrtmntSystemAm,
      this.efluentTreatmentPlant,
      this.envMgmtPlan,
      this.gasCarbEmision,
      this.gasCarbEmisionAm,
      this.compoundAllot,
      this.comunityCompliant,
      this.comunityCompliantAm,
      this.envFocalPerson,
      this.safetyProfesional,
      this.notificationProcedure,
      this.universityLinkage,
      this.universityLinkageAm,
      this.recallSystem,
      this.qualityDefectsAm,
      this.qualityDefects,
      this.gasWasteMgmntMeasure,
      this.gasWasteMgmntMeasureAm,
      this.createdDate,
      this.lastUpdatedDate,
      this.expired,
      this.ownershipForm,
      this.contactPerson,
      this.workingHours,
      this.sourceOfEnergy,
      this.supportRequired,
      this.companyCondition,
      this.lastUpdatedBy,
      this.category,
      this.certification,
      this.managementTools,
      this.detail,
      this.detailAm,
      this.logo,
      this.establishedYear,
      this.companyCertificates});

  Company.fromMap(Map<dynamic, dynamic> map) {
    id = map["id"].toString();
    createdBy = map["created_by"].toString();
    companyAddress = map["company_address"];
    mainCategory = map["main_category"].toString();
    name = map["name"].toString();
    nameAm = map["name_am"].toString();
    logo = map["logo"].toString();
    geoLocation = map["geo_location"].toString();
    detail = map["detail"].toString();
    detailAm = map["detail_am"].toString();
    expansionPlan = map["expansion_plan"].toString();
    expansionPlanAm = map["expansion_plan_am"].toString();
    tradeLicense = map["trade_license"].toString();
    orgnStrct = map["orgn_strct"].toString();
    labTestAnalysis = map["lab_test_analysis"].toString();
    labTestAnalysisAm = map["lab_test_analysis_am"].toString();
    labEquipment = map["lab_equipment"].toString();
    labEquipmentAm = map["lab_equipment_am"].toString();
    outsourcedTestParam = map["outsourced_test_param"].toString();
    outsourcedTestParamAm = map["outsourced_test_param_am"].toString();
    conductedResearch = map["conducted_research"].toString();
    conductedResearchAm = map["conducted_research_am"].toString();
    newProductDeveloped = map["new_product_developed"].toString();
    newProductDevelopedAm = map["new_product_developed_am"].toString();
    electricPower = map["electric_power"];
    waterSupply = map["water_supply"];
    telecom = map["telecom"];
    marketingDepartment = map["marketing_department"];
    activeDatabase = map["active_database"];
    wasteTrtmntSystem = map["waste_trtmnt_system"].toString();
    wasteTrtmntSystemAm = map["waste_trtmnt_system_am"].toString();
    efluentTreatmentPlant = map["efluent_treatment_plant"];
    envMgmtPlan = map["env_mgmt_plan"].toString();
    gasCarbEmision = map["gas_carb_emision"].toString();
    gasCarbEmisionAm = map["gas_carb_emision_am"].toString();
    compoundAllot = map["compound_allot"].toString();
    comunityCompliant = map["comunity_compliant"].toString();
    comunityCompliantAm = map["comunity_compliant_am"].toString();
    envFocalPerson = map["env_focal_person"];
    safetyProfesional = map["safety_profesional"];
    notificationProcedure = map["notification_procedure"];
    universityLinkage = map["university_linkage"].toString();
    universityLinkageAm = map["university_linkage_am"].toString();
    recallSystem = map["recall_system"];
    qualityDefectsAm = map["quality_defects_am"].toString();
    qualityDefects = map["quality_defects"].toString();
    gasWasteMgmntMeasure = map["gas_waste_mgmnt_measure"].toString();
    gasWasteMgmntMeasureAm = map["gas_waste_mgmnt_measure_am"].toString();
    createdDate = map["created_date"].toString();
    lastUpdatedDate = map["last_updated_date"].toString();
    expired = map["expired"];
    ownershipForm = map["ownership_form"].toString();
    contactPerson = map["contact_person"].toString();
    workingHours = map["working_hours"].toString();
    sourceOfEnergy = map["source_of_energy"].toString();
    supportRequired = map["support_required"].toString();
    companyCondition = map["company_condition"].toString();
    lastUpdatedBy = map["last_updated_by"].toString();
    category = map["category"];
    certification = map["certification"];
    managementTools = map["management_tools"];
    establishedYear = map["established_yr"].toString();
    companyCertificates = map['company_certificates'];
  }
}
