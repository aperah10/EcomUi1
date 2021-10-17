import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/AFile/Scr/Steper/myOrder.dart';
import 'package:uiecom/Backend/Bloc_Pattern/Product/ProdwithCart/prodwithcart_bloc.dart';
import 'package:uiecom/Fortend/Screen/Product_Scr/Cart/Cart.dart';
import 'package:uiecom/Fortend/Widget/Appbar/CusAppbar.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Btn.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Image_C.dart';

class ProductListScreens extends StatefulWidget {
  dynamic prodNumber;
  List? cartNumber;
  dynamic adrNumber;
  ProductListScreens(
      {Key? key, this.prodNumber, this.cartNumber, this.adrNumber});
  @override
  _ProductListScreensState createState() => _ProductListScreensState();
}

class _ProductListScreensState extends State<ProductListScreens> {
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //     appBar: CustomAppBar(titleName: 'Featured'),
        // body:
        Container(
            child: GridView.builder(
                itemCount: widget.prodNumber.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.60,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                itemBuilder: (context, index) {
                  return dataOfListView(prodNumber: widget.prodNumber[index]);
                }));
    // ));
  }

  dataOfListView({
    dynamic prodNumber,
  }) {
    return new Container(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        width: 160.0,
        child: Wrap(
          children: <Widget>[
            // ! PRODUCT PIC
            MultiplePic(prodNumber.pic == null ? '' : prodNumber.pic),

            ListTile(
              onTap: () {},
              title: Text(
                prodNumber.title,
                // title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                prodNumber.description,
                // subTitle,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FBtn(
                    widget.cartNumber!.any((e) => e.product!.id!
                                .contains(prodNumber.id.toString())) ==
                            false
                        ? 'acart'
                        : 'gcart',
                    submitMethod: () {
                      // // ! PRODUCT DOES'NT EXIST IN CART
                      if (widget.cartNumber!.any((e) => e.product!.id!
                              .contains(prodNumber.id.toString())) ==
                          false) {
                        BlocProvider.of<ProdwithcartBloc>(context)
                          ..add(ProdAddedCartEvent(
                              productId: prodNumber.id, quantity: 1));
                      } // ! PRODUCT  EXIST IN CART
                      else {
                        Navigator.of(context)
                            .pushReplacementNamed(CartScr.routeName);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: FBtn('Buy', submitMethod: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // ! add PRODUCT ITEM DEIALS
                                MyOrder(
                                    prodNumber: prodNumber,
                                    cartNumber: widget.cartNumber,
                                    adrNumber: widget.adrNumber)));
                  }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
