import 'package:shared_preferences/shared_preferences.dart';

class EditProfileService{
  String userId = '';
  Future<dynamic> editProfilepost()async{
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';

  }
}