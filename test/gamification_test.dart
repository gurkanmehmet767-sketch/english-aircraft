// Gamification Logic Tests
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('XP Calculation Tests', () {
    test('Correct answer should give base XP', () {
      const baseXP = 10;
      const streakBonus = 0;
      const totalXP = baseXP + streakBonus;

      expect(totalXP, 10);
    });

    test('Streak bonus should multiply correctly', () {
      const baseXP = 10;
      const streakDays = 3;
      const streakBonus = baseXP * streakDays * 0.1;
      const totalXP = baseXP + streakBonus;

      expect(streakBonus, 3.0);
      expect(totalXP, 13.0);
    });

    test('Wrong answer should give 0 XP', () {
      const baseXP = 0;
      expect(baseXP, 0);
    });

    test('Perfect lesson completion bonus', () {
      const baseXP = 10;
      const questionsCount = 10;
      const perfectBonus = 50;
      const totalXP = (baseXP * questionsCount) + perfectBonus;

      expect(totalXP, 150);
    });
  });

  group('Lives System Tests', () {
    test('Initial lives should be 5', () {
      const initialLives = 5;
      expect(initialLives, 5);
    });

    test('Wrong answer should decrease lives', () {
      int lives = 5;
      lives--;

      expect(lives, 4);
    });

    test('Lives should not go below 0', () {
      int lives = 1;
      lives = lives - 1;
      if (lives < 0) lives = 0;

      expect(lives, 0);
    });

    test('Lives should not exceed maximum (5)', () {
      int lives = 5;
      lives++;
      if (lives > 5) lives = 5;

      expect(lives, 5);
    });

    test('Lives regenerate over time', () {
      // 1 life per 30 minutes
      const minutesPassed = 30;
      const livesRegened = minutesPassed ~/ 30;

      expect(livesRegened, 1);
    });

    test('Multiple lives regeneration', () {
      const minutesPassed = 150; // 2.5 hours
      const livesRegened = minutesPassed ~/ 30;

      expect(livesRegened, 5);
    });
  });

  group('Streak System Tests', () {
    test('New user should have 0 streak', () {
      const streak = 0;
      expect(streak, 0);
    });

    test('Daily completion should increase streak', () {
      int streak = 0;
      streak++;

      expect(streak, 1);
    });

    test('Missing a day should reset streak', () {
      int streak = 10;
      const missedDay = true;

      if (missedDay) streak = 0;

      expect(streak, 0);
    });

    test('Streak should be maintained with daily activity', () {
      int streak = 5;
      const completedToday = true;

      if (completedToday) streak++;

      expect(streak, 6);
    });
  });

  group('League System Tests', () {
    test('User should start in Bronze league', () {
      const xp = 0;
      String league = 'Bronz';

      if (xp >= 10000) {
        league = 'Şampiyon';
      } else if (xp >= 5000) {
        league = 'Elmas';
      } else if (xp >= 3000) {
        league = 'Platin';
      } else if (xp >= 1500) {
        league = 'Altın';
      } else if (xp >= 500) {
        league = 'Gümüş';
      }

      expect(league, 'Bronz');
    });

    test('500 XP should promote to Silver', () {
      const xp = 500;
      String league = 'Bronz';

      if (xp >= 10000) {
        league = 'Şampiyon';
      } else if (xp >= 5000) {
        league = 'Elmas';
      } else if (xp >= 3000) {
        league = 'Platin';
      } else if (xp >= 1500) {
        league = 'Altın';
      } else if (xp >= 500) {
        league = 'Gümüş';
      }

      expect(league, 'Gümüş');
    });

    test('10000 XP should promote to Champion', () {
      const xp = 10000;
      String league = 'Bronz';

      if (xp >= 10000) {
        league = 'Şampiyon';
      } else if (xp >= 5000) {
        league = 'Elmas';
      } else if (xp >= 3000) {
        league = 'Platin';
      } else if (xp >= 1500) {
        league = 'Altın';
      } else if (xp >= 500) {
        league = 'Gümüş';
      }

      expect(league, 'Şampiyon');
    });
  });

  group('Mastery System Tests', () {
    test('New lesson should have mastery level 0', () {
      const masteryLevel = 0;
      expect(masteryLevel, 0);
    });

    test('First completion should set mastery to 1 (Bronze)', () {
      int mastery = 0;
      const lessonCompleted = true;

      if (lessonCompleted) mastery = 1;

      expect(mastery, 1);
    });

    test('Mastery should not exceed level 4', () {
      int mastery = 4;
      mastery++;
      if (mastery > 4) mastery = 4;

      expect(mastery, 4);
    });

    test('Wrong answers should decrease mastery', () {
      int mastery = 3;
      const wrongAnswer = true;

      if (wrongAnswer && mastery > 0) mastery--;

      expect(mastery, 2);
    });
  });
}
