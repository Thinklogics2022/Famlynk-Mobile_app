import 'package:famlynk_version1/mvc/model/profile_model/profile_model.dart';

class ProfileService {
  Future<User> fetchUserProfile(String userId) async {
    await Future.delayed(Duration(seconds: 2));

    return User(
      id: userId,
      profileImageUrl: 'assets/profile_image.png',
      name: 'John Doe',
      email: 'johndoe@example.com',
      gender: 'Male',
      dob: '1990-01-01',
      mobileNumber: '+1234567890',
    );
  }

  Future<void> updateProfile(User updatedUser) async {
    await Future.delayed(Duration(seconds: 2));

    print('Updated user profile: $updatedUser');
  }
}


