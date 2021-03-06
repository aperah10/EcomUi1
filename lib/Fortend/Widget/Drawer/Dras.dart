import 'package:flutter/material.dart';
import 'package:uiecom/AFile/Scr/Address/EditAddress.dart';
import 'package:uiecom/AFile/Scr/Address/ShowAddress.dart';
import 'package:uiecom/AFile/Scr/Cart/CartPage.dart';
import 'package:uiecom/AFile/Scr/Order/Order.dart';
import 'package:uiecom/AFile/Scr/Profile/ShowProdile.dart';
import 'package:uiecom/AFile/Scr/Steper/myOrder.dart';
import 'package:uiecom/AFile/Scr/Steper/strp.dart';
import 'package:uiecom/Fortend/Screen/Product_Scr/Cart/Cart.dart';
import 'package:uiecom/Fortend/Screen/Product_Scr/Product/ProdPage.dart';
import 'package:uiecom/Fortend/Screen/Product_Scr/Product/Product_Cat.dart';

class MyDrawerList extends StatefulWidget {
  const MyDrawerList({Key? key}) : super(key: key);

  @override
  _MyDrawerListState createState() => _MyDrawerListState();
}

class _MyDrawerListState extends State<MyDrawerList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        //  orc Custom Header file
        CusDrawerHeader(),
        // CusAvaitar2(),
        //  ! END  Custom Header file

        // ! CUSTOM DRAWER LIST ITEM
        CusDrawerList(
            title: 'Product Grid Show',
            icon: Icons.price_check,
            submitMethod: () => ProductGridScr()),
        CusDrawerList(
            title: 'CartPage',
            icon: Icons.price_check,
            submitMethod: () => CartPage()),
      ])),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                          // !P:- 1. CUSTOM DRAWER HEADER                         */
/* -------------------------------------------------------------------------- */
class CusDrawerHeader extends StatelessWidget {
  CusDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Image.asset(
                '',
                width: 130,
                height: 130,
              ),
            ),
          ),
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Rahul",
                  style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}

/* -------------------------------------------------------------------------- */
/*               // ! P:-2. CUSTOM DRAWER LIST VIEW DATA                     */
/* -------------------------------------------------------------------------- */

class CusDrawerList extends StatelessWidget {
  dynamic submitMethod;

  String title;
  IconData icon;

  CusDrawerList({
    Key? key,
    required this.title,
    required this.icon,
    this.submitMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return submitMethod();
          }));
        },
        child: ListTile(
          title: Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          leading: Icon(icon),
        ));
  }
}
