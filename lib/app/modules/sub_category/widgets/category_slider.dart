import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plus/app/core/widgets/cached_image.dart';

class AutoScrollImageRow extends StatefulWidget {
  const AutoScrollImageRow({super.key, required this.image});

  final String image;
  @override
  State<AutoScrollImageRow> createState() => _AutoScrollImageRowState();
}

class _AutoScrollImageRowState extends State<AutoScrollImageRow> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_scrollController.hasClients) {
        _scrollPosition += 2; // Adjust scroll speed
        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            _scrollPosition,
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 20, // Repeat image 20 times (for seamless scroll)
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedImage(imageUrl: widget.image),
            ),
          );
        },
      ),
    );
  }
}
