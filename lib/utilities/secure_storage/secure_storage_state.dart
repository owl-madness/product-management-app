abstract class SecureStorageState {}

class DataStoredState extends SecureStorageState {}

class DataRetrievedState extends SecureStorageState {
  final String? value;

  DataRetrievedState(this.value);
}
