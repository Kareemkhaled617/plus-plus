import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/prescription_entity.dart';
import '../repositories/prescription_repository.dart';

class GetPrescriptionsUseCase {
  final PrescriptionRepository repository;

  GetPrescriptionsUseCase(this.repository);

  Future<Either<Failure, List<PrescriptionEntity>>> call() {
    return repository.getPrescriptions();
  }
}
