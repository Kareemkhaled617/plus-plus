import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/prescription_entity.dart';
import '../../domain/repositories/prescription_repository.dart';
import '../models/prescription_model.dart';

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final ApiService apiService;

  PrescriptionRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, PrescriptionEntity>> uploadPrescription({
    required String filePath,
    required String aboutImage,
    required String orderProductNames,
  }) async {
    final formData = filePath.isNotEmpty
        ? FormData.fromMap({
            'image': [
              await MultipartFile.fromFile(filePath,
                  filename: filePath.split('/').last)
            ],
            'about_image': aboutImage,
            'image_type': 'image',
            'order_product_names': orderProductNames,
          })
        : FormData.fromMap({
            'order_product_names': orderProductNames,
          });

    final response = await apiService.postFormDataRequest(
      'prescriptions',
      formData,
    );

    if (response.success) {
      final model = PrescriptionModel.fromJson(response.data['data']);

      return Right(model);
    } else {
      return Left(Failure(response.message ?? "Failed to upload prescription",
          statusCode: response.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<PrescriptionEntity>>> getPrescriptions() async {
    final response = await apiService.getRequest('prescriptions');

    if (response.success) {
      try {
        List<dynamic> data = response.data["data"];
        List<PrescriptionEntity> prescriptions =
            data.map((json) => PrescriptionModel.fromJson(json)).toList();
        return Right(prescriptions);
      } catch (e) {
        return Left(Failure("Failed to parse prescriptions: $e"));
      }
    } else {
      return Left(Failure(response.message ?? "Failed to fetch prescriptions",
          statusCode: response.statusCode));
    }
  }
}
