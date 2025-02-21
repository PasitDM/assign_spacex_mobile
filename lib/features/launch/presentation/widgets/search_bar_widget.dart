import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/launch_bloc.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

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
