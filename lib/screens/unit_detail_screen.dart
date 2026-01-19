import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/vocabulary_models.dart';
import 'lesson_screen.dart';

class UnitDetailScreen extends StatefulWidget {
  final String unitName;
  final String sectionName;
  final List<MapEntry<String, CategoryData>> lessons;

  const UnitDetailScreen({
    super.key,
    required this.unitName,
    required this.sectionName,
    required this.lessons,
  });

  @override
  State<UnitDetailScreen> createState() => _UnitDetailScreenState();
}

class _UnitDetailScreenState extends State<UnitDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unitName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              provider.themeMode == ThemeMode.dark
                  ? 'assets/images/space_bg.webp'
                  : 'assets/images/palm_beach_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.3)),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Unit header info
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF58CC02).withValues(alpha: 0.8),
                          const Color(0xFF4CAF50).withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF58CC02).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.sectionName,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.unitName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.lessons.length} lessons',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Lessons path
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: widget.lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = widget.lessons[index];
                      final lessonKey = lesson.key;
                      final lessonData = lesson.value;
                      
                      final isCompleted =
                          provider.completedLessons.contains(lessonKey);
                      final isLocked = index > 0 &&
                          !provider.completedLessons.contains(
                              widget.lessons[index - 1].key);

                      return _buildLessonNode(
                        context,
                        lessonData,
                        isCompleted,
                        isLocked,
                        index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonNode(
    BuildContext context,
    CategoryData category,
    bool isCompleted,
    bool isLocked,
    int index,
  ) {
    const nodeSize = 80.0;
    const iconSize = 32.0;

    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
      Colors.pink,
    ];

    final nodeColor = isLocked
        ? Colors.grey.withValues(alpha: 0.3)
        : (isCompleted ? Colors.green : colors[index % colors.length]);

    // Zigzag pattern
    final bool isLeftAligned = index % 2 != 0;

    return GestureDetector(
      onTap: isLocked
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonScreen(category: category),
                ),
              );
            },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisAlignment: isLeftAligned
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                  width: nodeSize,
                  height: nodeSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: nodeColor,
                    boxShadow: isLocked
                        ? []
                        : [
                            BoxShadow(
                              color: nodeColor.withValues(alpha: 0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            )
                          ],
                  ),
                  child: Center(
                    child: Text(
                      isLocked ? '🔒' : (isCompleted ? '✅' : category.icon),
                      style: TextStyle(fontSize: iconSize),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Category Title
                SizedBox(
                  width: 120,
                  child: Text(
                    category.title,
                    style: TextStyle(
                      color: isLocked ? Colors.grey : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
