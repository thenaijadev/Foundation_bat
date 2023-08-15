import 'package:batnf/features/home/data/projects/model/projects/project_details_model.dart';
import 'package:batnf/features/home/data/projects/model/projects/projects_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectRepository {
  Future<Either<String,List<ProjectsResponseModel>>> getProjects();
  Future<Either<String,GetProjectByIdResponseModel>> getProjectById({required String id});
}