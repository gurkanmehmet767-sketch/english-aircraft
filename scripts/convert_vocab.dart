// Script to expand vocabulary_data_fixed.dart with words from word_dictionary.dart
import 'dart:io';
import 'package:flutter/foundation.dart' show debugPrint;

void main() {
  // Read word_dictionary.dart
  final dictFile = File('lib/data/word_dictionary.dart');
  final content = dictFile.readAsStringSync();
  
  // Parse words - count unique entries
  final regex = RegExp(r"'(\w+)':\s*\{'tr':\s*'([^']*)'");
  final matches = regex.allMatches(content);
  
  debugPrint('Found ${matches.length} words in word_dictionary.dart');
  
  // Group by category
  final categories = <String, List<Map<String, String>>>{
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
  
  // Keywords for categorization
  final catKeywords = {
    'safety': ['safety', 'hazard', 'warning', 'caution', 'protective', 'goggles', 'gloves', 'helmet', 'boots', 'vest', 'harness', 'coveralls', 'respirator', 'shield', 'danger', 'flammable', 'corrosive', 'radiation', 'slippery', 'toxic', 'fumes', 'exposure'],
    'tools': ['tool', 'wrench', 'screwdriver', 'pliers', 'hammer', 'drill', 'socket', 'torque', 'calibration', 'gauge', 'spanner', 'fastener', 'micrometer', 'caliper', 'chisel', 'clamp', 'vice', 'hacksaw', 'cutters', 'adjustable'],
    'aircraft': ['aircraft', 'fuselage', 'wing', 'engine', 'cockpit', 'landing', 'propeller', 'tail', 'flap', 'rudder', 'aileron', 'empennage', 'stabilizer', 'elevator', 'slat', 'spoiler', 'nacelle', 'pylon', 'fairing', 'cabin', 'seat', 'galley'],
    'electrical': ['battery', 'circuit', 'wire', 'voltage', 'current', 'generator', 'switch', 'fuse', 'relay', 'connector', 'electrical', 'power', 'alternator', 'inverter', 'rectifier', 'regulator', 'terminal', 'wiring', 'digital', 'analog', 'signal'],
    'hydraulic': ['hydraulic', 'pump', 'pressure', 'valve', 'reservoir', 'actuator', 'fluid', 'seal', 'cylinder', 'filter', 'pneumatic', 'accumulator', 'servo', 'bleed', 'pressurization'],
    'navigation': ['navigation', 'radar', 'gps', 'compass', 'altimeter', 'heading', 'waypoint', 'transponder', 'autopilot', 'avionics', 'route', 'altitude', 'airspeed', 'distance', 'bearing', 'coordinates', 'latitude', 'longitude', 'track', 'course'],
    'emergency': ['evacuation', 'extinguisher', 'oxygen', 'mask', 'exit', 'alarm', 'rescue', 'survival', 'beacon', 'distress', 'fire', 'emergency', 'escape', 'slide', 'foam', 'hydrant', 'sprinkler', 'detector', 'wound', 'bleeding', 'fracture', 'resuscitation', 'defibrillator'],
    'maintenance': ['maintenance', 'inspection', 'repair', 'replace', 'check', 'test', 'install', 'remove', 'lubricate', 'adjust', 'crack', 'dent', 'corrosion', 'worn', 'alignment', 'leak', 'rivet', 'riveting'],
  };
  
  for (final match in matches) {
    final word = match.group(1)!;
    final turkish = match.group(2)!;
    
    // Find category
    String cat = 'general';
    for (final entry in catKeywords.entries) {
      if (entry.value.contains(word.toLowerCase())) {
        cat = entry.key;
        break;
      }
    }
    
    categories[cat]!.add({'en': word.toUpperCase(), 'tr': turkish});
  }
  
  // Print counts
  for (final entry in categories.entries) {
    debugPrint('${entry.key}: ${entry.value.length} words');
  }
}
