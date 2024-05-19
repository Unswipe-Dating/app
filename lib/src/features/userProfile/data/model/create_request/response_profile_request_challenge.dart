

part of 'response_profile_request.dart';


@JsonSerializable()
class ResponseProfileRequestChallenge {
  ResponseProfileRequestChallenge(this.weeklyDates, this.amountUSD);

  factory ResponseProfileRequestChallenge.fromJson(Map<String, dynamic> json) =>
      _$ResponseProfileRequestChallengeFromJson(json);

  int weeklyDates;
  int amountUSD;


  Map<String, dynamic> toJson() => _$ResponseProfileRequestChallengeToJson(this);
}
