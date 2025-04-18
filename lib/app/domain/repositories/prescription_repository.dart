import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/prescription_entity.dart';

abstract class PrescriptionRepository {
  Future<Either<Failure, PrescriptionEntity>> uploadPrescription({
    required String filePath,
    required String aboutImage,
    required String orderProductNames,
  });

  Future<Either<Failure, List<PrescriptionEntity>>> getPrescriptions();
}
