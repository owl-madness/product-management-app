abstract class SecureStorageEvent {}

class StoreDataEvent extends SecureStorageEvent {
  final String key;
  final String value;

  StoreDataEvent(this.key, this.value);
}

class RetrieveDataEvent extends SecureStorageEvent {
  final String key;

  RetrieveDataEvent(this.key);
}
