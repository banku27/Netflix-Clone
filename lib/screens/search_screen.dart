import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CupertinoSearchTextField(
            padding: const EdgeInsets.all(10.0),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.grey,
            ),
            suffixIcon: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
            style: const TextStyle(color: Colors.white),
            backgroundColor: Colors.grey.withOpacity(0.3),
            onChanged: (value) {
              if (value.isEmpty) {}
            },
          ),
        ],
      ),
    ));
  }
}
