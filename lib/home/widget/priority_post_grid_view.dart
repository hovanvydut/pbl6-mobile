import 'package:flutter/material.dart';
import 'package:pbl6_mobile/home/home.dart';

class PriorityPostGridView extends StatelessWidget {
  const PriorityPostGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Phòng trọ nổi bật',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          GridView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            shrinkWrap: true,
            primary: false,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
              mainAxisExtent: 260,
            ),
            itemBuilder: (context, index) {
              return const PostGridCard();
            },
          )
        ],
      ),
    );
  }
}