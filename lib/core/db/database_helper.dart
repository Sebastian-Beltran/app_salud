// ignore_for_file: avoid_print

import 'package:app_salud/core/constants/box_constants.dart';
import 'package:app_salud/features/home/models/user_health.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final dbHelperProvider = Provider<DataBaseHelper>((_) => DataBaseHelperImpl());

abstract class DataBaseHelper {
  Future<UserHealth> getData({required String key, required String boxName});
  Future<String?> put({required String key, required dynamic data, required String boxName});
}

class DataBaseHelperImpl implements DataBaseHelper {
  @override
  Future<UserHealth> getData({
    required String key,
    required String boxName,
  }) async {
    try {
      final box = await openBox(boxName: boxName);
      final res = await box.get(key);
      print(res);
      res as Map<dynamic, dynamic>;
      Map<String, dynamic> mapStringDynamic = res.map((key, value) {
        return MapEntry(key.toString(), value);
      });
      print(mapStringDynamic);
      return UserHealth.fromJson(mapStringDynamic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> put({
    required String key,
    required dynamic data,
    required String boxName,
  }) async {
    try {
      final box = await openBox(boxName: boxName);
      await box.put(key, data);
      print(box.get(DataBaseConstants.userHealth.key));

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<Box<dynamic>> openBox({required String boxName}) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        return Hive.box(boxName);
      }
      return await Hive.openBox(boxName);
    } catch (e) {
      rethrow;
    }
  }
}
