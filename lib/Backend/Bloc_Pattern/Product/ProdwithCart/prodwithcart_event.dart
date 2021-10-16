part of 'prodwithcart_bloc.dart';

abstract class ProdwithcartEvent extends Equatable {
  ProdwithcartEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchProductEvent extends ProdwithcartEvent {
  @override
  List<Object> get props => [];
}
/* -------------------------------------------------------------------------- */
/*                        // ! CART EVETNS WITH PRODUCT                       */
/* -------------------------------------------------------------------------- */

class ProdAddingCartEvent extends ProdwithcartEvent {
  List<NewCart> cartItems;

  ProdAddingCartEvent({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class ProdAddedCartEvent extends ProdwithcartEvent {
  final String productId;
  final dynamic quantity;

  ProdAddedCartEvent({required this.productId, this.quantity = 1});
  @override
  List<Object> get props => [];
}

class ProdDeleteCartEvent extends ProdwithcartEvent {
  final String productId;

  ProdDeleteCartEvent({required this.productId});
  @override
  List<Object> get props => [productId];
}
