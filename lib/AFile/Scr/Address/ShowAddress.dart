import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Porf_Address/Address/address_bloc.dart';
import 'package:uiecom/Fortend/Widget/Appbar/CusAppbar.dart';
import 'UpdAddress.dart';

class AddressShowScr extends StatelessWidget {
  static const routeName = '/showp-Addresspage in ';
  AddressShowScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: CustomAppBar(
        //     titleName: 'Address Page ',
        //     act: [Icon(Icons.add)],
        //   ),
        //   body:
        SafeArea(
            bottom: false,
            left: true,
            right: true,
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Address1(),
            ));
    // );
  }
}

/* -------------------------------------------------------------------------- */
/*                              // ! Address BODY                             */
/* -------------------------------------------------------------------------- */
class Address1 extends StatefulWidget {
  Address1({
    Key? key,
  }) : super(key: key);

  @override
  _Address1State createState() => _Address1State();
}

class _Address1State extends State<Address1> {
  dynamic idtData;

  // ! Address instance

  AddressBloc prodBloc = AddressBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<AddressBloc>(context);
    prodBloc.add(FetchAddressEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressLoadingState) {
          Center(child: CircularProgressIndicator());
        }
        if (state is AddressDelState) {
          Navigator.of(context).pushReplacementNamed(AddressShowScr.routeName);
        }
        if (state is AddressErrorState) {
          Center(child: Text(state.error.toString()));
        }
      },
      child: BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
        if (state is AddressLoadedState) {
          return AddressShow(
            adrState: state.addressData,
          );
        }

        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              // ! ADDRESS SHOW                             */
// /* -------------------------------------------------------------------------- */

class AddressShow extends StatefulWidget {
  dynamic adrState;
  Function(String)? callback;

  AddressShow({Key? key, this.adrState, this.callback}) : super(key: key);

  @override
  _AddressShowState createState() => _AddressShowState();
}

class _AddressShowState extends State<AddressShow> {
  dynamic gValue = 0;
  dynamic idt;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        // ! Name
        // Container(
        //   width: double.infinity,
        //   height: 50,
        //   child: Card(
        //       child: InkWell(
        //           onTap: () {
        //             Navigator.of(context)
        //                 .pushReplacementNamed(AddressPostScr.routeName);
        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.only(top: 8.0),
        //             child:
        //                 Text('Add New Address', style: TextStyle(fontSize: 18)),
        //           ))),
        // ),
        // ! end

        widget.adrState.isNotEmpty
            ? Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.adrState.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          value: index,
                          groupValue: gValue,
                          onChanged: (ind) {
                            setState(() {
                              gValue = ind;
                              idt = widget.adrState[index].id;
                            });
                          },
                          title: AddressItem(adrNumber: widget.adrState[index]),
                        );
                      }),
                ],
              )
            : Center(child: Text('No Address')),

        // ! Name
        // widget.adrState.isNotEmpty ? FBtn('Save') : Text('')
        // ! end
      ],
    ));
  }
}

class AddressItem extends StatelessWidget {
  dynamic adrNumber;
  AddressItem({Key? key, this.adrNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    adrNumber.fullname != null
                        ? adrNumber.fullname
                        : 'Fullname',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Container(
                child: Text(
                  "${adrNumber.house} , ${adrNumber.trade} ${adrNumber.trade} , ${adrNumber.city}\n ${adrNumber.state} ",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text: "${adrNumber.phone}",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              AddressBtn(adrNumber: adrNumber)
            ],
          ),
        ),
      ),
    );
  }
}

// ! Address Btn
class AddressBtn extends StatelessWidget {
  dynamic adrNumber;
  AddressBtn({Key? key, this.adrNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          adrBtn("Edit /Change", submitMethod: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // ! add PRODUCT ITEM DEIALS
                        AddressUpScr(
                          adrNumber: adrNumber,
                        )));
          }),

          Spacer(
            flex: 3,
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          Spacer(
            flex: 3,
          ),
          // ! btn field
          adrBtn("Remove", submitMethod: () {
            // !adr DELETE
            BlocProvider.of<AddressBloc>(context)
              ..add(AddressDel(adrId: adrNumber.id.toString()));

            // ! Address METHOD
          }),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget adrBtn(String btnName, {dynamic submitMethod}) {
    return MaterialButton(
      onPressed: submitMethod,
      child: Text(btnName,
          style: TextStyle(fontSize: 12, color: Colors.indigo.shade700)),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
