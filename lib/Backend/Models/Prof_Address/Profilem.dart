import 'dart:convert';

MainProfile mainProductMFromJson(String str) =>
    MainProfile.fromJson(json.decode(str));

String mainProductMToJson(MainProfile data) => json.encode(data.toJson());

class MainProfile {
  MainProfile({
    required this.profileData,
  });

  List<Profile> profileData;

  factory MainProfile.fromJson(Map<String, dynamic> json) => MainProfile(
        profileData: List<Profile>.from(
            json["profileData"].map((x) => Profile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "profileData": List<dynamic>.from(profileData.map((x) => x.toJson())),
      };
}

/* -------------------------------------------------------------------------- */
/*                 // orc 1.  PROFILE PAGE MODEL  IN WITHOUT LIST                */
/* -------------------------------------------------------------------------- */

class Profile {
  Profile({
    this.fullname,
    this.email,
    this.pic,
    this.gender,
  });

  String? fullname;
  String? email;
  dynamic pic;
  dynamic gender;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        fullname: json["fullname"],
        email: json["email"],
        pic: json["pic"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "pic": pic,
        "gender": gender,
      };
}
