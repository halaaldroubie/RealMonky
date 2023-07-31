import 'package:food_ordering_sp1/core/translation/languages/ar_language.dart';
import 'package:food_ordering_sp1/core/translation/languages/en_language.dart';
import 'package:food_ordering_sp1/core/translation/languages/tr_language.dart';
import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': ENLanguage.map,
        'ar_SA': ARLanguage.map,
        'tr_TR': TRLanguage.map
      };
}

tr(String key) => key.tr;
