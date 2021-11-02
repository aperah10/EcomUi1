import 'package:flutter/material.dart';
import 'package:uiecom/AFile/Scr/Address/EditAddress.dart';
import 'package:uiecom/AFile/Scr/Address/ShowAddress.dart';
import 'package:uiecom/AFile/Scr/Steper/OrderItem.dart';

// ! only order Scffold
class OrderScf extends StatelessWidget {
  dynamic prodNumber;
  dynamic cartNumber;
  dynamic adrNumber;
  OrderScf({Key? key, this.prodNumber, this.adrNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "MyOrder",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: MyOrderScr1(adrNumber: adrNumber, prodNumber: prodNumber),
    );
  }
}

// ! MyOrderScr1
class MyOrderScr1 extends StatefulWidget {
  dynamic prodNumber;
  dynamic cartNumber;
  dynamic adrNumber;
  MyOrderScr1({Key? key, this.prodNumber, this.adrNumber, this.cartNumber});
  @override
  _MyOrderScr1State createState() => _MyOrderScr1State();
}

class _MyOrderScr1State extends State<MyOrderScr1> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

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
    // return Builder(builder: (context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  // ! Address List
                  SizedBox(
                    child: adrNavigate(),
                  ),

                  widget.prodNumber != null
                      ? OrderItem1(prodNumber: widget.prodNumber)
                      : OrderItem(cartNumber: widget.cartNumber),
                ],
              ),
            ),
            flex: 90,
          ),
          // FBtn("Place Order")
        ],
      ),
    );
    // });
  }
}
