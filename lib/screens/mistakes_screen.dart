import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class MistakesScreen extends StatelessWidget {
  const MistakesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final mistakes = provider.mistakes;

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.getString('mistakes_title')),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: mistakes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🎉', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  Text(provider.getString('no_mistakes'), 
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(provider.getString('continue_lessons'), style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            )
          : Column(
              children: [
                // Üst bilgi
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.red.withValues(alpha: 0.1),
                  child: Column(
                    children: [
                      Text('${mistakes.length} ${provider.getString('mistakes_count')}', 
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                      const SizedBox(height: 8),
                      Text(provider.getString('check_mistakes'),
                        style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                // Hata listesi
                Expanded(
                  child: ListView.builder(
                    itemCount: mistakes.length,
                    itemBuilder: (context, index) {
                      final mistake = mistakes[index];
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Text('❌', style: TextStyle(fontSize: 20)),
                          ),
                          title: Text(mistake['question'] ?? '', 
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${provider.getString('your_answer')}: ${mistake['yourAnswer']}', 
                                style: const TextStyle(color: Colors.red)),
                              Text('${provider.getString('correct_answer')}: ${mistake['correctAnswer']}', 
                                style: const TextStyle(color: Colors.green)),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.grey),
                            onPressed: () => provider.removeMistake(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Temizle butonu
                if (mistakes.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton.icon(
                      onPressed: () => provider.clearMistakes(),
                      icon: const Icon(Icons.delete_sweep),
                      label: Text(provider.getString('clear_all')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
