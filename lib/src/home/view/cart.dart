// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_shopper/src/view.dart';

import 'package:mvc_shopper/src/model.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key key}) : super(key: key);
  @override
  State createState() => _MyCartState();
}

class _MyCartState extends StateMVC<MyCart> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Cart', style: Theme.of(context).textTheme.headline1),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.yellow,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: _CartList(this),
                ),
              ),
              const Divider(height: 4, color: Colors.black),
              _CartTotal()
            ],
          ),
        ),
      );
}

class _CartList extends StatelessWidget {
  _CartList(StateMVC state) : cart = CartModel(state);

  final CartModel cart;

  @override
  Widget build(BuildContext context) =>
      // This gets the current state of CartModel and also tells Flutter
      // to rebuild this widget when CartModel notifies listeners (in other words,
      // when it changes).
//    final cart = context.watch<CartModel>();

      ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.done),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              cart.remove(cart.items[index]);
            },
          ),
          title: Text(
            cart.items[index].name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      );
}

class _CartTotal extends StatelessWidget {
  _CartTotal({Key key})
      : cart = CartModel(),
        super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 200,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // //  Another way to listen to a model's change is to include
              // //  the Consumer widget. This widget will automatically listen
              // //  to CartModel and rerun its builder on every change.
              // //
              // //  The important thing is that it will not rebuild
              // // the rest of the widgets in this build method.
              // Consumer<CartModel>(
              //     builder: (context, cart, child) =>
              //         Text('\$${cart.totalPrice}', style: hugeStyle)),
              Text('\$${cart.totalPrice}',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 48)),
              const SizedBox(width: 24),
              FlatButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                      content: Text('Buying not supported yet.')));
                },
                color: Colors.white,
                child: const Text('BUY'),
              ),
            ],
          ),
        ),
      );
}
