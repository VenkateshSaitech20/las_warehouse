// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  String? version;
  String? tmsVersion;
  String? wbsVersion;
  String? termsTxt;
  String? noInvoices;
  String? noBookings;
  String? noActiveBids;
  String? noRecords;
  String? noCompletedOrders;
  String? noWorkOrders;
  String? noPending;
  String? noRequirements;
  String? noProducts;
  String? noWarehouses;
  String? noVehicles;
  String? noDrivers;
  String? noOpCity;
  String? noMtType;
  String? noHub;
  String? whList;
  String? sequenceReq;
  String? seqExists;
  String? displayInReq;
  String? recordDeleted;
  String? loginSuccess;
  String? loginUpdated;
  String? colorIconReq;
  String? notApproved;
  String? approved;
  String? alphaV;
  String? alpha;
  String? alphaSeq;
  String? errorDelFile;
  String? succDelFile;
  String? commonError;
  String? nonePosted;
  String? oneOption;
  String? invalidCurPwd;
  String? pwdNotEmpty;
  String? pwdNotMatch;
  String? pwdUpdate;
  String? allFieldsReq;
  String? noFileUpl;
  String? noToken;
  String? tokenNotValid;
  String? recordAdded;
  String? recordUpdated;
  String? notAssigned;
  String? whLogo;
  String? leaseRentReq;
  String? fireSafeReq;
  String? buildingPlanReq;
  String? envClearanceReq;
  String? insDocReq;
  String? shopLicDocReq;
  String? labLiDocReq;
  String? yardPhtsReq;
  String? gatePhtsReq;
  String? dockingAreaReq;
  String? wahEquPhtsReq;
  String? workDaysReq;
  String? emailExists;
  String? approvalWaiting;
  String? noUser;
  String? invalidLogin;
  String? gstExists;
  String? panExists;
  String? aadharExists;
  String? dupliExists;
  String? productNotFound;
  String? reqrmentDelete;
  String? reqrmentExists;
  String? productDelete;
  String? productUpdate;
  String? productAdd;
  String? customerNotFound;
  String? customerUpdate;
  String? customerAdd;
  String? vrequirementAdd;
  String? requirementAdd;
  String? requirementNotFound;
  String? negoEntry;
  String? bidExists;
  String? vendorBid;
  String? invalidBidId;
  String? bidNotFound;
  String? podUpd;
  String? invoiceUpd;
  String? statusUpdate;
  String? statusNotUpdated;
  String? tripCompleted;
  String? bidCancelled;
  String? paymentDone;
  String? ratingAdded;
  String? bidAccepted;
  String? acceptedCompletion;
  String? invoiceDone;
  String? chkOutCompleted;
  String? priceConfirmed;
  String? bidNotInterest;
  String? bidNotInterestAlready;
  String? warehouseNotFound;
  String? warehouseDelete;
  String? warehouseAdd;
  String? mateAdd;
  String? mateDelete;
  String? mateUpdate;
  String? mateNotFound;
  String? tcAdd;
  String? tcUpdate;
  String? hubNotFound;
  String? hubAdd;
  String? hubDelete;
  String? cityExists;
  String? cityAdd;
  String? cityDelete;
  String? cityNotFound;
  String? vendorNotFound;
  String? vendorUpdate;
  String? vendorAdd;
  String? userAdd;
  String? userUpdate;
  String? userDelete;
  String? vehNoReq;
  String? permitTReq;
  String? permitDocReq;
  String? validityReq;
  String? trackAvilReq;
  String? vehicleExists;
  String? vehicleAdd;
  String? vehicleNotFound;
  String? vehicleDelete;
  String? driverDelete;
  String? driverNotFound;
  String? driverNameReq;
  String? licenseNoInvalid;
  String? licenseNoReq;
  String? licenseDateReq;
  String? validTillDateReq;
  String? driverImgReq;
  String? consentFormReq;
  String? driverDobReq;
  String? driverTReq;
  String? driverExists;
  String? driverAdd;
  String? assignedSucc;
  String? amenityReq;
  String? licenseReq;
  String? fuelReq;
  String? materialTReq;
  String? consignmentReq;
  String? loadingTReq;
  String? specialRqsReq;
  String? commonReq;
  String? statusReq;
  String? uomReq;
  String? bookingTReq;
  String? vehLtReq;
  String? vehCateReq;
  String? vehPermitReq;
  String? vehTReq;
  String? drivTReq;
  String? vehTfReq;
  String? timingReq;
  String? packTypReq;
  String? logTypReq;
  String? goodsHandleReq;
  String? iconReq;
  String? serviceTReq;
  String? serviceIReq;
  String? stateReq;
  String? cityReq;
  String? warehouseTReq;
  String? emailReq;
  String? validEmail;
  String? passwordReq;
  String? cpasswordReq;
  String? passwordLength;
  String? passwordUpperCase;
  String? passwordLowerCase;
  String? passwordDigit;
  String? passwordSpecialChar;
  String? gstReq;
  String? cinReq;
  String? cinLength;
  String? tanReq;
  String? tanLength;
  String? gstLength;
  String? gstFileReq;
  String? panReq;
  String? panLength;
  String? panFileReq;
  String? aadharReq;
  String? aadharLength;
  String? aadharFileReq;
  String? vendorReq;
  String? anameReq;
  String? nameReq;
  String? doeReq;
  String? minName;
  String? maxName;
  String? nameMatch;
  String? alphaNum;
  String? numMatch;
  String? phoneReq;
  String? phoneLength;
  String? address1Req;
  String? address2Req;
  String? pincodeReq;
  String? pincodeValid;
  String? countryReq;
  String? prdNameReq;
  String? minHsn;
  String? maxHsn;
  String? hsnReq;
  String? matTypeReq;
  String? weightReq;
  String? weightTReq;
  String? lengthReq;
  String? widthReq;
  String? heightReq;
  String? custDataReq;
  String? reqNoReq;
  String? fromDtReq;
  String? toDtReq;
  String? pickupDtReq;
  String? pickupCReq;
  String? pickupLReq;
  String? dropCReq;
  String? dropLReq;
  String? selectProduct;
  String? sqftReq;
  String? qtyReq;
  String? totalQReq;
  String? totalWReq;
  String? etaReq;
  String? chooseReq;
  String? descriptionReq;
  String? reqIdReq;
  String? senderIdReq;
  String? senderTypeReq;
  String? senderDataReq;
  String? messageReq;
  String? termsReq;
  String? hubNameReq;
  String? totalAreaReq;
  String? amenitiesReq;
  String? latitudeReq;
  String? longitudeReq;
  String? bidPriceReq;
  String? paymentTReq;
  String? paymentStReq;
  String? locationReq;
  String? builtUpReq;
  String? yearBReq;
  String? handlingChReq;
  String? storageChReq;
  String? totalLandReq;
  String? whTypeReq;
  String? whNameReq;
  String? shtNameReq;
  String? noBids;
  String? chkOutBid;
  String? delVehicle;
  String? delProduct;
  String? deldriver;
  String? delMaterialType;
  String? delOperatingCity;
  String? reqNotInterest;
  String? bidCancel;
  String? bidAccept;
  String? hubDeleteAsk;
  String? errorMsg;
  String? delUser;
  List<PrivilegeMenu>? tmsVendorMenus;
  List<PrivilegeMenu>? tmsCustomerMenus;
  List<PrivilegeMenu>? wbsVendorMenus;
  List<PrivilegeMenu>? wbsCustomerMenus;

  MessageModel({
    this.version,
    this.tmsVersion,
    this.wbsVersion,
    this.termsTxt,
    this.noInvoices,
    this.noBookings,
    this.noActiveBids,
    this.noRecords,
    this.noCompletedOrders,
    this.noWorkOrders,
    this.noPending,
    this.noRequirements,
    this.noProducts,
    this.noWarehouses,
    this.noVehicles,
    this.noDrivers,
    this.noOpCity,
    this.noMtType,
    this.noHub,
    this.whList,
    this.sequenceReq,
    this.seqExists,
    this.displayInReq,
    this.recordDeleted,
    this.loginSuccess,
    this.loginUpdated,
    this.colorIconReq,
    this.notApproved,
    this.approved,
    this.alphaV,
    this.alpha,
    this.alphaSeq,
    this.errorDelFile,
    this.succDelFile,
    this.commonError,
    this.nonePosted,
    this.oneOption,
    this.invalidCurPwd,
    this.pwdNotEmpty,
    this.pwdNotMatch,
    this.pwdUpdate,
    this.allFieldsReq,
    this.noFileUpl,
    this.noToken,
    this.tokenNotValid,
    this.recordAdded,
    this.recordUpdated,
    this.notAssigned,
    this.whLogo,
    this.leaseRentReq,
    this.fireSafeReq,
    this.buildingPlanReq,
    this.envClearanceReq,
    this.insDocReq,
    this.shopLicDocReq,
    this.labLiDocReq,
    this.yardPhtsReq,
    this.gatePhtsReq,
    this.dockingAreaReq,
    this.wahEquPhtsReq,
    this.workDaysReq,
    this.emailExists,
    this.approvalWaiting,
    this.noUser,
    this.invalidLogin,
    this.gstExists,
    this.panExists,
    this.aadharExists,
    this.dupliExists,
    this.productNotFound,
    this.reqrmentDelete,
    this.reqrmentExists,
    this.productDelete,
    this.productUpdate,
    this.productAdd,
    this.customerNotFound,
    this.customerUpdate,
    this.customerAdd,
    this.vrequirementAdd,
    this.requirementAdd,
    this.requirementNotFound,
    this.negoEntry,
    this.bidExists,
    this.vendorBid,
    this.invalidBidId,
    this.bidNotFound,
    this.podUpd,
    this.invoiceUpd,
    this.statusUpdate,
    this.statusNotUpdated,
    this.tripCompleted,
    this.bidCancelled,
    this.paymentDone,
    this.ratingAdded,
    this.bidAccepted,
    this.acceptedCompletion,
    this.invoiceDone,
    this.chkOutCompleted,
    this.priceConfirmed,
    this.bidNotInterest,
    this.bidNotInterestAlready,
    this.warehouseNotFound,
    this.warehouseDelete,
    this.warehouseAdd,
    this.mateAdd,
    this.mateDelete,
    this.mateUpdate,
    this.mateNotFound,
    this.tcAdd,
    this.tcUpdate,
    this.hubNotFound,
    this.hubAdd,
    this.hubDelete,
    this.cityExists,
    this.cityAdd,
    this.cityDelete,
    this.cityNotFound,
    this.vendorNotFound,
    this.vendorUpdate,
    this.vendorAdd,
    this.userAdd,
    this.userUpdate,
    this.userDelete,
    this.vehNoReq,
    this.permitTReq,
    this.permitDocReq,
    this.validityReq,
    this.trackAvilReq,
    this.vehicleExists,
    this.vehicleAdd,
    this.vehicleNotFound,
    this.vehicleDelete,
    this.driverDelete,
    this.driverNotFound,
    this.driverNameReq,
    this.licenseNoInvalid,
    this.licenseNoReq,
    this.licenseDateReq,
    this.validTillDateReq,
    this.driverImgReq,
    this.consentFormReq,
    this.driverDobReq,
    this.driverTReq,
    this.driverExists,
    this.driverAdd,
    this.assignedSucc,
    this.amenityReq,
    this.licenseReq,
    this.fuelReq,
    this.materialTReq,
    this.consignmentReq,
    this.loadingTReq,
    this.specialRqsReq,
    this.commonReq,
    this.statusReq,
    this.uomReq,
    this.bookingTReq,
    this.vehLtReq,
    this.vehCateReq,
    this.vehPermitReq,
    this.vehTReq,
    this.drivTReq,
    this.vehTfReq,
    this.timingReq,
    this.packTypReq,
    this.logTypReq,
    this.goodsHandleReq,
    this.iconReq,
    this.serviceTReq,
    this.serviceIReq,
    this.stateReq,
    this.cityReq,
    this.warehouseTReq,
    this.emailReq,
    this.validEmail,
    this.passwordReq,
    this.cpasswordReq,
    this.passwordLength,
    this.passwordUpperCase,
    this.passwordLowerCase,
    this.passwordDigit,
    this.passwordSpecialChar,
    this.gstReq,
    this.cinReq,
    this.cinLength,
    this.tanReq,
    this.tanLength,
    this.gstLength,
    this.gstFileReq,
    this.panReq,
    this.panLength,
    this.panFileReq,
    this.aadharReq,
    this.aadharLength,
    this.aadharFileReq,
    this.vendorReq,
    this.anameReq,
    this.nameReq,
    this.doeReq,
    this.minName,
    this.maxName,
    this.nameMatch,
    this.alphaNum,
    this.numMatch,
    this.phoneReq,
    this.phoneLength,
    this.address1Req,
    this.address2Req,
    this.pincodeReq,
    this.pincodeValid,
    this.countryReq,
    this.prdNameReq,
    this.minHsn,
    this.maxHsn,
    this.hsnReq,
    this.matTypeReq,
    this.weightReq,
    this.weightTReq,
    this.lengthReq,
    this.widthReq,
    this.heightReq,
    this.custDataReq,
    this.reqNoReq,
    this.fromDtReq,
    this.toDtReq,
    this.pickupDtReq,
    this.pickupCReq,
    this.pickupLReq,
    this.dropCReq,
    this.dropLReq,
    this.selectProduct,
    this.sqftReq,
    this.qtyReq,
    this.totalQReq,
    this.totalWReq,
    this.etaReq,
    this.chooseReq,
    this.descriptionReq,
    this.reqIdReq,
    this.senderIdReq,
    this.senderTypeReq,
    this.senderDataReq,
    this.messageReq,
    this.termsReq,
    this.hubNameReq,
    this.totalAreaReq,
    this.amenitiesReq,
    this.latitudeReq,
    this.longitudeReq,
    this.bidPriceReq,
    this.paymentTReq,
    this.paymentStReq,
    this.locationReq,
    this.builtUpReq,
    this.yearBReq,
    this.handlingChReq,
    this.storageChReq,
    this.totalLandReq,
    this.whTypeReq,
    this.whNameReq,
    this.shtNameReq,
    this.noBids,
    this.chkOutBid,
    this.delVehicle,
    this.delProduct,
    this.deldriver,
    this.delMaterialType,
    this.delOperatingCity,
    this.reqNotInterest,
    this.bidCancel,
    this.bidAccept,
    this.hubDeleteAsk,
    this.errorMsg,
    this.delUser,
    this.tmsVendorMenus,
    this.tmsCustomerMenus,
    this.wbsVendorMenus,
    this.wbsCustomerMenus,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        version: json["version"],
        tmsVersion: json["tmsVersion"],
        wbsVersion: json["wbsVersion"],
        termsTxt: json["termsTxt"],
        noInvoices: json["noInvoices"],
        noBookings: json["noBookings"],
        noActiveBids: json["noActiveBids"],
        noRecords: json["noRecords"],
        noCompletedOrders: json["noCompletedOrders"],
        noWorkOrders: json["noWorkOrders"],
        noPending: json["noPending"],
        noRequirements: json["noRequirements"],
        noProducts: json["noProducts"],
        noWarehouses: json["noWarehouses"],
        noVehicles: json["noVehicles"],
        noDrivers: json["noDrivers"],
        noOpCity: json["noOpCity"],
        noMtType: json["noMtType"],
        noHub: json["noHub"],
        whList: json["whList"],
        sequenceReq: json["sequenceReq"],
        seqExists: json["seqExists"],
        displayInReq: json["displayInReq"],
        recordDeleted: json["recordDeleted"],
        loginSuccess: json["LoginSuccess"],
        loginUpdated: json["LoginUpdated"],
        colorIconReq: json["colorIconReq"],
        notApproved: json["notApproved"],
        approved: json["Approved"],
        alphaV: json["alphaV"],
        alpha: json["alpha"],
        alphaSeq: json["alphaSeq"],
        errorDelFile: json["errorDelFile"],
        succDelFile: json["succDelFile"],
        commonError: json["commonError"],
        nonePosted: json["nonePosted"],
        oneOption: json["oneOption"],
        invalidCurPwd: json["invalidCurPwd"],
        pwdNotEmpty: json["pwdNotEmpty"],
        pwdNotMatch: json["pwdNotMatch"],
        pwdUpdate: json["pwdUpdate"],
        allFieldsReq: json["allFieldsReq"],
        noFileUpl: json["noFileUpl"],
        noToken: json["noToken"],
        tokenNotValid: json["tokenNotValid"],
        recordAdded: json["recordAdded"],
        recordUpdated: json["recordUpdated"],
        notAssigned: json["notAssigned"],
        whLogo: json["whLogo"],
        leaseRentReq: json["leaseRentReq"],
        fireSafeReq: json["fireSafeReq"],
        buildingPlanReq: json["buildingPlanReq"],
        envClearanceReq: json["envClearanceReq"],
        insDocReq: json["insDocReq"],
        shopLicDocReq: json["shopLicDocReq"],
        labLiDocReq: json["labLiDocReq"],
        yardPhtsReq: json["yardPhtsReq"],
        gatePhtsReq: json["gatePhtsReq"],
        dockingAreaReq: json["dockingAreaReq"],
        wahEquPhtsReq: json["wahEquPhtsReq"],
        workDaysReq: json["workDaysReq"],
        emailExists: json["emailExists"],
        approvalWaiting: json["approvalWaiting"],
        noUser: json["noUser"],
        invalidLogin: json["invalidLogin"],
        gstExists: json["gstExists"],
        panExists: json["panExists"],
        aadharExists: json["aadharExists"],
        dupliExists: json["dupliExists"],
        productNotFound: json["productNotFound"],
        reqrmentDelete: json["reqrmentDelete"],
        reqrmentExists: json["reqrmentExists"],
        productDelete: json["productDelete"],
        productUpdate: json["productUpdate"],
        productAdd: json["productAdd"],
        customerNotFound: json["customerNotFound"],
        customerUpdate: json["customerUpdate"],
        customerAdd: json["customerAdd"],
        vrequirementAdd: json["vrequirementAdd"],
        requirementAdd: json["requirementAdd"],
        requirementNotFound: json["requirementNotFound"],
        negoEntry: json["negoEntry"],
        bidExists: json["bidExists"],
        vendorBid: json["vendorBid"],
        invalidBidId: json["invalidBidId"],
        bidNotFound: json["bidNotFound"],
        podUpd: json["podUpd"],
        invoiceUpd: json["invoiceUpd"],
        statusUpdate: json["statusUpdate"],
        statusNotUpdated: json["statusNotUpdated"],
        tripCompleted: json["tripCompleted"],
        bidCancelled: json["bidCancelled"],
        paymentDone: json["paymentDone"],
        ratingAdded: json["ratingAdded"],
        bidAccepted: json["bidAccepted"],
        acceptedCompletion: json["acceptedCompletion"],
        invoiceDone: json["invoiceDone"],
        chkOutCompleted: json["chkOutCompleted"],
        priceConfirmed: json["priceConfirmed"],
        bidNotInterest: json["bidNotInterest"],
        bidNotInterestAlready: json["bidNotInterestAlready"],
        warehouseNotFound: json["warehouseNotFound"],
        warehouseDelete: json["warehouseDelete"],
        warehouseAdd: json["warehouseAdd"],
        mateAdd: json["mateAdd"],
        mateDelete: json["mateDelete"],
        mateUpdate: json["mateUpdate"],
        mateNotFound: json["mateNotFound"],
        tcAdd: json["tcAdd"],
        tcUpdate: json["tcUpdate"],
        hubNotFound: json["hubNotFound"],
        hubAdd: json["hubAdd"],
        hubDelete: json["hubDelete"],
        cityExists: json["cityExists"],
        cityAdd: json["cityAdd"],
        cityDelete: json["cityDelete"],
        cityNotFound: json["cityNotFound"],
        vendorNotFound: json["vendorNotFound"],
        vendorUpdate: json["vendorUpdate"],
        vendorAdd: json["vendorAdd"],
        userAdd: json["userAdd"],
        userUpdate: json["userUpdate"],
        userDelete: json["userDelete"],
        vehNoReq: json["vehNoReq"],
        permitTReq: json["permitTReq"],
        permitDocReq: json["permitDocReq"],
        validityReq: json["validityReq"],
        trackAvilReq: json["trackAvilReq"],
        vehicleExists: json["vehicleExists"],
        vehicleAdd: json["vehicleAdd"],
        vehicleNotFound: json["vehicleNotFound"],
        vehicleDelete: json["vehicleDelete"],
        driverDelete: json["driverDelete"],
        driverNotFound: json["driverNotFound"],
        driverNameReq: json["driverNameReq"],
        licenseNoInvalid: json["licenseNoInvalid"],
        licenseNoReq: json["licenseNoReq"],
        licenseDateReq: json["licenseDateReq"],
        validTillDateReq: json["validTillDateReq"],
        driverImgReq: json["driverImgReq"],
        consentFormReq: json["consentFormReq"],
        driverDobReq: json["driverDobReq"],
        driverTReq: json["driverTReq"],
        driverExists: json["driverExists"],
        driverAdd: json["driverAdd"],
        assignedSucc: json["assignedSucc"],
        amenityReq: json["amenityReq"],
        licenseReq: json["licenseReq"],
        fuelReq: json["fuelReq"],
        materialTReq: json["materialTReq"],
        consignmentReq: json["consignmentReq"],
        loadingTReq: json["loadingTReq"],
        specialRqsReq: json["specialRqsReq"],
        commonReq: json["commonReq"],
        statusReq: json["statusReq"],
        uomReq: json["uomReq"],
        bookingTReq: json["bookingTReq"],
        vehLtReq: json["vehLTReq"],
        vehCateReq: json["vehCateReq"],
        vehPermitReq: json["vehPermitReq"],
        vehTReq: json["vehTReq"],
        drivTReq: json["drivTReq"],
        vehTfReq: json["vehTFReq"],
        timingReq: json["timingReq"],
        packTypReq: json["packTypReq"],
        logTypReq: json["logTypReq"],
        goodsHandleReq: json["goodsHandleReq"],
        iconReq: json["iconReq"],
        serviceTReq: json["serviceTReq"],
        serviceIReq: json["serviceIReq"],
        stateReq: json["stateReq"],
        cityReq: json["cityReq"],
        warehouseTReq: json["warehouseTReq"],
        emailReq: json["emailReq"],
        validEmail: json["validEmail"],
        passwordReq: json["passwordReq"],
        cpasswordReq: json["cpasswordReq"],
        passwordLength: json["passwordLength"],
        passwordUpperCase: json["passwordUpperCase"],
        passwordLowerCase: json["passwordLowerCase"],
        passwordDigit: json["passwordDigit"],
        passwordSpecialChar: json["passwordSpecialChar"],
        gstReq: json["gstReq"],
        cinReq: json["cinReq"],
        cinLength: json["cinLength"],
        tanReq: json["tanReq"],
        tanLength: json["tanLength"],
        gstLength: json["gstLength"],
        gstFileReq: json["gstFileReq"],
        panReq: json["panReq"],
        panLength: json["panLength"],
        panFileReq: json["panFileReq"],
        aadharReq: json["aadharReq"],
        aadharLength: json["aadharLength"],
        aadharFileReq: json["aadharFileReq"],
        vendorReq: json["vendorReq"],
        anameReq: json["anameReq"],
        nameReq: json["nameReq"],
        doeReq: json["doeReq"],
        minName: json["minName"],
        maxName: json["maxName"],
        nameMatch: json["nameMatch"],
        alphaNum: json["alphaNum"],
        numMatch: json["numMatch"],
        phoneReq: json["phoneReq"],
        phoneLength: json["phoneLength"],
        address1Req: json["address1Req"],
        address2Req: json["address2Req"],
        pincodeReq: json["pincodeReq"],
        pincodeValid: json["pincodeValid"],
        countryReq: json["countryReq"],
        prdNameReq: json["prdNameReq"],
        minHsn: json["minHsn"],
        maxHsn: json["maxHsn"],
        hsnReq: json["hsnReq"],
        matTypeReq: json["matTypeReq"],
        weightReq: json["weightReq"],
        weightTReq: json["weightTReq"],
        lengthReq: json["lengthReq"],
        widthReq: json["widthReq"],
        heightReq: json["heightReq"],
        custDataReq: json["custDataReq"],
        reqNoReq: json["reqNoReq"],
        fromDtReq: json["fromDTReq"],
        toDtReq: json["toDTReq"],
        pickupDtReq: json["pickupDTReq"],
        pickupCReq: json["pickupCReq"],
        pickupLReq: json["pickupLReq"],
        dropCReq: json["dropCReq"],
        dropLReq: json["dropLReq"],
        selectProduct: json["selectProduct"],
        sqftReq: json["sqftReq"],
        qtyReq: json["qtyReq"],
        totalQReq: json["totalQReq"],
        totalWReq: json["totalWReq"],
        etaReq: json["etaReq"],
        chooseReq: json["chooseReq"],
        descriptionReq: json["descriptionReq"],
        reqIdReq: json["reqIdReq"],
        senderIdReq: json["senderIdReq"],
        senderTypeReq: json["senderTypeReq"],
        senderDataReq: json["senderDataReq"],
        messageReq: json["messageReq"],
        termsReq: json["termsReq"],
        hubNameReq: json["hubNameReq"],
        totalAreaReq: json["totalAreaReq"],
        amenitiesReq: json["amenitiesReq"],
        latitudeReq: json["latitudeReq"],
        longitudeReq: json["longitudeReq"],
        bidPriceReq: json["bidPriceReq"],
        paymentTReq: json["paymentTReq"],
        paymentStReq: json["paymentStReq"],
        locationReq: json["locationReq"],
        builtUpReq: json["builtUpReq"],
        yearBReq: json["yearBReq"],
        handlingChReq: json["handlingChReq"],
        storageChReq: json["storageChReq"],
        totalLandReq: json["totalLandReq"],
        whTypeReq: json["whTypeReq"],
        whNameReq: json["whNameReq"],
        shtNameReq: json["shtNameReq"],
        noBids: json["noBids"],
        chkOutBid: json["chkOutBid"],
        delVehicle: json["delVehicle"],
        delProduct: json["delProduct"],
        deldriver: json["deldriver"],
        delMaterialType: json["delMaterialType"],
        delOperatingCity: json["delOperatingCity"],
        reqNotInterest: json["reqNotInterest"],
        bidCancel: json["bidCancel"],
        bidAccept: json["bidAccept"],
        hubDeleteAsk: json["hubDeleteAsk"],
        errorMsg: json["errorMsg"],
        delUser: json["delUser"],
        tmsVendorMenus: json["tmsVendorMenus"] == null
            ? []
            : List<PrivilegeMenu>.from(
                json["tmsVendorMenus"]!.map((x) => PrivilegeMenu.fromJson(x)),
              ),
        tmsCustomerMenus: json["tmsCustomerMenus"] == null
            ? []
            : List<PrivilegeMenu>.from(
                json["tmsCustomerMenus"]!.map((x) => PrivilegeMenu.fromJson(x)),
              ),
        wbsVendorMenus: json["wbsVendorMenus"] == null
            ? []
            : List<PrivilegeMenu>.from(
                json["wbsVendorMenus"]!.map((x) => PrivilegeMenu.fromJson(x)),
              ),
        wbsCustomerMenus: json["wbsCustomerMenus"] == null
            ? []
            : List<PrivilegeMenu>.from(
                json["wbsCustomerMenus"]!.map((x) => PrivilegeMenu.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "tmsVersion": tmsVersion,
        "wbsVersion": wbsVersion,
        "termsTxt": termsTxt,
        "noInvoices": noInvoices,
        "noBookings": noBookings,
        "noActiveBids": noActiveBids,
        "noRecords": noRecords,
        "noCompletedOrders": noCompletedOrders,
        "noWorkOrders": noWorkOrders,
        "noPending": noPending,
        "noRequirements": noRequirements,
        "noProducts": noProducts,
        "noWarehouses": noWarehouses,
        "noVehicles": noVehicles,
        "noDrivers": noDrivers,
        "noOpCity": noOpCity,
        "noMtType": noMtType,
        "noHub": noHub,
        "whList": whList,
        "sequenceReq": sequenceReq,
        "seqExists": seqExists,
        "displayInReq": displayInReq,
        "recordDeleted": recordDeleted,
        "LoginSuccess": loginSuccess,
        "LoginUpdated": loginUpdated,
        "colorIconReq": colorIconReq,
        "notApproved": notApproved,
        "Approved": approved,
        "alphaV": alphaV,
        "alpha": alpha,
        "alphaSeq": alphaSeq,
        "errorDelFile": errorDelFile,
        "succDelFile": succDelFile,
        "commonError": commonError,
        "nonePosted": nonePosted,
        "oneOption": oneOption,
        "invalidCurPwd": invalidCurPwd,
        "pwdNotEmpty": pwdNotEmpty,
        "pwdNotMatch": pwdNotMatch,
        "pwdUpdate": pwdUpdate,
        "allFieldsReq": allFieldsReq,
        "noFileUpl": noFileUpl,
        "noToken": noToken,
        "tokenNotValid": tokenNotValid,
        "recordAdded": recordAdded,
        "recordUpdated": recordUpdated,
        "notAssigned": notAssigned,
        "whLogo": whLogo,
        "leaseRentReq": leaseRentReq,
        "fireSafeReq": fireSafeReq,
        "buildingPlanReq": buildingPlanReq,
        "envClearanceReq": envClearanceReq,
        "insDocReq": insDocReq,
        "shopLicDocReq": shopLicDocReq,
        "labLiDocReq": labLiDocReq,
        "yardPhtsReq": yardPhtsReq,
        "gatePhtsReq": gatePhtsReq,
        "dockingAreaReq": dockingAreaReq,
        "wahEquPhtsReq": wahEquPhtsReq,
        "workDaysReq": workDaysReq,
        "emailExists": emailExists,
        "approvalWaiting": approvalWaiting,
        "noUser": noUser,
        "invalidLogin": invalidLogin,
        "gstExists": gstExists,
        "panExists": panExists,
        "aadharExists": aadharExists,
        "dupliExists": dupliExists,
        "productNotFound": productNotFound,
        "reqrmentDelete": reqrmentDelete,
        "reqrmentExists": reqrmentExists,
        "productDelete": productDelete,
        "productUpdate": productUpdate,
        "productAdd": productAdd,
        "customerNotFound": customerNotFound,
        "customerUpdate": customerUpdate,
        "customerAdd": customerAdd,
        "vrequirementAdd": vrequirementAdd,
        "requirementAdd": requirementAdd,
        "requirementNotFound": requirementNotFound,
        "negoEntry": negoEntry,
        "bidExists": bidExists,
        "vendorBid": vendorBid,
        "invalidBidId": invalidBidId,
        "bidNotFound": bidNotFound,
        "podUpd": podUpd,
        "invoiceUpd": invoiceUpd,
        "statusUpdate": statusUpdate,
        "statusNotUpdated": statusNotUpdated,
        "tripCompleted": tripCompleted,
        "bidCancelled": bidCancelled,
        "paymentDone": paymentDone,
        "ratingAdded": ratingAdded,
        "bidAccepted": bidAccepted,
        "acceptedCompletion": acceptedCompletion,
        "invoiceDone": invoiceDone,
        "chkOutCompleted": chkOutCompleted,
        "priceConfirmed": priceConfirmed,
        "bidNotInterest": bidNotInterest,
        "bidNotInterestAlready": bidNotInterestAlready,
        "warehouseNotFound": warehouseNotFound,
        "warehouseDelete": warehouseDelete,
        "warehouseAdd": warehouseAdd,
        "mateAdd": mateAdd,
        "mateDelete": mateDelete,
        "mateUpdate": mateUpdate,
        "mateNotFound": mateNotFound,
        "tcAdd": tcAdd,
        "tcUpdate": tcUpdate,
        "hubNotFound": hubNotFound,
        "hubAdd": hubAdd,
        "hubDelete": hubDelete,
        "cityExists": cityExists,
        "cityAdd": cityAdd,
        "cityDelete": cityDelete,
        "cityNotFound": cityNotFound,
        "vendorNotFound": vendorNotFound,
        "vendorUpdate": vendorUpdate,
        "vendorAdd": vendorAdd,
        "userAdd": userAdd,
        "userUpdate": userUpdate,
        "userDelete": userDelete,
        "vehNoReq": vehNoReq,
        "permitTReq": permitTReq,
        "permitDocReq": permitDocReq,
        "validityReq": validityReq,
        "trackAvilReq": trackAvilReq,
        "vehicleExists": vehicleExists,
        "vehicleAdd": vehicleAdd,
        "vehicleNotFound": vehicleNotFound,
        "vehicleDelete": vehicleDelete,
        "driverDelete": driverDelete,
        "driverNotFound": driverNotFound,
        "driverNameReq": driverNameReq,
        "licenseNoInvalid": licenseNoInvalid,
        "licenseNoReq": licenseNoReq,
        "licenseDateReq": licenseDateReq,
        "validTillDateReq": validTillDateReq,
        "driverImgReq": driverImgReq,
        "consentFormReq": consentFormReq,
        "driverDobReq": driverDobReq,
        "driverTReq": driverTReq,
        "driverExists": driverExists,
        "driverAdd": driverAdd,
        "assignedSucc": assignedSucc,
        "amenityReq": amenityReq,
        "licenseReq": licenseReq,
        "fuelReq": fuelReq,
        "materialTReq": materialTReq,
        "consignmentReq": consignmentReq,
        "loadingTReq": loadingTReq,
        "specialRqsReq": specialRqsReq,
        "commonReq": commonReq,
        "statusReq": statusReq,
        "uomReq": uomReq,
        "bookingTReq": bookingTReq,
        "vehLTReq": vehLtReq,
        "vehCateReq": vehCateReq,
        "vehPermitReq": vehPermitReq,
        "vehTReq": vehTReq,
        "drivTReq": drivTReq,
        "vehTFReq": vehTfReq,
        "timingReq": timingReq,
        "packTypReq": packTypReq,
        "logTypReq": logTypReq,
        "goodsHandleReq": goodsHandleReq,
        "iconReq": iconReq,
        "serviceTReq": serviceTReq,
        "serviceIReq": serviceIReq,
        "stateReq": stateReq,
        "cityReq": cityReq,
        "warehouseTReq": warehouseTReq,
        "emailReq": emailReq,
        "validEmail": validEmail,
        "passwordReq": passwordReq,
        "cpasswordReq": cpasswordReq,
        "passwordLength": passwordLength,
        "passwordUpperCase": passwordUpperCase,
        "passwordLowerCase": passwordLowerCase,
        "passwordDigit": passwordDigit,
        "passwordSpecialChar": passwordSpecialChar,
        "gstReq": gstReq,
        "cinReq": cinReq,
        "cinLength": cinLength,
        "tanReq": tanReq,
        "tanLength": tanLength,
        "gstLength": gstLength,
        "gstFileReq": gstFileReq,
        "panReq": panReq,
        "panLength": panLength,
        "panFileReq": panFileReq,
        "aadharReq": aadharReq,
        "aadharLength": aadharLength,
        "aadharFileReq": aadharFileReq,
        "vendorReq": vendorReq,
        "anameReq": anameReq,
        "nameReq": nameReq,
        "doeReq": doeReq,
        "minName": minName,
        "maxName": maxName,
        "nameMatch": nameMatch,
        "alphaNum": alphaNum,
        "numMatch": numMatch,
        "phoneReq": phoneReq,
        "phoneLength": phoneLength,
        "address1Req": address1Req,
        "address2Req": address2Req,
        "pincodeReq": pincodeReq,
        "pincodeValid": pincodeValid,
        "countryReq": countryReq,
        "prdNameReq": prdNameReq,
        "minHsn": minHsn,
        "maxHsn": maxHsn,
        "hsnReq": hsnReq,
        "matTypeReq": matTypeReq,
        "weightReq": weightReq,
        "weightTReq": weightTReq,
        "lengthReq": lengthReq,
        "widthReq": widthReq,
        "heightReq": heightReq,
        "custDataReq": custDataReq,
        "reqNoReq": reqNoReq,
        "fromDTReq": fromDtReq,
        "toDTReq": toDtReq,
        "pickupDTReq": pickupDtReq,
        "pickupCReq": pickupCReq,
        "pickupLReq": pickupLReq,
        "dropCReq": dropCReq,
        "dropLReq": dropLReq,
        "selectProduct": selectProduct,
        "sqftReq": sqftReq,
        "qtyReq": qtyReq,
        "totalQReq": totalQReq,
        "totalWReq": totalWReq,
        "etaReq": etaReq,
        "chooseReq": chooseReq,
        "descriptionReq": descriptionReq,
        "reqIdReq": reqIdReq,
        "senderIdReq": senderIdReq,
        "senderTypeReq": senderTypeReq,
        "senderDataReq": senderDataReq,
        "messageReq": messageReq,
        "termsReq": termsReq,
        "hubNameReq": hubNameReq,
        "totalAreaReq": totalAreaReq,
        "amenitiesReq": amenitiesReq,
        "latitudeReq": latitudeReq,
        "longitudeReq": longitudeReq,
        "bidPriceReq": bidPriceReq,
        "paymentTReq": paymentTReq,
        "paymentStReq": paymentStReq,
        "locationReq": locationReq,
        "builtUpReq": builtUpReq,
        "yearBReq": yearBReq,
        "handlingChReq": handlingChReq,
        "storageChReq": storageChReq,
        "totalLandReq": totalLandReq,
        "whTypeReq": whTypeReq,
        "whNameReq": whNameReq,
        "shtNameReq": shtNameReq,
        "noBids": noBids,
        "chkOutBid": chkOutBid,
        "delVehicle": delVehicle,
        "delProduct": delProduct,
        "deldriver": deldriver,
        "delMaterialType": delMaterialType,
        "delOperatingCity": delOperatingCity,
        "reqNotInterest": reqNotInterest,
        "bidCancel": bidCancel,
        "bidAccept": bidAccept,
        "hubDeleteAsk": hubDeleteAsk,
        "errorMsg": errorMsg,
        "delUser": delUser,
        "tmsVendorMenus": tmsVendorMenus == null
            ? []
            : List<dynamic>.from(tmsVendorMenus!.map((x) => x.toJson())),
        "tmsCustomerMenus": tmsCustomerMenus == null
            ? []
            : List<dynamic>.from(tmsCustomerMenus!.map((x) => x.toJson())),
        "wbsVendorMenus": wbsVendorMenus == null
            ? []
            : List<dynamic>.from(wbsVendorMenus!.map((x) => x.toJson())),
        "wbsCustomerMenus": wbsCustomerMenus == null
            ? []
            : List<dynamic>.from(wbsCustomerMenus!.map((x) => x.toJson())),
      };
}

class PrivilegeMenu {
  String? name;
  String? alias;

  PrivilegeMenu({
    this.name,
    this.alias,
  });

  factory PrivilegeMenu.fromJson(Map<String, dynamic> json) => PrivilegeMenu(
        name: json["name"],
        alias: json["alias"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alias": alias,
      };
}
