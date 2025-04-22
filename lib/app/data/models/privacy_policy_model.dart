import '../../domain/entities/privacy_policy_entity.dart';

class PrivacyPolicyModel extends PrivacyPolicyEntity {
  const PrivacyPolicyModel({
    required super.content,
    required super.contentType,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      content: json['content'] ?? '',
      contentType: json['content_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'content_type': contentType,
    };
  }
}
