import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/helpers/snackbar.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_scaffold.dart';
import 'package:movies_app/features/person_details/presentation/cubit/person_details_cubit.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_content.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_error_widget.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_loading_widget.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen({super.key, required this.personId});

  final int personId;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Person Details',
      backgroundColor: AppColors.kBackground,
      body: BlocConsumer<PersonDetailsCubit, PersonDetailsState>(
        listener: (context, state) {
          if (state is PersonDetailsError) {
            showSnackBar(state.message, isError: true);
          }
        },
        builder: (context, state) {
          return _buildContent(context, state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, PersonDetailsState state) {
    switch (state.runtimeType) {
      case const (PersonDetailsInitial):
      case const (PersonDetailsLoading):
        return const PersonDetailsLoadingWidget();

      case const (PersonDetailsLoaded):
        final loadedState = state as PersonDetailsLoaded;
        return PersonDetailsContent(personDetails: loadedState.personDetails);

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
