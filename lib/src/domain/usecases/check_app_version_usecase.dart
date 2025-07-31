import '../entities/app_version_entity.dart';
import '../repositories/app_version_repository.dart';

class CheckAppVersionUseCase {
  final AppVersionRepository repository;

  CheckAppVersionUseCase(this.repository);

  Future<AppVersionEntity> call() async {
    return await repository.fetchAppVersion();
  }
}
