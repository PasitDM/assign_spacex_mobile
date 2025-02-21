import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/launch.dart';
import '../bloc/launch_bloc.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Launches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              _showSortOptions(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Search', border: OutlineInputBorder()),
              onChanged: (query) {
                context.read<LaunchBloc>().add(SearchLaunches(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LaunchBloc, LaunchState>(
              builder: (context, state) {
                if (state is LaunchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LaunchLoaded) {
                  return ListView.builder(
                    itemCount: state.launches.length,
                    itemBuilder: (context, index) {
                      final launch = state.launches[index];
                      return ListTile(
                        title: Text(launch.name),
                        subtitle: Text(launch.dateUtc),
                        trailing: launch.patchSmall.isNotEmpty ? Image.network(launch.patchSmall) : null,
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
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Mission Name (A-Z)'),
              onTap: () {
                context.read<LaunchBloc>().add(const SortLaunches(SortType.missionNameAsc));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Mission Name (Z-A)'),
              onTap: () {
                context.read<LaunchBloc>().add(const SortLaunches(SortType.missionNameDesc));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Launch Date (Newest to Oldest)'),
              onTap: () {
                context.read<LaunchBloc>().add(const SortLaunches(SortType.launchDateDesc));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Launch Date (Oldest to Newest)'),
              onTap: () {
                context.read<LaunchBloc>().add(const SortLaunches(SortType.launchDateAsc));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class LaunchDetailPage extends StatelessWidget {
  final Launch launch;

  const LaunchDetailPage({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(launch.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mission Name: ${launch.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Launch Date & Time: ${launch.dateUtc}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            if (launch.patchLarge.isNotEmpty) Image.network(launch.patchLarge),
            const SizedBox(height: 8),
            Text('Launch Details: ${launch.details}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Rocket Information: ...', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Crew Members: ...', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Launchpad Details: ...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
