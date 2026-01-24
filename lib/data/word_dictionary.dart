// Ortak Havacılık Kelime Sözlüğü - Tüm Diller
// Common Aviation Word Dictionary - All Languages

const Map<String, Map<String, String>> commonWords = {
  // Temel kelimeler
  'safety': {
    'tr': 'emniyet',
    'nl': 'veiligheid',
    'de': 'Sicherheit',
    'fr': 'sécurité',
    'es': 'seguridad'
  },
  'regulations': {
    'tr': 'yönetmelikler',
    'nl': 'voorschriften',
    'de': 'Vorschriften',
    'fr': 'règlements',
    'es': 'regulaciones'
  },
  'aircraft': {
    'tr': 'uçak',
    'nl': 'vliegtuig',
    'de': 'Flugzeug',
    'fr': 'avion',
    'es': 'aeronave'
  },
  'maintenance': {
    'tr': 'bakım',
    'nl': 'onderhoud',
    'de': 'Wartung',
    'fr': 'maintenance',
    'es': 'mantenimiento'
  },
  'essential': {
    'tr': 'gerekli',
    'nl': 'essentieel',
    'de': 'wesentlich',
    'fr': 'essentiel',
    'es': 'esencial'
  },
  'protecting': {
    'tr': 'koruma',
    'nl': 'beschermen',
    'de': 'Schutz',
    'fr': 'protection',
    'es': 'protección'
  },
  'personnel': {
    'tr': 'personel',
    'nl': 'personeel',
    'de': 'Personal',
    'fr': 'personnel',
    'es': 'personal'
  },
  'equipment': {
    'tr': 'ekipman',
    'nl': 'uitrusting',
    'de': 'Ausrüstung',
    'fr': 'équipement',
    'es': 'equipo'
  },
  'before': {
    'tr': 'önce',
    'nl': 'voor',
    'de': 'vor',
    'fr': 'avant',
    'es': 'antes'
  },
  'starting': {
    'tr': 'başlama',
    'nl': 'starten',
    'de': 'Starten',
    'fr': 'démarrage',
    'es': 'inicio'
  },
  'work': {
    'tr': 'iş',
    'nl': 'werk',
    'de': 'Arbeit',
    'fr': 'travail',
    'es': 'trabajo'
  },
  'technicians': {
    'tr': 'teknisyenler',
    'nl': 'technici',
    'de': 'Techniker',
    'fr': 'techniciens',
    'es': 'técnicos'
  },
  'must': {
    'tr': 'gerekir',
    'nl': 'moet',
    'de': 'muss',
    'fr': 'doit',
    'es': 'debe'
  },
  'attend': {
    'tr': 'katılmak',
    'nl': 'bijwonen',
    'de': 'teilnehmen',
    'fr': 'assister',
    'es': 'asistir'
  },
  'briefing': {
    'tr': 'brifing',
    'nl': 'briefing',
    'de': 'Briefing',
    'fr': 'briefing',
    'es': 'sesión informativa'
  },
  'covers': {
    'tr': 'kapsar',
    'nl': 'omvat',
    'de': 'umfasst',
    'fr': 'couvre',
    'es': 'cubre'
  },
  'hazard': {
    'tr': 'tehlike',
    'nl': 'gevaar',
    'de': 'Gefahr',
    'fr': 'danger',
    'es': 'peligro'
  },
  'identification': {
    'tr': 'tanımlama',
    'nl': 'identificatie',
    'de': 'Identifikation',
    'fr': 'identification',
    'es': 'identificación'
  },
  'risk': {
    'tr': 'risk',
    'nl': 'risico',
    'de': 'Risiko',
    'fr': 'risque',
    'es': 'riesgo'
  },
  'assessment': {
    'tr': 'değerlendirme',
    'nl': 'beoordeling',
    'de': 'Bewertung',
    'fr': 'évaluation',
    'es': 'evaluación'
  },
  'procedures': {
    'tr': 'prosedürler',
    'nl': 'procedures',
    'de': 'Verfahren',
    'fr': 'procédures',
    'es': 'procedimientos'
  },
  'all': {'tr': 'tüm', 'nl': 'alle', 'de': 'alle', 'fr': 'tous', 'es': 'todos'},
  'wear': {
    'tr': 'giymek',
    'nl': 'dragen',
    'de': 'tragen',
    'fr': 'porter',
    'es': 'usar'
  },
  'appropriate': {
    'tr': 'uygun',
    'nl': 'geschikt',
    'de': 'geeignet',
    'fr': 'approprié',
    'es': 'apropiado'
  },
  'personal': {
    'tr': 'kişisel',
    'nl': 'persoonlijk',
    'de': 'persönlich',
    'fr': 'personnel',
    'es': 'personal'
  },
  'protective': {
    'tr': 'koruyucu',
    'nl': 'beschermend',
    'de': 'Schutz-',
    'fr': 'de protection',
    'es': 'protector'
  },
  'including': {
    'tr': 'dahil',
    'nl': 'inclusief',
    'de': 'einschließlich',
    'fr': 'y compris',
    'es': 'incluyendo'
  },
  'goggles': {
    'tr': 'gözlük',
    'nl': 'bril',
    'de': 'Schutzbrille',
    'fr': 'lunettes',
    'es': 'gafas'
  },
  'gloves': {
    'tr': 'eldivenler',
    'nl': 'handschoenen',
    'de': 'Handschuhe',
    'fr': 'gants',
    'es': 'guantes'
  },
  'shoes': {
    'tr': 'ayakkabılar',
    'nl': 'schoenen',
    'de': 'Schuhe',
    'fr': 'chaussures',
    'es': 'zapatos'
  },
  'working': {
    'tr': 'çalışma',
    'nl': 'werken',
    'de': 'Arbeiten',
    'fr': 'travail',
    'es': 'trabajo'
  },
  'restricted': {
    'tr': 'kısıtlı',
    'nl': 'beperkt',
    'de': 'eingeschränkt',
    'fr': 'restreint',
    'es': 'restringido'
  },
  'areas': {
    'tr': 'alanlar',
    'nl': 'gebieden',
    'de': 'Bereiche',
    'fr': 'zones',
    'es': 'áreas'
  },
  'requires': {
    'tr': 'gerektirir',
    'nl': 'vereist',
    'de': 'erfordert',
    'fr': 'nécessite',
    'es': 'requiere'
  },
  'special': {
    'tr': 'özel',
    'nl': 'speciaal',
    'de': 'spezial',
    'fr': 'spécial',
    'es': 'especial'
  },
  'authorization': {
    'tr': 'yetkilendirme',
    'nl': 'autorisatie',
    'de': 'Genehmigung',
    'fr': 'autorisation',
    'es': 'autorización'
  },
  'additional': {
    'tr': 'ek',
    'nl': 'extra',
    'de': 'zusätzlich',
    'fr': 'supplémentaire',
    'es': 'adicional'
  },
  'precautions': {
    'tr': 'önlemler',
    'nl': 'voorzorgsmaatregelen',
    'de': 'Vorsichtsmaßnahmen',
    'fr': 'précautions',
    'es': 'precauciones'
  },

  // Acil durum kelimeleri
  'emergency': {
    'tr': 'acil',
    'nl': 'nood',
    'de': 'Notfall',
    'fr': 'urgence',
    'es': 'emergencia'
  },
  'exit': {
    'tr': 'çıkış',
    'nl': 'uitgang',
    'de': 'Ausgang',
    'fr': 'sortie',
    'es': 'salida'
  },
  'fire': {
    'tr': 'yangın',
    'nl': 'brand',
    'de': 'Feuer',
    'fr': 'feu',
    'es': 'fuego'
  },
  'extinguisher': {
    'tr': 'söndürücü',
    'nl': 'blusser',
    'de': 'Löscher',
    'fr': 'extincteur',
    'es': 'extintor'
  },
  'alarm': {
    'tr': 'alarm',
    'nl': 'alarm',
    'de': 'Alarm',
    'fr': 'alarme',
    'es': 'alarma'
  },
  'evacuation': {
    'tr': 'tahliye',
    'nl': 'evacuatie',
    'de': 'Evakuierung',
    'fr': 'évacuation',
    'es': 'evacuación'
  },
  'drill': {
    'tr': 'tatbikat',
    'nl': 'oefening',
    'de': 'Übung',
    'fr': 'exercice',
    'es': 'simulacro'
  },
  'assembly': {
    'tr': 'toplanma',
    'nl': 'verzameling',
    'de': 'Sammlung',
    'fr': 'rassemblement',
    'es': 'reunión'
  },
  'point': {
    'tr': 'nokta',
    'nl': 'punt',
    'de': 'Punkt',
    'fr': 'point',
    'es': 'punto'
  },

  // Atölye kelimeleri
  'workshop': {
    'tr': 'atölye',
    'nl': 'werkplaats',
    'de': 'Werkstatt',
    'fr': 'atelier',
    'es': 'taller'
  },
  'tool': {
    'tr': 'alet',
    'nl': 'gereedschap',
    'de': 'Werkzeug',
    'fr': 'outil',
    'es': 'herramienta'
  },
  'tools': {
    'tr': 'aletler',
    'nl': 'gereedschappen',
    'de': 'Werkzeuge',
    'fr': 'outils',
    'es': 'herramientas'
  },
  'bench': {
    'tr': 'tezgah',
    'nl': 'werkbank',
    'de': 'Werkbank',
    'fr': 'établi',
    'es': 'banco'
  },
  'drilling': {
    'tr': 'delme/matkap',
    'nl': 'boren',
    'de': 'Bohren',
    'fr': 'perçage',
    'es': 'perforación'
  },
  'grinder': {
    'tr': 'taşlama',
    'nl': 'slijper',
    'de': 'Schleifer',
    'fr': 'meuleuse',
    'es': 'amoladora'
  },
  'cutting': {
    'tr': 'kesme',
    'nl': 'snijden',
    'de': 'Schneiden',
    'fr': 'coupe',
    'es': 'corte'
  },
  'fluid': {
    'tr': 'sıvı',
    'nl': 'vloeistof',
    'de': 'Flüssigkeit',
    'fr': 'fluide',
    'es': 'fluido'
  },
  'metal': {
    'tr': 'metal',
    'nl': 'metaal',
    'de': 'Metall',
    'fr': 'métal',
    'es': 'metal'
  },
  'prevent': {
    'tr': 'önlemek',
    'nl': 'voorkomen',
    'de': 'verhindern',
    'fr': 'prévenir',
    'es': 'prevenir'
  },
  'overheating': {
    'tr': 'aşırı ısınma',
    'nl': 'oververhitting',
    'de': 'Überhitzung',
    'fr': 'surchauffe',
    'es': 'sobrecalentamiento'
  },

  // El aletleri
  'spanner': {
    'tr': 'anahtar',
    'nl': 'moersleutel',
    'de': 'Schraubenschlüssel',
    'fr': 'clé',
    'es': 'llave'
  },
  'wrench': {
    'tr': 'anahtar',
    'nl': 'sleutel',
    'de': 'Schlüssel',
    'fr': 'clé',
    'es': 'llave'
  },
  'screwdriver': {
    'tr': 'tornavida',
    'nl': 'schroevendraaier',
    'de': 'Schraubendreher',
    'fr': 'tournevis',
    'es': 'destornillador'
  },
  'pliers': {
    'tr': 'pense',
    'nl': 'tang',
    'de': 'Zange',
    'fr': 'pince',
    'es': 'alicates'
  },
  'hammer': {
    'tr': 'çekiç',
    'nl': 'hamer',
    'de': 'Hammer',
    'fr': 'marteau',
    'es': 'martillo'
  },
  'torque': {
    'tr': 'tork',
    'nl': 'koppel',
    'de': 'Drehmoment',
    'fr': 'couple',
    'es': 'par'
  },
  'socket': {
    'tr': 'lokma',
    'nl': 'dop',
    'de': 'Stecknuss',
    'fr': 'douille',
    'es': 'vaso'
  },
  'fastener': {
    'tr': 'bağlayıcı',
    'nl': 'bevestiger',
    'de': 'Befestiger',
    'fr': 'fixation',
    'es': 'sujetador'
  },
  'tightening': {
    'tr': 'sıkma',
    'nl': 'aandraaien',
    'de': 'Anziehen',
    'fr': 'serrage',
    'es': 'apriete'
  },

  // Ölçüm kelimeleri
  'measurement': {
    'tr': 'ölçüm',
    'nl': 'meting',
    'de': 'Messung',
    'fr': 'mesure',
    'es': 'medición'
  },
  'precision': {
    'tr': 'hassasiyet',
    'nl': 'precisie',
    'de': 'Präzision',
    'fr': 'précision',
    'es': 'precisión'
  },
  'micrometer': {
    'tr': 'mikrometre',
    'nl': 'micrometer',
    'de': 'Mikrometer',
    'fr': 'micromètre',
    'es': 'micrómetro'
  },
  'caliper': {
    'tr': 'kumpas',
    'nl': 'schuifmaat',
    'de': 'Schieblehre',
    'fr': 'pied à coulisse',
    'es': 'calibrador'
  },
  'gauge': {
    'tr': 'ölçer',
    'nl': 'meter',
    'de': 'Messgerät',
    'fr': 'jauge',
    'es': 'galga'
  },
  'tolerance': {
    'tr': 'tolerans',
    'nl': 'tolerantie',
    'de': 'Toleranz',
    'fr': 'tolérance',
    'es': 'tolerancia'
  },
  'clearance': {
    'tr': 'boşluk',
    'nl': 'speling',
    'de': 'Spiel',
    'fr': 'jeu',
    'es': 'holgura'
  },
  'accuracy': {
    'tr': 'doğruluk',
    'nl': 'nauwkeurigheid',
    'de': 'Genauigkeit',
    'fr': 'exactitude',
    'es': 'exactitud'
  },
  'calibration': {
    'tr': 'kalibrasyon',
    'nl': 'kalibratie',
    'de': 'Kalibrierung',
    'fr': 'étalonnage',
    'es': 'calibración'
  },

  // Kaynak kelimeleri
  'welding': {
    'tr': 'kaynak',
    'nl': 'lassen',
    'de': 'Schweißen',
    'fr': 'soudage',
    'es': 'soldadura'
  },
  'brazing': {
    'tr': 'lehimleme',
    'nl': 'hardsolderen',
    'de': 'Hartlöten',
    'fr': 'brasage',
    'es': 'soldadura fuerte'
  },
  'soldering': {
    'tr': 'havya ile lehimleme',
    'nl': 'solderen',
    'de': 'Löten',
    'fr': 'soudure',
    'es': 'soldadura blanda'
  },
  'electrode': {
    'tr': 'elektrot',
    'nl': 'elektrode',
    'de': 'Elektrode',
    'fr': 'électrode',
    'es': 'electrodo'
  },
  'filler': {
    'tr': 'dolgu',
    'nl': 'vulmateriaal',
    'de': 'Füllmaterial',
    'fr': 'matériau d\'apport',
    'es': 'material de aporte'
  },
  'shielding': {
    'tr': 'koruyucu',
    'nl': 'afschermend',
    'de': 'Schutz-',
    'fr': 'de protection',
    'es': 'de protección'
  },
  'gas': {'tr': 'gaz', 'nl': 'gas', 'de': 'Gas', 'fr': 'gaz', 'es': 'gas'},

  // Bakım kelimeleri
  'inspection': {
    'tr': 'muayene',
    'nl': 'inspectie',
    'de': 'Inspektion',
    'fr': 'inspection',
    'es': 'inspección'
  },
  'installation': {
    'tr': 'kurulum',
    'nl': 'installatie',
    'de': 'Installation',
    'fr': 'installation',
    'es': 'instalación'
  },
  'alignment': {
    'tr': 'hizalama',
    'nl': 'uitlijning',
    'de': 'Ausrichtung',
    'fr': 'alignement',
    'es': 'alineación'
  },
  'crack': {
    'tr': 'çatlak',
    'nl': 'scheur',
    'de': 'Riss',
    'fr': 'fissure',
    'es': 'grieta'
  },
  'dent': {
    'tr': 'ezik',
    'nl': 'deuk',
    'de': 'Delle',
    'fr': 'bosse',
    'es': 'abolladura'
  },
  'corrosion': {
    'tr': 'korozyon',
    'nl': 'corrosie',
    'de': 'Korrosion',
    'fr': 'corrosion',
    'es': 'corrosión'
  },
  'worn': {
    'tr': 'aşınmış',
    'nl': 'versleten',
    'de': 'abgenutzt',
    'fr': 'usé',
    'es': 'desgastado'
  },
  'repair': {
    'tr': 'onarım',
    'nl': 'reparatie',
    'de': 'Reparatur',
    'fr': 'réparation',
    'es': 'reparación'
  },
  'replace': {
    'tr': 'değiştirmek',
    'nl': 'vervangen',
    'de': 'ersetzen',
    'fr': 'remplacer',
    'es': 'reemplazar'
  },
  'check': {
    'tr': 'kontrol',
    'nl': 'controle',
    'de': 'Prüfung',
    'fr': 'vérification',
    'es': 'verificación'
  },
  'test': {
    'tr': 'test',
    'nl': 'test',
    'de': 'Test',
    'fr': 'test',
    'es': 'prueba'
  },
  'pressure': {
    'tr': 'basınç',
    'nl': 'druk',
    'de': 'Druck',
    'fr': 'pression',
    'es': 'presión'
  },
  'leak': {
    'tr': 'sızıntı',
    'nl': 'lek',
    'de': 'Leck',
    'fr': 'fuite',
    'es': 'fuga'
  },

  // Uçak parçaları
  'wing': {
    'tr': 'kanat',
    'nl': 'vleugel',
    'de': 'Flügel',
    'fr': 'aile',
    'es': 'ala'
  },
  'fuselage': {
    'tr': 'gövde',
    'nl': 'romp',
    'de': 'Rumpf',
    'fr': 'fuselage',
    'es': 'fuselaje'
  },
  'engine': {
    'tr': 'motor',
    'nl': 'motor',
    'de': 'Motor',
    'fr': 'moteur',
    'es': 'motor'
  },
  'cockpit': {
    'tr': 'kokpit',
    'nl': 'cockpit',
    'de': 'Cockpit',
    'fr': 'cockpit',
    'es': 'cabina'
  },
  'landing': {
    'tr': 'iniş',
    'nl': 'landing',
    'de': 'Landung',
    'fr': 'atterrissage',
    'es': 'aterrizaje'
  },
  'gear': {
    'tr': 'takım',
    'nl': 'toestel',
    'de': 'Fahrwerk',
    'fr': 'train',
    'es': 'tren'
  },
  'flap': {
    'tr': 'flap',
    'nl': 'flap',
    'de': 'Klappe',
    'fr': 'volet',
    'es': 'flap'
  },
  'rudder': {
    'tr': 'dümen',
    'nl': 'roer',
    'de': 'Ruder',
    'fr': 'gouvernail',
    'es': 'timón'
  },
  'aileron': {
    'tr': 'kanatçık',
    'nl': 'rolroer',
    'de': 'Querruder',
    'fr': 'aileron',
    'es': 'alerón'
  },
  'tail': {
    'tr': 'kuyruk',
    'nl': 'staart',
    'de': 'Heck',
    'fr': 'queue',
    'es': 'cola'
  },
  'propeller': {
    'tr': 'pervane',
    'nl': 'propeller',
    'de': 'Propeller',
    'fr': 'hélice',
    'es': 'hélice'
  },
  'hydraulic': {
    'tr': 'hidrolik',
    'nl': 'hydraulisch',
    'de': 'hydraulisch',
    'fr': 'hydraulique',
    'es': 'hidráulico'
  },
  'pneumatic': {
    'tr': 'pnömatik',
    'nl': 'pneumatisch',
    'de': 'pneumatisch',
    'fr': 'pneumatique',
    'es': 'neumático'
  },
  'electrical': {
    'tr': 'elektrik',
    'nl': 'elektrisch',
    'de': 'elektrisch',
    'fr': 'électrique',
    'es': 'eléctrico'
  },
  'fuel': {
    'tr': 'yakıt',
    'nl': 'brandstof',
    'de': 'Treibstoff',
    'fr': 'carburant',
    'es': 'combustible'
  },
  'oil': {'tr': 'yağ', 'nl': 'olie', 'de': 'Öl', 'fr': 'huile', 'es': 'aceite'},

  // Genel fiiller
  'is': {'tr': 'dir', 'nl': 'is', 'de': 'ist', 'fr': 'est', 'es': 'es'},
  'are': {
    'tr': 'vardır',
    'nl': 'zijn',
    'de': 'sind',
    'fr': 'sont',
    'es': 'son'
  },
  'the': {
    'tr': '',
    'nl': 'de/het',
    'de': 'der/die/das',
    'fr': 'le/la',
    'es': 'el/la'
  },
  'a': {'tr': 'bir', 'nl': 'een', 'de': 'ein', 'fr': 'un/une', 'es': 'un/una'},
  'and': {'tr': 've', 'nl': 'en', 'de': 'und', 'fr': 'et', 'es': 'y'},
  'or': {'tr': 'veya', 'nl': 'of', 'de': 'oder', 'fr': 'ou', 'es': 'o'},
  'for': {'tr': 'için', 'nl': 'voor', 'de': 'für', 'fr': 'pour', 'es': 'para'},
  'in': {'tr': 'içinde', 'nl': 'in', 'de': 'in', 'fr': 'dans', 'es': 'en'},
  'on': {'tr': 'üzerinde', 'nl': 'op', 'de': 'auf', 'fr': 'sur', 'es': 'en'},
  'to': {'tr': 'için', 'nl': 'naar', 'de': 'zu', 'fr': 'à', 'es': 'a'},
  'with': {'tr': 'ile', 'nl': 'met', 'de': 'mit', 'fr': 'avec', 'es': 'con'},
  'by': {
    'tr': 'tarafından',
    'nl': 'door',
    'de': 'von',
    'fr': 'par',
    'es': 'por'
  },
  'this': {'tr': 'bu', 'nl': 'dit', 'de': 'dies', 'fr': 'ce', 'es': 'este'},
  'that': {'tr': 'şu', 'nl': 'dat', 'de': 'das', 'fr': 'cela', 'es': 'ese'},
  'these': {
    'tr': 'bunlar',
    'nl': 'deze',
    'de': 'diese',
    'fr': 'ces',
    'es': 'estos'
  },
  'those': {
    'tr': 'şunlar',
    'nl': 'die',
    'de': 'jene',
    'fr': 'ceux',
    'es': 'esos'
  },
  'can': {
    'tr': 'yapabilir',
    'nl': 'kan',
    'de': 'kann',
    'fr': 'peut',
    'es': 'puede'
  },
  'should': {
    'tr': 'yapmalı',
    'nl': 'zou moeten',
    'de': 'sollte',
    'fr': 'devrait',
    'es': 'debería'
  },
  'will': {
    'tr': 'yapacak',
    'nl': 'zal',
    'de': 'wird',
    'fr': 'va',
    'es': 'va a'
  },
  'have': {
    'tr': 'sahip olmak',
    'nl': 'hebben',
    'de': 'haben',
    'fr': 'avoir',
    'es': 'tener'
  },
  'has': {
    'tr': 'sahiptir',
    'nl': 'heeft',
    'de': 'hat',
    'fr': 'a',
    'es': 'tiene'
  },
  'been': {
    'tr': 'olmuş',
    'nl': 'geweest',
    'de': 'gewesen',
    'fr': 'été',
    'es': 'sido'
  },
  'being': {
    'tr': 'olmak',
    'nl': 'zijn',
    'de': 'sein',
    'fr': 'être',
    'es': 'ser'
  },
  'use': {
    'tr': 'kullanmak',
    'nl': 'gebruiken',
    'de': 'verwenden',
    'fr': 'utiliser',
    'es': 'usar'
  },
  'used': {
    'tr': 'kullanılmış',
    'nl': 'gebruikt',
    'de': 'verwendet',
    'fr': 'utilisé',
    'es': 'usado'
  },
  'using': {
    'tr': 'kullanarak',
    'nl': 'gebruikend',
    'de': 'verwendend',
    'fr': 'utilisant',
    'es': 'usando'
  },
  'ensure': {
    'tr': 'sağlamak',
    'nl': 'verzekeren',
    'de': 'sicherstellen',
    'fr': 'assurer',
    'es': 'asegurar'
  },
  'proper': {
    'tr': 'uygun',
    'nl': 'juist',
    'de': 'richtig',
    'fr': 'approprié',
    'es': 'adecuado'
  },
  'correct': {
    'tr': 'doğru',
    'nl': 'correct',
    'de': 'korrekt',
    'fr': 'correct',
    'es': 'correcto'
  },
  'incorrect': {
    'tr': 'yanlış',
    'nl': 'onjuist',
    'de': 'falsch',
    'fr': 'incorrect',
    'es': 'incorrecto'
  },
  'important': {
    'tr': 'önemli',
    'nl': 'belangrijk',
    'de': 'wichtig',
    'fr': 'important',
    'es': 'importante'
  },
  'necessary': {
    'tr': 'gerekli',
    'nl': 'noodzakelijk',
    'de': 'notwendig',
    'fr': 'nécessaire',
    'es': 'necesario'
  },
  'required': {
    'tr': 'gerekli',
    'nl': 'vereist',
    'de': 'erforderlich',
    'fr': 'requis',
    'es': 'requerido'
  },
  'complete': {
    'tr': 'tamamlamak',
    'nl': 'voltooien',
    'de': 'abschließen',
    'fr': 'compléter',
    'es': 'completar'
  },
  'completed': {
    'tr': 'tamamlanmış',
    'nl': 'voltooid',
    'de': 'abgeschlossen',
    'fr': 'complété',
    'es': 'completado'
  },
  'follow': {
    'tr': 'takip etmek',
    'nl': 'volgen',
    'de': 'folgen',
    'fr': 'suivre',
    'es': 'seguir'
  },
  'according': {
    'tr': 'göre',
    'nl': 'volgens',
    'de': 'gemäß',
    'fr': 'selon',
    'es': 'según'
  },
  'standard': {
    'tr': 'standart',
    'nl': 'standaard',
    'de': 'Standard',
    'fr': 'standard',
    'es': 'estándar'
  },
  'specification': {
    'tr': 'şartname',
    'nl': 'specificatie',
    'de': 'Spezifikation',
    'fr': 'spécification',
    'es': 'especificación'
  },
  'manual': {
    'tr': 'kılavuz',
    'nl': 'handleiding',
    'de': 'Handbuch',
    'fr': 'manuel',
    'es': 'manual'
  },
  'procedure': {
    'tr': 'prosedür',
    'nl': 'procedure',
    'de': 'Verfahren',
    'fr': 'procédure',
    'es': 'procedimiento'
  },
  'system': {
    'tr': 'sistem',
    'nl': 'systeem',
    'de': 'System',
    'fr': 'système',
    'es': 'sistema'
  },
  'component': {
    'tr': 'bileşen',
    'nl': 'component',
    'de': 'Komponente',
    'fr': 'composant',
    'es': 'componente'
  },
  'part': {
    'tr': 'parça',
    'nl': 'onderdeel',
    'de': 'Teil',
    'fr': 'pièce',
    'es': 'pieza'
  },
  'parts': {
    'tr': 'parçalar',
    'nl': 'onderdelen',
    'de': 'Teile',
    'fr': 'pièces',
    'es': 'piezas'
  },
  'surface': {
    'tr': 'yüzey',
    'nl': 'oppervlak',
    'de': 'Oberfläche',
    'fr': 'surface',
    'es': 'superficie'
  },
  'material': {
    'tr': 'malzeme',
    'nl': 'materiaal',
    'de': 'Material',
    'fr': 'matériau',
    'es': 'material'
  },
  'materials': {
    'tr': 'malzemeler',
    'nl': 'materialen',
    'de': 'Materialien',
    'fr': 'matériaux',
    'es': 'materiales'
  },
  'quality': {
    'tr': 'kalite',
    'nl': 'kwaliteit',
    'de': 'Qualität',
    'fr': 'qualité',
    'es': 'calidad'
  },
  'performance': {
    'tr': 'performans',
    'nl': 'prestatie',
    'de': 'Leistung',
    'fr': 'performance',
    'es': 'rendimiento'
  },
  'operation': {
    'tr': 'işlem',
    'nl': 'operatie',
    'de': 'Betrieb',
    'fr': 'opération',
    'es': 'operación'
  },
  'operations': {
    'tr': 'işlemler',
    'nl': 'operaties',
    'de': 'Operationen',
    'fr': 'opérations',
    'es': 'operaciones'
  },
  'function': {
    'tr': 'fonksiyon',
    'nl': 'functie',
    'de': 'Funktion',
    'fr': 'fonction',
    'es': 'función'
  },
  'functional': {
    'tr': 'fonksiyonel',
    'nl': 'functioneel',
    'de': 'funktionell',
    'fr': 'fonctionnel',
    'es': 'funcional'
  },
  'adjust': {
    'tr': 'ayarlamak',
    'nl': 'aanpassen',
    'de': 'anpassen',
    'fr': 'ajuster',
    'es': 'ajustar'
  },
  'adjustment': {
    'tr': 'ayar',
    'nl': 'aanpassing',
    'de': 'Anpassung',
    'fr': 'ajustement',
    'es': 'ajuste'
  },
  'remove': {
    'tr': 'kaldırmak',
    'nl': 'verwijderen',
    'de': 'entfernen',
    'fr': 'retirer',
    'es': 'quitar'
  },
  'install': {
    'tr': 'kurmak',
    'nl': 'installeren',
    'de': 'installieren',
    'fr': 'installer',
    'es': 'instalar'
  },
  'connect': {
    'tr': 'bağlamak',
    'nl': 'verbinden',
    'de': 'verbinden',
    'fr': 'connecter',
    'es': 'conectar'
  },
  'disconnect': {
    'tr': 'ayırmak',
    'nl': 'loskoppelen',
    'de': 'trennen',
    'fr': 'déconnecter',
    'es': 'desconectar'
  },
  'secure': {
    'tr': 'güvenli',
    'nl': 'beveiligen',
    'de': 'sichern',
    'fr': 'sécuriser',
    'es': 'asegurar'
  },
  'verify': {
    'tr': 'doğrulamak',
    'nl': 'verifiëren',
    'de': 'überprüfen',
    'fr': 'vérifier',
    'es': 'verificar'
  },
  'report': {
    'tr': 'rapor',
    'nl': 'rapport',
    'de': 'Bericht',
    'fr': 'rapport',
    'es': 'informe'
  },
  'document': {
    'tr': 'belge',
    'nl': 'document',
    'de': 'Dokument',
    'fr': 'document',
    'es': 'documento'
  },
  'record': {
    'tr': 'kayıt',
    'nl': 'record',
    'de': 'Aufzeichnung',
    'fr': 'enregistrement',
    'es': 'registro'
  },

  // Ek fiiller ve isimler
  'extends': {
    'tr': 'uzatır',
    'nl': 'verlengt',
    'de': 'verlängert',
    'fr': 'prolonge',
    'es': 'extiende'
  },
  'ensures': {
    'tr': 'sağlar',
    'nl': 'zorgt ervoor',
    'de': 'stellt sicher',
    'fr': 'assure',
    'es': 'asegura'
  },
  'stored': {
    'tr': 'depolanmış',
    'nl': 'opgeslagen',
    'de': 'gelagert',
    'fr': 'stocké',
    'es': 'almacenado'
  },
  'designated': {
    'tr': 'belirlenmiş',
    'nl': 'aangewezen',
    'de': 'bestimmt',
    'fr': 'désigné',
    'es': 'designado'
  },
  'locations': {
    'tr': 'konumlar',
    'nl': 'locaties',
    'de': 'Standorte',
    'fr': 'emplacements',
    'es': 'ubicaciones'
  },
  'after': {
    'tr': 'sonra',
    'nl': 'na',
    'de': 'nach',
    'fr': 'après',
    'es': 'después'
  },
  'damaged': {
    'tr': 'hasarlı',
    'nl': 'beschadigd',
    'de': 'beschädigt',
    'fr': 'endommagé',
    'es': 'dañado'
  },
  'immediately': {
    'tr': 'derhal',
    'nl': 'onmiddellijk',
    'de': 'sofort',
    'fr': 'immédiatement',
    'es': 'inmediatamente'
  },
  'removed': {
    'tr': 'kaldırılmış',
    'nl': 'verwijderd',
    'de': 'entfernt',
    'fr': 'retiré',
    'es': 'quitado'
  },
  'service': {
    'tr': 'servis',
    'nl': 'dienst',
    'de': 'Service',
    'fr': 'service',
    'es': 'servicio'
  },
  'responsible': {
    'tr': 'sorumlu',
    'nl': 'verantwoordelijk',
    'de': 'verantwortlich',
    'fr': 'responsable',
    'es': 'responsable'
  },
  'keeping': {
    'tr': 'tutmak',
    'nl': 'houden',
    'de': 'halten',
    'fr': 'garder',
    'es': 'mantener'
  },
  'clean': {
    'tr': 'temiz',
    'nl': 'schoon',
    'de': 'sauber',
    'fr': 'propre',
    'es': 'limpio'
  },
  'organized': {
    'tr': 'düzenli',
    'nl': 'georganiseerd',
    'de': 'organisiert',
    'fr': 'organisé',
    'es': 'organizado'
  },
  'life': {
    'tr': 'ömür',
    'nl': 'leven',
    'de': 'Lebensdauer',
    'fr': 'durée de vie',
    'es': 'vida útil'
  },
  'when': {
    'tr': 'zaman',
    'nl': 'wanneer',
    'de': 'wann',
    'fr': 'quand',
    'es': 'cuando'
  },
  'remains': {
    'tr': 'kalır',
    'nl': 'blijft',
    'de': 'bleibt',
    'fr': 'reste',
    'es': 'permanece'
  },
  'serviceable': {
    'tr': 'kullanılabilir',
    'nl': 'bruikbaar',
    'de': 'betriebsfähig',
    'fr': 'en bon état',
    'es': 'utilizable'
  },
  'good': {'tr': 'iyi', 'nl': 'goed', 'de': 'gut', 'fr': 'bon', 'es': 'bueno'},
  'housekeeping': {
    'tr': 'düzen',
    'nl': 'huishouding',
    'de': 'Hauskeeping',
    'fr': 'entretien',
    'es': 'limpieza'
  },
  'prevents': {
    'tr': 'önler',
    'nl': 'voorkomt',
    'de': 'verhindert',
    'fr': 'empêche',
    'es': 'previene'
  },
  'accidents': {
    'tr': 'kazalar',
    'nl': 'ongevallen',
    'de': 'Unfälle',
    'fr': 'accidents',
    'es': 'accidentes'
  },
  'specialized': {
    'tr': 'özel',
    'nl': 'gespecialiseerd',
    'de': 'spezialisiert',
    'fr': 'spécialisé',
    'es': 'especializado'
  },
  'requiring': {
    'tr': 'gerektiren',
    'nl': 'vereisend',
    'de': 'erfordern',
    'fr': 'nécessitant',
    'es': 'requiere'
  },
  'training': {
    'tr': 'eğitim',
    'nl': 'training',
    'de': 'Schulung',
    'fr': 'formation',
    'es': 'formación'
  },
  'regular': {
    'tr': 'düzenli',
    'nl': 'regelmatig',
    'de': 'regelmäßig',
    'fr': 'régulier',
    'es': 'regular'
  },

  // Reading metin kelimeleri
  'supervisor': {
    'tr': 'süpervizör',
    'nl': 'supervisor',
    'de': 'Vorgesetzter',
    'fr': 'superviseur',
    'es': 'supervisor'
  },
  'checking': {
    'tr': 'kontrol etme',
    'nl': 'controleren',
    'de': 'überprüfen',
    'fr': 'vérification',
    'es': 'verificación'
  },
  'each': {
    'tr': 'her',
    'nl': 'elk',
    'de': 'jede',
    'fr': 'chaque',
    'es': 'cada'
  },
  'during': {
    'tr': 'sırasında',
    'nl': 'tijdens',
    'de': 'während',
    'fr': 'pendant',
    'es': 'durante'
  },
  'failure': {
    'tr': 'arıza',
    'nl': 'storing',
    'de': 'Ausfall',
    'fr': 'panne',
    'es': 'falla'
  },

  // Safety Culture kelimeleri
  'govern': {
    'tr': 'yönetmek',
    'nl': 'regeren',
    'de': 'regieren',
    'fr': 'régir',
    'es': 'gobernar'
  },
  'prioritizes': {
    'tr': 'önceliklendirir',
    'nl': 'geeft prioriteit aan',
    'de': 'priorisiert',
    'fr': 'priorise',
    'es': 'prioriza'
  },
  'schedule': {
    'tr': 'program',
    'nl': 'schema',
    'de': 'Zeitplan',
    'fr': 'calendrier',
    'es': 'horario'
  },
  'understand': {
    'tr': 'anlamak',
    'nl': 'begrijpen',
    'de': 'verstehen',
    'fr': 'comprendre',
    'es': 'entender'
  },
  'accidental': {
    'tr': 'kazara',
    'nl': 'per ongeluk',
    'de': 'versehentlich',
    'fr': 'accidentel',
    'es': 'accidental'
  },
  'retraction': {
    'tr': 'geri çekme',
    'nl': 'intrekking',
    'de': 'Rückzug',
    'fr': 'rétraction',
    'es': 'retracción'
  },
  'specific': {
    'tr': 'özel',
    'nl': 'specifiek',
    'de': 'spezifisch',
    'fr': 'spécifique',
    'es': 'específico'
  },
  'opening': {
    'tr': 'açma',
    'nl': 'opening',
    'de': 'Öffnung',
    'fr': 'ouverture',
    'es': 'apertura'
  },
  'promotes': {
    'tr': 'teşvik eder',
    'nl': 'bevordert',
    'de': 'fördert',
    'fr': 'favorise',
    'es': 'promueve'
  },
  'reporting': {
    'tr': 'raporlama',
    'nl': 'rapporteren',
    'de': 'Berichterstattung',
    'fr': 'signalement',
    'es': 'reporte'
  },
  'incidents': {
    'tr': 'olaylar',
    'nl': 'incidenten',
    'de': 'Vorfälle',
    'fr': 'incidents',
    'es': 'incidentes'
  },
  'without': {
    'tr': 'olmadan',
    'nl': 'zonder',
    'de': 'ohne',
    'fr': 'sans',
    'es': 'sin'
  },
  'fear': {
    'tr': 'korku',
    'nl': 'angst',
    'de': 'Angst',
    'fr': 'peur',
    'es': 'miedo'
  },
  'meetings': {
    'tr': 'toplantılar',
    'nl': 'vergaderingen',
    'de': 'Besprechungen',
    'fr': 'réunions',
    'es': 'reuniones'
  },
  'reinforce': {
    'tr': 'pekiştirmek',
    'nl': 'versterken',
    'de': 'verstärken',
    'fr': 'renforcer',
    'es': 'reforzar'
  },
  'compliance': {
    'tr': 'uyum',
    'nl': 'naleving',
    'de': 'Konformität',
    'fr': 'conformité',
    'es': 'cumplimiento'
  },
  'facilities': {
    'tr': 'tesisler',
    'nl': 'faciliteiten',
    'de': 'Einrichtungen',
    'fr': 'installations',
    'es': 'instalaciones'
  },
  'strict': {
    'tr': 'sıkı',
    'nl': 'strikt',
    'de': 'streng',
    'fr': 'strict',
    'es': 'estricto'
  },
  'begins': {
    'tr': 'başlar',
    'nl': 'begint',
    'de': 'beginnt',
    'fr': 'commence',
    'es': 'comienza'
  },
  'continues': {
    'tr': 'devam eder',
    'nl': 'gaat door',
    'de': 'geht weiter',
    'fr': 'continue',
    'es': 'continúa'
  },
  'through': {
    'tr': 'boyunca',
    'nl': 'door',
    'de': 'durch',
    'fr': 'à travers',
    'es': 'a través de'
  },
  'daily': {
    'tr': 'günlük',
    'nl': 'dagelijks',
    'de': 'täglich',
    'fr': 'quotidien',
    'es': 'diario'
  },
  'installed': {
    'tr': 'takılmış',
    'nl': 'geïnstalleerd',
    'de': 'installiert',
    'fr': 'installé',
    'es': 'instalado'
  },
  'authorized': {
    'tr': 'yetkili',
    'nl': 'geautoriseerd',
    'de': 'autorisiert',
    'fr': 'autorisé',
    'es': 'autorizado'
  },
  'entry': {
    'tr': 'giriş',
    'nl': 'toegang',
    'de': 'Eintrag',
    'fr': 'entrée',
    'es': 'entrada'
  },
  'protect': {
    'tr': 'korumak',
    'nl': 'beschermen',
    'de': 'schützen',
    'fr': 'protéger',
    'es': 'proteger'
  },
  'both': {
    'tr': 'her ikisi',
    'nl': 'beide',
    'de': 'beide',
    'fr': 'les deux',
    'es': 'ambos'
  },

  // Aviyonik Sistemler (Avionics)
  'avionics': {
    'tr': 'aviyonik',
    'nl': 'avionica',
    'de': 'Avionik',
    'fr': 'avionique',
    'es': 'aviónica'
  },
  'radar': {
    'tr': 'radar',
    'nl': 'radar',
    'de': 'Radar',
    'fr': 'radar',
    'es': 'radar'
  },
  'transponder': {
    'tr': 'transponder',
    'nl': 'transponder',
    'de': 'Transponder',
    'fr': 'transpondeur',
    'es': 'transpondedor'
  },
  'altimeter': {
    'tr': 'irtifa ölçer',
    'nl': 'hoogtemeter',
    'de': 'Höhenmesser',
    'fr': 'altimètre',
    'es': 'altímetro'
  },
  'display': {
    'tr': 'gösterge',
    'nl': 'display',
    'de': 'Anzeige',
    'fr': 'affichage',
    'es': 'pantalla'
  },
  'autopilot': {
    'tr': 'otopilot',
    'nl': 'automatische piloot',
    'de': 'Autopilot',
    'fr': 'pilote automatique',
    'es': 'piloto automático'
  },
  'navigation': {
    'tr': 'navigasyon',
    'nl': 'navigatie',
    'de': 'Navigation',
    'fr': 'navigation',
    'es': 'navegación'
  },
  'communication': {
    'tr': 'iletişim',
    'nl': 'communicatie',
    'de': 'Kommunikation',
    'fr': 'communication',
    'es': 'comunicación'
  },
  'instrument': {
    'tr': 'cihaz',
    'nl': 'instrument',
    'de': 'Instrument',
    'fr': 'instrument',
    'es': 'instrumento'
  },
  'sensor': {
    'tr': 'sensör',
    'nl': 'sensor',
    'de': 'Sensor',
    'fr': 'capteur',
    'es': 'sensor'
  },
  'computer': {
    'tr': 'bilgisayar',
    'nl': 'computer',
    'de': 'Computer',
    'fr': 'ordinateur',
    'es': 'computadora'
  },
  'processor': {
    'tr': 'işlemci',
    'nl': 'processor',
    'de': 'Prozessor',
    'fr': 'processeur',
    'es': 'procesador'
  },
  'software': {
    'tr': 'yazılım',
    'nl': 'software',
    'de': 'Software',
    'fr': 'logiciel',
    'es': 'software'
  },
  'hardware': {
    'tr': 'donanım',
    'nl': 'hardware',
    'de': 'Hardware',
    'fr': 'matériel',
    'es': 'hardware'
  },
  'interface': {
    'tr': 'arayüz',
    'nl': 'interface',
    'de': 'Schnittstelle',
    'fr': 'interface',
    'es': 'interfaz'
  },
  'digital': {
    'tr': 'dijital',
    'nl': 'digitaal',
    'de': 'digital',
    'fr': 'numérique',
    'es': 'digital'
  },
  'analog': {
    'tr': 'analog',
    'nl': 'analoog',
    'de': 'analog',
    'fr': 'analogique',
    'es': 'analógico'
  },
  'signal': {
    'tr': 'sinyal',
    'nl': 'signaal',
    'de': 'Signal',
    'fr': 'signal',
    'es': 'señal'
  },
  'antenna': {
    'tr': 'anten',
    'nl': 'antenne',
    'de': 'Antenne',
    'fr': 'antenne',
    'es': 'antena'
  },
  'receiver': {
    'tr': 'alıcı',
    'nl': 'ontvanger',
    'de': 'Empfänger',
    'fr': 'récepteur',
    'es': 'receptor'
  },

  // Navigasyon (Navigation)
  'gps': {'tr': 'GPS', 'nl': 'GPS', 'de': 'GPS', 'fr': 'GPS', 'es': 'GPS'},
  'compass': {
    'tr': 'pusula',
    'nl': 'kompas',
    'de': 'Kompass',
    'fr': 'compas',
    'es': 'brújula'
  },
  'heading': {
    'tr': 'başlık',
    'nl': 'koers',
    'de': 'Kurs',
    'fr': 'cap',
    'es': 'rumbo'
  },
  'waypoint': {
    'tr': 'rota noktası',
    'nl': 'routepunt',
    'de': 'Wegpunkt',
    'fr': 'point de cheminement',
    'es': 'punto de ruta'
  },
  'route': {
    'tr': 'rota',
    'nl': 'route',
    'de': 'Route',
    'fr': 'route',
    'es': 'ruta'
  },
  'altitude': {
    'tr': 'irtifa',
    'nl': 'hoogte',
    'de': 'Höhe',
    'fr': 'altitude',
    'es': 'altitud'
  },
  'airspeed': {
    'tr': 'hava hızı',
    'nl': 'luchtsnelheid',
    'de': 'Fluggeschwindigkeit',
    'fr': 'vitesse air',
    'es': 'velocidad aérea'
  },
  'groundspeed': {
    'tr': 'yer hızı',
    'nl': 'grondsnelheid',
    'de': 'Groundspeed',
    'fr': 'vitesse sol',
    'es': 'velocidad terrestre'
  },
  'distance': {
    'tr': 'mesafe',
    'nl': 'afstand',
    'de': 'Entfernung',
    'fr': 'distance',
    'es': 'distancia'
  },
  'bearing': {
    'tr': 'kerteriz',
    'nl': 'peiling',
    'de': 'Peilung',
    'fr': 'relèvement',
    'es': 'marcación'
  },
  'coordinates': {
    'tr': 'koordinatlar',
    'nl': 'coördinaten',
    'de': 'Koordinaten',
    'fr': 'coordonnées',
    'es': 'coordenadas'
  },
  'latitude': {
    'tr': 'enlem',
    'nl': 'breedtegraad',
    'de': 'Breitengrad',
    'fr': 'latitude',
    'es': 'latitud'
  },
  'longitude': {
    'tr': 'boylam',
    'nl': 'lengtegraad',
    'de': 'Längengrad',
    'fr': 'longitude',
    'es': 'longitud'
  },
  'track': {
    'tr': 'iz',
    'nl': 'track',
    'de': 'Track',
    'fr': 'trajectoire',
    'es': 'trayectoria'
  },
  'course': {
    'tr': 'kurs',
    'nl': 'koers',
    'de': 'Kurs',
    'fr': 'cap',
    'es': 'rumbo'
  },

  // Meteoroloji (Weather/Meteorology)
  'weather': {
    'tr': 'hava durumu',
    'nl': 'weer',
    'de': 'Wetter',
    'fr': 'météo',
    'es': 'clima'
  },
  'temperature': {
    'tr': 'sıcaklık',
    'nl': 'temperatuur',
    'de': 'Temperatur',
    'fr': 'température',
    'es': 'temperatura'
  },
  'wind': {
    'tr': 'rüzgar',
    'nl': 'wind',
    'de': 'Wind',
    'fr': 'vent',
    'es': 'viento'
  },
  'visibility': {
    'tr': 'görüş',
    'nl': 'zicht',
    'de': 'Sichtweite',
    'fr': 'visibilité',
    'es': 'visibilidad'
  },
  'cloud': {
    'tr': 'bulut',
    'nl': 'wolk',
    'de': 'Wolke',
    'fr': 'nuage',
    'es': 'nube'
  },
  'ceiling': {
    'tr': 'tavan',
    'nl': 'wolkenbasis',
    'de': 'Wolkenuntergrenze',
    'fr': 'plafond',
    'es': 'techo'
  },
  'turbulence': {
    'tr': 'türbülans',
    'nl': 'turbulentie',
    'de': 'Turbulenz',
    'fr': 'turbulence',
    'es': 'turbulencia'
  },
  'icing': {
    'tr': 'buzlanma',
    'nl': 'ijsvorming',
    'de': 'Vereisung',
    'fr': 'givrage',
    'es': 'formación de hielo'
  },
  'precipitation': {
    'tr': 'yağış',
    'nl': 'neerslag',
    'de': 'Niederschlag',
    'fr': 'précipitation',
    'es': 'precipitación'
  },
  'humidity': {
    'tr': 'nem',
    'nl': 'vochtigheid',
    'de': 'Feuchtigkeit',
    'fr': 'humidité',
    'es': 'humedad'
  },
  'thunderstorm': {
    'tr': 'fırtına',
    'nl': 'onweer',
    'de': 'Gewitter',
    'fr': 'orage',
    'es': 'tormenta'
  },
  'forecast': {
    'tr': 'tahmin',
    'nl': 'voorspelling',
    'de': 'Vorhersage',
    'fr': 'prévision',
    'es': 'pronóstico'
  },
  'barometric': {
    'tr': 'barometrik',
    'nl': 'barometrisch',
    'de': 'barometrisch',
    'fr': 'barométrique',
    'es': 'barométrico'
  },
  'atmosphere': {
    'tr': 'atmosfer',
    'nl': 'atmosfeer',
    'de': 'Atmosphäre',
    'fr': 'atmosphère',
    'es': 'atmósfera'
  },
  'conditions': {
    'tr': 'koşullar',
    'nl': 'omstandigheden',
    'de': 'Bedingungen',
    'fr': 'conditions',
    'es': 'condiciones'
  },

  // Hava Trafik Kontrolü (ATC)
  'control': {
    'tr': 'kontrol',
    'nl': 'controle',
    'de': 'Kontrolle',
    'fr': 'contrôle',
    'es': 'control'
  },
  'tower': {
    'tr': 'kule',
    'nl': 'toren',
    'de': 'Turm',
    'fr': 'tour',
    'es': 'torre'
  },
  'runway': {
    'tr': 'pist',
    'nl': 'landingsbaan',
    'de': 'Landebahn',
    'fr': 'piste',
    'es': 'pista'
  },
  'taxiway': {
    'tr': 'taksi yolu',
    'nl': 'taxibaan',
    'de': 'Rollbahn',
    'fr': 'voie de circulation',
    'es': 'calle de rodaje'
  },
  'apron': {
    'tr': 'apron',
    'nl': 'platform',
    'de': 'Vorfeld',
    'fr': 'aire de trafic',
    'es': 'plataforma'
  },
  'approach': {
    'tr': 'yaklaşma',
    'nl': 'nadering',
    'de': 'Anflug',
    'fr': 'approche',
    'es': 'aproximación'
  },
  'departure': {
    'tr': 'kalkış',
    'nl': 'vertrek',
    'de': 'Abflug',
    'fr': 'départ',
    'es': 'salida'
  },
  'arrival': {
    'tr': 'varış',
    'nl': 'aankomst',
    'de': 'Ankunft',
    'fr': 'arrivée',
    'es': 'llegada'
  },
  'frequency': {
    'tr': 'frekans',
    'nl': 'frequentie',
    'de': 'Frequenz',
    'fr': 'fréquence',
    'es': 'frecuencia'
  },
  'radio': {
    'tr': 'radyo',
    'nl': 'radio',
    'de': 'Funk',
    'fr': 'radio',
    'es': 'radio'
  },
  'contact': {
    'tr': 'temas',
    'nl': 'contact',
    'de': 'Kontakt',
    'fr': 'contact',
    'es': 'contacto'
  },
  'squawk': {
    'tr': 'squawk',
    'nl': 'squawk',
    'de': 'Squawk',
    'fr': 'squawk',
    'es': 'squawk'
  },
  'vector': {
    'tr': 'vektör',
    'nl': 'vector',
    'de': 'Vektor',
    'fr': 'vecteur',
    'es': 'vector'
  },
  'holding': {
    'tr': 'bekleme',
    'nl': 'wachten',
    'de': 'Warteschleife',
    'fr': 'attente',
    'es': 'espera'
  },
  'pattern': {
    'tr': 'patern',
    'nl': 'patroon',
    'de': 'Muster',
    'fr': 'circuit',
    'es': 'patrón'
  },
  'traffic': {
    'tr': 'trafik',
    'nl': 'verkeer',
    'de': 'Verkehr',
    'fr': 'trafic',
    'es': 'tráfico'
  },
  'spacing': {
    'tr': 'aralık',
    'nl': 'afstand',
    'de': 'Abstand',
    'fr': 'espacement',
    'es': 'espaciado'
  },
  'separation': {
    'tr': 'ayrım',
    'nl': 'scheiding',
    'de': 'Trennung',
    'fr': 'séparation',
    'es': 'separación'
  },
  'handoff': {
    'tr': 'devir',
    'nl': 'overdracht',
    'de': 'Übergabe',
    'fr': 'transfert',
    'es': 'transferencia'
  },

  // Uçuş Mekaniği (Flight Mechanics)
  'lift': {
    'tr': 'kaldırma',
    'nl': 'lift',
    'de': 'Auftrieb',
    'fr': 'portance',
    'es': 'sustentación'
  },
  'drag': {
    'tr': 'sürükleme',
    'nl': 'weerstand',
    'de': 'Widerstand',
    'fr': 'traînée',
    'es': 'resistencia'
  },
  'thrust': {
    'tr': 'itme',
    'nl': 'stuwkracht',
    'de': 'Schub',
    'fr': 'poussée',
    'es': 'empuje'
  },
  'weight': {
    'tr': 'ağırlık',
    'nl': 'gewicht',
    'de': 'Gewicht',
    'fr': 'poids',
    'es': 'peso'
  },
  'pitch': {
    'tr': 'yunuslama',
    'nl': 'pitch',
    'de': 'Nicken',
    'fr': 'tangage',
    'es': 'cabeceo'
  },
  'roll': {
    'tr': 'yalpa',
    'nl': 'rol',
    'de': 'Rollen',
    'fr': 'roulis',
    'es': 'alabeo'
  },
  'yaw': {
    'tr': 'sapma',
    'nl': 'gieren',
    'de': 'Gieren',
    'fr': 'lacet',
    'es': 'guiñada'
  },
  'angle': {
    'tr': 'açı',
    'nl': 'hoek',
    'de': 'Winkel',
    'fr': 'angle',
    'es': 'ángulo'
  },
  'speed': {
    'tr': 'hız',
    'nl': 'snelheid',
    'de': 'Geschwindigkeit',
    'fr': 'vitesse',
    'es': 'velocidad'
  },
  'acceleration': {
    'tr': 'ivme',
    'nl': 'versnelling',
    'de': 'Beschleunigung',
    'fr': 'accélération',
    'es': 'aceleración'
  },
  'velocity': {
    'tr': 'hız vektörü',
    'nl': 'snelheid',
    'de': 'Geschwindigkeit',
    'fr': 'vélocité',
    'es': 'velocidad'
  },
  'maneuver': {
    'tr': 'manevra',
    'nl': 'manoeuvre',
    'de': 'Manöver',
    'fr': 'manœuvre',
    'es': 'maniobra'
  },
  'climb': {
    'tr': 'tırmanma',
    'nl': 'klimmen',
    'de': 'Steigflug',
    'fr': 'montée',
    'es': 'ascenso'
  },
  'descent': {
    'tr': 'iniş',
    'nl': 'daling',
    'de': 'Sinkflug',
    'fr': 'descente',
    'es': 'descenso'
  },
  'stall': {
    'tr': 'stol',
    'nl': 'overtrek',
    'de': 'Strömungsabriss',
    'fr': 'décrochage',
    'es': 'pérdida'
  },

  // Elektrik/Elektronik (Electrical)
  'battery': {
    'tr': 'batarya',
    'nl': 'batterij',
    'de': 'Batterie',
    'fr': 'batterie',
    'es': 'batería'
  },
  'generator': {
    'tr': 'jeneratör',
    'nl': 'generator',
    'de': 'Generator',
    'fr': 'générateur',
    'es': 'generador'
  },
  'alternator': {
    'tr': 'alternatör',
    'nl': 'alternator',
    'de': 'Lichtmaschine',
    'fr': 'alternateur',
    'es': 'alternador'
  },
  'voltage': {
    'tr': 'voltaj',
    'nl': 'spanning',
    'de': 'Spannung',
    'fr': 'tension',
    'es': 'voltaje'
  },
  'current': {
    'tr': 'akım',
    'nl': 'stroom',
    'de': 'Strom',
    'fr': 'courant',
    'es': 'corriente'
  },
  'circuit': {
    'tr': 'devre',
    'nl': 'circuit',
    'de': 'Schaltkreis',
    'fr': 'circuit',
    'es': 'circuito'
  },
  'breaker': {
    'tr': 'devre kesici',
    'nl': 'zekering',
    'de': 'Sicherung',
    'fr': 'disjoncteur',
    'es': 'interruptor'
  },
  'fuse': {
    'tr': 'sigorta',
    'nl': 'zekering',
    'de': 'Sicherung',
    'fr': 'fusible',
    'es': 'fusible'
  },
  'wire': {
    'tr': 'kablo',
    'nl': 'draad',
    'de': 'Draht',
    'fr': 'fil',
    'es': 'cable'
  },
  'wiring': {
    'tr': 'kablolama',
    'nl': 'bedrading',
    'de': 'Verkabelung',
    'fr': 'câblage',
    'es': 'cableado'
  },
  'connector': {
    'tr': 'konnektör',
    'nl': 'connector',
    'de': 'Stecker',
    'fr': 'connecteur',
    'es': 'conector'
  },
  'terminal': {
    'tr': 'terminal',
    'nl': 'terminal',
    'de': 'Klemme',
    'fr': 'borne',
    'es': 'terminal'
  },
  'switch': {
    'tr': 'anahtar',
    'nl': 'schakelaar',
    'de': 'Schalter',
    'fr': 'interrupteur',
    'es': 'interruptor'
  },
  'relay': {
    'tr': 'röle',
    'nl': 'relais',
    'de': 'Relais',
    'fr': 'relais',
    'es': 'relé'
  },
  'power': {
    'tr': 'güç',
    'nl': 'vermogen',
    'de': 'Leistung',
    'fr': 'puissance',
    'es': 'potencia'
  },

  // Kompozit Malzemeler (Composites)
  'composite': {
    'tr': 'kompozit',
    'nl': 'composiet',
    'de': 'Verbundwerkstoff',
    'fr': 'composite',
    'es': 'compuesto'
  },
  'carbon': {
    'tr': 'karbon',
    'nl': 'koolstof',
    'de': 'Kohlenstoff',
    'fr': 'carbone',
    'es': 'carbono'
  },
  'fiber': {
    'tr': 'fiber',
    'nl': 'vezel',
    'de': 'Faser',
    'fr': 'fibre',
    'es': 'fibra'
  },
  'resin': {
    'tr': 'reçine',
    'nl': 'hars',
    'de': 'Harz',
    'fr': 'résine',
    'es': 'resina'
  },
  'laminate': {
    'tr': 'laminat',
    'nl': 'laminaat',
    'de': 'Laminat',
    'fr': 'stratifié',
    'es': 'laminado'
  },
  'matrix': {
    'tr': 'matris',
    'nl': 'matrix',
    'de': 'Matrix',
    'fr': 'matrice',
    'es': 'matriz'
  },
  'honeycomb': {
    'tr': 'bal peteği',
    'nl': 'honingraat',
    'de': 'Wabenkern',
    'fr': 'nid d\'abeille',
    'es': 'panal'
  },
  'bonding': {
    'tr': 'yapıştırma',
    'nl': 'verlijmen',
    'de': 'Kleben',
    'fr': 'collage',
    'es': 'pegado'
  },
  'adhesive': {
    'tr': 'yapıştırıcı',
    'nl': 'lijm',
    'de': 'Klebstoff',
    'fr': 'adhésif',
    'es': 'adhesivo'
  },
  'curing': {
    'tr': 'kürleme',
    'nl': 'uitharden',
    'de': 'Aushärten',
    'fr': 'durcissement',
    'es': 'curado'
  },

  // Kalite Kontrol (Quality Control)
  'assurance': {
    'tr': 'güvence',
    'nl': 'borging',
    'de': 'Sicherung',
    'fr': 'assurance',
    'es': 'aseguramiento'
  },
  'certification': {
    'tr': 'sertifikasyon',
    'nl': 'certificering',
    'de': 'Zertifizierung',
    'fr': 'certification',
    'es': 'certificación'
  },
  'audit': {
    'tr': 'denetim',
    'nl': 'audit',
    'de': 'Audit',
    'fr': 'audit',
    'es': 'auditoría'
  },
  'defect': {
    'tr': 'kusur',
    'nl': 'defect',
    'de': 'Defekt',
    'fr': 'défaut',
    'es': 'defecto'
  },
  'deviation': {
    'tr': 'sapma',
    'nl': 'afwijking',
    'de': 'Abweichung',
    'fr': 'déviation',
    'es': 'desviación'
  },
  'nonconformance': {
    'tr': 'uygunsuzluk',
    'nl': 'afwijking',
    'de': 'Nichtkonformität',
    'fr': 'non-conformité',
    'es': 'no conformidad'
  },
  'traceability': {
    'tr': 'izlenebilirlik',
    'nl': 'traceerbaarheid',
    'de': 'Rückverfolgbarkeit',
    'fr': 'traçabilité',
    'es': 'trazabilidad'
  },
  'documentation': {
    'tr': 'dokümantasyon',
    'nl': 'documentatie',
    'de': 'Dokumentation',
    'fr': 'documentation',
    'es': 'documentación'
  },

  // AMM - Aircraft Maintenance Manual
  'requirement': {
    'tr': 'gereksinim',
    'nl': 'vereiste',
    'de': 'Anforderung',
    'fr': 'exigence',
    'es': 'requisito'
  },
  'requirements': {
    'tr': 'gereksinimler',
    'nl': 'vereisten',
    'de': 'Anforderungen',
    'fr': 'exigences',
    'es': 'requisitos'
  },

  // Emergency Equipment - Acil Durum Ekipmanları
  'escape': {
    'tr': 'kaçış',
    'nl': 'ontsnapping',
    'de': 'Flucht',
    'fr': 'échappement',
    'es': 'escape'
  },
  'slide': {
    'tr': 'kayma',
    'nl': 'glijbaan',
    'de': 'Rutsche',
    'fr': 'toboggan',
    'es': 'tobogán'
  },
  'portable': {
    'tr': 'taşınabilir',
    'nl': 'draagbaar',
    'de': 'tragbar',
    'fr': 'portable',
    'es': 'portátil'
  },
  'oxygen': {
    'tr': 'oksijen',
    'nl': 'zuurstof',
    'de': 'Sauerstoff',
    'fr': 'oxygène',
    'es': 'oxígeno'
  },
  'cylinder': {
    'tr': 'silindir',
    'nl': 'cilinder',
    'de': 'Zylinder',
    'fr': 'cylindre',
    'es': 'cilindro'
  },
  'cylinders': {
    'tr': 'silindirler',
    'nl': 'cilinders',
    'de': 'Zylinder',
    'fr': 'cylindres',
    'es': 'cilindros'
  },
  'extinguishers': {
    'tr': 'söndürücüler',
    'nl': 'blussers',
    'de': 'Feuerlöscher',
    'fr': 'extincteurs',
    'es': 'extintores'
  },
  'mask': {
    'tr': 'maske',
    'nl': 'masker',
    'de': 'Maske',
    'fr': 'masque',
    'es': 'máscara'
  },
  'masks': {
    'tr': 'maskeler',
    'nl': 'maskers',
    'de': 'Masken',
    'fr': 'masques',
    'es': 'máscaras'
  },

  // Passenger Service Unit (PSU)
  'passenger': {
    'tr': 'yolcu',
    'nl': 'passagier',
    'de': 'Passagier',
    'fr': 'passager',
    'es': 'pasajero'
  },
  'passengers': {
    'tr': 'yolcular',
    'nl': 'passagiers',
    'de': 'Passagiere',
    'fr': 'passagers',
    'es': 'pasajeros'
  },
  'unit': {
    'tr': 'ünite',
    'nl': 'eenheid',
    'de': 'Einheit',
    'fr': 'unité',
    'es': 'unidad'
  },
  'panel': {
    'tr': 'panel',
    'nl': 'paneel',
    'de': 'Panel',
    'fr': 'panneau',
    'es': 'panel'
  },

  // Cabin Interior Equipment - Kabin İç Ekipmanları
  'cabin': {
    'tr': 'kabin',
    'nl': 'cabine',
    'de': 'Kabine',
    'fr': 'cabine',
    'es': 'cabina'
  },
  'interior': {
    'tr': 'iç',
    'nl': 'interieur',
    'de': 'Innenraum',
    'fr': 'intérieur',
    'es': 'interior'
  },
  'seat': {
    'tr': 'koltuk',
    'nl': 'stoel',
    'de': 'Sitz',
    'fr': 'siège',
    'es': 'asiento'
  },
  'seats': {
    'tr': 'koltuklar',
    'nl': 'stoelen',
    'de': 'Sitze',
    'fr': 'sièges',
    'es': 'asientos'
  },
  'tracks': {
    'tr': 'raylar',
    'nl': 'rails',
    'de': 'Schienen',
    'fr': 'rails',
    'es': 'rieles'
  },
  'galley': {
    'tr': 'mutfak',
    'nl': 'kombuis',
    'de': 'Bordküche',
    'fr': 'office',
    'es': 'cocina'
  },
  'kitchen': {
    'tr': 'mutfak',
    'nl': 'keuken',
    'de': 'Küche',
    'fr': 'cuisine',
    'es': 'cocina'
  },

  // Hydraulic System - Hidrolik Sistem
  'hydraulics': {
    'tr': 'hidrolik',
    'nl': 'hydrauliek',
    'de': 'Hydraulik',
    'fr': 'hydraulique',
    'es': 'hidráulica'
  },
  'pump': {
    'tr': 'pompa',
    'nl': 'pomp',
    'de': 'Pumpe',
    'fr': 'pompe',
    'es': 'bomba'
  },
  'pumps': {
    'tr': 'pompalar',
    'nl': 'pompen',
    'de': 'Pumpen',
    'fr': 'pompes',
    'es': 'bombas'
  },
  'reservoir': {
    'tr': 'rezervuar',
    'nl': 'reservoir',
    'de': 'Reservoir',
    'fr': 'réservoir',
    'es': 'depósito'
  },
  'valve': {
    'tr': 'valf',
    'nl': 'klep',
    'de': 'Ventil',
    'fr': 'valve',
    'es': 'válvula'
  },
  'valves': {
    'tr': 'valfler',
    'nl': 'kleppen',
    'de': 'Ventile',
    'fr': 'valves',
    'es': 'válvulas'
  },

  // Entertainment Systems - Eğlence Sistemleri
  'video': {
    'tr': 'video',
    'nl': 'video',
    'de': 'Video',
    'fr': 'vidéo',
    'es': 'vídeo'
  },
  'audio': {
    'tr': 'ses',
    'nl': 'audio',
    'de': 'Audio',
    'fr': 'audio',
    'es': 'audio'
  },
  'entertainment': {
    'tr': 'eğlence',
    'nl': 'entertainment',
    'de': 'Unterhaltung',
    'fr': 'divertissement',
    'es': 'entretenimiento'
  },
  'monitor': {
    'tr': 'monitör',
    'nl': 'monitor',
    'de': 'Monitor',
    'fr': 'moniteur',
    'es': 'monitor'
  },
  'screen': {
    'tr': 'ekran',
    'nl': 'scherm',
    'de': 'Bildschirm',
    'fr': 'écran',
    'es': 'pantalla'
  },
  'headset': {
    'tr': 'kulaklık',
    'nl': 'headset',
    'de': 'Kopfhörer',
    'fr': 'casque',
    'es': 'auriculares'
  },

  // Air Stairs and Access - Merdiven ve Erişim
  'stairs': {
    'tr': 'merdivenler',
    'nl': 'trap',
    'de': 'Treppe',
    'fr': 'escalier',
    'es': 'escaleras'
  },
  'boarding': {
    'tr': 'biniş',
    'nl': 'instappen',
    'de': 'Einstieg',
    'fr': 'embarquement',
    'es': 'embarque'
  },
  'door': {
    'tr': 'kapı',
    'nl': 'deur',
    'de': 'Tür',
    'fr': 'porte',
    'es': 'puerta'
  },
  'doors': {
    'tr': 'kapılar',
    'nl': 'deuren',
    'de': 'Türen',
    'fr': 'portes',
    'es': 'puertas'
  },
  'hatch': {
    'tr': 'kapak',
    'nl': 'luik',
    'de': 'Luke',
    'fr': 'trappe',
    'es': 'escotilla'
  },

  // Crew Equipment - Ekip Ekipmanları
  'attendant': {
    'tr': 'görevli',
    'nl': 'steward',
    'de': 'Flugbegleiter',
    'fr': 'hôtesse',
    'es': 'auxiliar'
  },

  // Emergency Lighting - Acil Aydınlatma
  'lighting': {
    'tr': 'aydınlatma',
    'nl': 'verlichting',
    'de': 'Beleuchtung',
    'fr': 'éclairage',
    'es': 'iluminación'
  },
  'light': {
    'tr': 'ışık',
    'nl': 'licht',
    'de': 'Licht',
    'fr': 'lumière',
    'es': 'luz'
  },
  'lights': {
    'tr': 'ışıklar',
    'nl': 'lichten',
    'de': 'Lichter',
    'fr': 'lumières',
    'es': 'luces'
  },
  'strip': {
    'tr': 'şerit',
    'nl': 'strip',
    'de': 'Streifen',
    'fr': 'bande',
    'es': 'tira'
  },
  'indicator': {
    'tr': 'gösterge',
    'nl': 'indicator',
    'de': 'Anzeige',
    'fr': 'indicateur',
    'es': 'indicador'
  },

  // Systems - Sistemler
  'automatic': {
    'tr': 'otomatik',
    'nl': 'automatisch',
    'de': 'automatisch',
    'fr': 'automatique',
    'es': 'automático'
  },
  'activated': {
    'tr': 'aktif',
    'nl': 'geactiveerd',
    'de': 'aktiviert',
    'fr': 'activé',
    'es': 'activado'
  },
  'deactivated': {
    'tr': 'devre dışı',
    'nl': 'gedeactiveerd',
    'de': 'deaktiviert',
    'fr': 'désactivé',
    'es': 'desactivado'
  },
  'backup': {
    'tr': 'yedek',
    'nl': 'back-up',
    'de': 'Backup',
    'fr': 'secours',
    'es': 'respaldo'
  },
  'primary': {
    'tr': 'birincil',
    'nl': 'primair',
    'de': 'primär',
    'fr': 'primaire',
    'es': 'primario'
  },
  'secondary': {
    'tr': 'ikincil',
    'nl': 'secundair',
    'de': 'sekundär',
    'fr': 'secondaire',
    'es': 'secundario'
  },

  // PPE - Kişisel Koruyucu Ekipman
  'helmet': {
    'tr': 'kask',
    'nl': 'helm',
    'de': 'Helm',
    'fr': 'casque',
    'es': 'casco'
  },
  'boots': {
    'tr': 'botlar',
    'nl': 'laarzen',
    'de': 'Stiefel',
    'fr': 'bottes',
    'es': 'botas'
  },
  'vest': {
    'tr': 'yelek',
    'nl': 'vest',
    'de': 'Weste',
    'fr': 'gilet',
    'es': 'chaleco'
  },
  'harness': {
    'tr': 'kemer',
    'nl': 'harnas',
    'de': 'Gurt',
    'fr': 'harnais',
    'es': 'arnés'
  },
  'coveralls': {
    'tr': 'tulum',
    'nl': 'overall',
    'de': 'Overall',
    'fr': 'combinaison',
    'es': 'mono'
  },
  'respirator': {
    'tr': 'solunum maskesi',
    'nl': 'ademhalingsmasker',
    'de': 'Atemschutz',
    'fr': 'respirateur',
    'es': 'respirador'
  },
  'shield': {
    'tr': 'siper',
    'nl': 'schild',
    'de': 'Schild',
    'fr': 'écran',
    'es': 'pantalla'
  },

  // Safety Signs - Emniyet İşaretleri
  'warning': {
    'tr': 'uyarı',
    'nl': 'waarschuwing',
    'de': 'Warnung',
    'fr': 'avertissement',
    'es': 'advertencia'
  },
  'caution': {
    'tr': 'dikkat',
    'nl': 'voorzichtig',
    'de': 'Vorsicht',
    'fr': 'attention',
    'es': 'precaución'
  },
  'danger': {
    'tr': 'tehlike',
    'nl': 'gevaar',
    'de': 'Gefahr',
    'fr': 'danger',
    'es': 'peligro'
  },
  'smoking': {
    'tr': 'sigara',
    'nl': 'roken',
    'de': 'Rauchen',
    'fr': 'fumer',
    'es': 'fumar'
  },
  'flammable': {
    'tr': 'yanıcı',
    'nl': 'brandbaar',
    'de': 'brennbar',
    'fr': 'inflammable',
    'es': 'inflamable'
  },
  'corrosive': {
    'tr': 'aşındırıcı',
    'nl': 'corrosief',
    'de': 'ätzend',
    'fr': 'corrosif',
    'es': 'corrosivo'
  },
  'radiation': {
    'tr': 'radyasyon',
    'nl': 'straling',
    'de': 'Strahlung',
    'fr': 'radiation',
    'es': 'radiación'
  },
  'slippery': {
    'tr': 'kaygan',
    'nl': 'glad',
    'de': 'rutschig',
    'fr': 'glissant',
    'es': 'resbaladizo'
  },

  // Workplace Hazards - İşyeri Tehlikeleri
  'spill': {
    'tr': 'dökülme',
    'nl': 'morsen',
    'de': 'Verschüttung',
    'fr': 'déversement',
    'es': 'derrame'
  },
  'toxic': {
    'tr': 'zehirli',
    'nl': 'giftig',
    'de': 'giftig',
    'fr': 'toxique',
    'es': 'tóxico'
  },
  'fumes': {
    'tr': 'duman',
    'nl': 'dampen',
    'de': 'Dämpfe',
    'fr': 'fumées',
    'es': 'humos'
  },
  'machinery': {
    'tr': 'makine',
    'nl': 'machines',
    'de': 'Maschinen',
    'fr': 'machines',
    'es': 'maquinaria'
  },
  'vibration': {
    'tr': 'titreşim',
    'nl': 'trillingen',
    'de': 'Vibration',
    'fr': 'vibration',
    'es': 'vibración'
  },
  'ergonomic': {
    'tr': 'ergonomik',
    'nl': 'ergonomisch',
    'de': 'ergonomisch',
    'fr': 'ergonomique',
    'es': 'ergonómico'
  },
  'exposure': {
    'tr': 'maruziyet',
    'nl': 'blootstelling',
    'de': 'Exposition',
    'fr': 'exposition',
    'es': 'exposición'
  },

  // Workshop Tools - Atölye Aletleri
  'adjustable': {
    'tr': 'ayarlanabilir',
    'nl': 'verstelbaar',
    'de': 'einstellbar',
    'fr': 'réglable',
    'es': 'ajustable'
  },
  'flathead': {
    'tr': 'düz',
    'nl': 'platkop',
    'de': 'Schlitz',
    'fr': 'plat',
    'es': 'plano'
  },
  'phillips': {
    'tr': 'yıldız',
    'nl': 'kruiskop',
    'de': 'Kreuz',
    'fr': 'cruciforme',
    'es': 'Phillips'
  },
  'cutters': {
    'tr': 'kesiciler',
    'nl': 'knippers',
    'de': 'Schneider',
    'fr': 'pinces',
    'es': 'cortadores'
  },
  'chisel': {
    'tr': 'keski',
    'nl': 'beitel',
    'de': 'Meißel',
    'fr': 'ciseau',
    'es': 'cincel'
  },
  'clamp': {
    'tr': 'kelepçe',
    'nl': 'klem',
    'de': 'Klemme',
    'fr': 'pince',
    'es': 'abrazadera'
  },
  'vice': {
    'tr': 'mengene',
    'nl': 'bankschroef',
    'de': 'Schraubstock',
    'fr': 'étau',
    'es': 'tornillo'
  },
  'hacksaw': {
    'tr': 'demir testeresi',
    'nl': 'metaalzaag',
    'de': 'Metallsäge',
    'fr': 'scie à métaux',
    'es': 'sierra'
  },

  // Documentation - Dokümantasyon
  'logbook': {
    'tr': 'kayıt defteri',
    'nl': 'logboek',
    'de': 'Logbuch',
    'fr': 'carnet',
    'es': 'libro de registro'
  },
  'permit': {
    'tr': 'izin',
    'nl': 'vergunning',
    'de': 'Genehmigung',
    'fr': 'permis',
    'es': 'permiso'
  },
  'directive': {
    'tr': 'direktif',
    'nl': 'richtlijn',
    'de': 'Richtlinie',
    'fr': 'directive',
    'es': 'directiva'
  },
  'signature': {
    'tr': 'imza',
    'nl': 'handtekening',
    'de': 'Unterschrift',
    'fr': 'signature',
    'es': 'firma'
  },
  'checklist': {
    'tr': 'kontrol listesi',
    'nl': 'checklist',
    'de': 'Checkliste',
    'fr': 'liste de contrôle',
    'es': 'lista de verificación'
  },

  // Aircraft Structures - Uçak Yapıları
  'empennage': {
    'tr': 'kuyruk takımı',
    'nl': 'staartstuk',
    'de': 'Leitwerk',
    'fr': 'empennage',
    'es': 'empenaje'
  },
  'stabilizer': {
    'tr': 'stabilizör',
    'nl': 'stabilisator',
    'de': 'Stabilisator',
    'fr': 'stabilisateur',
    'es': 'estabilizador'
  },
  'elevator': {
    'tr': 'irtifa dümeni',
    'nl': 'hoogteroer',
    'de': 'Höhenruder',
    'fr': 'gouverne',
    'es': 'timón de profundidad'
  },
  'slat': {
    'tr': 'slat',
    'nl': 'slat',
    'de': 'Vorflügel',
    'fr': 'bec',
    'es': 'slat'
  },
  'spoiler': {
    'tr': 'fren kanadı',
    'nl': 'spoiler',
    'de': 'Spoiler',
    'fr': 'déporteur',
    'es': 'spoiler'
  },
  'nacelle': {
    'tr': 'motor yuvası',
    'nl': 'motorgondel',
    'de': 'Triebwerksgondel',
    'fr': 'nacelle',
    'es': 'góndola'
  },
  'pylon': {
    'tr': 'pilon',
    'nl': 'pyloon',
    'de': 'Pylon',
    'fr': 'pylône',
    'es': 'pilón'
  },
  'fairing': {
    'tr': 'karenaj',
    'nl': 'stroomlijnkap',
    'de': 'Verkleidung',
    'fr': 'carénage',
    'es': 'carenado'
  },

  // Hydraulic & Pneumatic - Hidrolik ve Pnömatik
  'actuator': {
    'tr': 'aktüatör',
    'nl': 'actuator',
    'de': 'Aktuator',
    'fr': 'actionneur',
    'es': 'actuador'
  },
  'accumulator': {
    'tr': 'akümülatör',
    'nl': 'accumulator',
    'de': 'Akkumulator',
    'fr': 'accumulateur',
    'es': 'acumulador'
  },
  'servo': {
    'tr': 'servo',
    'nl': 'servo',
    'de': 'Servo',
    'fr': 'servo',
    'es': 'servo'
  },
  'bleed': {
    'tr': 'kanama',
    'nl': 'aftap',
    'de': 'Zapfluft',
    'fr': 'prélèvement',
    'es': 'sangrado'
  },
  'pressurization': {
    'tr': 'basınlandırma',
    'nl': 'drukcabine',
    'de': 'Druckbeaufschlagung',
    'fr': 'pressurisation',
    'es': 'presurización'
  },

  // Electrical - Elektrik
  'inverter': {
    'tr': 'invertör',
    'nl': 'omvormer',
    'de': 'Wechselrichter',
    'fr': 'onduleur',
    'es': 'inversor'
  },
  'rectifier': {
    'tr': 'redresör',
    'nl': 'gelijkrichter',
    'de': 'Gleichrichter',
    'fr': 'redresseur',
    'es': 'rectificador'
  },
  'regulator': {
    'tr': 'regülatör',
    'nl': 'regelaar',
    'de': 'Regler',
    'fr': 'régulateur',
    'es': 'regulador'
  },
  'limiter': {
    'tr': 'sınırlandırıcı',
    'nl': 'begrenzer',
    'de': 'Begrenzer',
    'fr': 'limiteur',
    'es': 'limitador'
  },

  // Flight Controls - Uçuş Kontrolleri
  'yoke': {
    'tr': 'kumanda kolonu',
    'nl': 'stuurkolom',
    'de': 'Steuerhorn',
    'fr': 'manche',
    'es': 'cuerno de mando'
  },
  'sidestick': {
    'tr': 'yan kumanda',
    'nl': 'sidestick',
    'de': 'Sidestick',
    'fr': 'mini-manche',
    'es': 'palanca lateral'
  },
  'pedals': {
    'tr': 'pedallar',
    'nl': 'pedalen',
    'de': 'Pedale',
    'fr': 'pédales',
    'es': 'pedales'
  },
  'trim': {
    'tr': 'trim',
    'nl': 'trim',
    'de': 'Trimm',
    'fr': 'trim',
    'es': 'compensador'
  },
  'bellcrank': {
    'tr': 'kol mekanizması',
    'nl': 'zwenkhefboom',
    'de': 'Umlenkhebel',
    'fr': 'renvoi',
    'es': 'palanca acodada'
  },
  'damper': {
    'tr': 'sönümleyici',
    'nl': 'demper',
    'de': 'Dämpfer',
    'fr': 'amortisseur',
    'es': 'amortiguador'
  },

  // Emergency - Acil Durum (evacuation, extinguisher already defined above)
  'foam': {
    'tr': 'köpük',
    'nl': 'schuim',
    'de': 'Schaum',
    'fr': 'mousse',
    'es': 'espuma'
  },
  'hydrant': {
    'tr': 'yangın musluğu',
    'nl': 'brandkraan',
    'de': 'Hydrant',
    'fr': 'bouche d\'incendie',
    'es': 'hidrante'
  },
  'sprinkler': {
    'tr': 'yağmurlama',
    'nl': 'sprinkler',
    'de': 'Sprinkler',
    'fr': 'sprinkler',
    'es': 'rociador'
  },
  'detector': {
    'tr': 'dedektör',
    'nl': 'detector',
    'de': 'Detektor',
    'fr': 'détecteur',
    'es': 'detector'
  },

  // Ground Handling - Yer Hizmetleri
  'pushback': {
    'tr': 'geri itme',
    'nl': 'pushback',
    'de': 'Pushback',
    'fr': 'repoussage',
    'es': 'remolque'
  },
  'towing': {
    'tr': 'çekilme',
    'nl': 'slepen',
    'de': 'Schleppen',
    'fr': 'remorquage',
    'es': 'remolque'
  },
  'marshalling': {
    'tr': 'park yönlendirme',
    'nl': 'marshalling',
    'de': 'Einweisung',
    'fr': 'guidage',
    'es': 'señalización'
  },
  'chocks': {
    'tr': 'takozlar',
    'nl': 'blokken',
    'de': 'Bremsklötze',
    'fr': 'cales',
    'es': 'calzos'
  },
  'taxiing': {
    'tr': 'taksi yapma',
    'nl': 'taxiën',
    'de': 'Rollen',
    'fr': 'roulage',
    'es': 'rodaje'
  },
  'throttle': {
    'tr': 'gaz kolu',
    'nl': 'gashandel',
    'de': 'Gashebel',
    'fr': 'manette des gaz',
    'es': 'acelerador'
  },

  // Riveting - Perçinleme
  'rivet': {
    'tr': 'perçin',
    'nl': 'klinknagel',
    'de': 'Niet',
    'fr': 'rivet',
    'es': 'remache'
  },
  'riveting': {
    'tr': 'perçinleme',
    'nl': 'klinken',
    'de': 'Nieten',
    'fr': 'rivetage',
    'es': 'remachado'
  },
  'countersunk': {
    'tr': 'havşa başlı',
    'nl': 'verzonken',
    'de': 'versenkt',
    'fr': 'fraisé',
    'es': 'avellanado'
  },
  'flush': {
    'tr': 'gömme',
    'nl': 'vlak',
    'de': 'bündig',
    'fr': 'affleurant',
    'es': 'enrasado'
  },

  // Bearings - Yataklar (bearing already defined above as navigation bearing)
  'roller': {
    'tr': 'makara',
    'nl': 'rol',
    'de': 'Rolle',
    'fr': 'rouleau',
    'es': 'rodillo'
  },
  'cylindrical': {
    'tr': 'silindirik',
    'nl': 'cilindrisch',
    'de': 'zylindrisch',
    'fr': 'cylindrique',
    'es': 'cilíndrico'
  },
  'spherical': {
    'tr': 'küresel',
    'nl': 'sferisch',
    'de': 'sphärisch',
    'fr': 'sphérique',
    'es': 'esférico'
  },
  'angular': {
    'tr': 'açısal',
    'nl': 'hoekig',
    'de': 'Winkel',
    'fr': 'angulaire',
    'es': 'angular'
  },

  // Fuel - Yakıt
  'kerosene': {
    'tr': 'gazyağı',
    'nl': 'kerosine',
    'de': 'Kerosin',
    'fr': 'kérosène',
    'es': 'queroseno'
  },
  'petrol': {
    'tr': 'benzin',
    'nl': 'benzine',
    'de': 'Benzin',
    'fr': 'essence',
    'es': 'gasolina'
  },
  'refuelling': {
    'tr': 'yakıt ikmali',
    'nl': 'tanken',
    'de': 'Betankung',
    'fr': 'ravitaillement',
    'es': 'repostaje'
  },
  'vapour': {
    'tr': 'buhar',
    'nl': 'damp',
    'de': 'Dampf',
    'fr': 'vapeur',
    'es': 'vapor'
  },
  'contamination': {
    'tr': 'kirlilik',
    'nl': 'verontreiniging',
    'de': 'Verunreinigung',
    'fr': 'contamination',
    'es': 'contaminación'
  },

  // Medical - Tıbbi
  'wound': {
    'tr': 'yara',
    'nl': 'wond',
    'de': 'Wunde',
    'fr': 'blessure',
    'es': 'herida'
  },
  'bleeding': {
    'tr': 'kanama',
    'nl': 'bloeden',
    'de': 'Blutung',
    'fr': 'saignement',
    'es': 'sangrado'
  },
  'fracture': {
    'tr': 'kırık',
    'nl': 'breuk',
    'de': 'Bruch',
    'fr': 'fracture',
    'es': 'fractura'
  },
  'unconscious': {
    'tr': 'bilinçsiz',
    'nl': 'bewusteloos',
    'de': 'bewusstlos',
    'fr': 'inconscient',
    'es': 'inconsciente'
  },
  'resuscitation': {
    'tr': 'canlandırma',
    'nl': 'reanimatie',
    'de': 'Wiederbelebung',
    'fr': 'réanimation',
    'es': 'reanimación'
  },
  'tourniquet': {
    'tr': 'turnike',
    'nl': 'tourniquet',
    'de': 'Tourniquet',
    'fr': 'garrot',
    'es': 'torniquete'
  },
  'defibrillator': {
    'tr': 'defibrilatör',
    'nl': 'defibrillator',
    'de': 'Defibrillator',
    'fr': 'défibrillateur',
    'es': 'desfibrilador'
  },
};

// Kelime çevirisi al - dile göre
String? getWordTranslation(String word, String langCode) {
  final lowerWord = word.toLowerCase();
  if (commonWords.containsKey(lowerWord)) {
    return commonWords[lowerWord]?[langCode];
  }
  return null;
}
