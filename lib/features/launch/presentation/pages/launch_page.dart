import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/launch_bloc.dart';
import '../widgets/launch_list_item.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/sort_options_widget.dart';
import 'launch_detail_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final state = context.read<LaunchBloc>().state;
      if (state is LaunchLoaded && !state.hasReachedMax) {
        context.read<LaunchBloc>().add(LoadMoreLaunches(_currentPage + 1));
        setState(() {
          _currentPage++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('SpaceX Launches', style: Theme.of(context).textTheme.headlineSmall),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Expanded(child: SearchBarWidget()),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.grey[700]),
                    onPressed: () {
                      _showSortOptions(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<LaunchBloc>().add(InitialLaunches());
                  setState(() {
                    _currentPage = 1;
                  });
                },
                child: _buildLaunchList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    final currentState = context.read<LaunchBloc>().state;
    SortType? currentSortType;

    if (currentState is LaunchLoaded) {
      currentSortType = currentState.sortType;
    }

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return SortOptions(currentSortType: currentSortType);
      },
    );
  }

  Widget _buildLaunchList() {
    return BlocBuilder<LaunchBloc, LaunchState>(
      builder: (context, state) {
        if (state is LaunchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LaunchLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax ? state.launches.length : state.launches.length + 1,
            itemBuilder: (context, index) {
              if (index == state.launches.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final launch = state.launches[index];
              return LaunchListItem(
                launch: launch,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LaunchDetailPage(launch: launch)));
                },
              );
            },
          );
        } else if (state is LaunchError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
