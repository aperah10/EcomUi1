import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:uiecom/Backend/Models/Cart/New_Cartm.dart';
import 'package:uiecom/Backend/Models/Product/New_Product_m.dart';
import 'package:uiecom/Backend/Models/Prof_Address/Addressm.dart';
import 'package:uiecom/Backend/Respo/Product/ProdRespo.dart';
import 'package:uiecom/Backend/Respo/Prof_Address/AddressRespo.dart';
import 'package:uiecom/Backend/Respo/RCLS/Cart/CartRespo.dart';

part 'prodwithcart_event.dart';
part 'prodwithcart_state.dart';

class ProdwithcartBloc extends Bloc<ProdwithcartEvent, ProdwithcartState> {
  // ! Adding Repo for data logic
  CartDataRespo cartRespo = CartDataRespo();
  ProductDataRespo prodRespo = ProductDataRespo();
  AddressDataRespo adrRespo = AddressDataRespo();

  ProdwithcartBloc() : super(ProdwithcartInitial());

  @override
  Stream<ProdwithcartState> mapEventToState(
    ProdwithcartEvent event,
  ) async* {
    // ! FIRST STATE /EVENT FOR FETECH DATA
    if (event is FetchProductEvent) {
      yield ProductCartLoadingState();

      try {
        List<ProductC> productData = await prodRespo.getProduct();
        List<NewCart> cartData = await cartRespo.getCartData();
        List<Address> adrData = await adrRespo.getAddressData();

        yield ProductCartLoadedState(
          productData: productData,
          cartData: cartData,
          adrData: adrData,
        );
      } catch (e) {
        yield ProductCartErrorState(message: e.toString());
      }
    }

    /* -------------------------------------------------------------------------- */
    /*                  // ! CART ADDED , ADDING  , DELETING BLOC                 */
    /* -------------------------------------------------------------------------- */
    if (event is ProdAddingCartEvent) {
      yield ProdAddingCartState(cartItems: event.cartItems);
    }

    if (event is ProdAddedCartEvent) {
      List<NewCart> prodList = await cartRespo.addCartData(
          productId: event.productId, quantity: event.quantity);

      yield ProdAddedCartState(cartItems: prodList);
    }
    if (event is ProdDeleteCartEvent) {
      List<NewCart> prodList = await cartRespo.delCartData(
        productId: event.productId,
      );

      yield ProdDeletingCartState(cartItems: prodList);
    }
  }
}
