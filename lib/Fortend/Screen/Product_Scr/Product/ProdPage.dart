import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Product/ProdwithCart/prodwithcart_bloc.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Image_C.dart';

class ProductDetailTwoPage extends StatelessWidget {
  dynamic prodNumber;
  List? cartNumber;
  static final String routeName =
      "lib/src/pages/ecommerce/ecommerce_detail2.dart";

  ProductDetailTwoPage({Key? key, this.prodNumber, this.cartNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProdwithcartBloc, ProdwithcartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  // ! 1. PRODUCT PIC
                  SinglePic(
                    prodNumber.pic == null ? '' : prodNumber.pic,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: buildDropdownButton(
                                ['Black', 'Blue', 'Red'], 'Black')),
                        Expanded(
                            child: buildDropdownButton(
                                ['S', 'M', 'XL', 'XXL'], 'XXL')),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                    child: Text(
                      prodNumber.title,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                          ),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("5.0 stars",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14.0))
                        ],
                      )),
                      Text(prodNumber.salesPrice.toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30.0,
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text("Description",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400))),
                  Container(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    child: Text(
                      prodNumber.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppBar(
                    iconTheme: IconThemeData(color: Colors.black),
                    brightness: Brightness.light,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      "Back to Shopping",
                      style: TextStyle(color: Colors.black),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: Colors.deepOrange,
                          elevation: 0,
                          onPressed: () {},
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Buy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.black54,
                          elevation: 0,
                          onPressed: () {},
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Add a bag",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildDropdownButton(List<String> items, String selectedValue) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedValue,
      onChanged: (_) {},
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
