import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class SentimentIllustrator extends StatelessWidget {
  const SentimentIllustrator({super.key, required this.sentiment});

  final Sentiment sentiment;

  @override
  Widget build(BuildContext context) {
    switch (sentiment) {
      case Sentiment.negative:
        return Tooltip(
          message: 'Đây là bình luận được đánh giá tiêu cực',
          child: Assets.lottie.sad.lottie(
            repeat: true,
            height: 60,
          ),
        );
      case Sentiment.positive:
        return Tooltip(
          message: 'Đây là bình luận được đánh giá tích cực',
          child: Assets.lottie.happy.lottie(
            repeat: true,
            height: 60,
          ),
        );
      case Sentiment.neutral:
        return Tooltip(
          message: 'Đây là bình luận được đánh giá tự nhiên',
          child: Assets.lottie.normal.lottie(
            repeat: true,
            height: 60,
          ),
        );
    }
  }
}
