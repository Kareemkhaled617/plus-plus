// domain/usecases/get_default_address_usecase.dart
import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/address_entity.dart';
import '../entities/default_address_entity.dart';
import '../repositories/address_repository.dart';

class GetDefaultAddressUseCase {
  final AddressRepository repository;

  GetDefaultAddressUseCase(this.repository);

  Future<Either<Failure, DefaultAddressEntity>> call() async {
    return await repository.getDefaultAddress();
  }
}
