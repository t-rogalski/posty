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
        title: const Text('Posts', style: TextStyle(fontSize: 32)),
        backgroundColor: Colors.blue[300],
      ),
      body: postsState.when(
        data: (posts) => ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              tileColor: index.isEven ? Colors.blue[50] : Colors.white,
              leading: Text(post.id.toString(), style: TextStyle(fontSize: 20)),
              trailing: const Icon(Icons.arrow_forward),
              title: Text(post.title, style: TextStyle(fontSize: 20)),
              onTap: () => {
                ref.read(selectedTileColorProvider.notifier).state =
                    index.isEven ? Colors.blue[50] : Colors.white,
                context.go('/post/${post.id}'),
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
