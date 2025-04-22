import 'package:dartz/dartz.dart';
import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/default_address_entity.dart' as dt;
import '../../domain/repositories/address_repository.dart';
import '../models/address_model.dart';
import '../models/default_address_model.dart' as df;

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

  @override
  Future<Either<Failure, dt.DefaultAddressEntity>> getDefaultAddress() async {
    try {
      final response =
          await apiService.postRequest('/account/default-address', {});
      if (response.success) {
        final data = df.DefaultAddressModel.fromJson(response.data['data']);
        return Right(data);
      } else {
        return Left(
            Failure(response.message ?? "Failed to fetch default address"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error occurred"));
    }
  }
}
