import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uiecom/AFile/Scr/Address/ShowAddress.dart';
import 'package:uiecom/AFile/Scr/Order/OrderWid.dart';
import 'package:uiecom/AFile/Scr/Steper/strp.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Porf_Address/Address/address_bloc.dart';
import 'package:uiecom/Fortend/Widget/Appbar/CusAppbar.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Drop_Down_C.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/AllFormField.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/AllFormValidation.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Btn.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Buttons_C.dart';
import 'package:uiecom/ZExtra/DataList.dart';

class AddressPostScr extends StatefulWidget {
  static const routeName = '/edit-address-post';
  AddressPostScr({Key? key}) : super(key: key);

  @override
  _AddressPostScrState createState() => _AddressPostScrState();
}

class _AddressPostScrState extends State<AddressPostScr> {
  AddressBloc prodBloc = AddressBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<AddressBloc>(context);
    prodBloc.add(FetchAddressEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleName: 'Add New Address',
        ),
        body: SafeArea(
          child: BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              // print('AState ${state}');
              if (state is AddressLoadingState) {
                Center(child: CircularProgressIndicator());
              }
              if (state is AddressErrorState) {
                Center(child: Text(state.error.toString()));
              }
              if (state is AddressSuccessState) {
                Navigator.of(context).pushReplacementNamed(Strper.routeName);
              }
            },
            child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
              if (state is AddressLoadedState) {
                return CreateAddressScreen(adrState: state.addressData);
              }

              return Center(child: CircularProgressIndicator());
            }),
          ),
        ));
  }
}

class CreateAddressScreen extends StatefulWidget {
  dynamic adrState;
  CreateAddressScreen({Key? key, this.adrState}) : super(key: key);
  @override
  _CreateAddressScreenState createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final houseController = TextEditingController();
  final tradeController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateController = TextEditingController();
  final delTimeController = TextEditingController();
  /* -------------------------------------------------------------------------- */
  /*                              // ! Address BUTTON                             */
  /* -------------------------------------------------------------------------- */
  _addressBtn() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return "Enter the Correct Value";
    }
    _form.currentState!.save();

    var isToken = BlocProvider.of<AddressBloc>(context).add(
      AddressSaveBtnEvent(
        fullname: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        house: houseController.text,
        trade: tradeController.text,
        city: cityController.text,
        area: areaController.text,
        state: stateController.text,
        pinCode: pinCodeController.text,
        delTime: delTimeController.text,
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                             // ! END Address BUTTON FORM                            */
  /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    /* -------------------------------------------------------------------------- */
    /*                       //  ! FORM VALIDATION PROVIDER                       */
    /* -------------------------------------------------------------------------- */
    final formvalid = Provider.of<AllFormValdation>(context);

    return SingleChildScrollView(
        child: Container(
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ! Name EditFormFields
            EditFormFields(
              formValidator: (String? val) => formvalid.reqValid(val),
              placeholder: 'Name',
              inputType: TextInputType.name,
              controller: nameController,
            ),
            // ! PHONE field
            EditFormFields(
              formValidator: (String? val) => formvalid.mobileValidator(val),
              placeholder: 'Phone',
              inputType: TextInputType.phone,
              controller: phoneController,
            ),

            // ! Email field
            EditFormFields(
              formValidator: (String? val) => formvalid.emailVal2(val),
              placeholder: 'Email',
              inputType: TextInputType.emailAddress,
              controller: emailController,
            ),

            // ! House field
            EditFormFields(
                placeholder: 'house',
                inputType: TextInputType.name,
                controller: houseController),
            // ! Address field
            EditFormFields(
                placeholder: 'Trade',
                inputType: TextInputType.name,
                controller: tradeController),

            // ! City field
            EditFormFields(
                formValidator: (String? val) => formvalid.reqValid(val),
                inputType: TextInputType.name,
                placeholder: 'City',
                controller: cityController),

            // ! City field
            EditFormFields(
              inputType: TextInputType.name,
              placeholder: 'Area',
              controller: areaController,
            ),

            // ! POSTTAL field
            EditFormFields(
              formValidator: (String? val) => formvalid.postalCodeValid(val),
              inputType: TextInputType.number,
              placeholder: 'PostalCode',
              controller: pinCodeController,
            ),

            // ! DROP DOWN FOR STATE_LIST
            DropDownBtn(
              formValidator: (String? val) => formvalid.reqValid(val),
              dName: 'State',
              listData: AllListData.stateData,
              listController: stateController,
              pageName: 'State',
            ),

            // ! DELIVEY TIME
            DropDownBtn(
              formValidator: (String? val) => formvalid.reqValid(val),
              dName: 'Delivery Time',
              listData: AllListData.deliveryData,
              listController: delTimeController,
              pageName: 'Delivery Time',
            ),

            // Login Button
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 0.0),
              child: widget.adrState is AddressLoadingState
                  ? CupertinoActivityIndicator()
                  : FBtn(
                      'Save',
                      submitMethod: _addressBtn,
                    ),
            ),
          ],
        ),
      ),
    ));
  }
}
