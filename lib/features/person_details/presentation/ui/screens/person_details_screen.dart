import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/helpers/snackbar.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_scaffold.dart';
import 'package:movies_app/features/person_details/presentation/cubit/person_details_cubit.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/person_details_body.dart';

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
        buildWhen: (previous, current) {
          return current is PersonDetailsInitial ||
              current is PersonDetailsLoading ||
              current is PersonDetailsLoaded ||
              current is PersonDetailsError;
        },
        builder: (context, state) {
          return PersonDetailsBody(
            state: state,
            personId: personId,
          );
        },
      ),
    );
  }
}