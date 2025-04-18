import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../../core/storage/secure_storage_helper.dart';
import '../../routes/app_routes.dart'; // Ensure this exists

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/intro/intro.mp4');

    try {
      await _videoController.initialize();
      _videoController.setLooping(false); // No looping
      _videoController.setVolume(1.0); // Ensure sound is enabled
      _videoController.play();


      // Listen for when the video completes
      _videoController.addListener(() {
        if (_videoController.value.position >=
            _videoController.value.duration) {
          _checkAuthToken();
        }
      });

      setState(() {}); // Refresh UI when video is ready
    } catch (e) {
      debugPrint("Video Initialization Error: $e");
    }
  }

  Future<void> _checkAuthToken() async {
    String? splash = await SecureStorageHelper().getData("splash");
    String? token = await SecureStorageHelper().getData("auth_token");

    if (splash != null && splash.isNotEmpty) {
      if (token != null && token.isNotEmpty) {
        Get.offAllNamed(AppRoutes.landingScreen);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.fullScreenImageScreen);
    }
  }

  void _onVideoEnd() {
    Get.toNamed(
      AppRoutes.fullScreenImageScreen,
    ); // Navigate to home screen
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
