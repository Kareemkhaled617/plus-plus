import '../repositories/account_repository.dart';

class UpdateAccountUseCase {
  final AccountRepository repository;

  UpdateAccountUseCase(this.repository);

  Future<bool> call(String name) {
    return repository.updateAccount(name);
  }
}
