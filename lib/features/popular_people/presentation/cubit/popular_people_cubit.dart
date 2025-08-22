import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/core/helpers/network_connectivity_helper.dart';
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
  bool _isOfflineMode = false;

  Future<void> loadPopularPeople({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _allPeople.clear();
      _hasReachedMax = false;
      _isOfflineMode = false;
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

    // Check network connectivity first
    final hasNetwork = await NetworkConnectivityHelper.canReachTmdbApi();
    if (!hasNetwork) {
      debugPrint('No network connection - attempting offline mode');
      _isOfflineMode = true;
    }

    final result = await _repository.getPopularPeople(
      page: _currentPage,
      forceRefresh: refresh,
    );

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
            isOfflineMode: _isOfflineMode,
          ),
        );

      case Error<PopularPeopleResponseModel>():
        // Check if we have offline data available
        final hasOfflineData = await _repository.hasOfflineData();

        if (hasOfflineData && _allPeople.isEmpty) {
          debugPrint('API failed, trying to load from cache');
          await _loadOfflineData();
        } else {
          emit(
            PopularPeopleError(
              message: _isOfflineMode
                  ? 'No internet connection and no cached data available'
                  : result.message,
              currentPeople: _allPeople.isNotEmpty
                  ? List.from(_allPeople)
                  : null,
              isOfflineMode: _isOfflineMode,
            ),
          );
        }
    }
  }

  Future<void> _loadOfflineData() async {
    try {
      _isOfflineMode = true;
      final result = await _repository.getPopularPeople(page: 1);

      if (result is Success<PopularPeopleResponseModel>) {
        _allPeople.clear();
        _allPeople.addAll(result.data.results);
        _currentPage = 2;
        _hasReachedMax = true; // Only show first page in offline mode

        emit(
          PopularPeopleLoaded(
            people: List.from(_allPeople),
            currentPage: 1,
            totalPages: 1,
            hasReachedMax: true,
            isOfflineMode: true,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error loading offline data: $e');
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
