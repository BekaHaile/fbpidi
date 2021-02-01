import 'package:flutter/material.dart';
import './cart_bloc.dart';

class CartProvider extends InheritedWidget {
  final bloc = CartBloc();

  CartProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CartBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CartProvider>()).bloc;
  }
}