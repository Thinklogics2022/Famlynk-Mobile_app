import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DltMemberService {
  String userId = "";
  Future<dynamic> deleteFamilyMember(String userId, String uniqueUserID) async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';

    Map<String, dynamic> mapObj = {
      "userId": userId,
      "uniqueUserID": uniqueUserID
    };
    print(mapObj);

    try {
      var response = await http.delete(
        Uri.parse(FamlynkServiceUrl.deleteFamilyMember +
            "$userId" +
            "/" +
            "$uniqueUserID"),
        headers: {"Content-Type": "application/json ; charset=UTF-8"},
      );
      if (response.statusCode == 200) {
        print("Deleted sucessfuly");
        print(response.body);
        print(response.statusCode);
        return response.body;
      }
    } catch (e) {
      print("Member not deleted ");
    }
  }
}
