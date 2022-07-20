import 'package:im_good_test_app/core/domain/models/i_serializable.dart';

abstract class CacheRepository {
  Future<String?> getValueFromCache<T>(int id);
  Future<List<String>?> getValuesFromCache<T>(int id);

  Future<bool> putValueToCache<T extends ISerializible>(int id, T value);
  Future<bool> putValuesToCache<T extends ISerializible>(List<T> values);
}
