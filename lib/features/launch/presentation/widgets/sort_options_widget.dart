import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/launch_bloc.dart';

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
