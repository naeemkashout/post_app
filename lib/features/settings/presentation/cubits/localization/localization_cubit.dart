import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:post_app/core/cache/cache_helper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  void getSavedLanguage() {
    final cachedLanguageCode = CacheHelper.getCachedLanguageCode();
    emit(ChangeLocalState(locale: Locale(cachedLanguageCode)));
  }
  
  Future<void> changeLanguage(String languageCode) async {
    await CacheHelper.cacheLanguageCode(languageCode);
    emit(ChangeLocalState(locale: Locale(languageCode)));
  }
}
