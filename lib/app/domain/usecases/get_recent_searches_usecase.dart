import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';

import '../entities/recent_search_entity.dart';
import '../repositories/recent_search_repository.dart';

class GetRecentSearchesUseCase {
  final RecentSearchRepository repository;

  GetRecentSearchesUseCase(this.repository);

  Future<Either<Failure, List<RecentSearchEntity>>> call() {
    return repository.getRecentSearches();
  }
}
