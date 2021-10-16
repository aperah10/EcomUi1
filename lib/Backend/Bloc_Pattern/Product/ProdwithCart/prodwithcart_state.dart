part of 'prodwithcart_bloc.dart';

abstract class ProdwithcartState extends Equatable {
  const ProdwithcartState();

  @override
  List<Object> get props => [];
}

class ProdwithcartInitial extends ProdwithcartState {}

// ! STATE ADDED FOR PRODUCT DATA $ CART DATA
class ProductCartLoadingState extends ProdwithcartState {
  @override
  List<Object> get props => [];
}

class ProductCartLoadedState extends ProdwithcartState {
  List<ProductC> productData;
  List<NewCart>? cartData;

  ProductCartLoadedState({
    required this.productData,
    this.cartData,
  });

  @override
  List<Object> get props => [];
}

class ProductCartErrorState extends ProdwithcartState {
  String message;
  ProductCartErrorState({required this.message});
  @override
  List<Object> get props => [];
}

/* -------------------------------------------------------------------------- */
/*                        // ! CART STATE WITH PRODUCT                        */
/* -------------------------------------------------------------------------- */

class ProdAddingCartState extends ProdwithcartState {
  MainCart? cartData;
  List<NewCart> cartItems;

  ProdAddingCartState({this.cartData, required this.cartItems});
}

class ProdAddedCartState extends ProdwithcartState {
  List<NewCart> cartItems;

  ProdAddedCartState({required this.cartItems});
  @override
  List<Object> get props => [];
}

class ProdDeletingCartState extends ProdwithcartState {
  List<NewCart> cartItems;

  ProdDeletingCartState({required this.cartItems});
  @override
  List<Object> get props => [];
}
