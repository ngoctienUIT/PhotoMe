abstract class SettingState {}

class InitState extends SettingState {}

class LoadingState extends SettingState {}

class SuccessState extends SettingState {}

class ErrorState extends SettingState {
  String error;

  ErrorState(this.error);
}
