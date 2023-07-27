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
  static const String searchAllUser = baseUrl + "/register/retrievemembers/";
  static const String getFamilyMember =
      baseUrl + "/familymembers/retrieveFamilyMembers/";
  static const String searchAddMember = baseUrl + "/familymembers/addfamily";
  static const String deleteFamilyMember =
      baseUrl + "/familymembers/deletefamilymember/";
  static const String postNewsFeed = baseUrl + "/newsfeed/createnewsfeed";
  static const String getPublicNewsFeed =
      baseUrl + "/newsfeed/retrievenewsfeed/pagination/";
  static const String getFamilyNewsFeed =
      baseUrl + "/newsfeed/retrievefamilynewsfeed/";
  static const String updateFamilyMember =
      baseUrl + "/familymembers/updatefamilymembers/";
  static const String updatePassword =
      baseUrl + "/register/updatepasswordbyemail/";
  static const String gallery = baseUrl + "/newsfeed/retrieveusernewsfeed/";
  static const String profileUser = baseUrl + "/register/retrieveregisterbyid/";
  static const String editProfile = baseUrl + "/register/updateregisterbyid/";
  static const String addComment = baseUrl + "/comment/createcomment";
  static const String getComment =
      baseUrl + "/comment/retrievecommentbyid/{newsFeedId}";
  static const String updateComment = "/comment/updatecommentbyid/{id}";
  static const String deleteComment = "/comment/deletecomment/{id}";
  static const String like = baseUrl + "/newsfeed/likes/";


  static const String profileUserrr = baseUrl + "/register/retrievemembersbyuserid/";
}
