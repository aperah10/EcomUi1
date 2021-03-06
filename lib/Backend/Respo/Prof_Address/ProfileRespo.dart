import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:uiecom/Backend/Models/Prof_Address/Profilem.dart';

LocalStorage storage = new LocalStorage('usertoken');
var token = storage.getItem('token');

class ProfileDataRespo {
  Future<List<Profile>> getProfileData() async {
    String baseUrl = 'https://rahul10apes.pythonanywhere.com/profile/';
    try {
      var res = await http.get(Uri.parse(baseUrl), headers: {
        "Authorization": "token $token",
      });

      if (res.statusCode == 200) {
        var datar = jsonDecode(res.body);
        // print('datatr $datar');
        MainProfile mpt = MainProfile.fromJson({'profileData': datar});

        List<Profile> profileData = mpt.profileData;
        // print('Profile RESPO PRODDATA :- $profileData');

        return profileData;
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (e) {
      print('Error:- $e');
      return Future.error("Error Fetching Data !");
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                           // ! PROFILE POST REQUEST                         */
  /* -------------------------------------------------------------------------- */

  Future<List<Profile>> addProfileData(
      {required String fullname,
      String? email,
      String? pic,
      String? gender}) async {
    String baseUrl = 'https://rahul10apes.pythonanywhere.com/profile/';

    try {
      var res = await http.post(Uri.parse(baseUrl),
          body: json.encode({
            "fullname": fullname,
            "email": email,
            "pic": pic,
            "gender": gender,
          }),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': "token $token"
          });
      var data = json.decode(res.body) as Map;
      // print('this is data in post method :- $data');
      // print(res.body);
      // print(' Statuc Code  :-  ${res.statusCode}');

      if (res.statusCode == 200) {
        return getProfileData();
        // return true;
      }
      return Future.error("Error Fetching Data !");

      // return false;
    } catch (e) {
      print("e Profile");
      print(e);
      // return false;
      return Future.error("Error Fetching Data !");
    }
  }
}
