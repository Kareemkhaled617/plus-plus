import '../repositories/account_repository.dart';

class ChangeLanguageUseCase {
  final AccountRepository repository;

  ChangeLanguageUseCase(this.repository);

  Future<bool> call(String locale) {
    return repository.changeLanguage(locale);
  }
}
