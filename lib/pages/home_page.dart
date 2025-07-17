import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:posty/providers/post_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Posts', style: TextStyle(fontSize: 32)),
        backgroundColor: Colors.blue[300],
      ),
      body: postsState.when(
        data: (posts) => ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                tileColor: index.isEven ? Colors.blue[50] : Colors.white,
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[200],
                  child: Text(
                    post.id.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                title: Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  ref.read(selectedTileColorProvider.notifier).state =
                      index.isEven ? Colors.blue[50] : Colors.white;
                  context.go('/post/${post.id}');
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
