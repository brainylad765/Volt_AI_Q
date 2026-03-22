import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final double end;
  final Duration duration;
  final String prefix;
  final String suffix;
  final int decimals;
  final TextStyle? style;

  const AnimatedCounter({
    super.key,
    required this.end,
    this.duration = const Duration(seconds: 2),
    this.prefix = '',
    this.suffix = '',
    this.decimals = 0,
    this.style,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.end).animate(_controller);
    _animation.addListener(() {
      setState(() {
        _currentValue = _animation.value;
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String display;
    if (widget.decimals > 0) {
      display = _currentValue.toStringAsFixed(widget.decimals);
    } else {
      display = _currentValue.round().toString();
    }
    return Text(
      '${widget.prefix}$display${widget.suffix}',
      style: widget.style,
    );
  }
}