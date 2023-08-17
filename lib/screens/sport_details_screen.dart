import 'package:flutter/material.dart';

import '../models/sport_item.dart';

class SportDetailsScreen extends StatelessWidget {
  final SportsItem sportsItem;
  const SportDetailsScreen({super.key, required this.sportsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sportsItem.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              sportsItem.imageUrl,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sportsItem.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
