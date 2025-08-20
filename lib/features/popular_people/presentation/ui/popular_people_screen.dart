import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/widgets/custom_scaffold.dart';
import 'package:movies_app/features/popular_people/presentation/cubit/popular_people_cubit.dart';
import 'package:movies_app/features/popular_people/presentation/widgets/popular_people_error_widget.dart';
import 'package:movies_app/features/popular_people/presentation/widgets/popular_people_list_view.dart';
import 'package:movies_app/features/popular_people/presentation/widgets/popular_people_loading_widgets.dart';

class PopularPeopleScreen extends StatelessWidget {
  const PopularPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Popular People',
      body: BlocConsumer<PopularPeopleCubit, PopularPeopleState>(
        listener: (context, state) {
          if (state is PopularPeopleError && state.currentPeople != null) {
            // Show error snackbar when we have existing data
            PopularPeopleErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<PopularPeopleCubit>().loadMorePeople(),
              hasData: true,
            );
          }
        },
        builder: (context, state) {
          return PopularPeopleContent(state: state);
        },
      ),
    );
  }
}

class PopularPeopleContent extends StatelessWidget {
  final PopularPeopleState state;

  const PopularPeopleContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state.runtimeType) {
      case const (PopularPeopleInitial):
      case const (PopularPeopleLoading):
        return const PopularPeopleLoadingWidget();

      case const (PopularPeopleLoaded):
        final loadedState = state as PopularPeopleLoaded;
        if (loadedState.people.isEmpty) {
          return PopularPeopleEmptyWidget(
            onRetry: () => context.read<PopularPeopleCubit>().refreshPeople(),
          );
        }
        return PopularPeopleListView(
          people: loadedState.people,
          hasReachedMax: loadedState.hasReachedMax,
        );

      case const (PopularPeopleLoadingMore):
        final loadingMoreState = state as PopularPeopleLoadingMore;
        return PopularPeopleListView(
          people: loadingMoreState.currentPeople,
          hasReachedMax: false,
        );

      case const (PopularPeopleError):
        final errorState = state as PopularPeopleError;
        if (errorState.currentPeople != null &&
            errorState.currentPeople!.isNotEmpty) {
          // Show list with error snackbar
          return PopularPeopleListView(
            people: errorState.currentPeople!,
            hasReachedMax: true, // Prevent loading more on error
          );
        }
        return PopularPeopleErrorWidget(
          message: errorState.message,
          onRetry: () => context.read<PopularPeopleCubit>().refreshPeople(),
        );

      default:
        return const PopularPeopleLoadingWidget();
    }
  }
}
