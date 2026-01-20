class PreviewShortsVideoModel {
  final String name;
  final String userId;
  final String userName;
  final String userImage;

  final String videoId;
  final String videoUrl;
  final String videoImage;
  final String caption;
  final List hashTag;
  final bool isLike;
  final bool isBanned;
  final bool isProfileImageBanned;
  final int likes;
  final int comments;
  final String songId;

  PreviewShortsVideoModel({
    required this.name,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.videoId,
    required this.videoUrl,
    required this.videoImage,
    required this.caption,
    required this.hashTag,
    required this.isLike,
    required this.isBanned,
    required this.isProfileImageBanned,
    required this.likes,
    required this.comments,
    required this.songId,
  });
}
