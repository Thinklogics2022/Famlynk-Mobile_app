import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;

class DltMemberService {
  Future<dynamic> deleteFamilyMember(String userId, String uniqueUserId) async {
    Map<String, dynamic> mapObj = {
      "userId": userId,
      "uniqueUserId": uniqueUserId
    };
    print(mapObj);

    try {
      var response = await http.delete(
        Uri.parse(FamlynkServiceUrl.deleteFamilyMember +
            "$userId" +
            "/" +
            "$uniqueUserId"),
        headers: {"Content-Type": "application/json ; charset=UTF-8"},
      );

      print("Deleted sucessfuly");
      print(response.body);
      print(response.statusCode);
      return response.body;
    } catch (e) {
      print("Member not deleted ");
    }
  }
}
