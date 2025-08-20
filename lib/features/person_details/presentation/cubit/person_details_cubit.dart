import 'package:bloc/bloc.dart';
import 'package:movies_app/core/networking/data_result.dart';
import 'package:movies_app/features/person_details/data/models/person_details_response_model.dart';
import 'package:movies_app/features/person_details/data/repo/person_details_repo.dart';

part 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit(this._repository) : super(PersonDetailsInitial());
  final PersonDetailsRepo _repository;
  Future<void> loadPersonDetails(int personId, {String? language}) async {
    emit(PersonDetailsLoading());

    final result = await _repository.getPersonDetails(
      personId: personId,
      language: language,
    );

    switch (result){
      case Success(:final data):
        emit(PersonDetailsLoaded(data));
        break;
      case Error(:final message):
        emit(PersonDetailsError(message));
        break;
    }
  }
}
