import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const TextField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.search_circle,
            size: 40.0,
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
          hintText: 'Search a city...',
        ),
      ),
    );
  }
}
