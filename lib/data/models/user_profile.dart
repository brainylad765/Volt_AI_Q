class UserProfile {
  final String id;
  final String name;
  final String phone;
  final String discom;
  final String accountType; // Prepaid/Postpaid
  final bool isOnboardingComplete;

  UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.discom,
    required this.accountType,
    required this.isOnboardingComplete,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? phone,
    String? discom,
    String? accountType,
    bool? isOnboardingComplete,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      discom: discom ?? this.discom,
      accountType: accountType ?? this.accountType,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
    );
  }
}
