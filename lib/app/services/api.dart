class API {
  // static const baseUrl = "http://43.205.69.203/api/"; // live
  // static const baseUrl = "http://13.232.106.186/api/"; // live
  static const baseUrl = "http://13.232.106.186/microservice-api/"; // live

  static const userCredentialBaseUrl =
      "${baseUrl}tmswbs-login-signup-ms-4000/"; //
  static const masterBaseUrl = "${baseUrl}super-admin-4004/"; //
  static const dashboardBaseUrl = "${baseUrl}tmswbs-dashboard-ms-4001/"; //
  static const masterNprofileBaseUrl =
      "${baseUrl}tmswbs-master-profile-ms-4002/"; //
  static const orderManagementBaseUrl =
      "${baseUrl}tmswbs-order-management-ms-4006/"; //
  static const reportsBaseUrl = "${baseUrl}tmswbs-reports-ms-4007/"; //

  static const apiKey =
      "Z1ZpakFRcmFhNS9KUmREMUZWTHRtYzVpbUJnNExrMmsvUXIrK1dLZS9QdENzTVZ5bEFXMlJoTjg5V0xIdFBtUg==";

// User Registration

  static const register = "${userCredentialBaseUrl}wbs-vendor/vendor-register";
  static const userLogin =
      "${userCredentialBaseUrl}wbs-vendor/wbs-vendor-login";

  // User Profile

  static const changePassword =
      "${masterNprofileBaseUrl}wbs-vendor/change-password";
  static const viewProfile = "${masterNprofileBaseUrl}wbs-vendor/profile-data";
  static const updateProfile =
      "${masterNprofileBaseUrl}wbs-vendor/update-vendor";

//Dashboard

  static const dashboard = "${dashboardBaseUrl}wbs-vendor/get-dashboard-data";

  // Requirements

  static const wbsCustomerRequirements =
      "${orderManagementBaseUrl}wbs-vendor/wbs-customer-requirements";
  static const getWbsRequirements =
      "${orderManagementBaseUrl}wbs-vendor/get-wbs-requirement";
  static const vendorBid = "${orderManagementBaseUrl}wbs-vendor/vendor-bid";
  static const notinterestBid =
      "${orderManagementBaseUrl}wbs-vendor/not-interest-bid";
  static const reachedEntry =
      "${orderManagementBaseUrl}wbs-vendor/reached-entry";
  static const availableWarehouse =
      "${orderManagementBaseUrl}wbs-vendor/get-warehouse-by-requirement";

  //Pending Bids

  static const pendingBids = "${orderManagementBaseUrl}wbs-vendor/pending-bids";
  static const cancelBid = "${orderManagementBaseUrl}wbs-vendor/cancel-bid";
  static const wbsBidNegotiations =
      "${orderManagementBaseUrl}wbs-vendor/wbs-bid-negotiations";
  static const negotiationsEntry =
      "${orderManagementBaseUrl}wbs-vendor/wbs-negotiation-entry";
  static const bidPriceConfirm =
      "${orderManagementBaseUrl}wbs-vendor/wbs-bid-price-confirm";
  static const BidNegotiationsAttachmentUploadAPI =
      "${orderManagementBaseUrl}wbs-vendor/wbs-negotiation-attachment";

// Workorders

  static const workorders = "${orderManagementBaseUrl}wbs-vendor/work-orders";
  static const workordersnegotiations =
      "${orderManagementBaseUrl}wbs-vendor/wbs-bid-workorder-negotiations";
  static const workordersnegotiationsEntry =
      "${orderManagementBaseUrl}wbs-vendor/wbs-workorder-negotiation-entry";
  static const workorderspriceConfirm =
      "${orderManagementBaseUrl}wbs-vendor/wbs-bid-workorder-price-confirm";
  static const WOBidNegotiationsAttachmentUploadAPI =
      "${orderManagementBaseUrl}wbs-vendor/wbs-workorder-negotiation-attachment";

  // Completed Orders

  static const checkoutOrder =
      "${orderManagementBaseUrl}wbs-vendor/checkout-order";
  static const completedorders =
      "${orderManagementBaseUrl}wbs-vendor/completed-orders";
  static const confirmInvoice =
      "${orderManagementBaseUrl}wbs-vendor/confirm-invoice";
  static const downloadWorkorder =
      "${orderManagementBaseUrl}wbs-customer/download-pdf-mob";
  static const downloadInvoice =
      "${orderManagementBaseUrl}wbs-customer/download-invoice-mob";
  static const uploadInvoice =
      "${orderManagementBaseUrl}wbs-vendor/upload-invoice";
  static const completedbidDetail =
      "${orderManagementBaseUrl}wbs-customer/get-vendor-bid";

  // Control Tower)

  static const controlTowerAPI = "${reportsBaseUrl}wbs-vendor/control-tower";

  // WBS Report )

  static const getWHReportList = "${reportsBaseUrl}wbs-vendor/bid-report";
  static const getWHReportDetailData =
      "${reportsBaseUrl}wbs-vendor/report-detail";

  // Master User (Privilieges)

  static const getInterUsersAPI =
      "${userCredentialBaseUrl}wbs-vendor/get-users";
  static const getUserAPI = "${userCredentialBaseUrl}wbs-vendor/get-user";
  static const addUserAPI = "${userCredentialBaseUrl}wbs-vendor/add-user";
  static const deleteUserAPI = "${userCredentialBaseUrl}wbs-vendor/delete-user";

  // User Role (Privilieges)

  static const getInterUserRolesAPI =
      "${userCredentialBaseUrl}wbs-vendor/user-roles";
  static const getInterUserRoleMenusAPI =
      "${userCredentialBaseUrl}wbs-vendor/get-menus";
  static const getUserRoleAPI =
      "${userCredentialBaseUrl}wbs-vendor/get-user-role";
  static const addUserRoleAPI =
      "${userCredentialBaseUrl}wbs-vendor/add-user-role";
  static const deleteUserRoleAPI =
      "${userCredentialBaseUrl}wbs-vendor/delete-user-role";

  //  Warehouse (Master)

  static const addWarehouse =
      "${masterNprofileBaseUrl}wbs-vendor/add-warehouse";
  static const deleteWarehouse =
      "${masterNprofileBaseUrl}wbs-vendor/delete-warehouse";
  static const warehouseList = "${masterNprofileBaseUrl}wbs-vendor/warehouses";
  static const warehouseDetails =
      "${masterNprofileBaseUrl}wbs-vendor/get-warehouse";

  //Terms and Conditions

  static const getTermsnConditions =
      "${masterNprofileBaseUrl}wbs-vendor/get-terms-conditions";
  static const addTermsnConditions =
      "${masterNprofileBaseUrl}wbs-vendor/add-terms-conditions";

  // Master

  static const cities = "${masterBaseUrl}master/cities";
  static const warehousetypes = "${masterBaseUrl}master/warehouse-types";
  static const materialtypes = "${masterBaseUrl}master/material-types";
  static const amenity = "${masterBaseUrl}master/amenities";
  static const timing = "${masterBaseUrl}master/warehouse-timings";
  static const cityLocation = "${masterBaseUrl}master/city-only";
  static const messages = "${masterBaseUrl}master/resp-messages";
  static const paymentTypes = "${masterBaseUrl}master/payment-types";
  static const wbsCategoriesList =
      "${masterBaseUrl}master/warehouse-categories";
  static const wbsServicesList = "${masterBaseUrl}master/warehouse-services";
}
