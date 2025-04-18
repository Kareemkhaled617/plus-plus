import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/section_entity.dart';
import '../../domain/repositories/section_repository.dart';
import '../models/section_model.dart';

class SectionRepositoryImpl implements SectionRepository {
  final ApiService apiService;

  SectionRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<SectionEntity>>> getSections() async {
    final response = await apiService.getRequest('sections');

    if (response.success) {
      print('wereiuryueirye');
      print(response.data['data']['sections']);
      final List sectionsJson = response.data['data']['sections'];
      final sections = sectionsJson.map((e) => SectionModel.fromJson(e)).toList();
      return Right(sections);
    } else {
      return Left(Failure(response.message ?? "Failed to load sections", statusCode: response.statusCode));
    }
  }
}
