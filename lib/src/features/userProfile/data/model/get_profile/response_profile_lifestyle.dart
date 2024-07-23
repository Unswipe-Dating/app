


part of 'response_profile_swipe.dart';



@JsonSerializable()
class ResponseProfileLifeStyle {
  ResponseProfileLifeStyle(
      this.drink,
      this.smoke,
      this.exercise,
      this.cook,
      this.householdChores,
      );

  factory ResponseProfileLifeStyle.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileLifeStyleFromJson(json);

  String? drink;
  String? smoke;
  String? exercise;
  String? cook;
  String? householdChores;



  Map<String, dynamic> toJson() => _$ResponseProfileLifeStyleToJson(this);
}
