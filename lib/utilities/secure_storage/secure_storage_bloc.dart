import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'secure_storage_event.dart';
import 'secure_storage_state.dart';

class SecureStorageBloc extends Bloc<SecureStorageEvent, SecureStorageState> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  SecureStorageBloc() : super(DataStoredState());

  @override
  Stream<SecureStorageState> mapEventToState(SecureStorageEvent event) async* {
    if (event is StoreDataEvent) {
      yield* _mapStoreDataEventToState(event);
    } else if (event is RetrieveDataEvent) {
      yield* _mapRetrieveDataEventToState(event);
    }
  }

  Stream<SecureStorageState> _mapStoreDataEventToState(StoreDataEvent event) async* {
    try {
      await secureStorage.write(key: event.key, value: event.value);
      yield DataStoredState();
    } catch (e) {
      // Handle error
      print('Error storing data: $e');
    }
  }

  Stream<SecureStorageState> _mapRetrieveDataEventToState(RetrieveDataEvent event) async* {
    try {
      final value = await secureStorage.read(key: event.key);
      yield DataRetrievedState(value);
    } catch (e) {
      // Handle error
      print('Error retrieving data: $e');
    }
  }
}
