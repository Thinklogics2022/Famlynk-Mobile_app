class FamlynkServiceUrl {
  static const String baseUrl = "http://192.168.1.23:8080";
  static const String createUser = baseUrl + "/register/createregister";
  static const String login = baseUrl + "/authenticate/login";
  static const String updateRegister =
      baseUrl + "/familymembers/createfamilymembers/{email}";
  static const String verifyOtp = baseUrl + "/register/verifyotp/";
  static const String resendOtp = baseUrl + "/register/resend/";
  static const String addMember =
      baseUrl + "/familymembers/createfamilymembers/";
  static const String allUser = baseUrl + "/register/retrievemembers/";
  static const String getFamilyMember =
      baseUrl + "/familymembers/retrievefamilymembersbyuseridss/";
  static const String searchAddMember = baseUrl + "/familymembers/addfamily";
  static const String deleteFamilyMember =
      baseUrl + "/familymembers/deletefamilymember/";
  static const String postNewsFeed = baseUrl + "/newsfeed/createnewsfeed";
  static const String getPublicNewsFeed =
      baseUrl + "/newsfeed/retrievenewsfeed/pagination/";
  static const String getFamilyNewsFeed =
      baseUrl + "/newsfeed/retrievefamilynewsfeed/pagination/";
  static const String like = baseUrl + "/newsfeed/likes/{userId}/{newsFeedId}";
  static const String postComment = baseUrl + "/comment/createcomment";
  static const String getComment =
      baseUrl + "/comment/retrievecommentbyid/{newsFeedId}";
  static const String updateFamilyMember =
      baseUrl + "/familymembers/updatefamilymembers/";
  static const String updatePassword =
      baseUrl + "/register/updatepasswordbyemail/";
  static const String gallery = baseUrl + "/newsfeed/retrieveusernewsfeed/";
  static const String profileUser =
      baseUrl + "/register/retrievemembersbyuserid/";
  static const String editProfile = baseUrl + "/register/updateregisterbyid/";
}
