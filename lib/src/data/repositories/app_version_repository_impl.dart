import 'package:getx_clean_architecture_boilerplate/src/domain/entities/app_version_entity.dart';
import 'package:getx_clean_architecture_boilerplate/src/domain/repositories/app_version_repository.dart';

class AppVersionRepositoryImpl implements AppVersionRepository {
  @override
  Future<AppVersionEntity> fetchAppVersion() async {
    try {
      // Uncomment the following lines to use the real API call
      // final response = await Dio().get('https://api.example.com/app-version');
      // return AppVersionEntity(
      //   currentAppVersion: response.data['currentAppVersion'],
      //   minimumAppVersion: response.data['minimumAppVersion'],
      // );

      // Simulate an API call
      await Future.delayed(const Duration(seconds: 2));
      return AppVersionEntity(currentAppVersion: 3, minimumAppVersion: 1);
    } catch (e) {
      throw Exception('Failed to fetch app version: $e');
    }
  }
}
