import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:volt_ai_q/data/providers/auth_provider.dart';
import 'package:volt_ai_q/ui/widgets/energy_background.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final _nameController = TextEditingController();
  String _discom = 'UPPCL';
  String _accountType = 'Postpaid';
  
  final List<String> _discoms = ['UPPCL', 'BSES', 'MSEDCL', 'TPPDL', 'TATA POWER'];
  final List<String> _accountTypes = ['Prepaid', 'Postpaid'];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    ref.read(authProvider.notifier).completeOnboarding();
    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnergyBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: List.generate(3, (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: index <= _currentStep ? Colors.cyan : Colors.white10,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  )),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentStep = i),
                  children: [
                    _buildStep1(),
                    _buildStep2(),
                    _buildStep3(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                        child: const Text('BACK', style: TextStyle(color: Colors.white54)),
                      )
                    else
                      const SizedBox.shrink(),
                    ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(_currentStep == 2 ? 'GET STARTED' : 'CONTINUE', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personalize Your\nExperience', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          const Text('Let\'s set up your profile to optimize your energy consumption accurately.', style: TextStyle(color: Colors.white54, fontSize: 16)),
          const SizedBox(height: 48),
          _buildTextField('Full Name', _nameController, Icons.person_outline),
          const SizedBox(height: 24),
          _buildDropdown('Utility Provider (DISCOM)', _discom, _discoms, (v) => setState(() => _discom = v!)),
          const SizedBox(height: 24),
          _buildDropdown('Account Type', _accountType, _accountTypes, (v) => setState(() => _accountType = v!)),
        ],
      ).animate().fadeIn().slideX(begin: 0.1),
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Connect Your\nSmart Meter', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          const Text('Enter your meter number or scan your latest bill for instant connection.', style: TextStyle(color: Colors.white54, fontSize: 16)),
          const SizedBox(height: 48),
          _buildTextField('Meter Number', TextEditingController(), Icons.speed_outlined),
          const SizedBox(height: 32),
          const Center(child: Text('OR', style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 32),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.cyan.withOpacity(0.2), width: 2, style: BorderStyle.solid),
              ),
              child: const Column(
                children: [
                  Icon(Icons.camera_enhance_outlined, size: 48, color: Colors.cyan),
                  SizedBox(height: 16),
                  Text('Scan Utility Bill', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
                  Text('AI will extract all details automatically', style: TextStyle(color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ).animate().fadeIn().slideX(begin: 0.1),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Optimize Your\nAppliances', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          const Text('Tell us about your high-load devices so VoltIQ can schedule them during low-tariff hours.', style: TextStyle(color: Colors.white54, fontSize: 16)),
          const SizedBox(height: 40),
          _buildApplianceTile('Air Conditioner', 'Primary cooling unit', Icons.ac_unit, true),
          _buildApplianceTile('Geyser / Water Heater', 'Morning hot water', Icons.hot_tub, true),
          _buildApplianceTile('Washing Machine', 'Heavy laundry loads', Icons.local_laundry_service, true),
          _buildApplianceTile('Electric Vehicle', 'Daily charging', Icons.ev_station, false),
        ],
      ).animate().fadeIn().slideX(begin: 0.1),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.cyan),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.cyan, width: 1)),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF1B1F2C),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApplianceTile(String title, String subtitle, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.cyan.withOpacity(0.1) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.cyan.withOpacity(0.3) : Colors.white10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, color: isSelected ? Colors.cyan : Colors.white38),
        title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        trailing: Checkbox(
          value: isSelected,
          activeColor: Colors.cyan,
          checkColor: Colors.black,
          onChanged: (v) {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
