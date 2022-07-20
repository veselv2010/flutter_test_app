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
  Future<String?> getValueFromCache<T>(int id) async {
    final prefs = await _getPrefs();
    final cachedData = prefs.getStringList(_getKeyFromType<T>());

    if (cachedData == null) {
      return null;
    }

    if (cachedData.length > id) {
      return cachedData.elementAt(id);
    }

    return null;
  }

  @override
  Future<List<String>?> getValuesFromCache<T>(int id) async {
    final prefs = await _getPrefs();

    return prefs.getStringList(_getKeyFromType<T>());
  }

  @override
  Future<bool> putValueToCache<T extends ISerializible>(int id, T value) async {
    final prefs = await _getPrefs();
    final serialized = jsonEncode(value.toMap());
    final cachedData = prefs.getStringList(_getKeyFromType<T>());

    if (cachedData == null) {
      return prefs.setStringList(_getKeyFromType<T>(), [serialized]);
    }

    if (cachedData.length < id) {
      cachedData.add(serialized);
    } else {
      cachedData[id] = serialized;
    }

    return prefs.setStringList(_getKeyFromType<T>(), cachedData);
  }

  @override
  Future<bool> putValuesToCache<T extends ISerializible>(List<T> values) async {
    final prefs = await _getPrefs();
    final serialized = values.map((e) => jsonEncode(e.toMap())).toList();

    return prefs.setStringList(_getKeyFromType<T>(), serialized);
  }

  Future<SharedPreferences> _getPrefs() {
    return SharedPreferences.getInstance();
  }

  String _getKeyFromType<T>() {
    switch (T) {
      case User:
        return 'users';
      case Comment:
        return 'comments';
      case Album:
        return 'albums';
      case Post:
        return 'posts';
      case Photo:
        return 'photo';
      default:
        throw UnsupportedError('Invalid type');
    }
  }
}
