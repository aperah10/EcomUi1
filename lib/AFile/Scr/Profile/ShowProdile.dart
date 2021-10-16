import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/AFile/Scr/Order/OrderWid.dart';
import 'package:uiecom/AFile/Scr/Profile/EditProfile.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Porf_Address/Profile/profile_bloc.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/AllFormField.dart';

class ShowProfileScr extends StatelessWidget {
  static const routeName = '/showp-profilepage in ';
  ShowProfileScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Profile1(),
    );
  }
}

class Profile1 extends StatefulWidget {
  Profile1({Key? key}) : super(key: key);

  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  // ! PRofile instance

  ProfileBloc prodBloc = ProfileBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProfileBloc>(context);
    prodBloc.add(FetchProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          Center(child: CircularProgressIndicator());
        }
        if (state is ProfileErrorState) {
          Center(child: Text(state.error.toString()));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoadedState) {
          print(state.profileData);
          return ProfileS(profState: state.profileData);
        }

        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class ProfileS extends StatelessWidget {
  dynamic profState;
  ProfileS({Key? key, this.profState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          // ! AVIATAR Pic
          AviPic(),
          //  ! FORM FILED WIDGET
          ShowFormFields(
            placeholder:
                profState[0].fullname != null ? profState[0].fullname : 'Name',
          ),
          ShowFormFields(
            placeholder: profState[0].email,
          ),
          ShowFormFields(
            placeholder:
                profState[0].gender != null ? profState[0].gender : 'Gender',
          ),
          // ! btn for update
          Container(
            height: 50,
            child: PlaceBtn("Edit", submitMethod: () {
              Navigator.of(context)
                  .pushReplacementNamed(EditProfileScr.routeName);
            }),
          )
        ],
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));
}

// ! AVIATAR Pic
class AviPic extends StatelessWidget {
  const AviPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.red, Colors.purple])),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 120,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                Text(
                  "Choose Image",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
