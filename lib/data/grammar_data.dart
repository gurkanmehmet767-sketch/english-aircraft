import '../models/grammar_models.dart';

// Grammar Topics A-Z
final Map<String, GrammarTopic> grammarTopics = {
  'A': topicAWordOrder,
  'B': topicBPrepositions,
  'C1': topicC1Infinitive,
  'C2': topicC2PresentSimple,
  'C3': topicC3ToBeToHave,
  'C4': topicC4Imperative,
  'C5': topicC5Gerund,
  'C6': topicC6PastParticiple,
  'D': topicDInstructionsAndProcedures,
  'E': topicESentencePatterns,
  'F': topicFBasicStructureAndWordEndings,
  // G-Z will be added later
};

// TOPIC A: WORD ORDER (Kelime Sırası)
final GrammarTopic topicAWordOrder = GrammarTopic(
  letter: 'A',
  title: 'Word Order',
  titleKey: 'grammar_word_order',
  description:
      'Understanding correct word order in technical English sentences',
  icon: '📝',
  sentences: _topicASentences,
);

// TOPIC A SENTENCES (100 sentences)
final List<GrammarSentence> _topicASentences = [
  // Basic Descriptions
  GrammarSentence(
      text: 'The control panel is located in the cockpit.',
      translation: 'Kontrol paneli kokpitte bulunur.'),
  GrammarSentence(
      text:
          'The landing gear is deployed when the aircraft touches the ground.',
      translation: 'İniş takımı uçak yere değdiğinde açılır.'),
  GrammarSentence(
      text: 'The fuel system is located in the wing of the aircraft.',
      translation: 'Yakıt sistemi uçağın kanadında bulunur.'),
  GrammarSentence(
      text: 'The tail rotor is attached to the tail section.',
      translation: 'Kuyruk rotoru kuyruk bölümüne bağlıdır.'),
  GrammarSentence(
      text: 'The avionics bay is located behind the cockpit.',
      translation: 'Aviyonik bölümü kokpitin arkasında bulunur.'),
  GrammarSentence(
      text:
          'The engine nacelle houses the engine and the aircraft\'s power systems.',
      translation:
          'Motor kaportası motoru ve uçağın güç sistemlerini barındırır.'),
  GrammarSentence(
      text: 'The fuel gauge monitors the fuel level in the fuel tank.',
      translation: 'Yakıt göstergesi yakıt tankındaki yakıt seviyesini izler.'),
  GrammarSentence(
      text:
          'The air conditioning system is responsible for maintaining a comfortable temperature in the cabin.',
      translation:
          'Klima sistemi kabinde konforlu bir sıcaklığı korumaktan sorumludur.'),
  GrammarSentence(
      text:
          'The altimeter measures the aircraft\'s altitude using barometric pressure.',
      translation:
          'İrtifa ölçer barometrik basıncı kullanarak uçağın irtifasını ölçer.'),
  GrammarSentence(
      text: 'The cargo hold is located below the passenger cabin.',
      translation: 'Kargo bölümü yolcu kabininin altında bulunur.'),
  GrammarSentence(
      text: 'The aircraft\'s wings generate lift during flight.',
      translation: 'Uçağın kanatları uçuş sırasında kaldırma kuvveti üretir.'),
  GrammarSentence(
      text: 'The flight data recorder stores critical flight information.',
      translation: 'Uçuş veri kaydedici kritik uçuş bilgilerini saklar.'),
  GrammarSentence(
      text: 'The windshield wipers clean the cockpit windows of rain.',
      translation: 'Ön cam silecekleri kokpit camlarını yağmurdan temizler.'),
  GrammarSentence(
      text: 'The emergency exit is located near the front of the aircraft.',
      translation: 'Acil çıkış uçağın ön kısmının yakınında bulunur.'),
  GrammarSentence(
      text: 'The engine cowling is designed to reduce drag and noise.',
      translation:
          'Motor kaportası sürtünmeyi ve gürültüyü azaltmak için tasarlanmıştır.'),
  GrammarSentence(
      text:
          'The flight management system controls the navigation system and the autopilot.',
      translation:
          'Uçuş yönetim sistemi navigasyon sistemini ve otopilotu kontrol eder.'),
  GrammarSentence(
      text: 'The oxygen masks drop from the ceiling during decompression.',
      translation: 'Oksijen maskeleri basınç kaybı sırasında tavandan düşer.'),
  GrammarSentence(
      text:
          'The autopilot system helps the pilot maintain a steady altitude and heading.',
      translation:
          'Otopilot sistemi pilotun sabit bir irtifa ve rota korumasına yardımcı olur.'),
  GrammarSentence(
      text: 'The windshield heaters prevent the cockpit windows from fogging.',
      translation: 'Ön cam ısıtıcıları kokpit camlarının buğulanmasını önler.'),
  GrammarSentence(
      text:
          'The landing lights are mounted on the wing tips to aid during landing.',
      translation:
          'İniş ışıkları inişe yardımcı olmak için kanat uçlarına monte edilir.'),

  // Bileşik Kelimeler ve Tanımlamalar
  GrammarSentence(
      text: 'The tailplane is part of the horizontal stabilizer.',
      translation: 'Kuyruk kanadı yatay dengeleyicinin bir parçasıdır.'),
  GrammarSentence(
      text: 'The electrical system powers the aircraft\'s essential functions.',
      translation:
          'Elektrik sistemi uçağın temel fonksiyonlarını güçlendirir.'),
  GrammarSentence(
      text: 'The fuel flow meter tracks the fuel consumption of the engine.',
      translation: 'Yakıt akış ölçer motorun yakıt tüketimini takip eder.'),
  GrammarSentence(
      text:
          'The aircraft\'s wheels are equipped with brake systems for safe landings.',
      translation:
          'Uçağın tekerlekleri güvenli inişler için fren sistemleriyle donatılmıştır.'),
  GrammarSentence(
      text: 'The landing gear doors close when the gear is fully retracted.',
      translation:
          'İniş takımı kapıları takım tamamen geri çekildiğinde kapanır.'),
  GrammarSentence(
      text: 'The turbine engine converts fuel into thrust.',
      translation: 'Türbin motoru yakıtı itişe dönüştürür.'),
  GrammarSentence(
      text:
          'The engine control unit monitors the engine\'s performance during flight.',
      translation:
          'Motor kontrol ünitesi uçuş sırasında motorun performansını izler.'),
  GrammarSentence(
      text: 'The rudder pedals are used to control the aircraft\'s yaw.',
      translation:
          'Dümen pedalları uçağın sapmasını kontrol etmek için kullanılır.'),
  GrammarSentence(
      text:
          'The autopilot system maintains the aircraft\'s course during long flights.',
      translation: 'Otopilot sistemi uzun uçuşlarda uçağın rotasını korur.'),
  GrammarSentence(
      text:
          'The transponder sends the aircraft\'s position to air traffic control.',
      translation:
          'Transponder uçağın konumunu hava trafik kontrolüne gönderir.'),
  GrammarSentence(
      text: 'The cargo compartment is located in the lower fuselage.',
      translation: 'Kargo bölümü alt gövdede bulunur.'),
  GrammarSentence(
      text: 'The hydraulic system powers the control surfaces during flight.',
      translation:
          'Hidrolik sistem uçuş sırasında kontrol yüzeylerini güçlendirir.'),
  GrammarSentence(
      text:
          'The engine nacelle is part of the engine assembly that houses the engine.',
      translation:
          'Motor kaportası motoru barındıran motor montajının bir parçasıdır.'),
  GrammarSentence(
      text: 'The flap actuators control the position of the wing flaps.',
      translation:
          'Kanatçık aktüatörleri kanat kanatçıklarının pozisyonunu kontrol eder.'),
  GrammarSentence(
      text:
          'The altimeter measures the aircraft\'s altitude using air pressure.',
      translation:
          'İrtifa ölçer hava basıncını kullanarak uçağın irtifasını ölçer.'),
  GrammarSentence(
      text: 'The tail rotor helps control the helicopter\'s yaw.',
      translation:
          'Kuyruk rotoru helikopterin sapmasını kontrol etmeye yardımcı olur.'),
  GrammarSentence(
      text: 'The control panel is located at the pilot\'s station.',
      translation: 'Kontrol paneli pilotun istasyonunda bulunur.'),
  GrammarSentence(
      text:
          'The emergency lighting system provides illumination during evacuations.',
      translation:
          'Acil aydınlatma sistemi tahliyeler sırasında aydınlatma sağlar.'),
  GrammarSentence(
      text: 'The propeller blades are part of the powerplant system.',
      translation: 'Pervane kanatları güç ünitesi sisteminin bir parçasıdır.'),
  GrammarSentence(
      text:
          'The navigation lights are mounted on the wing tips for visibility.',
      translation:
          'Navigasyon ışıkları görünürlük için kanat uçlarına monte edilir.'),

  // Teknik Yazımda Kelime Sırasının Önemi
  GrammarSentence(
      text: 'The engine mounting is secured to the fuselage with brackets.',
      translation: 'Motor bağlantısı braketlerle gövdeye sabitlenir.'),
  GrammarSentence(
      text: 'The rudder controls the aircraft\'s yaw during takeoff.',
      translation: 'Dümen kalkış sırasında uçağın sapmasını kontrol eder.'),
  GrammarSentence(
      text:
          'The aircraft\'s fuselage contains the cockpit, cargo hold, and wings.',
      translation:
          'Uçağın gövdesi kokpiti, kargo bölümünü ve kanatları içerir.'),
  GrammarSentence(
      text:
          'The emergency exits are marked with illuminated signs during low-light conditions.',
      translation:
          'Acil çıkışlar düşük ışık koşullarında aydınlatılmış işaretlerle belirtilir.'),
  GrammarSentence(
      text:
          'The control yoke is used by the pilot to adjust the aircraft\'s pitch.',
      translation:
          'Kontrol boynuzu pilot tarafından uçağın yunuslamasını ayarlamak için kullanılır.'),
  GrammarSentence(
      text: 'The windshield is made of reinforced glass to protect the pilot.',
      translation:
          'Ön cam pilotu korumak için güçlendirilmiş camdan yapılmıştır.'),
  GrammarSentence(
      text:
          'The turbine engines provide the thrust needed for takeoff and flight.',
      translation:
          'Türbin motorları kalkış ve uçuş için gerekli itişi sağlar.'),
  GrammarSentence(
      text:
          'The flap system increases the lift and drag of the aircraft during landing.',
      translation:
          'Kanatçık sistemi iniş sırasında uçağın kaldırma ve sürtünmesini artırır.'),
  GrammarSentence(
      text:
          'The cargo doors are controlled by hydraulic actuators to open and close.',
      translation:
          'Kargo kapıları açılıp kapanmak için hidrolik aktüatörlerle kontrol edilir.'),
  GrammarSentence(
      text: 'The pilot\'s seat is adjustable for comfort during long flights.',
      translation: 'Pilotun koltuğu uzun uçuşlarda konfor için ayarlanabilir.'),
  GrammarSentence(
      text: 'The tailplane stabilizes the aircraft\'s pitch during flight.',
      translation:
          'Kuyruk kanadı uçuş sırasında uçağın yunuslamasını dengeler.'),
  GrammarSentence(
      text:
          'The windshield wipers are activated by the pilot during rainy conditions.',
      translation:
          'Ön cam silecekleri yağmurlu koşullarda pilot tarafından etkinleştirilir.'),
  GrammarSentence(
      text:
          'The oxygen system provides emergency air during high-altitude flights.',
      translation:
          'Oksijen sistemi yüksek irtifa uçuşlarında acil hava sağlar.'),
  GrammarSentence(
      text:
          'The landing gear consists of wheels, hydraulic actuators, and brake systems.',
      translation:
          'İniş takımı tekerlekler, hidrolik aktüatörler ve fren sistemlerinden oluşur.'),
  GrammarSentence(
      text:
          'The cargo hold doors are designed to be opened by ground crew during loading.',
      translation:
          'Kargo bölümü kapıları yükleme sırasında yer ekibi tarafından açılacak şekilde tasarlanmıştır.'),
  GrammarSentence(
      text:
          'The electrical system powers the instruments, lights, and communication systems.',
      translation:
          'Elektrik sistemi aletleri, ışıkları ve iletişim sistemlerini güçlendirir.'),
  GrammarSentence(
      text:
          'The flight deck houses the pilot\'s controls and navigation systems.',
      translation:
          'Uçuş güvertesi pilotun kontrollerini ve navigasyon sistemlerini barındır.'),
  GrammarSentence(
      text:
          'The engine\'s thrust is controlled by the pilot through the throttle.',
      translation:
          'Motorun itişi pilot tarafından gaz kelebeği aracılığıyla kontrol edilir.'),
  GrammarSentence(
      text:
          'The emergency beacon transmits a signal to rescue teams during an emergency.',
      translation:
          'Acil durum işareti acil bir durumda kurtarma ekiplerine sinyal gönderir.'),
  GrammarSentence(
      text:
          'The autopilot system can control the aircraft\'s speed, altitude, and heading.',
      translation:
          'Otopilot sistemi uçağın hızını, irtifasını ve rotasını kontrol edebilir.'),

  // Kelime Sırasının Diğer Örnekleri
  GrammarSentence(
      text: 'The fuel system ensures that fuel is supplied to the engines.',
      translation: 'Yakıt sistemi motorlara yakıt sağlanmasını garanti eder.'),
  GrammarSentence(
      text: 'The turbine engines are located at the rear of the aircraft.',
      translation: 'Türbin motorları uçağın arkasında bulunur.'),
  GrammarSentence(
      text:
          'The cargo hold is separated from the passenger cabin by a bulkhead.',
      translation: 'Kargo bölümü yolcu kabininden bir bölme ile ayrılır.'),
  GrammarSentence(
      text:
          'The engine cowling reduces drag and protects the engine from debris.',
      translation:
          'Motor kaportası sürtünmeyi azaltır ve motoru kalıntılardan korur.'),
  GrammarSentence(
      text:
          'The propeller blades rotate to produce the necessary thrust for the aircraft.',
      translation:
          'Pervane kanatları uçak için gereken itişi üretmek için döner.'),
  GrammarSentence(
      text: 'The tail section includes the elevator, rudder, and stabilizer.',
      translation: 'Kuyruk bölümü asansör, dümen ve dengeleyiciyi içerir.'),
  GrammarSentence(
      text: 'The wings provide lift and aerodynamic stability to the aircraft.',
      translation: 'Kanatlar uçağa kaldırma ve aerodinamik stabilite sağlar.'),
  GrammarSentence(
      text:
          'The avionics system controls the navigation, communication, and instrumentation of the aircraft.',
      translation:
          'Aviyonik sistemi uçağın navigasyonunu, iletişimini ve enstrümanlarını kontrol eder.'),
  GrammarSentence(
      text:
          'The autopilot system allows the pilot to manage the aircraft\'s course during long flights.',
      translation:
          'Otopilot sistemi pilotun uzun uçuşlarda uçağın rotasını yönetmesine olanak tanır.'),
  GrammarSentence(
      text:
          'The navigation lights ensure that the aircraft is visible to other aircraft.',
      translation:
          'Navigasyon ışıkları uçağın diğer uçaklar tarafından görülebilmesini sağlar.'),
  GrammarSentence(
      text:
          'The engine control system monitors the engine\'s temperature, fuel flow, and thrust output.',
      translation:
          'Motor kontrol sistemi motorun sıcaklığını, yakıt akışını ve itme çıktısını izler.'),
  GrammarSentence(
      text:
          'The flap actuators are controlled by hydraulic pressure during takeoff.',
      translation:
          'Kanatçık aktüatörleri kalkış sırasında hidrolik basınçla kontrol edilir.'),
  GrammarSentence(
      text:
          'The landing gear is equipped with shock absorbers to cushion the impact during landing.',
      translation:
          'İniş takımı iniş sırasında darbeyi yumuşatmak için amortisörlerle donatılmıştır.'),
  GrammarSentence(
      text:
          'The windshield of the cockpit is heated to prevent icing during flight.',
      translation:
          'Kokpitin ön camı uçuş sırasında buzlanmayı önlemek için ısıtılır.'),
  GrammarSentence(
      text:
          'The control surfaces are operated using hydraulic fluid during flight.',
      translation:
          'Kontrol yüzeyleri uçuş sırasında hidrolik sıvı kullanılarak çalıştırılır.'),
  GrammarSentence(
      text:
          'The cargo area is designed to carry both passengers\' luggage and cargo.',
      translation:
          'Kargo alanı hem yolcu bagajlarını hem de kargoyu taşımak için tasarlanmıştır.'),
  GrammarSentence(
      text: 'The pitot tube measures the aircraft\'s speed through the air.',
      translation: 'Pitot tüpü uçağın havadaki hızını ölçer.'),
  GrammarSentence(
      text:
          'The flight deck is equipped with instrumentation to monitor the aircraft\'s status.',
      translation:
          'Uçuş güvertesi uçağın durumunu izlemek için enstrümanlarla donatılmıştır.'),
  GrammarSentence(
      text:
          'The turbine engines provide thrust for the aircraft to maintain speed and altitude.',
      translation:
          'Türbin motorları uçağın hızını ve irtifasını koruması için itiş sağlar.'),
  GrammarSentence(
      text:
          'The autopilot system uses sensors to adjust the aircraft\'s heading during flight.',
      translation:
          'Otopilot sistemi uçuş sırasında uçağın rotasını ayarlamak için sensörler kullanır.'),

  // Bileşik Kelimelerin Kullanımı
  GrammarSentence(
      text: 'The fuel pump draws fuel from the tank to the engine.',
      translation: 'Yakıt pompası tanktan motora yakıt çeker.'),
  GrammarSentence(
      text:
          'The navigation system helps the pilot determine the aircraft\'s position.',
      translation:
          'Navigasyon sistemi pilotun uçağın konumunu belirlemesine yardımcı olur.'),
  GrammarSentence(
      text:
          'The electrical circuit powers the cockpit instruments during flight.',
      translation:
          'Elektrik devresi uçuş sırasında kokpit aletlerini güçlendirir.'),
  GrammarSentence(
      text: 'The cargo bay is accessible from the aircraft\'s rear section.',
      translation: 'Kargo bölümü uçağın arka kısmından erişilebilir.'),
  GrammarSentence(
      text:
          'The emergency exit allows for a quick evacuation of the aircraft in case of emergency.',
      translation:
          'Acil çıkış acil durumlarda uçağın hızlı tahliyesine olanak tanır.'),
  GrammarSentence(
      text:
          'The tail rotor is responsible for counteracting the torque produced by the main rotor.',
      translation:
          'Kuyruk rotoru ana rotorun ürettiği torka karşı koymaktan sorumludur.'),
  GrammarSentence(
      text:
          'The control yoke is used to adjust the pitch and roll of the aircraft.',
      translation:
          'Kontrol boynuzu uçağın yunuslamasını ve yuvarlanmasını ayarlamak için kullanılır.'),
  GrammarSentence(
      text:
          'The emergency oxygen mask is deployed when the cabin pressure drops.',
      translation:
          'Acil oksijen maskesi kabin basıncı düştüğünde devreye girer.'),
  GrammarSentence(
      text:
          'The engine cowling is designed to protect the engine and reduce air resistance.',
      translation:
          'Motor kaportası motoru korumak ve hava direncini azaltmak için tasarlanmıştır.'),
  GrammarSentence(
      text: 'The flap system adjusts the angle of the wings to increase lift.',
      translation:
          'Kanatçık sistemi kaldırma kuvvetini artırmak için kanatların açısını ayarlar.'),
  GrammarSentence(
      text:
          'The air conditioning system regulates the temperature inside the cabin.',
      translation: 'Klima sistemi kabin içindeki sıcaklığı düzenler.'),
  GrammarSentence(
      text:
          'The avionics bay houses the navigation system and communication equipment.',
      translation:
          'Aviyonik bölümü navigasyon sistemini ve iletişim ekipmanını barındırır.'),
  GrammarSentence(
      text: 'The control panel allows the pilot to manage flight systems.',
      translation:
          'Kontrol paneli pilotun uçuş sistemlerini yönetmesine olanak tanır.'),
  GrammarSentence(
      text:
          'The landing gear is equipped with shock absorbers for smooth landings.',
      translation:
          'İniş takımı yumuşak inişler için amortisörlerle donatılmıştır.'),
  GrammarSentence(
      text:
          'The emergency beacon transmits the aircraft\'s position to the ground crews.',
      translation: 'Acil durum işareti uçağın konumunu yer ekiplerine iletir.'),
  GrammarSentence(
      text:
          'The engine control system monitors the performance of the engine during flight.',
      translation:
          'Motor kontrol sistemi uçuş sırasında motorun performansını izler.'),
  GrammarSentence(
      text:
          'The tail rotor is located at the end of the helicopter\'s tail to prevent spinning.',
      translation:
          'Kuyruk rotoru dönmeyi önlemek için helikopterin kuyruğunun sonunda bulunur.'),
  GrammarSentence(
      text:
          'The pilot\'s seat is adjustable for comfort and safety during long flights.',
      translation:
          'Pilotun koltuğu uzun uçuşlarda konfor ve güvenlik için ayarlanabilir.'),
  GrammarSentence(
      text:
          'The autopilot system controls the aircraft\'s altitude, heading, and speed.',
      translation:
          'Otopilot sistemi uçağın irtifasını, rotasını ve hızını kontrol eder.'),
  GrammarSentence(
      text:
          'The wings of the aircraft generate lift and stability during flight.',
      translation:
          'Uçağın kanatları uçuş sırasında kaldırma ve stabilite üretir.'),
];

