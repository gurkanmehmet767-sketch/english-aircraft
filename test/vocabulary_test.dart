// Vocabulary Model Tests
import 'package:flutter_test/flutter_test.dart';
import 'package:english_aircraft/models/vocabulary_models.dart';

void main() {
  group('Term Model Tests', () {
    test('Term should be created with correct properties', () {
      const term = Term(
        'SAFETY',
        'emniyet',
        'A2',
        dutch: 'veiligheid',
        german: 'Sicherheit',
        french: 'sécurité',
        spanish: 'seguridad',
      );

      expect(term.english, 'SAFETY');
      expect(term.turkish, 'emniyet');
      expect(term.level, 'A2');
      expect(term.dutch, 'veiligheid');
      expect(term.german, 'Sicherheit');
      expect(term.french, 'sécurité');
      expect(term.spanish, 'seguridad');
    });

    test('Term equality should work correctly', () {
      const term1 = Term('AIRCRAFT', 'uçak', 'A2');
      const term2 = Term('AIRCRAFT', 'uçak', 'A2');
      const term3 = Term('ENGINE', 'motor', 'A2');

      expect(term1, equals(term2));
      expect(term1, isNot(equals(term3)));
    });

    test('Term hashCode should be consistent', () {
      const term1 = Term('WING', 'kanat', 'A1');
      const term2 = Term('WING', 'kanat', 'A1');

      expect(term1.hashCode, equals(term2.hashCode));
    });
  });

  group('CategoryData Model Tests', () {
    test('CategoryData should be created correctly', () {
      const category = CategoryData(
        title: 'Safety',
        icon: '🛡️',
        section: '1. KISIM',
        terms: [
          Term('SAFETY', 'emniyet', 'A2'),
          Term('RISK', 'risk', 'A1'),
        ],
        readings: [],
      );

      expect(category.title, 'Safety');
      expect(category.icon, '🛡️');
      expect(category.section, '1. KISIM');
      expect(category.terms.length, 2);
      expect(category.readings.length, 0);
    });

    test('CategoryData should have correct term count', () {
      const category = CategoryData(
        title: 'Tools',
        icon: '🔧',
        section: '2. KISIM',
        terms: [
          Term('DRILL', 'matkap', 'A1'),
          Term('HAMMER', 'çekiç', 'A2'),
          Term('WRENCH', 'anahtar', 'A2'),
        ],
        readings: [],
      );

      expect(category.terms.length, 3);
    });
  });

  group('League Model Tests', () {
    test('League should be created with correct properties', () {
      const league = League(
        name: 'Bronz',
        xp: 0,
        colors: ['#CD7F32'],
        desc: 'Başlangıç',
      );

      expect(league.name, 'Bronz');
      expect(league.xp, 0);
      expect(league.colors, ['#CD7F32']);
      expect(league.desc, 'Başlangıç');
    });

    test('League comparison should work based on XP', () {
      const bronze = League(name: 'Bronz', xp: 0, colors: [], desc: '');
      const silver = League(name: 'Gümüş', xp: 500, colors: [], desc: '');
      const gold = League(name: 'Altın', xp: 1500, colors: [], desc: '');

      expect(bronze.xp < silver.xp, true);
      expect(silver.xp < gold.xp, true);
      expect(gold.xp > bronze.xp, true);
    });
  });
}
