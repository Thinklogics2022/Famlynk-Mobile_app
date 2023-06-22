class FamlynkServiceUrl {
  static const String baseUrl = "http://192.168.1.18:8080";
  static const String createUser = baseUrl + "/register/createregister";
  static const String login = baseUrl + "/authenticate/login";
  static const String updateRegister =
      baseUrl + "/familymembers/createfamilymembers/{email}";
  static const String verifyOtp = baseUrl + "/register/verifyotp/";
  static const String addMember =
      baseUrl + "/familymembers/createfamilymembers/";
  static const String allUser = baseUrl + "/register/retrieveregister";
  static const String getFamilyMember =
      baseUrl + "/familymembers/retrievefamilymembersbyuseridss/";
  static const String searchAddMember = baseUrl + "/familymembers/addfamily";
  static const String deleteFamilyMember =
      baseUrl + "/familymembers/deletefamilymember/";
  static const String newsFeed = baseUrl + "/newsfeed/createnewsfeed";
  static const String updateFamilyMember =
      baseUrl + "/familymembers/updatefamilymembers/";
}