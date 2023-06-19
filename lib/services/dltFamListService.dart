import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;

class DltMemberService {
  Future<dynamic> deleteFamilyMember(String userId, String uniqueUserId) async {
    Map<String, dynamic> mapObj = {
      "userId": userId,
      "uniqueUserId": uniqueUserId
    };

    try {
      var response = await http.delete(
        Uri.parse(FamlynkServiceUrl.deleteFamilyMember +
            "$userId" +
            "/" +
            "$uniqueUserId"),
        headers: {"Content-Type": "application/json ; charset=UTF-8"},
      );

      print("Deleted sucessfuly");
      return response.body;
    } catch (e) {
      print("Member not deleted ");
    }
  }
}
