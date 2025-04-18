import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsBySectionUseCase {
  final ProductRepository repository;

  GetProductsBySectionUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call(int sectionId) async {
    return await repository.getProductsBySection(sectionId);
  }
}
