import 'package:app_salud/api/request_handler.dart';
import 'package:app_salud/features/home/models/user_health.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert' as convert;

final homeServiceProvider = Provider<HomeService>(HomeServiceImpl.fromRef);

abstract class HomeService {
  Future<Either<String, UserHealth>> getInformationHealth(int userId);
}

class HomeServiceImpl implements HomeService {
  HomeServiceImpl({required this.client});

  factory HomeServiceImpl.fromRef(Ref ref) {
    return HomeServiceImpl(client: ref.read(requestHandlerProvider));
  }

  final RequestHandler client;

  @override
  Future<Either<String, UserHealth>> getInformationHealth(int userId) async {
    try {
      final path = '/$userId';
      final res = await client.performGet(path);
      final data = convert.jsonDecode(res.body.trim()) as Map<String, dynamic>;
      return Right(UserHealth.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
