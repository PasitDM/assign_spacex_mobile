import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/images/app_image.dart';
import '../../../../di/app_module.dart';
import '../../domain/entities/launch.dart';
import '../bloc/detail/launch_detail_bloc.dart';

class LaunchDetailPage extends StatelessWidget {
  final Launch launch;

  const LaunchDetailPage({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              LaunchDetailBloc(getRocketId: appModule.get(), getLaunchpadId: appModule.get())
                ..add(FetchLaunchDetail(rocketId: launch.rocket, launchpadId: launch.launchpad)),
      child: Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  if (launch.patchLarge.isNotEmpty) {
                    return AppImage(imageUrl: launch.patchLarge, height: 250, fit: BoxFit.fitHeight);
                  } else {
                    return Icon(Icons.error, color: Colors.grey[400], size: 80);
                  }
                },
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<LaunchDetailBloc, LaunchDetailState>(
                  builder: (context, state) {
                    if (state is LaunchDetailLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LaunchDetailLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle("Mission"),
                          _detailRow("Mission Name", launch.name),
                          _detailRow("Launch Date & Time", launch.dateUtc),
                          _detailRow("Launch Details", launch.details.isNotEmpty ? launch.details : "No details available"),
                          const Divider(height: 16, color: Color(0xffE8EAED)),

                          _sectionTitle("Rocket Information"),
                          _detailRow("Rocket Name", state.rocket.name),
                          _detailRow("Rocket Type", state.rocket.type),
                          _detailRow("Description", state.rocket.description),
                          const Divider(height: 16, color: Color(0xffE8EAED)),

                          _sectionTitle("Launchpad Details"),
                          _detailRow("Launchpad Name", state.launchpad.name),
                          _detailRow("Full Name", state.launchpad.fullName),
                          _detailRow(
                            "Details",
                            state.launchpad.details.isNotEmpty ? state.launchpad.details : "No details available",
                          ),
                          const Divider(height: 16, color: Color(0xffE8EAED)),

                          /// Crew Member
                          _sectionTitle("Crew Members"),
                          if (launch.crew.isNotEmpty)
                            ...launch.crew.map((member) => _detailRow("Crew Member", member as String? ?? '-'))
                          else
                            _detailRow("Crew Members", "No crew members"),
                          const SizedBox(height: 24),
                        ],
                      );
                    } else if (state is LaunchDetailError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('No data'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text.rich(
        TextSpan(
          text: "$title: ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          children: [TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16))],
        ),
      ),
    );
  }
}
