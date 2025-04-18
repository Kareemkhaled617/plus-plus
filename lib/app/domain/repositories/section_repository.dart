import 'package:dartz/dartz.dart';
import '../entities/section_entity.dart';
import '../../core/errors/failure.dart';

abstract class SectionRepository {
  Future<Either<Failure, List<SectionEntity>>> getSections();
}
