import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/helpers/extensions/context_extenstions.dart';
import 'package:movies_app/core/style/app_colors.dart';
import 'package:movies_app/core/widgets/custom_text.dart';
import 'package:movies_app/features/person_details/presentation/cubit/person_details_cubit.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_images_grid.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_images_grid_loading.dart';
import 'package:movies_app/features/person_details/presentation/ui/widgets/images_grid/person_details_images_grid_error.dart';

class PersonDetailsImagesSection extends StatelessWidget {
  const PersonDetailsImagesSection({super.key, required this.personId});

  final int personId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonDetailsImagesSectionTitle(),
        SizedBox(height: 16.h),
        BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
          builder: (context, state) {
            return _buildImagesContent(context, state);
          },
        ),
      ],
    );
  }

  Widget _buildImagesContent(BuildContext context, PersonDetailsState state) {
    switch (state.runtimeType) {
      case const (PersonImagesLoading):
        return const PersonDetailsImagesGridLoading();

      case const (PersonImagesLoaded):
        final loadedState = state as PersonImagesLoaded;
        return PersonDetailsImagesGrid(personImages: loadedState.personImages);

      case const (PersonImagesError):
        final errorState = state as PersonImagesError;
        return PersonDetailsImagesGridError(
          message: errorState.message,
          onRetry: () =>
              context.read<PersonDetailsCubit>().loadPersonImages(personId),
        );

      default:
        // Initial state - automatically load images
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<PersonDetailsCubit>().loadPersonImages(personId);
        });
        return const PersonDetailsImagesGridLoading();
    }
  }
}

class PersonDetailsImagesSectionTitle extends StatelessWidget {
  const PersonDetailsImagesSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      'Photos',
      style: context.textTheme.titleLarge!.copyWith(color: AppColors.kPrimary),
    );
  }
}
