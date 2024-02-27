// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final requestHandlerProvider = Provider<RequestHandler>(RequestHandlerImpl.new);

abstract class RequestHandler {
  Future<Response> performGet(String path);
}

class RequestHandlerImpl extends RequestHandler {
  RequestHandlerImpl(this.ref);

  final Ref ref;
  @override
  Future<Response> performGet(String path) async {
    try {
      final res = await http.get(
        _apiURL(path),
        headers: headers,
      );
      return res;
    } catch (e) {
      print('ERROR');
      print(e.toString());
      rethrow;
    }
  }

  Uri _apiURL(String path) {
    return Uri.parse('$basePath$path');
  }

  final String basePath = 'https://fitness-backend-8iy6.onrender.com/api/user-info';

  final headers = <String, String>{
    'Accept': 'application/json',
  };
}
