import 'package:dartz/dartz.dart';
import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../models/address_model.dart';

class AddressRepositoryImpl implements AddressRepository {
  final ApiService apiService;

  AddressRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() async {
    try {
      final response = await apiService.getRequest('/addresses');
      if (response.success) {
        final List addressList = response.data['data'];
        final addresses =
            addressList.map((item) => AddressModel.fromJson(item)).toList();
        return Right(addresses);
      } else {
        return Left(Failure(response.message ?? "Failed to fetch addresses"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error occurred"));
    }
  }
}
