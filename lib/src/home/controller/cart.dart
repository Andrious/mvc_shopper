// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

//import 'package:flutter/foundation.dart';

import 'package:mvc_shopper/src/model.dart';

import 'package:mvc_shopper/src/view.dart';

import 'package:mvc_shopper/src/controller.dart';


class Cart extends ControllerMVC {
  Cart([StateMVC state]) : super(state);

  /// The static fields preserve the cart's content.

  /// The private field backing [catalog].
  static CatalogModel _catalog;

  /// Internal, private state of the cart. Stores the ids of each item.
  static final List<int> _itemIds = [];

  static final Map<int, StateMVC> _itemMaps = {};

  /// The current catalog. Used to construct items from numeric ids.
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    assert(_itemIds.every((id) => newCatalog.getById(id) != null),
        'The catalog $newCatalog does not have one of $_itemIds in it.');
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item, StateMVC state) {
    _itemIds.add(item.id);

    _itemMaps[item.id] = state;

    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);

    final state = _itemMaps.remove(item.id);

    state?.setState(() {});

    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}
