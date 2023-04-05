part of 'localization_cubit.dart';

abstract class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object> get props => [];
}

class LocalizationInitial extends LocalizationState {}

class ChangeLocalState extends LocalizationState {
  final Locale locale;
  const ChangeLocalState({required this.locale});
  @override
  List<Object> get props => [locale];
}

