import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/tabs/orders_tab.dart';
import 'package:lojavirtual/tabs/places_tab.dart';
import 'package:lojavirtual/tabs/products_tab.dart';
import 'package:lojavirtual/widgets/cart_button.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Lojas'),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Meus Pedidos'),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}