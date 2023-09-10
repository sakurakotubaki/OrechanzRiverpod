import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs

@freezed
class Post with _$Post {
  const factory Post({
    String? id,// データを指定するidを作成。FirestoreのデータはdocumentIDで特定する。
    @Default('') String body,// 投稿データのフィールド
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);
}
