import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/recent_search_entity.dart';


abstract class RecentSearchRepository {
  Future<Either<Failure, List<RecentSearchEntity>>> getRecentSearches();
}
