import 'package:im_good_test_app/core/domain/models/i_serializable.dart';

abstract class CacheRepository {
  Future<T?> getValueFromCache<T>({
    required int id,
    required String key,
    required T Function(String json) mapper,
  });
  Future<List<T>?> getValuesFromCache<T>(
      {required String key, required T Function(String json) mapper});

  Future<bool> putValueToCache<T extends ISerializible>(String key, T value);
  Future<bool> putValuesToCache<T extends ISerializible>(
      {required String key, required List<T> values});
}
