import '../entities/app_version_entity.dart';

abstract class AppVersionRepository {
  Future<AppVersionEntity> fetchAppVersion();
}
