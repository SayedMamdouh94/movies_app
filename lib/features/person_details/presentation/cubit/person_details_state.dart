part of 'person_details_cubit.dart';


sealed class PersonDetailsState {}

final class PersonDetailsInitial extends PersonDetailsState {}
final class PersonDetailsLoading extends PersonDetailsState {}
final class PersonDetailsLoaded extends PersonDetailsState {
  final PersonDetailsResponseModel personDetails;

  PersonDetailsLoaded(this.personDetails);
}
final class PersonDetailsError extends PersonDetailsState {
  final String message;

  PersonDetailsError(this.message);
}