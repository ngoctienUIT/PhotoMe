abstract class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  bool isVN;

  ChangeLanguageEvent(this.isVN);
}
