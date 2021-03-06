import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uiecom/AFile/Scr/Order/OrderWid.dart';
import 'package:uiecom/AFile/Scr/Profile/ShowProdile.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Porf_Address/Profile/profile_bloc.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Drop_Down_C.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/AllFormField.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/AllFormValidation.dart';
import 'package:uiecom/ZExtra/DataList.dart';

class EditProfileScr extends StatelessWidget {
  static const routeName = '/edit-profile';
  const EditProfileScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            Center(child: CircularProgressIndicator());
          }
          if (state is ProfileErrorState) {
            Center(child: Text(state.error.toString()));
          }
          if (state is ProfileSuccessState) {
            Navigator.of(context)
                .pushReplacementNamed(ShowProfileScr.routeName);
          }
        },
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoadedState) {
            return ProfileForm(profState: state.profileData);
          }

          return Center(child: CircularProgressIndicator());
        }),
      ),
    ));
  }
}

class ProfileForm extends StatefulWidget {
  dynamic profState;
  ProfileForm({Key? key, this.profState}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  var genderData = [
    "Male",
    "Female",
    "Other",
  ];

  _profileBtn() async {
    var isvalid = formKey.currentState!.validate();
    if (!isvalid) {
      return "Enter the Correct Value";
    }
    formKey.currentState!.save();

    var isToken = BlocProvider.of<ProfileBloc>(context).add(
      ProfileSaveButtonEvent(
        fullname: nameController.text.isNotEmpty
            ? nameController.text
            : widget.profState[0].fullname,
        email: emailController.text.isNotEmpty
            ? emailController.text
            : widget.profState[0].email,
        gender: genderController.text.isNotEmpty
            ? genderController.text
            : widget.profState[0].gender,
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                             // ! END PROFILE BUTTON FORM                            */
  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    /* -------------------------------------------------------------------------- */
    /*                       //  ! FORM VALIDATION PROVIDER                       */
    /* -------------------------------------------------------------------------- */
    final formvalid = Provider.of<AllFormValdation>(context);

    return Container(
        padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //  !  staring list item
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),

              // ! 2. AVATOR CIRCLE FOR PIC

              //  ! AVATAR PIC
              AviPic(),

              // ! Avitar Pic,

              SizedBox(
                height: 35,
              ),

              //  ! FORM FILED WIDGET
              EditFormFields(
                formValidator: (String? val) => formvalid.reqValid(val),
                initValue: widget.profState[0].fullname.isNotEmpty
                    ? widget.profState[0].fullname
                    : '',
                inputType: TextInputType.name,
                placeholder: 'Enter the Name',
                savedValue: (String? newValue) {
                  setState(() {
                    nameController.text = newValue!;
                  });
                },
              ),
              // !EMAIL FILE D
              EditFormFields(
                formValidator: (String? val) => formvalid.emailVal2(val),
                initValue: widget.profState[0].email.isNotEmpty
                    ? widget.profState[0].email
                    : '',
                inputType: TextInputType.emailAddress,
                placeholder: 'Enter the Email',
                brd: false,
                savedValue: (String? newValue) {
                  setState(() {
                    emailController.text = newValue!;
                  });
                },
              ),

              DropDownBtn(
                pageName: 'Gender',
                dName: widget.profState[0].gender.toString().isNotEmpty
                    ? widget.profState[0].gender
                    : 'Gender',
                listData: AllListData.genderData,
                listController: genderController,
                currentItem: widget.profState[0].gender.toString().isNotEmpty
                    ? widget.profState[0].gender
                    : null,
                // // onValue:   ,
              ),

              // // ! END FORM FIELD PAGE

              Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 0.0),
                  child: widget.profState is ProfileLoadingState
                      ? CupertinoActivityIndicator()
                      : PlaceBtn('Save', submitMethod: _profileBtn)),
            ],
          ),
        ));
  }
}
