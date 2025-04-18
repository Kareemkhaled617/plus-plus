import '../../core/errors/failure.dart';
import '../entities/address_entity.dart';

import 'package:dartz/dartz.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
}
