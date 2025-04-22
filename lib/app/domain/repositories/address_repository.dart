import '../../core/errors/failure.dart';
import '../entities/address_entity.dart';

import 'package:dartz/dartz.dart';

import '../entities/default_address_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
  Future<Either<Failure, DefaultAddressEntity>> getDefaultAddress();

}
