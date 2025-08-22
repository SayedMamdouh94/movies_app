import 'package:bloc/bloc.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';
import 'package:movies_app/features/popular_people/data/repo/popular_people_repo.dart';
import 'package:movies_app/core/networking/data_result.dart';

part 'popular_people_state.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleState> {
  final PopularPeopleRepo _repository;

  PopularPeopleCubit(this._repository) : super(PopularPeopleInitial());

  int _currentPage = 1;
  final List<PopularPersonModel> _allPeople = [];
  bool _hasReachedMax = false;

  Future<void> loadPopularPeople({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _allPeople.clear();
      _hasReachedMax = false;
      emit(PopularPeopleLoading());
    } else if (_hasReachedMax) {
      return;
    } else if (_allPeople.isNotEmpty) {
      emit(
        PopularPeopleLoadingMore(
          currentPeople: _allPeople,
          currentPage: _currentPage,
        ),
      );
    } else {
      emit(PopularPeopleLoading());
    }

    final result = await _repository.getPopularPeople(page: _currentPage);

    switch (result) {
      case Success<PopularPeopleResponseModel>():
        _allPeople.addAll(result.data.results);
        _hasReachedMax = _currentPage >= result.data.totalPages;
        _currentPage++;

        emit(
          PopularPeopleLoaded(
            people: List.from(_allPeople),
            currentPage: _currentPage - 1,
            totalPages: result.data.totalPages,
            hasReachedMax: _hasReachedMax,
          ),
        );

      case Error<PopularPeopleResponseModel>():
        emit(
          PopularPeopleError(
            message: result.message,
            currentPeople: _allPeople.isNotEmpty ? List.from(_allPeople) : null,
          ),
        );
    }
  }

  Future<void> loadMorePeople() async {
    if (!_hasReachedMax && state is PopularPeopleLoaded) {
      await loadPopularPeople();
    }
  }

  Future<void> refreshPeople() async {
    await loadPopularPeople(refresh: true);
  }
}
