// import 'dart:async';
// import 'package:rxdart/rxdart.dart';
import 'package:fbpidi/models/product.dart';

class CartBloc extends Object {
  List<Product> cart = [];

  // Stream<List<Product>> get cart => _cart.stream;

  // // change data
  // Function(List<Product>) get updateCart => _cart.sink.add;

  // List<Product> get getCart => _cart.value;

  submit() async {}

  dispose() {
    // _cart.close();
  }
}
