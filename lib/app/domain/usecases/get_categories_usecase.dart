import 'package:dartz/dartz.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';
import '../../core/errors/failure.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}
