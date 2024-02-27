import 'package:app_salud/api/request_handler.dart';
import 'package:app_salud/core/constants/box_constants.dart';
import 'package:app_salud/core/db/database_helper.dart';
import 'package:app_salud/features/home/models/user_health.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert' as convert;

final homeServiceProvider = Provider<HomeService>(HomeServiceImpl.fromRef);

abstract class HomeService {
  Future<Either<String, UserHealth>> getInformationHealth(int userId);
  Future<void> saveData(Map<String, dynamic> data);
  Future<Either<String, UserHealth>> getData();
}

class HomeServiceImpl implements HomeService {
  HomeServiceImpl({
    required this.client,
    required this.dbHelper,
  });

  factory HomeServiceImpl.fromRef(Ref ref) {
    return HomeServiceImpl(
      client: ref.read(requestHandlerProvider),
      dbHelper: ref.read(dbHelperProvider),
    );
  }

  final RequestHandler client;
  final DataBaseHelper dbHelper;

  @override
  Future<Either<String, UserHealth>> getInformationHealth(int userId) async {
    try {
      final path = '/$userId';
      final res = await client.performGet(path);
      final data = convert.jsonDecode(res.body.trim()) as Map<String, dynamic>;
      await saveData(data);
      return Right(UserHealth.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> saveData(Map<String, dynamic> data) async {
    try {
      await dbHelper.put(
        key: DataBaseConstants.userHealth.key,
        data: data,
        boxName: DataBaseConstants.userHealth.boxName,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<String, UserHealth>> getData() async {
    try {
      final res = await dbHelper.getData(
        key: DataBaseConstants.userHealth.key,
        boxName: DataBaseConstants.userHealth.boxName,
      );
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
