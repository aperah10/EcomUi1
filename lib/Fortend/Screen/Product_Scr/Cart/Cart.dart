import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/Backend/Bloc_Pattern/RCLS/Cart/cartp_bloc.dart';
import 'package:uiecom/Fortend/Widget/Appbar/CusAppbar.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Buttons_C.dart';
import 'package:uiecom/Fortend/Widget/Resuable%20Code/Form/Text_C.dart';

class CartScr extends StatefulWidget {
  static const routeName = '/cart-screens';
  CartScr({Key? key}) : super(key: key);

  @override
  _CartScrState createState() => _CartScrState();
}

class _CartScrState extends State<CartScr> {
  CartpBloc cartBloc = CartpBloc();

  // ! LOAD INIT STATE IS CART PAGE
  @override
  void initState() {
    cartBloc = BlocProvider.of<CartpBloc>(context);
    cartBloc.add(FetchCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartpBloc, CartpState>(listener: (context, state) {
      if (state is ItemDeletingCartState) {
        Navigator.of(context).pushReplacementNamed(CartScr.routeName);
      }
      if (state is UpQuanState) {
        Navigator.of(context).pushReplacementNamed(CartScr.routeName);
      }
    }, builder: (context, state) {
      if (state is CartLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is CartErrorState) {
        return Center(child: Text(' this is eror ${state.message}'));
      }
      if (state is CartLoadedState) {
        return CartScrOne(cartData: state.cartData, adrData: state.addressData);
      }
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

/* -------------------------------------------------------------------------- */
/*                              // ! CART SCREEN                              */
/* -------------------------------------------------------------------------- */

class CartScrOne extends StatelessWidget {
  dynamic cartData;
  dynamic adrData;
  CartScrOne({
    Key? key,
    this.cartData,
    this.adrData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleName: 'Cart'),
      body: SafeArea(
          child: cartData.isNotEmpty
              ? Container(
                  child: Column(children: <Widget>[
                  // ! LISTVIEW BUIDER
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CartListScr(cartNumber: cartData[index]),
                              Text('5000')
                            ],
                          );
                          // return ProductShowList(prodNumber: cartData[index]);
                          // return ListdataScreen(productNumber: cartData[index]);
                        }),
                  ),
                  // // ! CHECKOUT BTN
                  // CartCheckBtn(adrData: adrData, cartData: cartData)
                ]))
              : Center(child: Text('No product in Cart'))),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            // ! CHECKOUT SCREEN                            */
/* -------------------------------------------------------------------------- */
class CartCheckBtn extends StatelessWidget {
  dynamic adrData;
  dynamic cartData;
  CartCheckBtn({Key? key, this.adrData, this.cartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black12,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // ! TOATAL PRICE DATA
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Ammount",
                    ),
                    Spacer(),
                    Text('5000'),
                  ],
                ),
              ),
              //  ! 2
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Checkout Price:",
                    ),
                    Spacer(),
                    Text(
                      "Rs. 5000",
                    ),
                  ],
                ),
              ),

              // ! CHECKOUT BTN
              SingleBtn("Continue", submitMethod: () {}
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             // ! add PRODUCT ITEM DEIALS
                  //             OrderWithCart(
                  //                 adrState: adrData, cartState: cartData)));

                  )
            ]));
  }
}

/* -------------------------------------------------------------------------- */
/*                            // !CART LIST SCREEN                            */
/* -------------------------------------------------------------------------- */
class CartListScr extends StatelessWidget {
  dynamic cartNumber;
  CartListScr({Key? key, this.cartNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: <Widget>[
        // ! 1  Product PIC

        Container(
          width: 100,
          height: 100,
          child: Image.network(
            cartNumber.product.pic == null ? '' : cartNumber.product.pic,
            width: 30.0,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),

        // !2. CART DATA
        Flexible(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: <Widget>[
                  // ! 2.1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TxtTitle(cartNumber.product.title),
                      ),
                      // ! 2.1.1
                      InkWell(
                        onTap: () {
                          // ! CART ITEM DELETE
                          BlocProvider.of<CartpBloc>(context)
                            ..add(ItemDeleteCartEvent(
                                productId: cartNumber.id.toString()));

                          // ! END CART ITEM METHOD
                        },
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                  // ! 2.2 data
                  Row(
                    children: [
                      TxtTitle("Price: "),
                      SizedBox(
                        width: 5,
                      ),
                      SubTxtTitle(cartNumber.disPrice.toString()),
                    ],
                  ),
                  // ! 2.3 DATA

                  Row(
                    children: <Widget>[
                      TxtTitle("Sub Total: "),
                      SizedBox(
                        width: 5,
                      ),
                      SubTxtTitle(
                        'Rs ${cartNumber.totalAmmount}',
                      )
                    ],
                  ),

                  // ! 2.4 DATA

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.remove),
                        onTap: () {
                          if (cartNumber.quantity > 1) {
                            BlocProvider.of<CartpBloc>(context)
                              ..add(UpQuanEvent(
                                  quantity: cartNumber.quantity - 1,
                                  productId: cartNumber.id.toString()));
                          }
                        },
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      // ! ITEM DATA
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(cartNumber.quantity.toString()),
                        ),
                      ),
                      // ! END ITEM DATA
                      SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        child: Icon(Icons.add),
                        onTap: () {
                          // ! CART ITEM ADDDED
                          BlocProvider.of<CartpBloc>(context)
                            ..add(UpQuanEvent(
                                quantity: cartNumber.quantity + 1,
                                productId: cartNumber.id.toString()));

                          // ! END CART ITEM METHOD
                        },
                      ),
                    ],
                  )
                ])))
      ]),
    );
  }
}
