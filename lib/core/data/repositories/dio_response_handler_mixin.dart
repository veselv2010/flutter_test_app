import 'dart:convert';

import 'package:dio/dio.dart';

mixin DioResponseHandlerMixin {
  List<T> handleGenericListReponse<T>(
      {required Response res, required T Function(String json) mapper}) {
    if (res.statusCode != 200) {
      return [];
    }

    final serialized = res.data as List;
    return serialized.map((e) => mapper(jsonEncode(e))).toList();
  }

  T? handleGenericReponse<T>(
      {required Response res, required T Function(String json) mapper}) {
    if (res.statusCode != 200) {
      return null;
    }

    final serialized = res.data as Map;
    return mapper(jsonEncode(serialized));
  }
}
