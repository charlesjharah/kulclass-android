import 'package:flutter/material.dart';
import 'package:flutter_svga/flutter_svga.dart';

class SVGAImageWrapper extends StatefulWidget {
  final String resUrl;
  final bool loop;

  const SVGAImageWrapper({
    Key? key,
    required this.resUrl,
    this.loop = true,
  }) : super(key: key);

  @override
  State<SVGAImageWrapper> createState() => _SVGAImageWrapperState();
}

class _SVGAImageWrapperState extends State<SVGAImageWrapper>
    with SingleTickerProviderStateMixin {
  SVGAAnimationController? _controller;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  Future<void> _initController() async {
    final controller = SVGAAnimationController(vsync: this);
    final parser = SVGAParser();
    try {
      final videoItem = await parser.decodeFromURL(widget.resUrl);

      if (!mounted) return; // ✅ don’t touch state if disposed

      controller.videoItem = videoItem;

      if (widget.loop) {
        controller.repeat();
      } else {
        controller.forward();
      }

      setState(() {
        _controller = controller;
        _isLoaded = true;
      });
    } catch (e) {
      debugPrint("❌ Failed to load SVGA: $e");
      controller.dispose(); // cleanup on error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _controller == null) {
      return const SizedBox();
    }
    return SVGAImage(_controller!);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }
}
