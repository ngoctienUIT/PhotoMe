abstract class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  bool isVN;

  ChangeLanguageEvent(this.isVN);
}

class SetUserID extends LanguageEvent {
  String? userID;

  SetUserID(this.userID);
}
