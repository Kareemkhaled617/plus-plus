import 'package:dartz/dartz.dart';
import '../repositories/category_repository.dart';
import '../entities/category_entity.dart';
import '../../core/errors/failure.dart';

class GetSubcategoriesUseCase {
  final CategoryRepository repository;

  GetSubcategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call(int parentId) {
    return repository.getSubcategories(parentId);
  }
}
