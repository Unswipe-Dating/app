


part of 'response_profile_swipe.dart';



@JsonSerializable()
class ResponseProfileWork {
  ResponseProfileWork(
      this.jobTitle,
      this.companyName,
      this.educationLevel,
      this.institution,
      this.isVerified
      );

  factory ResponseProfileWork.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileWorkFromJson(json);

  String? jobTitle;
  String? companyName;
  String? educationLevel;
  String? institution;
  bool? isVerified;



  Map<String, dynamic> toJson() => _$ResponseProfileWorkToJson(this);
}
