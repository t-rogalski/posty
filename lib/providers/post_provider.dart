import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posty/models/post.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get('https://jsonplaceholder.typicode.com/posts');
  final List data = response.data;
  return data.map((json) => Post.fromJson(json)).toList();
});

final postByIdProvider = Provider.family<Post?, int>((ref, id) {
  final posts = ref
      .watch(postsProvider)
      .maybeWhen(data: (posts) => posts, orElse: () => null);
  if (posts == null) return null;
  try {
    return posts.firstWhere((post) => post.id == id);
  } catch (_) {
    return null;
  }
});
