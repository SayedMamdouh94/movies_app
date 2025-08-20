part of 'popular_people_cubit.dart';

abstract class PopularPeopleState {}

class PopularPeopleInitial extends PopularPeopleState {}

class PopularPeopleLoading extends PopularPeopleState {}

class PopularPeopleLoadingMore extends PopularPeopleState {
  final List<PopularPersonModel> currentPeople;
  final int currentPage;

  PopularPeopleLoadingMore({
    required this.currentPeople,
    required this.currentPage,
  });
}

class PopularPeopleLoaded extends PopularPeopleState {
  final List<PopularPersonModel> people;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;

  PopularPeopleLoaded({
    required this.people,
    required this.currentPage,
    required this.totalPages,
    this.hasReachedMax = false,
  });

  PopularPeopleLoaded copyWith({
    List<PopularPersonModel>? people,
    int? currentPage,
    int? totalPages,
    bool? hasReachedMax,
  }) {
    return PopularPeopleLoaded(
      people: people ?? this.people,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class PopularPeopleError extends PopularPeopleState {
  final String message;
  final List<PopularPersonModel>? currentPeople;

  PopularPeopleError({required this.message, this.currentPeople});
}
