class EndPoints {
  static const String apiSecret = '';

  /// Auth endpoints
  static const String login = 'auth/login';
  static const String forgetPassSendOtp = 'auth/forget-password/send-otp';
  static const String verifyOtp = 'auth/verify-otp';
  static const String verifyOtpForgetPass = 'auth/forget-password/verify-otp';
  static const String resendOtp = 'auth/resend-otp';
  static const String forgetPassNewPass = 'auth/forget-password/set-password';
  static const String initRegister = '/auth/register';
  static const String activateAccount = '/auth/activate-account';

  /// Customer
  static const String profileVerifyOtp = '/account/verify-otp';
  static const String profileSendOtp = '/account/send-otp';
  static const String requestContactChange = '/account/request-contact-change';
  static const String updateProfileVerifyOtp = '/account/verify-contact-change';
  static const String deleteAccount = '/account/delete-account';

  /// Units
  static const String myUnits = '/unit/units';
  static const String customerUnits = '/unit/customer-units';
  static const String unitDetails = '/unit/';
  static const String unitUpComingPayments = '/payment/paymentList/';

  static const String allProjects = '/unit/businessEntities';

  /// News
  static const String news = 'news';

  /// Tickets
  static const String myTickets = '/ticket/customer-tickets';
  static const String createTicket = "/ticket/create-ticket";
  static const String getTicketDetails = "/ticket/ticket-id/";
  static const String editTicket = "/ticket/edit";
  static const String ticketStatuses = "/ticket/ticket-statuses";

  static const String ticketTypes = "/ticket/available-ticket-type";
  static const String branches = "/ticket/branches";

  static const String rm = "/account/rm";
  static const String changePassword = '/account/change-password';

  /// notifications
  static const String allNotifications = 'notifications';
  static const String unseenNotification = "notifications/unseen";
  static const String seenNotification = "notifications/seen";

  static const String confirmPayment = "/payment/create";
  static const String upcomingPayment = "payment/upcomingPayment";

  static const String updateFcm = "/account/fcmToken";

  static const String paymentHistory = "payment/paymentSummary";
  static const String notifications = "notifications";
  static const String getProfile = "account/profile";
  static const String submitSurvey = "survey/submit";
  static const String getSurvey = "survey/";
  static const String rateTicket = "/rate";
}
