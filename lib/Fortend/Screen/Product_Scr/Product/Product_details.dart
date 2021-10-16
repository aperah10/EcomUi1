import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uiecom/Backend/Bloc_Pattern/Product/ProdwithCart/prodwithcart_bloc.dart';
import 'package:uiecom/Fortend/Screen/Authr_Scr/HomeScr.dart';
import 'package:uiecom/Fortend/Widget/Appbar/CusAppbar.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Btn.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Text_C.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Image_C.dart';

class ProductDetailScr extends StatelessWidget {
  dynamic prodNumber;
  List? cartNumber;
  static final String routeName = "/product-details";
  ProductDetailScr({Key? key, this.prodNumber, this.cartNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProdwithcartBloc, ProdwithcartState>(
      listener: (context, state) {},
      child: BlocBuilder<ProdwithcartBloc, ProdwithcartState>(
          builder: (context, state) {
        if (state is ProdAddingCartState) {
          // cartItems = state.cartItems;
        }
        return Scaffold(
          appBar: CustomAppBar(
            titleName: 'Account Page',
          ),
          body: SafeArea(
              bottom: false,
              left: true,
              right: true,
              top: false,
              child: ProductDetailOne(
                prodNumber: prodNumber,
                cartNumber: cartNumber,
              )),
        );
      }),
    );
  }
}

class ProductDetailOne extends StatelessWidget {
  dynamic prodNumber;
  List? cartNumber;
  ProductDetailOne({Key? key, this.prodNumber, this.cartNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(' this is ProductAdded :- $prodNumber');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // fit: StackFit.expand,
        children: <Widget>[
          // ! 1. PRODUCT PIC
          SinglePic(
            prodNumber.pic == null ? '' : prodNumber.pic,
          ),

          // ! 2.  TITLE
          TxtTitle('Title'),
          TxtContent(
            prodNumber.discountPrice.toString(),
          ),
          // // ! 2.1 DROPDOWN_MENU_ITEM
          TxtTitle('Varitaion'),
          // DropDownBtn(),

          // ! 3.  DESCRIPTION
          TxtTitle("Description"),
          TxtContent(
            prodNumber.description,
          ),
          TxtTitle("Description"),
          TxtContent(
            prodNumber.description,
          ),
          TxtTitle("Description"),
          TxtContent(
            prodNumber.description,
          ),
          TxtTitle("Description"),
          TxtContent(
            prodNumber.description,
          ),
          // ! 4. RATINGS , Reviews , Comments .......
          // InformationBtn(),
          // ! 5. BUTTONS FOR CART AND BUYNOW
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            FBtn(
                cartNumber!.any((e) => e.product!.id!
                            .contains(prodNumber.id.toString())) ==
                        false
                    ? 'Add to Cart'
                    : 'Go to Cart', submitMethod: () {
              // ! PRODUCT DOES'NT EXIST IN CART
              if (cartNumber!.any((e) =>
                      e.product!.id!.contains(prodNumber.id.toString())) ==
                  false) {
                BlocProvider.of<ProdwithcartBloc>(context)
                  ..add(ProdAddedCartEvent(
                      productId: prodNumber.id, quantity: 1));
              } // ! PRODUCT  EXIST IN CART
              else {
                Navigator.of(context).pushReplacementNamed(HomeScr.routeName);
              }
            }),
            FBtn(
              'BuyNow',
            ),
          ])
        ],
      ),
    );
  }
}
