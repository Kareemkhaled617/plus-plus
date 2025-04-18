import 'package:dartz/dartz.dart';
import '../entities/section_entity.dart';
import '../repositories/section_repository.dart';
import '../../core/errors/failure.dart';

class GetSectionsUseCase {
  final SectionRepository repository;

  GetSectionsUseCase(this.repository);

  Future<Either<Failure, List<SectionEntity>>> call() {
    return repository.getSections();
  }
}
