import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/AFile/Scr/Address/ShowAddress.dart';
import 'package:uiecom/AFile/Scr/Order/Order.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Order/bloc/orderpage_bloc.dart';
import 'package:uiecom/Fortend/Screen/Authr_Scr/HomeScr.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Btn.dart';

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
      return MyOrderScr1(adrNumber: adrNumber, prodNumber: prodNumber);
    }));
  }
}

class MyOrderScr1 extends StatefulWidget {
  dynamic prodNumber;
  dynamic cartNumber;
  dynamic adrNumber;
  MyOrderScr1({Key? key, this.prodNumber, this.adrNumber});
  @override
  _MyOrderScr1State createState() => _MyOrderScr1State();
}

class _MyOrderScr1State extends State<MyOrderScr1> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
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
        body: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      AddressShow(
                        adrState: widget.adrNumber,
                      ),
                      OrderItem1(prodNumber: widget.prodNumber),
                    ],
                  ),
                ),
                flex: 90,
              ),
              FBtn("Place Order")
            ],
          );
        }),
      ),
    );
  }
}

// ! Order Item
class OrderItem extends StatelessWidget {
  dynamic prodNumber;
  OrderItem({Key? key, this.prodNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return OrderItem1(prodNumber: prodNumber[index]);
      },
      itemCount: prodNumber,
    );
  }
}

class OrderItem1 extends StatelessWidget {
  dynamic prodNumber;
  OrderItem1({Key? key, this.prodNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: AssetImage("images/shoes_1.png"))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          prodNumber.title,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle().copyWith(fontSize: 14),
                        ),
                      ),
                      // Utils.getSizedBox(height: 6),
                      Text(
                        "Green M",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              prodNumber.discountPrice.toString(),
                              style: TextStyle(color: Colors.green),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.remove,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text(
                                      "1",
                                      style: TextStyle(),
                                    ),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10, top: 8),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.green),
          ),
        )
      ],
    );
  }
}
