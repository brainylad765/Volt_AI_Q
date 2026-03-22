import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/problem_section.dart';
import 'widgets/solution_section.dart';
import 'widgets/numbers_section.dart';
import 'widgets/live_demo_section.dart';
import 'widgets/cta_section.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Column(
              children: [
                HeroSection(),
                ProblemSection(),
                SolutionSection(),
                NumbersSection(),
                LiveDemoSection(),
                CTASection(),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }
}