part of 'orderpage_bloc.dart';

abstract class OrderpageEvent extends Equatable {
  const OrderpageEvent();

  @override
  List<Object> get props => [];
}

class OrderBtnPressed extends OrderpageEvent {
  final String address;
  final String product;
  int? quantity;

  OrderBtnPressed(
      {required this.address, required this.product, this.quantity});

  @override
  List<Object> get props => [product, address];

  @override
  String toString() =>
      'OrderBtnPressed { username: $product, password: $address }';
}

/* -------------------------------------------------------------------------- */
/*                       // ! ORDER BUTTON FOR CART PAGE                      */
/* -------------------------------------------------------------------------- */
class OrderBtnCart extends OrderpageEvent {
  final String address;
  final List product;
  int? quantity;

  OrderBtnCart({required this.address, required this.product, this.quantity});

  @override
  List<Object> get props => [product, address];

  @override
  String toString() =>
      'OrderBtnPressed { username: $product, password: $address }';
}
