import 'dart:convert';

import 'package:im_good_test_app/core/domain/models/album.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/models/photo.dart';
import 'package:im_good_test_app/core/domain/models/post.dart';
import 'package:im_good_test_app/core/domain/models/i_serializable.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';
import 'package:im_good_test_app/core/domain/repositories/cache_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheRepositoryImpl implements CacheRepository {
  @override
  Future<T?> getValueFromCache<T>({
    required int id,
    required String key,
    required T Function(String json) mapper,
  }) async {
    final data = await getValuesFromCache(key: key, mapper: mapper);
    if (data == null) return null;

    if (data.length > id) {
      return data.elementAt(id);
    }

    return null;
  }

  @override
  Future<List<T>?> getValuesFromCache<T>(
      {required String key, required T Function(String json) mapper}) async {
    final prefs = await _getPrefs();
    return prefs.getStringList(key)?.map((e) => mapper(e)).toList();
  }

  @override
  Future<bool> putValueToCache<T extends ISerializible>(
    String key,
    T value,
  ) async {
    final prefs = await _getPrefs();
    final serialized = jsonEncode(value.toMap());
    final cachedData = prefs.getStringList(key);

    if (cachedData == null) {
      return prefs.setStringList(key, [serialized]);
    }

    cachedData.add(jsonEncode(value.toMap()));

    return prefs.setStringList(key, cachedData);
  }

  @override
  Future<bool> putValuesToCache<T extends ISerializible>(
      {required String key, required List<T> values}) async {
    final prefs = await _getPrefs();
    final serialized = values.map((e) => jsonEncode(e.toMap())).toList();

    return prefs.setStringList(key, serialized);
  }

  Future<SharedPreferences> _getPrefs() {
    return SharedPreferences.getInstance();
  }
}
