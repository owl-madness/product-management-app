import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/home/bloc/home_event.dart';
import 'package:product_management/features/home/bloc/home_state.dart';
import 'package:product_management/utilities/appconfigs.dart';
import 'package:product_management/utilities/secure_storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String keyword = '';
  Stream<QuerySnapshot<Map<String, dynamic>>> get products =>
      FirebaseFirestore.instance
          .collection("products")
          // .where('user_id', isEqualTo: AppConfig.userID)
          .snapshots();

  HomeBloc() : super(HomeRefreshDataState()) {
    on<InitDataFetchEvent>((event, emit) {
      emit(HomeInitState());
    });

    on<OnProductAddEvent>((event, emit) {
      FirebaseFirestore.instance.collection("products").add({
        "product_name": event.productName,
        "user_id": AppConfig.userID,
        "price": event.productPrice,
        "measurement": event.productMeasurement
      }).then((value) {
        debugPrint(value.id);
      }).catchError((error) {
        debugPrint(error);
      });
    });

    on<OnProductTappedEvent>((event, emit) {
      //navigate to product details screen
    });

    on<OnProfileTappedEvent>((event, emit) async {
      final pref = await SharedPreferences.getInstance();
      
        SecureStorageHelper secureStorageHelper = SecureStorageHelper();
      pref.setBool(AppConfig.loggedStateKey, false);
      pref.setBool(AppConfig.isPinGeneratedKey, false);
      secureStorageHelper.storeCredentials('');
      secureStorageHelper.storePin('');
      Navigator.pushNamedAndRemoveUntil(event.context, '/signin', (route) => false);
    });

    on<OnSearchEvent>((event, emit) {
      keyword = event.keyword.toLowerCase().trim();
      emit(HomeInitState());
    });
  }
}
