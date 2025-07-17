import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posty/providers/post_provider.dart';
import 'package:posty/utils/HeadingText.dart';
import 'package:go_router/go_router.dart';

class PostDetailScreen extends ConsumerWidget {
  final int postId;
  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPost = ref.watch(postByIdProvider(postId));
    final tileColor = ref.watch(selectedTileColorProvider);

    // Jeżeli post o danym ID nie istnieje, wyświetl komunikat
    if (selectedPost == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Post $postId'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
          backgroundColor: Colors.blue[300],
        ),
        body: const Center(child: Text('Post not found')),
      );
    }

    return Scaffold(
      backgroundColor: tileColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Post $postId'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Title
                        HeadingText(text: 'Title:'),
                        Text(
                          selectedPost.title,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        //Body
                        HeadingText(text: 'Body:'),
                        Text(
                          selectedPost.body,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 64),
                        //User ID
                        Text(
                          'User ID: ${selectedPost.userId}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
