import 'package:app_salud/api/request_handler.dart';
import 'package:app_salud/core/constants/constants.dart';
import 'package:app_salud/core/db/database_helper.dart';
import 'package:app_salud/features/home/models/user_health.dart';
import 'package:app_salud/features/home/services/home_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert' as convert;

import 'home_service_test.mocks.dart';

@GenerateMocks([RequestHandler, DataBaseHelper])
void main() {
  final client = MockRequestHandler();
  final dbHepler = MockDataBaseHelper();

  final service = HomeServiceImpl(
    client: client,
    dbHelper: dbHepler,
  );

  group('HomeService testing', () {
    // test('getInformationHealth test', () async {
    //   final userId = Constants.userId;
    //   final path = '/$userId';
    //   final response = Response(
    //     '{"name":"Sebastian Beltran","stepsCounter":3992,"stepsGoal":4500,"caloriesGoal":1800,"caloriesCounter":1200,"waterGoal":10,"waterCounter":6,"heartRate":95}';
    //     202,
    //   );
    //   final data = convert.jsonDecode(response.body.trim()) as Map<String, dynamic>;
    //   final res = UserHealth.fromJson(data);
    //   when(client.performGet(path)).thenAnswer((_)async => response);

    //    final  responseClient = await service.getInformationHealth(userId);

    // });
  });
}
