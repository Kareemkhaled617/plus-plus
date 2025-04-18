import 'package:dartz/dartz.dart';
import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final ApiService apiService;

  CategoryRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    final response = await apiService.getRequest(
      'categories',
    );

    if (response.success) {
      final List categoriesJson = response.data['data']['categories'];
      final categories = CategoryModel.fromJsonList(categoriesJson);
      return Right(categories);
    } else {
      return Left(Failure(response.message ?? "Failed to load categories",
          statusCode: response.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getSubcategories(
      int parentId) async {
    final response = await apiService.getRequest(
      'categories/children/$parentId',
    );

    if (response.success) {
      final List subcategoriesJson = response.data['data']['categories'];
      final subcategories = CategoryModel.fromJsonList(subcategoriesJson);
      return Right(subcategories);
    } else {
      return Left(Failure(response.message ?? "Failed to load subcategories",
          statusCode: response.statusCode));
    }
  }
}
