import 'package:batnf/core/state/view_state.dart';
import 'package:batnf/features/home/data/projects/model/projects/project_details_model.dart';
import 'package:batnf/features/home/data/projects/respository/projects/projects.dart';
import 'package:batnf/utilities/injector.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class ProjectDetailsController extends GetxController{
  final ProjectRepository _projectRepository = sl<ProjectRepository>();

  ViewState<GetProjectByIdResponseModel> projectDetailsDateStateView = ViewState(state: ResponseState.empty);
  void _setProjectDetailsNewsState(ViewState<GetProjectByIdResponseModel> projectDetailsDateStateView) {
    this.projectDetailsDateStateView = projectDetailsDateStateView;
  }
  void getProjectById({required String id}) async {
    try{
      _setProjectDetailsNewsState(ViewState.loading());
      update();
      Either<String, GetProjectByIdResponseModel> either = await _projectRepository.getProjectById(id: id);
      either.fold((l){
        _setProjectDetailsNewsState(ViewState.error(l));
        update();
        return _setProjectDetailsNewsState(ViewState.error(l));
      }, (r){
        _setProjectDetailsNewsState(ViewState.complete(r));
        update();
        return _setProjectDetailsNewsState(ViewState.complete(r));
      });
      update();
    }catch(e){
      _setProjectDetailsNewsState(ViewState.error(e.toString()));
      update();
      _setProjectDetailsNewsState(ViewState.error(e.toString()));
    }
  }
}