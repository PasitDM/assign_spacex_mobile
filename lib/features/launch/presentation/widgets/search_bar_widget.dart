import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/launch_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<LaunchBloc>().add(SearchLaunches(query));
    });
  }

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
        onChanged: _onSearchChanged,
      ),
    );
  }
}
