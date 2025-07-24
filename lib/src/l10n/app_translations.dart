import 'package:get/get.dart';
import 'en_US.dart';
import 'bn_BD.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'bn_BD': bnBD,
  };
}
