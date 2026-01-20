import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:auralive/utils/utils.dart';

class CustomThumbnail {
  static Future<String?> onGet(String videoPath) async {
    try {
      final videoThumbnail = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        timeMs: -1,
        maxHeight: 400,
        quality: 100,
      );
      return videoThumbnail.path;
    } catch (e) {
      Utils.showLog("Get Thumbnail Error => $e");
    }
    return null;
  }
}
