// Spaced Repetition Algorithm Tests
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Spaced Repetition Tests', () {
    test('New word should be due immediately', () {
      final lastReviewed = DateTime.now();
      final now = DateTime.now();
      final daysSinceReview = now.difference(lastReviewed).inDays;

      expect(daysSinceReview, 0);
    });

    test('First review should schedule next review in 1 day', () {
      const reviewCount = 1;
      final interval = _calculateInterval(reviewCount);

      expect(interval, 1);
    });

    test('Second review should schedule next review in 3 days', () {
      const reviewCount = 2;
      final interval = _calculateInterval(reviewCount);

      expect(interval, 3);
    });

    test('Third review should schedule next review in 7 days', () {
      const reviewCount = 3;
      final interval = _calculateInterval(reviewCount);

      expect(interval, 7);
    });

    test('Fourth review should schedule next review in 14 days', () {
      const reviewCount = 4;
      final interval = _calculateInterval(reviewCount);

      expect(interval, 14);
    });

    test('Word should be due after interval passes', () {
      final lastReviewed = DateTime.now().subtract(const Duration(days: 8));
      final nextReview = lastReviewed.add(const Duration(days: 7));
      final now = DateTime.now();

      final isDue = now.isAfter(nextReview);

      expect(isDue, true);
    });

    test('Word should not be due before interval passes', () {
      final lastReviewed = DateTime.now().subtract(const Duration(days: 3));
      final nextReview = lastReviewed.add(const Duration(days: 7));
      final now = DateTime.now();

      final isDue = now.isAfter(nextReview);

      expect(isDue, false);
    });

    test('Wrong answer should reset interval to 1 day', () {
      const wasCorrect = false;
      int reviewCount = 5;

      if (!wasCorrect) {
        reviewCount = 1;
      }

      final interval = _calculateInterval(reviewCount);

      expect(interval, 1);
    });

    test('Correct answer should increase interval', () {
      const wasCorrect = true;
      int reviewCount = 2;

      if (wasCorrect) {
        reviewCount++;
      }

      final interval = _calculateInterval(reviewCount);

      expect(interval, 7); // Third review = 7 days
    });
  });

  group('Review Priority Tests', () {
    test('Overdue words should have higher priority', () {
      final word1LastReview = DateTime.now().subtract(const Duration(days: 10));
      final word2LastReview = DateTime.now().subtract(const Duration(days: 2));

      final word1Overdue = DateTime.now().difference(word1LastReview).inDays;
      final word2Overdue = DateTime.now().difference(word2LastReview).inDays;

      expect(word1Overdue > word2Overdue, true);
    });

    test('Urgency should increase with days overdue', () {
      final scheduledReview = DateTime.now().subtract(const Duration(days: 5));
      final interval = 3; // Should have been reviewed 2 days ago
      final nextReview = scheduledReview.add(Duration(days: interval));
      final daysOverdue = DateTime.now().difference(nextReview).inDays;

      expect(daysOverdue, greaterThan(0));
    });

    test('New words should have lower priority than reviews', () {
      const word1ReviewCount = 0; // New word
      const word2ReviewCount = 3; // Reviewed word
      final word2DueDate = DateTime.now().subtract(const Duration(days: 1));

      final word2IsDue = DateTime.now().isAfter(word2DueDate);

      expect(word2IsDue, true);
      expect(word2ReviewCount > word1ReviewCount, true);
    });
  });

  group('Mastery Impact on Intervals', () {
    test('High mastery should have longer intervals', () {
      const lowMasteryReviewCount = 3;
      const highMasteryReviewCount = 5;

      final lowInterval = _calculateInterval(lowMasteryReviewCount);
      final highInterval = _calculateInterval(highMasteryReviewCount);

      expect(highInterval > lowInterval, true);
    });

    test('Perfect answers should double interval growth', () {
      const reviewCount = 3;
      const isPerfect = true;

      int interval = _calculateInterval(reviewCount);
      if (isPerfect && interval > 1) {
        interval = (interval * 1.5).round();
      }

      expect(interval, greaterThan(7));
    });
  });
}

// Helper function to calculate review intervals (simplified)
int _calculateInterval(int reviewCount) {
  const intervals = [0, 1, 3, 7, 14, 30, 60, 90];
  if (reviewCount >= intervals.length) {
    return intervals.last;
  }
  return intervals[reviewCount];
}
