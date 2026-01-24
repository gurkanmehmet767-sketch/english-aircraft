// Generate expanded vocabulary_data_fixed.dart
import 'dart:io';
import 'package:flutter/foundation.dart' show debugPrint;

void main() {
  final dictFile = File('lib/data/word_dictionary.dart');
  final content = dictFile.readAsStringSync();

  final regex = RegExp(
      r"'(\w+)':\s*\{'tr':\s*'([^']*)',\s*'nl':\s*'([^']*)',\s*'de':\s*'([^']*)',\s*'fr':\s*'([^']*)',\s*'es':\s*'([^']*)'");
  final matches = regex.allMatches(content);

  final categories = <String, List<String>>{
    'safety': [],
    'tools': [],
    'aircraft': [],
    'electrical': [],
    'hydraulic': [],
    'navigation': [],
    'emergency': [],
    'maintenance': [],
    'general': [],
  };

  final catKeywords = {
    'safety': [
      'safety',
      'hazard',
      'warning',
      'caution',
      'protective',
      'goggles',
      'gloves',
      'helmet',
      'boots',
      'vest',
      'harness',
      'coveralls',
      'respirator',
      'shield',
      'danger',
      'flammable',
      'corrosive',
      'radiation',
      'slippery',
      'toxic',
      'fumes',
      'exposure',
      'risk',
      'precautions',
      'personnel',
      'protecting'
    ],
    'tools': [
      'tool',
      'tools',
      'wrench',
      'screwdriver',
      'pliers',
      'hammer',
      'drill',
      'drilling',
      'socket',
      'torque',
      'calibration',
      'gauge',
      'spanner',
      'fastener',
      'micrometer',
      'caliper',
      'chisel',
      'clamp',
      'vice',
      'hacksaw',
      'cutters',
      'adjustable',
      'grinder',
      'cutting',
      'bench',
      'measurement',
      'precision',
      'tolerance',
      'accuracy'
    ],
    'aircraft': [
      'aircraft',
      'fuselage',
      'wing',
      'engine',
      'cockpit',
      'landing',
      'propeller',
      'tail',
      'flap',
      'rudder',
      'aileron',
      'empennage',
      'stabilizer',
      'elevator',
      'slat',
      'spoiler',
      'nacelle',
      'pylon',
      'fairing',
      'cabin',
      'seat',
      'seats',
      'galley',
      'door',
      'doors',
      'hatch',
      'interior',
      'passenger',
      'passengers'
    ],
    'electrical': [
      'battery',
      'circuit',
      'wire',
      'wiring',
      'voltage',
      'current',
      'generator',
      'switch',
      'fuse',
      'relay',
      'connector',
      'electrical',
      'power',
      'alternator',
      'inverter',
      'rectifier',
      'regulator',
      'terminal',
      'digital',
      'analog',
      'signal',
      'breaker',
      'sensor',
      'processor',
      'computer',
      'software',
      'hardware',
      'interface'
    ],
    'hydraulic': [
      'hydraulic',
      'hydraulics',
      'pump',
      'pumps',
      'pressure',
      'valve',
      'valves',
      'reservoir',
      'actuator',
      'fluid',
      'seal',
      'cylinder',
      'cylinders',
      'filter',
      'pneumatic',
      'accumulator',
      'servo',
      'bleed',
      'pressurization'
    ],
    'navigation': [
      'navigation',
      'radar',
      'gps',
      'compass',
      'altimeter',
      'heading',
      'waypoint',
      'transponder',
      'autopilot',
      'avionics',
      'route',
      'altitude',
      'airspeed',
      'groundspeed',
      'distance',
      'bearing',
      'coordinates',
      'latitude',
      'longitude',
      'track',
      'course',
      'radio',
      'frequency',
      'communication',
      'antenna',
      'receiver',
      'display',
      'instrument'
    ],
    'emergency': [
      'evacuation',
      'extinguisher',
      'extinguishers',
      'oxygen',
      'mask',
      'masks',
      'exit',
      'alarm',
      'rescue',
      'survival',
      'beacon',
      'distress',
      'fire',
      'emergency',
      'escape',
      'slide',
      'foam',
      'hydrant',
      'sprinkler',
      'detector',
      'wound',
      'bleeding',
      'fracture',
      'resuscitation',
      'defibrillator',
      'unconscious',
      'tourniquet',
      'lighting',
      'light',
      'lights'
    ],
    'maintenance': [
      'maintenance',
      'inspection',
      'repair',
      'replace',
      'check',
      'checking',
      'test',
      'install',
      'installation',
      'remove',
      'removed',
      'lubricate',
      'adjust',
      'adjustment',
      'crack',
      'dent',
      'corrosion',
      'worn',
      'alignment',
      'leak',
      'rivet',
      'riveting',
      'damaged',
      'service',
      'serviceable',
      'welding',
      'brazing',
      'soldering'
    ],
  };

  final seen = <String>{};

  for (final match in matches) {
    final word = match.group(1)!;
    final tr = match.group(2)!;
    final nl = match.group(3)!;
    final de = match.group(4)!;
    final fr = match.group(5)!;
    final es = match.group(6)!;

    if (seen.contains(word.toLowerCase())) continue;
    seen.add(word.toLowerCase());

    String cat = 'general';
    for (final entry in catKeywords.entries) {
      if (entry.value.contains(word.toLowerCase())) {
        cat = entry.key;
        break;
      }
    }

    final level = word.length <= 5 ? 'A1' : (word.length <= 8 ? 'A2' : 'B1');
    final line =
        "      const Term('${word.toUpperCase()}', '$tr', '$level', dutch: '$nl', german: '$de', french: '$fr', spanish: '$es'),";
    categories[cat]!.add(line);
  }

  // Generate output
  final buffer = StringBuffer();
  buffer.writeln('// Aviation Vocabulary Data - Expanded Version');
  buffer.writeln('// Contains ${seen.length} terms');
  buffer.writeln('');
  buffer.writeln("import '../models/vocabulary_models.dart';");
  buffer.writeln('');
  buffer.writeln('// Leagues list');
  buffer.writeln('const List<League> leagues = [');
  buffer.writeln(
      "  League(name: 'Bronz', xp: 0, colors: ['#CD7F32'], desc: 'Başlangıç'),");
  buffer.writeln(
      "  League(name: 'Gümüş', xp: 500, colors: ['#C0C0C0'], desc: 'Gelişen'),");
  buffer.writeln(
      "  League(name: 'Altın', xp: 1500, colors: ['#FFD700'], desc: 'İyi'),");
  buffer.writeln(
      "  League(name: 'Platin', xp: 3000, colors: ['#E5E4E2'], desc: 'Çok iyi'),");
  buffer.writeln(
      "  League(name: 'Elmas', xp: 5000, colors: ['#B9F2FF'], desc: 'Mükemmel'),");
  buffer.writeln(
      "  League(name: 'Şampiyon', xp: 10000, colors: ['#FF6B6B'], desc: 'Uzman'),");
  buffer.writeln('];');
  buffer.writeln('');
  buffer.writeln('// Section titles');
  buffer.writeln('const Map<String, String> sectionTitles = {');
  buffer.writeln("  'safety': '🛡️ Emniyet',");
  buffer.writeln("  'tools': '🔧 Aletler',");
  buffer.writeln("  'aircraft': '✈️ Uçak Parçaları',");
  buffer.writeln("  'electrical': '⚡ Elektrik',");
  buffer.writeln("  'hydraulic': '💧 Hidrolik',");
  buffer.writeln("  'navigation': '🧭 Navigasyon',");
  buffer.writeln("  'emergency': '🚨 Acil Durum',");
  buffer.writeln("  'maintenance': '🔩 Bakım',");
  buffer.writeln("  'general': '📚 Genel',");
  buffer.writeln('};');
  buffer.writeln('');
  buffer.writeln('// Section icons');
  buffer.writeln('const Map<String, String> sectionIcons = {');
  buffer.writeln("  'safety': '🛡️',");
  buffer.writeln("  'tools': '🔧',");
  buffer.writeln("  'aircraft': '✈️',");
  buffer.writeln("  'electrical': '⚡',");
  buffer.writeln("  'hydraulic': '💧',");
  buffer.writeln("  'navigation': '🧭',");
  buffer.writeln("  'emergency': '🚨',");
  buffer.writeln("  'maintenance': '🔩',");
  buffer.writeln("  'general': '📚',");
  buffer.writeln('};');
  buffer.writeln('');
  buffer.writeln('// Main vocabulary organized by category');
  buffer.writeln('final Map<String, CategoryData> vocabulary = {');

  final catInfo = {
    'safety': ['Safety', '🛡️', '1. KISIM'],
    'tools': ['Tools', '🔧', '2. KISIM'],
    'aircraft': ['Aircraft', '✈️', '3. KISIM'],
    'electrical': ['Electrical', '⚡', '4. KISIM'],
    'hydraulic': ['Hydraulic', '💧', '5. KISIM'],
    'navigation': ['Navigation', '🧭', '6. KISIM'],
    'emergency': ['Emergency', '🚨', '7. KISIM'],
    'maintenance': ['Maintenance', '🔩', '8. KISIM'],
    'general': ['General', '📚', '9. KISIM'],
  };

  for (final cat in catInfo.keys) {
    final info = catInfo[cat]!;
    buffer.writeln("  '$cat': CategoryData(");
    buffer.writeln("    title: '${info[0]}',");
    buffer.writeln("    icon: '${info[1]}',");
    buffer.writeln("    section: '${info[2]}',");
    buffer.writeln('    terms: [');
    for (final term in categories[cat]!) {
      buffer.writeln(term);
    }
    buffer.writeln('    ],');
    buffer.writeln('    readings: const [],');
    buffer.writeln('  ),');
  }

  buffer.writeln('};');

  File('lib/data/vocabulary_data_fixed.dart')
      .writeAsStringSync(buffer.toString());
  debugPrint('Generated vocabulary with ${seen.length} unique terms');
  for (final cat in categories.keys) {
    debugPrint('  $cat: ${categories[cat]!.length} terms');
  }
}
