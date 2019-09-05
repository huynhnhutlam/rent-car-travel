import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rent_car_travel/src/utils/application.dart';

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of (BuildContext context) {
    Translations translations = Localizations.of<Translations>(context, Translations);
    return translations;
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translation = new Translations(locale);
    String jsonContent = await rootBundle.loadString("lib/res/locales/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translation;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => applic.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => false;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overridenLocale;
  const SpecificLocalizationDelegate(this.overridenLocale);

  @override
  bool isSupported(Locale locale) => overridenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.load(overridenLocale == null ? locale : overridenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}