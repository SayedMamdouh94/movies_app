import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/person_details/presentation/cubit/person_details_cubit.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_content.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_error_widget.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_loading_widget.dart';

class PersonDetailsBody extends StatelessWidget {
  const PersonDetailsBody({
    super.key,
    required this.state,
    required this.personId,
  });

  final PersonDetailsState state;
  final int personId;

  @override
  Widget build(BuildContext context) {
    switch (state.runtimeType) {
      case const (PersonDetailsInitial):
      case const (PersonDetailsLoading):
        return const PersonDetailsLoadingWidget();

      case const (PersonDetailsLoaded):
        final loadedState = state as PersonDetailsLoaded;
        return PersonDetailsContent(
          personDetails: loadedState.personDetails,
          personId: personId,
        );

      case const (PersonDetailsError):
        final errorState = state as PersonDetailsError;
        return PersonDetailsErrorWidget(
          message: errorState.message,
          onRetry: () =>
              context.read<PersonDetailsCubit>().loadPersonDetails(personId),
        );

      default:
        return const PersonDetailsErrorWidget(
          message: 'Unknown state occurred',
          onRetry: null,
        );
    }
  }
}
