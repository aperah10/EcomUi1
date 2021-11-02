import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/AFile/Scr/Address/EditAddress.dart';
import 'package:uiecom/AFile/Scr/Address/ShowAddress.dart';
import 'package:uiecom/AFile/Scr/Order/Order.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Order/bloc/orderpage_bloc.dart';
import 'package:uiecom/Backend/Models/Prof_Address/Addressm.dart';
import 'package:uiecom/Fortend/Screen/Authr_Scr/HomeScr.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Btn.dart';

import 'OrderItem.dart';

class MyOrder extends StatelessWidget {
  dynamic prodNumber;
  dynamic cartNumber;
  dynamic adrNumber;
  MyOrder({Key? key, this.adrNumber, this.prodNumber, this.cartNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderpageBloc, OrderpageState>(listener:
        (context, state) {
      if (state is OrderFailure) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Order failed."),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (state is OrderSucccess) {
        Navigator.of(context).pushReplacementNamed(HomeScr.routeName);
      }
    }, child:
        BlocBuilder<OrderpageBloc, OrderpageState>(builder: (context, state) {
      return MyOrderScr2(
          adrNumber: adrNumber, prodNumber: prodNumber, cartNumber: cartNumber);
      // return OrderScf(adrNumber: adrNumber, prodNumber: prodNumber);
    }));
  }
}

// ! MyOrderScr2 order Scffold
class MyOrderScr2 extends StatefulWidget {
  dynamic prodNumber;
  dynamic cartNumber;
  dynamic adrNumber;
  MyOrderScr2({Key? key, this.prodNumber, this.adrNumber, this.cartNumber})
      : super(key: key);

  @override
  _MyOrderScr2State createState() => _MyOrderScr2State();
}

class _MyOrderScr2State extends State<MyOrderScr2> {
  Widget? adrNavigate() {
    if (widget.adrNumber == null || widget.adrNumber.isEmpty) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AddressPostScr()),
            (route) => false);
      });
    } else {
      return AddressItem(
        adrNumber: widget.adrNumber[0],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        // ! Address List
        Container(
          child: adrNavigate(),
        ),
        // ! OrderItem
        widget.prodNumber != null
            ? OrderItem1(prodNumber: widget.prodNumber)
            : OrderItem(cartNumber: widget.cartNumber),
      ],
    ));
  }
}
