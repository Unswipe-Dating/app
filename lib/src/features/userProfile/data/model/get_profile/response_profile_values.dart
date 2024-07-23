


part of 'response_profile_swipe.dart';



@JsonSerializable()
class ResponseProfileValues {
  ResponseProfileValues(
      this.religion,
      this.politicalViews,
      this.loveLanguage,
      this.children,
      this.coreValues
      );

  factory ResponseProfileValues.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileValuesFromJson(json);

  String? religion;
  String? politicalViews;
  String? loveLanguage;
  String? children;
  List<String>? coreValues;



  Map<String, dynamic> toJson() => _$ResponseProfileValuesToJson(this);
}
