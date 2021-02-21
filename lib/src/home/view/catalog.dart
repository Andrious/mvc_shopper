// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_shopper/src/model.dart';

import 'package:mvc_shopper/src/view.dart';

import 'package:mvc_shopper/src/controller.dart';

class MyCatalog extends StatelessWidget {
  MyCatalog({Key key}) : super(key: key) {
    final cart = Cart();
    cart.catalog = CatalogModel();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _MyAppBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index),
              ),
            ),
          ],
        ),
      );
}

class _AddButton extends StatefulWidget {
  const _AddButton({Key key, @required this.item}) : super(key: key);
  final Item item;
  @override
  State createState() => _AddButtonState();
}

class _AddButtonState extends StateMVC<_AddButton> {
  _AddButtonState() : super(Cart()) {
    cart = controller;
  }
  Cart cart;

  @override
  Widget build(BuildContext context) {
    // var isInCart = context.select<CartModel, bool>(
    //   // Here, we are only interested whether [item] is inside the cart.
    //       (cart) => cart.items.contains(item),
    // );
    //
    // return FlatButton(
    //   onPressed: isInCart
    //       ? null
    //       : () {
    //     // If the item is not in cart, we let the user add it.
    //     // We are using context.read() here because the callback
    //     // is executed whenever the user taps the button. In other
    //     // words, it is executed outside the build method.
    //     var cart = context.read<CartModel>();
    //     cart.add(item);
    //   },
    //   splashColor: Theme.of(context).primaryColor,
    //   child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('ADD'),
    // );

    //
    final isInCart = cart.items.contains(widget.item);

    return FlatButton(
      onPressed: isInCart ? null : () => cart.add(widget.item, this),
      splashColor: Theme.of(context).primaryColor,
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverAppBar(
        title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
        floating: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      );
}

class _MyListItem extends StatelessWidget {
  _MyListItem(this.index, {Key key})
      : catalog = CatalogModel(),
        super(key: key);

  final int index;
  final CatalogModel catalog;

  @override
  Widget build(BuildContext context) {
    //
    final item = catalog.getByPosition(index);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child:
                  Text(item.name, style: Theme.of(context).textTheme.headline6),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
