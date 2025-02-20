import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/launch_bloc.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SpaceX Launches')),
      body: BlocBuilder<LaunchBloc, LaunchState>(
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
                    // Handle tap
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
    );
  }
}
