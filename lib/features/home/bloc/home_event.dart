import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class HomeEvent {}

class InitDataFetchEvent extends HomeEvent {}

class OnProductAddEvent extends HomeEvent {
  String productName;
  double productPrice;
  int productMeasurement;
  OnProductAddEvent(
      {required this.productMeasurement,
      required this.productName,
      required this.productPrice});
}

class OnProductTappedEvent extends HomeEvent {
  QueryDocumentSnapshot product;
  OnProductTappedEvent({required this.product});
}

class OnProfileTappedEvent extends HomeEvent {
  BuildContext context;
  OnProfileTappedEvent({required this.context});
}

class OnSearchEvent extends HomeEvent {
  String keyword;
  OnSearchEvent({required this.keyword});
}
