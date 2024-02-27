enum DataBaseConstants {
  userHealth(key: 'userHealthKey', boxName: 'userHealthBox');

  const DataBaseConstants({
    required this.key,
    required this.boxName,
  });
  final String key;
  final String boxName;
}
