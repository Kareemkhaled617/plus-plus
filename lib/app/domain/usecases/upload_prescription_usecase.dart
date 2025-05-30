import 'package:dartz/dartz.dart';
import '../entities/prescription_entity.dart';
import '../repositories/prescription_repository.dart';
import '../../core/errors/failure.dart';

class UploadPrescriptionUseCase {
  final PrescriptionRepository repository;

  UploadPrescriptionUseCase(this.repository);

  Future<Either<Failure, PrescriptionEntity>> call({
    required String filePath,
    required String filetype,
    required String aboutImage,
    required String orderProductNames,
  }) {
    return repository.uploadPrescription(
      filePath: filePath,
      filetype: filetype,
      aboutImage: aboutImage,
      orderProductNames: orderProductNames,
    );
  }
}
