import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:my_office_th_app/components/card_dummy_loading.dart';
import 'package:my_office_th_app/models/item.dart' as mi;
import 'package:my_office_th_app/models/item_stock.dart' as mis;
import 'package:my_office_th_app/screens/inventory/item_info_card.dart';
import 'package:my_office_th_app/screens/inventory/item_stock_card.dart';
import 'package:my_office_th_app/services/fetch_items.dart' as si;
import 'package:my_office_th_app/services/fetch_item_stock.dart' as si;

class ItemHomeListView extends StatefulWidget {
  final String itemStr;

  ItemHomeListView(this.itemStr);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemHomeListView();
  }
}

class _ItemHomeListView extends State<ItemHomeListView> {
  mi.Item item;
  List<mis.ItemStock> listItemStock = new List<mis.ItemStock>();
  bool itemFound = false;

  @override
  void initState() {
//    TODO: calling the fetch method to get the item's details
    si
        .fetchAnItem(http.Client(), widget.itemStr)
        .timeout(Duration(seconds: 15))
        .then((result) {
      setState(() {
        item = result;
        itemFound = true;
      });
    }, onError: (error) {
      print('fetchAnItem onError: $error');
    }).catchError((error) {
      print('fetchAnItem catchError: $error');
    });

//    TODO: calling the fetch method to get the item's stock
    si
        .fetchModelItemStock(http.Client(), widget.itemStr)
        .timeout(Duration(seconds: 15))
        .then((result) {
      setState(() {
//        result.map((i) => listItemStock.add(i));
        for (mis.ItemStock i in result) {
          this.listItemStock.add(i);
        }
      });
    }, onError: (error) {
      print('fetchModelItemStock onError: $error');
    }).catchError((error) {
      print('fetchModelItemStock catchError: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        itemFound ? ItemInfoCard(item) : CardDummyLoading(),
        listItemStock.length > 0 ? ItemStockCard(listItemStock) : CardDummyLoading(),
      ],
    );
  }
}
