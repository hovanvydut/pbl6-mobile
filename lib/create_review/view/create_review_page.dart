import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pbl6_mobile/create_review/create_review.dart';

class CreateReviewPage extends StatelessWidget {
  const CreateReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateReviewBloc(),
      child: const CreateReviewView(),
    );
  }
}

class CreateReviewView extends StatelessWidget {
  const CreateReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('CreateReviewView is working'),
      ),
    );
  }
}
