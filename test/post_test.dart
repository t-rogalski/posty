import 'package:flutter_test/flutter_test.dart';
import 'package:posty/models/post.dart';

void main() {
  group('Post Model', () {
    test('fromJson should create a Post from JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Title',
        'body': 'Test Body',
        'userId': 1,
      };

      final post = Post.fromJson(json);

      expect(post.id, 1);
      expect(post.title, 'Test Title');
      expect(post.body, 'Test Body');
      expect(post.userId, 1);
    });
  });
}
