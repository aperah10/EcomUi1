import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uiecom/Backend/Models/Cart/New_Cartm.dart';
import 'package:uiecom/Backend/Respo/RCLS/Cart/CartRespo.dart';

part 'cartp_event.dart';
part 'cartp_state.dart';

class CartpBloc extends Bloc<CartpEvent, CartpState> {
  // ! Adding Repo for data logic
  CartDataRespo cartRespo = CartDataRespo();
  // AddressDataRespo addRespo = AddressDataRespo();

  CartpBloc() : super(CartpInitial());

  @override
  Stream<CartpState> mapEventToState(
    CartpEvent event,
  ) async* {
    if (event is FetchCartEvent) {
      yield CartLoadingState();
      try {
        // List<Address> addressData = await addRespo.getAddressData();
        List<NewCart> cartData = await cartRespo.getCartData();

        yield CartLoadedState(
          cartData: cartData,
        );
      } catch (e) {
        yield CartErrorState(message: e.toString());
      }
    }

    /* -------------------------------------------------------------------------- */
    /*                  // ! CART ADDED , ADDING  , DELETING BLOC                 */
    /* -------------------------------------------------------------------------- */
    if (event is ItemAddingCartEvent) {
      yield ItemAddingCartState(cartItems: event.cartItems);
    }

    if (event is ItemAddedCartEvent) {
      List<NewCart> prodList = await cartRespo.addCartData(
          productId: event.productId, quantity: event.quantity);
      yield ItemAddedCartState(cartItems: prodList);
    }

    if (event is UpQuanEvent) {
      List<NewCart> prodList = await cartRespo.upQuan(
          productId: event.productId, quantity: event.quantity);
      yield UpQuanState(cartItems: prodList);
    }

    /* -------------------------------------------------------------------------- */
    /*                           // ! CART ITEM DELTING                           */
    /* -------------------------------------------------------------------------- */
    if (event is ItemDeleteCartEvent) {
      List<NewCart> prodList = await cartRespo.delCartData(
        productId: event.productId,
      );

      yield ItemDeletingCartState(cartItems: prodList);
    }
  }
}