// TOPIC B: PREPOSITIONS (Edatlar/Prepositions)
final GrammarTopic topicBPrepositions = GrammarTopic(
  letter: 'B',
  title: 'Prepositions',
  titleKey: 'grammar_prepositions',
  description: 'Visual puzzles to learn prepositions of place and direction',
  icon: '🧩',
  exercises: _topicBExercises,
);

// TOPIC B EXERCISES (35 preposition puzzles)
final List<GrammarExercise> _topicBExercises = [
  GrammarExercise(
    question: 'The cargo is stored ___ the aircraft.',
    options: ['IN', 'ON', 'AT', 'TO'],
    correctIndex: 0,
    explanation:
        'We use IN for enclosed spaces like the interior of an aircraft.',
  ),
  GrammarExercise(
    question: 'The pilot is sitting ___ the control panel.',
    options: ['IN', 'AT', 'ON', 'OVER'],
    correctIndex: 1,
    explanation: 'We use AT when referring to a specific location or position.',
  ),
  GrammarExercise(
    question: 'The aircraft lands ___ 3 o\'clock.',
    options: ['IN', 'ON', 'AT', 'TO'],
    correctIndex: 2,
    explanation: 'We use AT with specific times.',
  ),
  GrammarExercise(
    question: 'The fuel flows ___ the engine.',
    options: ['IN', 'TO', 'AT', 'FROM'],
    correctIndex: 1,
    explanation: 'We use TO to show direction or movement toward something.',
  ),
  GrammarExercise(
    question: 'The wings extend ___ the fuselage.',
    options: ['OUT OF', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use OUT OF to show something coming from inside.',
  ),
  GrammarExercise(
    question: 'The engine is located ___ the wing.',
    options: ['IN', 'UNDER', 'ON', 'AT'],
    correctIndex: 1,
    explanation: 'We use UNDER to show something is below or beneath.',
  ),
  GrammarExercise(
    question: 'The aircraft flies ___ the runway.',
    options: ['IN FRONT OF', 'AT', 'IN', 'TO'],
    correctIndex: 0,
    explanation: 'We use IN FRONT OF to show position ahead of something.',
  ),
  GrammarExercise(
    question: 'The landing gear is ___ the fuselage.',
    options: ['IN', 'BENEATH', 'AT', 'ON'],
    correctIndex: 1,
    explanation: 'We use BENEATH to show something is directly below.',
  ),
  GrammarExercise(
    question: 'The radar is mounted ___ the cockpit.',
    options: ['OVER', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use OVER to show something is above or covering.',
  ),
  GrammarExercise(
    question: 'The aircraft taxies ___ the apron.',
    options: ['IN', 'ON', 'ALONG', 'AT'],
    correctIndex: 2,
    explanation: 'We use ALONG to show movement following a line or path.',
  ),
  GrammarExercise(
    question: 'The passengers sit ___ the cabin.',
    options: ['WITHIN', 'AT', 'ON', 'TO'],
    correctIndex: 0,
    explanation: 'We use WITHIN to show something is inside boundaries.',
  ),
  GrammarExercise(
    question: 'The aircraft descends ___ the clouds.',
    options: ['IN', 'THROUGH', 'AT', 'ON'],
    correctIndex: 1,
    explanation: 'We use THROUGH to show movement from one side to another.',
  ),
  GrammarExercise(
    question: 'The compass is ___ the center of the panel.',
    options: ['IN', 'AT', 'ON', 'CENTER'],
    correctIndex: 1,
    explanation: 'We use AT to indicate a specific point or location.',
  ),
  GrammarExercise(
    question: 'The fuel tank is located ___ the wing.',
    options: ['IN', 'ON', 'NEAR', 'AT'],
    correctIndex: 0,
    explanation: 'We use IN for something contained within.',
  ),
  GrammarExercise(
    question: 'The microphone is turned ___.',
    options: ['ON', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use ON to show activation of electronic devices.',
  ),
  GrammarExercise(
    question: 'The aircraft travels ___ cities.',
    options: ['BETWEEN', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use BETWEEN to show position in the middle of two things.',
  ),
  GrammarExercise(
    question: 'The thrust lever is positioned ___ the cockpit.',
    options: ['IN', 'ON', 'TOP', 'AT'],
    correctIndex: 0,
    explanation: 'We use IN to show location within an enclosed space.',
  ),
  GrammarExercise(
    question: 'The aircraft flies ___ London ___ New York.',
    options: ['FROM...TO', 'IN...AT', 'ON...TO', 'AT...IN'],
    correctIndex: 0,
    explanation: 'We use FROM...TO to show movement between two locations.',
  ),
  GrammarExercise(
    question: 'The altimeter is ___ the instrument panel.',
    options: ['ON', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use ON for surfaces and panels.',
  ),
  GrammarExercise(
    question: 'The airport is located ___ the city.',
    options: ['NEAR', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use NEAR to show proximity.',
  ),
  GrammarExercise(
    question: 'The rudder rotates ___ its axis.',
    options: ['AROUND', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use AROUND to show circular movement.',
  ),
  GrammarExercise(
    question: 'The cockpit is positioned ___ the fuselage.',
    options: ['AT', 'TOP', 'IN', 'ON'],
    correctIndex: 0,
    explanation: 'We use AT to indicate position at a specific location.',
  ),
  GrammarExercise(
    question: 'The aircraft parks ___ the hangar.',
    options: ['IN', 'ON', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use IN for enclosed spaces like hangars.',
  ),
  GrammarExercise(
    question: 'Navigation lights are ___ the wing tips.',
    options: ['AT', 'IN', 'ON', 'TO'],
    correctIndex: 2,
    explanation: 'We use ON for things attached to surfaces.',
  ),
  GrammarExercise(
    question: 'Emergency exits are ___ both sides.',
    options: ['ON', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use ON to show position on sides.',
  ),
  GrammarExercise(
    question: 'The aircraft climbs ___ higher altitude.',
    options: ['TO', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use TO to show movement toward a destination.',
  ),
  GrammarExercise(
    question: 'The turbulence occurs ___ the storm.',
    options: ['DURING', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use DURING to show when something happens.',
  ),
  GrammarExercise(
    question: 'The aircraft is ___ the runway.',
    options: ['ON', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use ON for surfaces like runways.',
  ),
  GrammarExercise(
    question: 'The cargo hold is ___ the passenger cabin.',
    options: ['BELOW', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use BELOW to show lower position.',
  ),
  GrammarExercise(
    question: 'The throttle is pushed ___.',
    options: ['FORWARD', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use FORWARD to show direction ahead.',
  ),
  GrammarExercise(
    question: 'The aircraft turns ___ the left.',
    options: ['TO', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use TO to show direction of turning.',
  ),
  GrammarExercise(
    question: 'The flight departs ___ gate 5.',
    options: ['FROM', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use FROM to show the starting point.',
  ),
  GrammarExercise(
    question: 'The engine is mounted ___ the wing.',
    options: ['UNDER', 'IN', 'AT', 'TO'],
    correctIndex: 0,
    explanation: 'We use UNDER to show something beneath.',
  ),
  GrammarExercise(
    question: 'The pilot looks ___ the windshield.',
    options: ['THROUGH', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use THROUGH to show seeing via transparent surface.',
  ),
  GrammarExercise(
    question: 'The aircraft flies ___ the clouds.',
    options: ['ABOVE', 'IN', 'AT', 'ON'],
    correctIndex: 0,
    explanation: 'We use ABOVE to show higher position.',
  ),
];

// TOPIC C1: THE INFINITIVE (Mastar)
final GrammarTopic topicC1Infinitive = GrammarTopic(
  letter: 'C1',
  title: 'The Infinitive',
  titleKey: 'grammar_infinitive',
  description:
      'Understanding infinitive verb forms (to + verb) in technical English',
  icon: '📌',
  sentences: _topicC1Sentences,
);

// TOPIC C1 SENTENCES (10 sentences)
final List<GrammarSentence> _topicC1Sentences = [
  GrammarSentence(
      text: 'The lever is used to extend the flaps.',
      translation: 'Kol kanatçıkları uzatmak için kullanılır.'),
  GrammarSentence(
      text: 'There is a knob to set the altitude.',
      translation: 'İrtifayı ayarlamak için bir düğme vardır.'),
  GrammarSentence(
      text: 'To open the circuit, pull the circuit breaker.',
      translation: 'Devreyi açmak için devre kesiciyi çekin.'),
  GrammarSentence(
      text: 'The valve is designed to control the air pressure.',
      translation: 'Valf hava basıncını kontrol etmek için tasarlanmıştır.'),
  GrammarSentence(
      text: 'The system is used to monitor the engine status.',
      translation: 'Sistem motor durumunu izlemek için kullanılır.'),
  GrammarSentence(
      text: 'The technician is instructed to inspect the hydraulic system.',
      translation:
          'Teknisyene hidrolik sistemi kontrol etmesi talimatı verilir.'),
  GrammarSentence(
      text: 'The machine requires to be repaired before use.',
      translation: 'Makine kullanımdan önce tamir edilmelidir.'),
  GrammarSentence(
      text: 'The purpose of the sensor is to detect abnormal vibrations.',
      translation: 'Sensörün amacı anormal titreşimleri tespit etmektir.'),
  GrammarSentence(
      text: 'The equipment needs to be updated for optimal performance.',
      translation: 'Ekipmanın optimum performans için güncellenmesi gerekir.'),
  GrammarSentence(
      text: 'To activate the alarm, press the red button.',
      translation: 'Alarmı etkinleştirmek için kırmızı düğmeye basın.'),
];

// TOPIC C2: THE PRESENT SIMPLE (Geniş Zaman)
final GrammarTopic topicC2PresentSimple = GrammarTopic(
  letter: 'C2',
  title: 'The Present Simple',
  titleKey: 'grammar_present_simple',
  description:
      'Using present simple tense for facts, routines, and regular actions',
  icon: '⏰',
  sentences: _topicC2Sentences,
);

// TOPIC C2 SENTENCES (10 sentences)
final List<GrammarSentence> _topicC2Sentences = [
  GrammarSentence(
      text: 'The turbine generates power for the entire system.',
      translation: 'Türbin tüm sistem için güç üretir.'),
  GrammarSentence(
      text: 'The air conditioning maintains the cabin temperature.',
      translation: 'Klima kabin sıcaklığını korur.'),
  GrammarSentence(
      text: 'The engine starts smoothly if the fuel system is intact.',
      translation: 'Yakıt sistemi sağlamsa motor yumuşak bir şekilde çalışır.'),
  GrammarSentence(
      text: 'The system monitors pressure levels automatically.',
      translation: 'Sistem basınç seviyelerini otomatik olarak izler.'),
  GrammarSentence(
      text: 'The technicians inspect the aircraft every 100 hours.',
      translation: 'Teknisyenler uçağı her 100 saatte bir kontrol eder.'),
  GrammarSentence(
      text: 'The crew checks the flight instruments before takeoff.',
      translation: 'Ekip kalkıştan önce uçuş aletlerini kontrol eder.'),
  GrammarSentence(
      text: 'The aircraft uses a hydraulic system to move the landing gear.',
      translation:
          'Uçak iniş takımını hareket ettirmek için hidrolik sistem kullanır.'),
  GrammarSentence(
      text: 'The pressure valve opens when the system exceeds limits.',
      translation: 'Sistem limitleri aştığında basınç valfi açılır.'),
  GrammarSentence(
      text: 'The system functions properly after calibration.',
      translation: 'Sistem kalibrasyondan sonra düzgün çalışır.'),
  GrammarSentence(
      text: 'The control system reacts automatically to sensor inputs.',
      translation:
          'Kontrol sistemi sensör girdilerine otomatik olarak tepki verir.'),
];

// TOPIC C3: TO BE / TO HAVE (Olmak/Sahip Olmak)
final GrammarTopic topicC3ToBeToHave = GrammarTopic(
  letter: 'C3',
  title: 'To Be / To Have',
  titleKey: 'grammar_to_be_to_have',
  description: 'Essential auxiliary verbs: be and have in technical contexts',
  icon: '🔧',
  sentences: _topicC3Sentences,
);

// TOPIC C3 SENTENCES (10 sentences)
final List<GrammarSentence> _topicC3Sentences = [
  GrammarSentence(
      text: 'The sensor is located under the cabin floor.',
      translation: 'Sensör kabin tabanının altında bulunur.'),
  GrammarSentence(
      text: 'The aircraft has four engines.',
      translation: 'Uçağın dört motoru vardır.'),
  GrammarSentence(
      text: 'The technician is performing the maintenance check.',
      translation: 'Teknisyen bakım kontrolünü yapıyor.'),
  GrammarSentence(
      text: 'The valves are inspected regularly for wear and tear.',
      translation:
          'Valfler aşınma ve yıpranma açısından düzenli olarak kontrol edilir.'),
  GrammarSentence(
      text: 'The power supply is turned on before starting the tests.',
      translation: 'Testlere başlamadan önce güç kaynağı açılır.'),
  GrammarSentence(
      text: 'The turbine has undergone extensive testing.',
      translation: 'Türbin kapsamlı test geçirmiştir.'),
  GrammarSentence(
      text: 'The technician is aware of the required procedures.',
      translation: 'Teknisyen gerekli prosedürlerin farkındadır.'),
  GrammarSentence(
      text: 'The pumps are tested for efficiency.',
      translation: 'Pompalar verimlilik açısından test edilir.'),
  GrammarSentence(
      text: 'The aircraft has a backup system for safety.',
      translation: 'Uçağın güvenlik için yedek bir sistemi vardır.'),
  GrammarSentence(
      text: 'The signal is clear once the connection is established.',
      translation: 'Bağlantı kurulduktan sonra sinyal nettir.'),
];

// TOPIC C4: THE IMPERATIVE (Emir Kipi)
final GrammarTopic topicC4Imperative = GrammarTopic(
  letter: 'C4',
  title: 'The Imperative',
  titleKey: 'grammar_imperative',
  description: 'Command forms used in instructions and procedures',
  icon: '⚡',
  sentences: _topicC4Sentences,
);

// TOPIC C4 SENTENCES (10 sentences)
final List<GrammarSentence> _topicC4Sentences = [
  GrammarSentence(
      text: 'Disconnect the power before starting the repair.',
      translation: 'Tamire başlamadan önce gücü kesin.'),
  GrammarSentence(
      text: 'Check the fuel levels before every flight.',
      translation: 'Her uçuştan önce yakıt seviyelerini kontrol edin.'),
  GrammarSentence(
      text: 'Turn off the system after testing.',
      translation: 'Testten sonra sistemi kapatın.'),
  GrammarSentence(
      text: 'Ensure the circuit is closed before starting the engine.',
      translation:
          'Motoru çalıştırmadan önce devrenin kapalı olduğundan emin olun.'),
  GrammarSentence(
      text: 'Install the new components as per the instructions.',
      translation: 'Yeni bileşenleri talimatlara göre takın.'),
  GrammarSentence(
      text: 'Replace the damaged cables immediately.',
      translation: 'Hasarlı kabloları hemen değiştirin.'),
  GrammarSentence(
      text: 'Calibrate the sensor to ensure accurate readings.',
      translation: 'Doğru ölçümler sağlamak için sensörü kalibre edin.'),
  GrammarSentence(
      text: 'Monitor the temperature levels during the operation.',
      translation: 'İşlem sırasında sıcaklık seviyelerini izleyin.'),
  GrammarSentence(
      text: 'Test the backup system after maintenance.',
      translation: 'Bakımdan sonra yedek sistemi test edin.'),
  GrammarSentence(
      text: 'Verify the equipment before use.',
      translation: 'Kullanmadan önce ekipmanı doğrulayın.'),
];

// TOPIC C5: THE GERUND (Fiil+ing)
final GrammarTopic topicC5Gerund = GrammarTopic(
  letter: 'C5',
  title: 'The Gerund',
  titleKey: 'grammar_gerund',
  description: 'Using verb+ing forms as nouns in technical writing',
  icon: '🔄',
  sentences: _topicC5Sentences,
);

// TOPIC C5 SENTENCES (10 sentences)
final List<GrammarSentence> _topicC5Sentences = [
  GrammarSentence(
      text: 'Checking the fuel pressure is mandatory before each flight.',
      translation:
          'Yakıt basıncını kontrol etmek her uçuştan önce zorunludur.'),
  GrammarSentence(
      text: 'Testing the circuit ensures safety.',
      translation: 'Devreyi test etmek güvenliği sağlar.'),
  GrammarSentence(
      text: 'Monitoring the temperature is crucial during operation.',
      translation: 'Sıcaklığı izlemek operasyon sırasında kritiktir.'),
  GrammarSentence(
      text: 'Inspecting the engine after each flight is a standard procedure.',
      translation:
          'Her uçuştan sonra motoru kontrol etmek standart bir prosedürdür.'),
  GrammarSentence(
      text: 'Cleaning the system filters prevents blockages.',
      translation: 'Sistem filtrelerini temizlemek tıkanmaları önler.'),
  GrammarSentence(
      text: 'Performing routine maintenance enhances system reliability.',
      translation: 'Rutin bakım yapmak sistem güvenilirliğini artırır.'),
  GrammarSentence(
      text: 'Starting the engine requires proper safety checks.',
      translation: 'Motoru çalıştırmak uygun güvenlik kontrolleri gerektirir.'),
  GrammarSentence(
      text: 'Maintaining the equipment regularly extends its lifespan.',
      translation: 'Ekipmanı düzenli olarak bakıma almak ömrünü uzatır.'),
  GrammarSentence(
      text: 'Installing the new software was completed successfully.',
      translation: 'Yeni yazılımı yüklemek başarıyla tamamlandı.'),
  GrammarSentence(
      text: 'Adjusting the control system ensures smoother operation.',
      translation: 'Kontrol sistemini ayarlamak daha yumuşak çalışma sağlar.'),
];

// TOPIC C6: THE PAST PARTICIPLE (Geçmiş Zaman Ortacı)
final GrammarTopic topicC6PastParticiple = GrammarTopic(
  letter: 'C6',
  title: 'The Past Participle',
  titleKey: 'grammar_past_participle',
  description: 'Past participle forms in passive voice and perfect tenses',
  icon: '⏮️',
  sentences: _topicC6Sentences,
);

// TOPIC C6 SENTENCES (10 sentences)
final List<GrammarSentence> _topicC6Sentences = [
  GrammarSentence(
      text: 'The circuit was connected before the test started.',
      translation: 'Test başlamadan önce devre bağlandı.'),
  GrammarSentence(
      text: 'The systems have been tested for durability.',
      translation: 'Sistemler dayanıklılık açısından test edildi.'),
  GrammarSentence(
      text: 'The oil filter has been replaced during the service.',
      translation: 'Yağ filtresi servis sırasında değiştirildi.'),
  GrammarSentence(
      text: 'The aircraft was inspected for any structural damage.',
      translation: 'Uçak herhangi bir yapısal hasar açısından kontrol edildi.'),
  GrammarSentence(
      text: 'The pressure valve was calibrated before use.',
      translation: 'Basınç valfi kullanımdan önce kalibre edildi.'),
  GrammarSentence(
      text: 'The maintenance report has been submitted to the team.',
      translation: 'Bakım raporu ekibe sunuldu.'),
  GrammarSentence(
      text: 'The components were assembled following the manual.',
      translation: 'Bileşenler kılavuzu takip ederek monte edildi.'),
  GrammarSentence(
      text: 'The system has been updated to the latest version.',
      translation: 'Sistem en son sürüme güncellendi.'),
  GrammarSentence(
      text: 'The procedure was completed without any issues.',
      translation: 'Prosedür herhangi bir sorun olmadan tamamlandı.'),
  GrammarSentence(
      text: 'The damage was repaired by the technician.',
      translation: 'Hasar teknisyen tarafından tamir edildi.'),
];

// TOPIC D: INSTRUCTIONS & PROCEDURES (Talimatlar ve Prosedürler)
final GrammarTopic topicDInstructionsAndProcedures = GrammarTopic(
  letter: 'D',
  title: 'Instructions & Procedures',
  titleKey: 'grammar_instructions_procedures',
  description:
      'Technical instructions and procedural language in aviation maintenance',
  icon: '📋',
  sentences: _topicDSentences,
);

// TOPIC D SENTENCES (60 sentences)
final List<GrammarSentence> _topicDSentences = [
  // Basic Instructions with Components (10 sentences)
  GrammarSentence(text: 'Turn off the engine.', translation: 'Motoru kapatın.'),
  GrammarSentence(
      text: 'Disconnect the electrical power supply.',
      translation: 'Elektrik güç kaynağını kesin.'),
  GrammarSentence(
      text: 'Remove the access panel.',
      translation: 'Erişim panelini çıkarın.'),
  GrammarSentence(
      text: 'Open the fuel valve.', translation: 'Yakıt valfini açın.'),
  GrammarSentence(
      text: 'Close the circuit breaker.',
      translation: 'Devre kesiciyi kapatın.'),
  GrammarSentence(
      text: 'Activate the hydraulic system.',
      translation: 'Hidrolik sistemi etkinleştirin.'),
  GrammarSentence(
      text: 'Release the parking brake.',
      translation: 'Park frenini serbest bırakın.'),
  GrammarSentence(
      text: 'Engage the landing gear.',
      translation: 'İniş takımını devreye alın.'),
  GrammarSentence(
      text: 'Shut down the auxiliary power unit.',
      translation: 'Yardımcı güç ünitesini kapatın.'),
  GrammarSentence(
      text: 'Unlock the control panel.',
      translation: 'Kontrol panelinin kilidini açın.'),

  // Using Passive Voice (10 sentences)
  GrammarSentence(text: 'The valve is closed.', translation: 'Valf kapalıdır.'),
  GrammarSentence(
      text: 'The air conditioning system is tested.',
      translation: 'Hava koşullandırma sistemi test edilmiştir.'),
  GrammarSentence(
      text: 'The circuit breaker is reset.',
      translation: 'Devre kesici sıfırlanmıştır.'),
  GrammarSentence(
      text: 'The fuel tank is drained.',
      translation: 'Yakıt tankı boşaltılmıştır.'),
  GrammarSentence(
      text: 'The engine is inspected.',
      translation: 'Motor kontrol edilmiştir.'),
  GrammarSentence(
      text: 'The battery is charged.', translation: 'Batarya şarj edilmiştir.'),
  GrammarSentence(
      text: 'The hydraulic fluid is replaced.',
      translation: 'Hidrolik sıvı değiştirilmiştir.'),
  GrammarSentence(
      text: 'The landing gear is retracted.',
      translation: 'İniş takımı geri çekilmiştir.'),
  GrammarSentence(
      text: 'The navigation system is calibrated.',
      translation: 'Navigasyon sistemi kalibre edilmiştir.'),
  GrammarSentence(
      text: 'The cockpit is secured.',
      translation: 'Kokpit güvenli hale getirilmiştir.'),

  // Procedure Steps (10 sentences)
  GrammarSentence(
      text: 'Ensure the power is off before beginning the maintenance.',
      translation:
          'Bakım işlemine başlamadan önce gücün kapalı olduğundan emin olun.'),
  GrammarSentence(
      text: 'Press the button to initiate the procedure.',
      translation: 'Prosedürü başlatmak için düğmeye basın.'),
  GrammarSentence(
      text: 'Check the oil level before starting the engine.',
      translation: 'Motoru çalıştırmadan önce yağ seviyesini kontrol edin.'),
  GrammarSentence(
      text: 'Verify all connections before applying power.',
      translation: 'Gücü uygulamadan önce tüm bağlantıları doğrulayın.'),
  GrammarSentence(
      text: 'Wait for the system to cool down before inspection.',
      translation: 'İncelemeden önce sistemin soğumasını bekleyin.'),
  GrammarSentence(
      text: 'Follow the checklist in the correct sequence.',
      translation: 'Kontrol listesini doğru sırayla takip edin.'),
  GrammarSentence(
      text: 'Confirm the engine status before takeoff.',
      translation: 'Kalkıştan önce motor durumunu onaylayın.'),
  GrammarSentence(
      text: 'Obtain clearance before starting the engines.',
      translation: 'Motorları çalıştırmadan önce izin alın.'),
  GrammarSentence(
      text: 'Document all findings in the maintenance log.',
      translation: 'Tüm bulguları bakım günlüğüne kaydedin.'),
  GrammarSentence(
      text: 'Complete the pre-flight inspection before departure.',
      translation: 'Kalkıştan önce uçuş öncesi kontrolü tamamlayın.'),

  // Using Action Verbs (10 sentences)
  GrammarSentence(
      text: 'Adjust the temperature settings.',
      translation: 'Sıcaklık ayarlarını yapın.'),
  GrammarSentence(
      text: 'Monitor the pressure regularly.',
      translation: 'Basıncı düzenli olarak izleyin.'),
  GrammarSentence(
      text: 'Perform the safety checks before takeoff.',
      translation: 'Kalkıştan önce güvenlik kontrollerini yapın.'),
  GrammarSentence(
      text: 'Inspect the landing gear for damage.',
      translation: 'İniş takımını hasar açısından inceleyin.'),
  GrammarSentence(
      text: 'Test the communication system.',
      translation: 'İletişim sistemini test edin.'),
  GrammarSentence(
      text: 'Measure the fuel quantity.',
      translation: 'Yakıt miktarını ölçün.'),
  GrammarSentence(
      text: 'Tighten all fasteners securely.',
      translation: 'Tüm bağlantı elemanlarını sıkıca sıkın.'),
  GrammarSentence(
      text: 'Lubricate the moving parts.',
      translation: 'Hareketli parçaları yağlayın.'),
  GrammarSentence(
      text: 'Clean the filter thoroughly.',
      translation: 'Filtreyi iyice temizleyin.'),
  GrammarSentence(
      text: 'Align the components correctly.',
      translation: 'Bileşenleri doğru şekilde hizalayın.'),

  // Checklist Action Examples (10 sentences)
  GrammarSentence(
      text: 'Record the system status in the logbook.',
      translation: 'Sistem durumunu günlük defterine kaydedin.'),
  GrammarSentence(
      text: 'Set the switch to ON.',
      translation: 'Anahtarı AÇIK konumuna getirin.'),
  GrammarSentence(
      text: 'Remove the old filter and install the new one.',
      translation: 'Eski filtreyi çıkarın ve yenisini takın.'),
  GrammarSentence(
      text: 'Mark the completed items on the checklist.',
      translation: 'Tamamlanan maddeleri kontrol listesinde işaretleyin.'),
  GrammarSentence(
      text: 'Attach the safety tags to the equipment.',
      translation: 'Güvenlik etiketlerini ekipmana takın.'),
  GrammarSentence(
      text: 'Sign the maintenance form after completion.',
      translation: 'Tamamladıktan sonra bakım formunu imzalayın.'),
  GrammarSentence(
      text: 'Label all components before disassembly.',
      translation: 'Sökümden önce tüm bileşenleri etiketleyin.'),
  GrammarSentence(
      text: 'Store the removed parts in the designated area.',
      translation: 'Çıkarılan parçaları belirtilen alana koyun.'),
  GrammarSentence(
      text: 'Place the warning signs in visible locations.',
      translation: 'Uyarı işaretlerini görünür yerlere yerleştirin.'),
  GrammarSentence(
      text: 'Update the maintenance schedule accordingly.',
      translation: 'Bakım programını buna göre güncelleyin.'),

  // Passive Voice and Result Descriptions (10 sentences)
  GrammarSentence(
      text: 'The system is reset after the failure.',
      translation: 'Sistem, arıza sonrası sıfırlanır.'),
  GrammarSentence(
      text: 'The door is locked after the procedure is completed.',
      translation: 'Prosedür tamamlandıktan sonra kapı kilitlenir.'),
  GrammarSentence(
      text: 'The aircraft is cleared for takeoff.',
      translation: 'Uçağa kalkış izni verilmiştir.'),
  GrammarSentence(
      text: 'The repairs are completed within the scheduled time.',
      translation: 'Onarımlar planlanan süre içinde tamamlanmıştır.'),
  GrammarSentence(
      text: 'The warning light is activated when pressure drops.',
      translation: 'Basınç düştüğünde uyarı ışığı etkinleştirilir.'),
  GrammarSentence(
      text: 'The data is recorded automatically.',
      translation: 'Veriler otomatik olarak kaydedilir.'),
  GrammarSentence(
      text: 'The component is replaced as per the manual.',
      translation: 'Bileşen kılavuza göre değiştirilmiştir.'),
  GrammarSentence(
      text: 'The test is conducted under controlled conditions.',
      translation: 'Test kontrollü koşullar altında yapılmıştır.'),
  GrammarSentence(
      text: 'The equipment is returned to service after inspection.',
      translation: 'Ekipman kontrolden sonra hizmete iade edilmiştir.'),
  GrammarSentence(
      text: 'The safety procedures are followed strictly.',
      translation: 'Güvenlik prosedürleri kesinlikle takip edilir.'),
];

// TOPIC E: SENTENCE PATTERNS (Cümle Kalıpları)
final GrammarTopic topicESentencePatterns = GrammarTopic(
  letter: 'E',
  title: 'Sentence Patterns',
  titleKey: 'grammar_sentence_patterns',
  description: 'Common sentence structures in technical aviation English',
  icon: '🔤',
  sentences: _topicESentences,
);

// TOPIC E SENTENCES (100 sentences)
final List<GrammarSentence> _topicESentences = [
  // Subject + Verb + Object + Means + Purpose (15 sentences)
  GrammarSentence(
      text:
          'The engine starts the process using the starter motor for ignition.',
      translation:
          'Motor, ateşleme için marş motorunu kullanarak işlemi başlatır.'),
  GrammarSentence(
      text:
          'The sensor detects pressure changes in the system to ensure proper operation.',
      translation:
          'Sensör, düzgün çalışmayı sağlamak için sistemdeki basınç değişikliklerini tespit eder.'),
  GrammarSentence(
      text:
          'The pump circulates coolant through the pipes to maintain engine temperature.',
      translation:
          'Pompa, motor sıcaklığını korumak için soğutucuyu borulardan dolaştırır.'),
  GrammarSentence(
      text:
          'The controller regulates voltage using electronic circuits to protect the equipment.',
      translation:
          'Kontrolör, ekipmanı korumak için elektronik devreler kullanarak voltajı düzenler.'),
  GrammarSentence(
      text:
          'The filter removes contaminants from the fuel to prevent engine damage.',
      translation:
          'Filtre, motor hasarını önlemek için yakıttan kirleticileri çıkarır.'),
  GrammarSentence(
      text:
          'The valve controls fluid flow through the actuator to adjust system pressure.',
      translation:
          'Valf, sistem basıncını ayarlamak için aktüatör aracılığıyla sıvı akışını kontrol eder.'),
  GrammarSentence(
      text:
          'The generator produces electricity using mechanical energy to power the aircraft systems.',
      translation:
          'Jeneratör, uçak sistemlerini çalıştırmak için mekanik enerji kullanarak elektrik üretir.'),
  GrammarSentence(
      text:
          'The computer monitors engine parameters via sensors to optimize performance.',
      translation:
          'Bilgisayar, performansı optimize etmek için sensörler aracılığıyla motor parametrelerini izler.'),
  GrammarSentence(
      text:
          'The hydraulic system moves control surfaces using pressurized fluid to enable flight maneuvers.',
      translation:
          'Hidrolik sistem, uçuş manevralarını mümkün kılmak için basınçlı sıvı kullanarak kontrol yüzeylerini hareket ettirir.'),
  GrammarSentence(
      text:
          'The turbine converts thermal energy through rotation to generate thrust.',
      translation:
          'Türbin, itki üretmek için dönüş yoluyla termal enerjiyi dönüştürür.'),
  GrammarSentence(
      text:
          'The cooling system dissipates heat using airflow to prevent overheating.',
      translation:
          'Soğutma sistemi, aşırı ısınmayı önlemek için hava akışı kullanarak ısıyı dağıtır.'),
  GrammarSentence(
      text:
          'The navigation system calculates position using GPS signals to determine flight path.',
      translation:
          'Navigasyon sistemi, uçuş yolunu belirlemek için GPS sinyalleri kullanarak konumu hesaplar.'),
  GrammarSentence(
      text:
          'The brake system reduces speed through friction to ensure safe landing.',
      translation:
          'Fren sistemi, güvenli iniş sağlamak için sürtünme yoluyla hızı azaltır.'),
  GrammarSentence(
      text:
          'The autopilot maintains altitude using servo motors to reduce pilot workload.',
      translation:
          'Otopilot, pilot iş yükünü azaltmak için servo motorlar kullanarak irtifayı korur.'),
  GrammarSentence(
      text:
          'The compressor increases air pressure by mechanical compression to feed the combustion chamber.',
      translation:
          'Kompresör, yanma odasını beslemek için mekanik sıkıştırma ile hava basıncını artırır.'),

  // Subject + Verb + Object (10 sentences)
  GrammarSentence(
      text: 'The technician inspects the air filter.',
      translation: 'Teknisyen hava filtresini inceler.'),
  GrammarSentence(
      text: 'The system controls the airflow in the cabin.',
      translation: 'Sistem kabinde hava akışını kontrol eder.'),
  GrammarSentence(
      text: 'The pilot monitors the instrument panel.',
      translation: 'Pilot gösterge panelini izler.'),
  GrammarSentence(
      text: 'The engineer tests the hydraulic pump.',
      translation: 'Mühendis hidrolik pompayı test eder.'),
  GrammarSentence(
      text: 'The crew secures the cargo.',
      translation: 'Ekip kargoyu güvenlik altına alır.'),
  GrammarSentence(
      text: 'The mechanic replaces the spark plugs.',
      translation: 'Tamirci bujiyi değiştirir.'),
  GrammarSentence(
      text: 'The computer records flight data.',
      translation: 'Bilgisayar uçuş verilerini kaydeder.'),
  GrammarSentence(
      text: 'The sensor measures temperature.',
      translation: 'Sensör sıcaklığı ölçer.'),
  GrammarSentence(
      text: 'The indicator displays fuel level.',
      translation: 'Gösterge yakıt seviyesini gösterir.'),
  GrammarSentence(
      text: 'The alarm signals system failure.',
      translation: 'Alarm sistem arızasını bildirir.'),

  // Subject + Verb + Object + Purpose (15 sentences)
  GrammarSentence(
      text: 'The operator adjusts the pressure to optimize fuel flow.',
      translation:
          'Operatör, yakıt akışını optimize etmek için basıncı ayarlar.'),
  GrammarSentence(
      text:
          'The crew checks the cabin temperature to ensure comfort for passengers.',
      translation:
          'Ekip, yolcuların rahatını sağlamak için kabin sıcaklığını kontrol eder.'),
  GrammarSentence(
      text: 'The technician calibrates the instruments to maintain accuracy.',
      translation: 'Teknisyen, doğruluğu korumak için aletleri kalibre eder.'),
  GrammarSentence(
      text: 'The pilot activates the landing lights to improve visibility.',
      translation:
          'Pilot, görünürlüğü artırmak için iniş ışıklarını etkinleştirir.'),
  GrammarSentence(
      text: 'The engineer inspects the wiring to detect faults.',
      translation:
          'Mühendis, arızaları tespit etmek için kablolamayı inceler.'),
  GrammarSentence(
      text: 'The mechanic lubricates the bearings to reduce friction.',
      translation: 'Tamirci, sürtünmeyi azaltmak için yatakları yağlar.'),
  GrammarSentence(
      text: 'The operator monitors the gauges to prevent malfunctions.',
      translation: 'Operatör, arızaları önlemek için göstergeleri izler.'),
  GrammarSentence(
      text: 'The crew secures the hatches to maintain cabin pressure.',
      translation:
          'Ekip, kabin basıncını korumak için ambar kapaklarını güvenlik altına alır.'),
  GrammarSentence(
      text: 'The technician tests the backup systems to ensure reliability.',
      translation:
          'Teknisyen, güvenilirliği sağlamak için yedek sistemleri test eder.'),
  GrammarSentence(
      text: 'The pilot reviews the flight plan to verify the route.',
      translation:
          'Pilot, rotayı doğrulamak için uçuş planını gözden geçirir.'),
  GrammarSentence(
      text: 'The engineer updates the software to improve performance.',
      translation: 'Mühendis, performansı artırmak için yazılımı günceller.'),
  GrammarSentence(
      text: 'The mechanic tightens the bolts to secure the assembly.',
      translation: 'Tamirci, montajı sağlamlaştırmak için cıvataları sıkar.'),
  GrammarSentence(
      text: 'The operator drains the tank to remove contaminated fuel.',
      translation: 'Operatör, kirli yakıtı çıkarmak için tankı boşaltır.'),
  GrammarSentence(
      text: 'The crew positions the aircraft to align with the runway.',
      translation: 'Ekip, pistle hizalamak için uçağı konumlandırır.'),
  GrammarSentence(
      text: 'The technician replaces the filter to maintain clean air supply.',
      translation:
          'Teknisyen, temiz hava beslemesini korumak için filtreyi değiştirir.'),

  // Simplified English Patterns (10 sentences)
  GrammarSentence(
      text: 'Press the button to activate the emergency system.',
      translation: 'Acil durum sistemini etkinleştirmek için düğmeye basın.'),
  GrammarSentence(
      text: 'Open the valve to release pressure.',
      translation: 'Basıncı serbest bırakmak için vanayı açın.'),
  GrammarSentence(
      text: 'Check the fuel levels before starting the engine.',
      translation:
          'Motoru çalıştırmadan önce yakıt seviyelerini kontrol edin.'),
  GrammarSentence(
      text: 'Turn the knob to adjust the flow rate.',
      translation: 'Akış hızını ayarlamak için düğmeyi çevirin.'),
  GrammarSentence(
      text: 'Pull the lever to extend the landing gear.',
      translation: 'İniş takımını uzatmak için kolu çekin.'),
  GrammarSentence(
      text: 'Close the door to seal the cabin.',
      translation: 'Kabini mühürlemek için kapıyı kapatın.'),
  GrammarSentence(
      text: 'Switch off the power to prevent electrical damage.',
      translation: 'Elektrik hasarını önlemek için gücü kapatın.'),
  GrammarSentence(
      text: 'Read the manual to understand the procedure.',
      translation: 'Prosedürü anlamak için kılavuzu okuyun.'),
  GrammarSentence(
      text: 'Wear protective gear to ensure safety.',
      translation: 'Güvenliği sağlamak için koruyucu ekipman giyin.'),
  GrammarSentence(
      text: 'Follow the checklist to complete the inspection.',
      translation: 'İncelemeyi tamamlamak için kontrol listesini takip edin.'),

  // Basic Sentence Structure (50 sentences)
  GrammarSentence(
      text: 'The technician checks the oil level before flight.',
      translation: 'Teknisyen uçuştan önce yağ seviyesini kontrol eder.'),
  GrammarSentence(
      text: 'The system transmits signals to the cockpit for monitoring.',
      translation: 'Sistem izleme için kokpite sinyal iletir.'),
  GrammarSentence(
      text: 'The crew operates the control panel to adjust the cabin pressure.',
      translation:
          'Ekip kabin basıncını ayarlamak için kontrol panelini çalıştırır.'),
  GrammarSentence(
      text: 'The valve releases pressure through the safety system.',
      translation:
          'Valf güvenlik sistemi aracılığıyla basıncı serbest bırakır.'),
  GrammarSentence(
      text: 'The generator supplies power to the lighting system.',
      translation: 'Jeneratör aydınlatma sistemine güç sağlar.'),
  GrammarSentence(
      text: 'The sensor detects temperature fluctuations in the engine.',
      translation: 'Sensör motordaki sıcaklık dalgalanmalarını tespit eder.'),
  GrammarSentence(
      text: 'The operator activates the emergency shutdown procedure.',
      translation: 'Operatör acil kapatma prosedürünü etkinleştirir.'),
  GrammarSentence(
      text:
          'The air conditioning system regulates the temperature for comfort.',
      translation: 'Klima sistemi konfor için sıcaklığı düzenler.'),
  GrammarSentence(
      text: 'The sensor monitors fuel flow through the pipes.',
      translation: 'Sensör borulardan yakıt akışını izler.'),
  GrammarSentence(
      text: 'The controller adjusts the flight speed for optimal performance.',
      translation: 'Kontrolör optimal performans için uçuş hızını ayarlar.'),
  GrammarSentence(
      text: 'The alarm activates when the pressure exceeds the limit.',
      translation: 'Basınç limiti aştığında alarm devreye girer.'),
  GrammarSentence(
      text: 'The team inspects the engine before starting the flight.',
      translation: 'Ekip uçuşu başlatmadan önce motoru kontrol eder.'),
  GrammarSentence(
      text:
          'The cooling system maintains optimal temperature during operation.',
      translation:
          'Soğutma sistemi operasyon sırasında optimal sıcaklığı korur.'),
  GrammarSentence(
      text:
          'The circuit breaker shuts off power to the malfunctioning component.',
      translation: 'Devre kesici arızalı bileşene gücü keser.'),
  GrammarSentence(
      text:
          'The actuator moves the control surface for aerodynamic adjustments.',
      translation:
          'Aktüatör aerodinamik ayarlamalar için kontrol yüzeyini hareket ettirir.'),
  GrammarSentence(
      text: 'The compressor pressurizes the cabin to maintain altitude.',
      translation: 'Kompresör irtifayı korumak için kabini basınçlandırır.'),
  GrammarSentence(
      text:
          'The flight crew ensures all systems are operational before departure.',
      translation:
          'Uçuş ekibi kalkıştan önce tüm sistemlerin çalışır durumda olduğundan emin olur.'),
  GrammarSentence(
      text: 'The warning light blinks when a malfunction is detected.',
      translation: 'Bir arıza tespit edildiğinde uyarı ışığı yanıp söner.'),
  GrammarSentence(
      text: 'The filter removes impurities from the fuel system.',
      translation: 'Filtre yakıt sisteminden safsızlıkları çıkarır.'),
  GrammarSentence(
      text: 'The fan circulates air through the cooling system for efficiency.',
      translation: 'Fan verimlilik için soğutma sisteminden hava dolaştırır.'),
  GrammarSentence(
      text: 'The operator sets the power output to maximum during takeoff.',
      translation: 'Operatör kalkış sırasında güç çıkışını maksimuma ayarlar.'),
  GrammarSentence(
      text: 'The pressure gauge measures the cabin pressure during flight.',
      translation: 'Basınç göstergesi uçuş sırasında kabin basıncını ölçer.'),
  GrammarSentence(
      text: 'The technician performs an inspection of the aircraft systems.',
      translation: 'Teknisyen uçak sistemlerinin incelemesini yapar.'),
  GrammarSentence(
      text: 'The aircraft systems are tested before each flight.',
      translation: 'Uçak sistemleri her uçuştan önce test edilir.'),
  GrammarSentence(
      text: 'The safety check confirms all systems are functioning correctly.',
      translation:
          'Güvenlik kontrolü tüm sistemlerin doğru çalıştığını onaylar.'),
  GrammarSentence(
      text: 'The autopilot maintains the aircraft\'s course and altitude.',
      translation: 'Otopilot uçağın rotasını ve irtifasını korur.'),
  GrammarSentence(
      text: 'The hydraulic system powers the landing gear mechanism.',
      translation: 'Hidrolik sistem iniş takımı mekanizmasını çalıştırır.'),
  GrammarSentence(
      text: 'The engine ignites fuel in the combustion chamber for thrust.',
      translation: 'Motor itiş için yanma odasında yakıtı tutuşturur.'),
  GrammarSentence(
      text: 'The air filter traps contaminants before entering the engine.',
      translation: 'Hava filtresi motora girmeden önce kirleticileri yakalar.'),
  GrammarSentence(
      text: 'The pilot monitors the aircraft\'s speed throughout the flight.',
      translation: 'Pilot uçuş boyunca uçağın hızını izler.'),
  GrammarSentence(
      text: 'The pilot turns off the engine after landing.',
      translation: 'Pilot inişten sonra motoru kapatır.'),
  GrammarSentence(
      text: 'The gear lever activates the landing gear to deploy.',
      translation: 'Vites kolu iniş takımını açmak için devreye alır.'),
  GrammarSentence(
      text: 'The control panel displays data from the aircraft\'s sensors.',
      translation: 'Kontrol paneli uçağın sensörlerinden verileri gösterir.'),
  GrammarSentence(
      text:
          'The aircraft stabilizer controls the plane\'s movement during flight.',
      translation:
          'Uçak dengeleyicisi uçuş sırasında uçağın hareketini kontrol eder.'),
  GrammarSentence(
      text: 'The autopilot adjusts speed to match the flight plan.',
      translation: 'Otopilot uçuş planına uyacak şekilde hızı ayarlar.'),
  GrammarSentence(
      text: 'The pressure switch ensures the cabin pressure is balanced.',
      translation:
          'Basınç anahtarı kabin basıncının dengeli olduğundan emin olur.'),
  GrammarSentence(
      text: 'The lighting system illuminates the cabin for passenger comfort.',
      translation: 'Aydınlatma sistemi yolcu konforu için kabini aydınlatır.'),
  GrammarSentence(
      text: 'The brakes apply force to slow down the aircraft on landing.',
      translation: 'Frenler inişte uçağı yavaşlatmak için kuvvet uygular.'),
  GrammarSentence(
      text: 'The fuel valve controls the flow of fuel into the engine.',
      translation: 'Yakıt valfi motora yakıt akışını kontrol eder.'),
  GrammarSentence(
      text:
          'The radar system detects obstacles in the aircraft\'s flight path.',
      translation:
          'Radar sistemi uçağın uçuş yolundaki engelleri tespit eder.'),
  GrammarSentence(
      text:
          'The maintenance team inspects the aircraft for damage after each flight.',
      translation:
          'Bakım ekibi her uçuştan sonra uçağı hasar açısından kontrol eder.'),
  GrammarSentence(
      text:
          'The oxygen system provides breathing air to the crew during emergencies.',
      translation:
          'Oksijen sistemi acil durumlarda ekibe solunum havası sağlar.'),
  GrammarSentence(
      text:
          'The communication system enables contact with air traffic control.',
      translation:
          'İletişim sistemi hava trafik kontrolü ile bağlantıyı mümkün kılar.'),
  GrammarSentence(
      text: 'The flight management system calculates the optimal flight path.',
      translation: 'Uçuş yönetim sistemi optimal uçuş yolunu hesaplar.'),
  GrammarSentence(
      text: 'The GPS system tracks the aircraft\'s position during flight.',
      translation: 'GPS sistemi uçuş sırasında uçağın konumunu takip eder.'),
  GrammarSentence(
      text: 'The aircraft performs a routine check before every takeoff.',
      translation: 'Uçak her kalkıştan önce rutin kontrol yapar.'),
  GrammarSentence(
      text: 'The emergency exits are clearly marked for passenger safety.',
      translation:
          'Acil çıkışlar yolcu güvenliği için açıkça işaretlenmiştir.'),
  GrammarSentence(
      text: 'The engines provide thrust for the aircraft to take off.',
      translation: 'Motorlar uçağın kalkması için itiş sağlar.'),
  GrammarSentence(
      text:
          'The lighting system ensures visibility in the cabin during low light conditions.',
      translation:
          'Aydınlatma sistemi düşük ışık koşullarında kabinde görünürlüğü sağlar.'),
  GrammarSentence(
      text: 'The flight data recorder records flight parameters for analysis.',
      translation:
          'Uçuş veri kaydedici analiz için uçuş parametrelerini kaydeder.'),
];

// TOPIC F: WORD ENDINGS (Kelime Sonları)
final GrammarTopic topicFBasicStructureAndWordEndings = GrammarTopic(
  letter: 'F',
  title: 'Word Endings',
  titleKey: 'grammar_word_endings',
  description: 'Common word endings and suffixes in technical aviation English',
  icon: '🔠',
  sentences: _topicFSentences,
);

// TOPIC F SENTENCES (50 sentences)
final List<GrammarSentence> _topicFSentences = [
  GrammarSentence(
      text: 'The sensor detects the presence of smoke in the cabin.',
      translation: 'Sensör kabinde duman varlığını tespit eder.'),
  GrammarSentence(
      text:
          'The manipulator is used to move heavy components during maintenance.',
      translation:
          'Manipülatör bakım sırasında ağır bileşenleri taşımak için kullanılır.'),
  GrammarSentence(
      text: 'The generator produces power for the aircraft systems.',
      translation: 'Jeneratör uçak sistemleri için güç üretir.'),
  GrammarSentence(
      text: 'The compressor pressurizes air for the cabin.',
      translation: 'Kompresör kabin için havayı basınçlandırır.'),
  GrammarSentence(
      text: 'The operator monitors the flight control systems.',
      translation: 'Operatör uçuş kontrol sistemlerini izler.'),
  GrammarSentence(
      text:
          'The controller adjusts the aircraft\'s speed to match the flight plan.',
      translation:
          'Kontrolör uçuş planına uyacak şekilde uçağın hızını ayarlar.'),
  GrammarSentence(
      text:
          'The monitoring system tracks the engine\'s performance in real-time.',
      translation:
          'İzleme sistemi motorun performansını gerçek zamanlı olarak takip eder.'),
  GrammarSentence(
      text:
          'The cooling system regulates the temperature of the aircraft\'s engine.',
      translation: 'Soğutma sistemi uçak motorunun sıcaklığını düzenler.'),
  GrammarSentence(
      text: 'The lighting system provides illumination for the cabin.',
      translation: 'Aydınlatma sistemi kabin için aydınlatma sağlar.'),
  GrammarSentence(
      text: 'The aircraft is designed to withstand extreme weather conditions.',
      translation:
          'Uçak aşırı hava koşullarına dayanacak şekilde tasarlanmıştır.'),
  GrammarSentence(
      text: 'The actuator adjusts the control surfaces during flight.',
      translation: 'Aktüatör uçuş sırasında kontrol yüzeylerini ayarlar.'),
  GrammarSentence(
      text: 'The filter removes contaminants from the fuel system.',
      translation: 'Filtre yakıt sisteminden kirleticileri çıkarır.'),
  GrammarSentence(
      text: 'The valve regulates the flow of air into the cabin.',
      translation: 'Valf kabine hava akışını düzenler.'),
  GrammarSentence(
      text: 'The brake system slows down the aircraft during landing.',
      translation: 'Fren sistemi iniş sırasında uçağı yavaşlatır.'),
  GrammarSentence(
      text: 'The fan circulates air through the engine to maintain efficiency.',
      translation: 'Fan verimliliği korumak için motordan hava dolaştırır.'),
  GrammarSentence(
      text: 'The gauge measures the pressure in the hydraulic system.',
      translation: 'Gösterge hidrolik sistemdeki basıncı ölçer.'),
  GrammarSentence(
      text: 'The switch turns off the electrical power when necessary.',
      translation: 'Anahtar gerektiğinde elektrik gücünü kapatır.'),
  GrammarSentence(
      text:
          'The alarm alerts the crew of potential malfunctions in the system.',
      translation:
          'Alarm ekibi sistemdeki potansiyel arızalar hakkında uyarır.'),
  GrammarSentence(
      text: 'The clamp holds the fuel lines in place during maintenance.',
      translation: 'Kelepçe bakım sırasında yakıt hatlarını yerinde tutar.'),
  GrammarSentence(
      text: 'The circuit connects the power supply to the system.',
      translation: 'Devre güç kaynağını sisteme bağlar.'),
  GrammarSentence(
      text:
          'The bypass valve allows fluid to flow around the system when necessary.',
      translation:
          'Bypass valfi gerektiğinde sıvının sistemin etrafından akmasına izin verir.'),
  GrammarSentence(
      text: 'The panel displays important information for the crew.',
      translation: 'Panel ekip için önemli bilgileri gösterir.'),
  GrammarSentence(
      text: 'The pump circulates fluid through the hydraulic system.',
      translation: 'Pompa hidrolik sistemden sıvı dolaştırır.'),
  GrammarSentence(
      text: 'The engine provides the necessary thrust for flight.',
      translation: 'Motor uçuş için gerekli itişi sağlar.'),
  GrammarSentence(
      text: 'The system integrates several components to work together.',
      translation:
          'Sistem birlikte çalışması için birkaç bileşeni entegre eder.'),
  GrammarSentence(
      text: 'The pressure switch monitors the pressure in the fuel system.',
      translation: 'Basınç anahtarı yakıt sistemindeki basıncı izler.'),
  GrammarSentence(
      text: 'The monitor checks the status of the aircraft\'s fuel levels.',
      translation: 'Monitör uçağın yakıt seviyelerinin durumunu kontrol eder.'),
  GrammarSentence(
      text: 'The indicator shows the fuel quantity on the control panel.',
      translation: 'Gösterge kontrol panelinde yakıt miktarını gösterir.'),
  GrammarSentence(
      text: 'The mixer blends air and fuel in the combustion chamber.',
      translation: 'Karıştırıcı yanma odasında hava ve yakıtı karıştırır.'),
  GrammarSentence(
      text: 'The detect function identifies any irregularities in the system.',
      translation:
          'Tespit fonksiyonu sistemdeki herhangi bir düzensizliği tanımlar.'),
  GrammarSentence(
      text: 'The circuitry provides power to the control systems.',
      translation: 'Devre sistemi kontrol sistemlerine güç sağlar.'),
  GrammarSentence(
      text: 'The repair manual explains the procedures for fixing the engine.',
      translation: 'Onarım kılavuzu motoru tamir etme prosedürlerini açıklar.'),
  GrammarSentence(
      text: 'The igniter sparks the fuel in the engine to begin combustion.',
      translation:
          'Ateşleyici yanmayı başlatmak için motordaki yakıtı tutuşturur.'),
  GrammarSentence(
      text: 'The activator turns on the electrical systems during startup.',
      translation: 'Etkinleştirici başlangıçta elektrik sistemlerini açar.'),
  GrammarSentence(
      text: 'The handler moves the aircraft into position for takeoff.',
      translation: 'İşleyici uçağı kalkış için pozisyona götürür.'),
  GrammarSentence(
      text: 'The detecting system identifies objects in the flight path.',
      translation: 'Tespit sistemi uçuş yolundaki nesneleri tanımlar.'),
  GrammarSentence(
      text: 'The pumping system circulates fluid through the cooling system.',
      translation: 'Pompalama sistemi soğutma sisteminden sıvı dolaştırır.'),
  GrammarSentence(
      text: 'The reducer adjusts the fuel flow to match the engine\'s needs.',
      translation:
          'Redüktör motorun ihtiyaçlarına uyacak şekilde yakıt akışını ayarlar.'),
  GrammarSentence(
      text: 'The insulator prevents heat loss in the aircraft\'s systems.',
      translation: 'İzolatör uçağın sistemlerinde ısı kaybını önler.'),
  GrammarSentence(
      text: 'The inspected components are cleared for flight.',
      translation: 'İncelenen bileşenler uçuş için onaylanmıştır.'),
  GrammarSentence(
      text: 'The tested equipment is checked for any signs of malfunction.',
      translation:
          'Test edilen ekipman herhangi bir arıza belirtisi açısından kontrol edilir.'),
  GrammarSentence(
      text: 'The decelerated aircraft came to a full stop after landing.',
      translation: 'Yavaşlatılan uçak inişten sonra tamamen durdu.'),
  GrammarSentence(
      text: 'The secured components are ready for use in the aircraft.',
      translation:
          'Güvenli hale getirilen bileşenler uçakta kullanıma hazırdır.'),
  GrammarSentence(
      text: 'The prepared materials are arranged for quick assembly.',
      translation: 'Hazırlanan malzemeler hızlı montaj için düzenlenmiştir.'),
  GrammarSentence(
      text: 'The connected systems work in harmony to control the flight.',
      translation:
          'Bağlı sistemler uçuşu kontrol etmek için uyum içinde çalışır.'),
  GrammarSentence(
      text:
          'The sensing technology monitors the aircraft\'s altitude and speed.',
      translation: 'Algılama teknolojisi uçağın irtifasını ve hızını izler.'),
  GrammarSentence(
      text: 'The processed data is sent to the flight management system.',
      translation: 'İşlenen veriler uçuş yönetim sistemine gönderilir.'),
  GrammarSentence(
      text: 'The powered equipment provides necessary energy during operation.',
      translation:
          'Güçlendirilmiş ekipman operasyon sırasında gerekli enerjiyi sağlar.'),
  GrammarSentence(
      text: 'The serviced aircraft is ready for the next flight.',
      translation: 'Bakımı yapılan uçak bir sonraki uçuş için hazırdır.'),
  GrammarSentence(
      text:
          'The observed performance indicates that the engine is functioning correctly.',
      translation:
          'Gözlemlenen performans motorun doğru çalıştığını gösterir.'),
];
