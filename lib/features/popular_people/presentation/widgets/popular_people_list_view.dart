import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/helpers/snackbar.dart';
import 'package:movies_app/features/popular_people/data/models/popular_people_response_model.dart';
import 'package:movies_app/features/popular_people/presentation/cubit/popular_people_cubit.dart';
import 'package:movies_app/features/popular_people/presentation/widgets/popular_people_person_card.dart';
import 'package:movies_app/features/popular_people/presentation/widgets/popular_people_loading_widgets.dart';

class PopularPeopleListView extends StatefulWidget {
  final List<PopularPersonModel> people;
  final bool hasReachedMax;

  const PopularPeopleListView({
    super.key,
    required this.people,
    required this.hasReachedMax,
  });

  @override
  State<PopularPeopleListView> createState() => _PopularPeopleListViewState();
}

class _PopularPeopleListViewState extends State<PopularPeopleListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !widget.hasReachedMax) {
      context.read<PopularPeopleCubit>().loadMorePeople();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<PopularPeopleCubit>().refreshPeople(),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.people.length + (widget.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= widget.people.length) {
            return const PopularPeopleLoadMoreWidget();
          }

          final person = widget.people[index];
          return PopularPeoplePersonCard(
            person: person,
            onTap: () => _onPersonTap(person),
          );
        },
      ),
    );
  }

  void _onPersonTap(PopularPersonModel person) {
    showSnackBar('Selected: ${person.name}');
    // TODO: Navigate to person details screen
  }
}
