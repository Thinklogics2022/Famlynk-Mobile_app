import 'package:famlynk_version1/utils/utils.dart';
import 'package:http/http.dart' as http;

class DltFamMemberService {
  Future<dynamic> deleteFamilyMember(int userId, String uniqueUserId) async {
    try {
      var response = await http.delete(
        Uri.parse(
            '${FamlynkServiceUrl.baseUrl}${FamlynkServiceUrl.deleteFamilyMember}/$userId/$uniqueUserId'),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );

      return response.body;
    } catch (e) {
      print(e);
    }
  }
}
