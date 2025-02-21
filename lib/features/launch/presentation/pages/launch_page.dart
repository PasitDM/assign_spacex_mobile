import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/components/images/app_image.dart';
import '../../../../extension/date_extension.dart';
import '../../domain/entities/launch.dart';
import '../bloc/launch_bloc.dart';
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
      context.read<LaunchBloc>().add(LoadMoreLaunches(_currentPage + 1));
      setState(() {
        _currentPage++;
      });
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
                  const Expanded(child: SearchBar()),
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
                child: LaunchList(scrollController: _scrollController),
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
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Search launches...",
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
        onChanged: (query) {
          context.read<LaunchBloc>().add(SearchLaunches(query));
        },
      ),
    );
  }
}

class LaunchList extends StatelessWidget {
  final ScrollController scrollController;

  const LaunchList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      builder: (context, state) {
        if (state is LaunchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LaunchLoaded) {
          print('state.launches.length: ${state.launches.length}');
          return ListView.builder(
            controller: scrollController,
            itemCount: state.launches.length + 1,
            itemBuilder: (context, index) {
              if (index == state.launches.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final launch = state.launches[index];
              return LaunchListItem(launch: launch);
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

class LaunchListItem extends StatelessWidget {
  final Launch launch;

  const LaunchListItem({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    final launchDate = DateTime.parse(launch.dateUtc);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LaunchDetailPage(launch: launch)));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(launch.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                    const SizedBox(height: 6),
                    Text(
                      'Launch Date: ${launchDate.formatDateTime(DateFormatPattern.dayMonthYearHHmm)}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Status: ${launch.upcoming ? 'Upcoming' : 'Past'}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: launch.upcoming ? Colors.orange : Colors.green,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('•', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
                        ),
                        Text(
                          'Result: ${launch.success ? 'Success' : 'Failure'}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: launch.success ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Builder(
                builder: (context) {
                  if (launch.patchSmall.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AppImage(imageUrl: launch.patchSmall, width: 80, height: 80),
                    );
                  } else {
                    return Icon(Icons.error, color: Colors.grey[400], size: 80);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SortOptions extends StatelessWidget {
  final SortType? currentSortType;

  const SortOptions({super.key, this.currentSortType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Mission Name (A-Z)'),
            trailing: currentSortType == SortType.missionNameAsc ? const Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              context.read<LaunchBloc>().add(const SortLaunches(SortType.missionNameAsc));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Mission Name (Z-A)'),
            trailing: currentSortType == SortType.missionNameDesc ? const Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              context.read<LaunchBloc>().add(const SortLaunches(SortType.missionNameDesc));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Launch Date (Newest to Oldest)'),
            trailing: currentSortType == SortType.launchDateDesc ? const Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              context.read<LaunchBloc>().add(const SortLaunches(SortType.launchDateDesc));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Launch Date (Oldest to Newest)'),
            trailing: currentSortType == SortType.launchDateAsc ? const Icon(Icons.check, color: Colors.blue) : null,
            onTap: () {
              context.read<LaunchBloc>().add(const SortLaunches(SortType.launchDateAsc));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
