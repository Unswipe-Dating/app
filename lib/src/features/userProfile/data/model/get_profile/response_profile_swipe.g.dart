// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_profile_swipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProfileSwipe _$ResponseProfileSwipeFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileSwipe(
      json['browseProfiles'] == null
          ? null
          : ResponseProfileSwipeBrowse.fromJson(
              json['browseProfiles'] as Map<String, dynamic>),
      (json['getRequestedProfilesForUser'] as List<dynamic>?)
          ?.map((e) => ResponseProfileList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['userProfile'] == null
          ? null
          : ResponseProfileList.fromJson(
              json['userProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseProfileSwipeToJson(
        ResponseProfileSwipe instance) =>
    <String, dynamic>{
      'browseProfiles': instance.browseProfiles,
      'getRequestedProfilesForUser': instance.getRequestedProfilesForUser,
      'userProfile': instance.userProfile,
    };

ResponseProfileSwipeBrowse _$ResponseProfileSwipeBrowseFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileSwipeBrowse(
      (json['profiles'] as List<dynamic>)
          .map((e) => ResponseProfileList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hasNext'] as bool?,
      (json['nextCursor'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ResponseProfileSwipeBrowseToJson(
        ResponseProfileSwipeBrowse instance) =>
    <String, dynamic>{
      'profiles': instance.profiles,
      'hasNext': instance.hasNext,
      'nextCursor': instance.nextCursor,
    };

ResponseProfileList _$ResponseProfileListFromJson(Map<String, dynamic> json) =>
    ResponseProfileList(
      json['id'] as String,
      json['userId'] as String,
      json['name'] as String,
      ResponseProfileSwipeInterests.fromJson(
          json['interests'] as Map<String, dynamic>),
      (json['photoURLs'] as List<dynamic>).map((e) => e as String).toList(),
      json['location'] as String?,
      json['dob'] as String?,
      json['datingPreference'] as String?,
      json['height'] as String?,
      json['hometown'] as String?,
      json['zodiac'] as String?,
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['request'] == null
          ? null
          : ResponseProfileRequestBody.fromJson(
              json['request'] as Map<String, dynamic>),
      json['pronouns'] as String?,
      json['gender'] as String?,
      (json['locationCoordinates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['showTruncatedName'] as bool?,
      json['showPronoun'] as bool?,
      json['showDatingPreference'] as bool?,
      json['showGender'] as bool?,
      json['work'] == null
          ? null
          : ResponseProfileWork.fromJson(json['work'] as Map<String, dynamic>),
      json['lifeStyle'] == null
          ? null
          : ResponseProfileLifeStyle.fromJson(
              json['lifeStyle'] as Map<String, dynamic>),
      json['values'] == null
          ? null
          : ResponseProfileValues.fromJson(
              json['values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseProfileListToJson(
        ResponseProfileList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'interests': instance.interests,
      'photoURLs': instance.photoURLs,
      'location': instance.location,
      'dob': instance.dob,
      'datingPreference': instance.datingPreference,
      'height': instance.height,
      'hometown': instance.hometown,
      'zodiac': instance.zodiac,
      'pronouns': instance.pronouns,
      'gender': instance.gender,
      'locationCoordinates': instance.locationCoordinates,
      'showTruncatedName': instance.showTruncatedName,
      'showPronoun': instance.showPronoun,
      'showDatingPreference': instance.showDatingPreference,
      'showGender': instance.showGender,
      'languages': instance.languages,
      'work': instance.work,
      'values': instance.values,
      'lifeStyle': instance.lifeStyle,
      'request': instance.request,
    };

ResponseProfileWork _$ResponseProfileWorkFromJson(Map<String, dynamic> json) =>
    ResponseProfileWork(
      json['jobTitle'] as String?,
      json['companyName'] as String?,
      json['educationLevel'] as String?,
      json['institution'] as String?,
      json['isVerified'] as bool?,
    );

Map<String, dynamic> _$ResponseProfileWorkToJson(
        ResponseProfileWork instance) =>
    <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'companyName': instance.companyName,
      'educationLevel': instance.educationLevel,
      'institution': instance.institution,
      'isVerified': instance.isVerified,
    };

ResponseProfileLifeStyle _$ResponseProfileLifeStyleFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileLifeStyle(
      json['drink'] as String?,
      json['smoke'] as String?,
      json['exercise'] as String?,
      json['cook'] as String?,
      json['householdChores'] as String?,
    );

Map<String, dynamic> _$ResponseProfileLifeStyleToJson(
        ResponseProfileLifeStyle instance) =>
    <String, dynamic>{
      'drink': instance.drink,
      'smoke': instance.smoke,
      'exercise': instance.exercise,
      'cook': instance.cook,
      'householdChores': instance.householdChores,
    };

ResponseProfileValues _$ResponseProfileValuesFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileValues(
      json['religion'] as String?,
      json['politicalViews'] as String?,
      json['loveLanguage'] as String?,
      json['children'] as String?,
      (json['coreValues'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResponseProfileValuesToJson(
        ResponseProfileValues instance) =>
    <String, dynamic>{
      'religion': instance.religion,
      'politicalViews': instance.politicalViews,
      'loveLanguage': instance.loveLanguage,
      'children': instance.children,
      'coreValues': instance.coreValues,
    };

ResponseProfileSwipeInterests _$ResponseProfileSwipeInterestsFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileSwipeInterests(
      (json['weekendActivities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['pets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['selfCare'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['fnd'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['sports'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResponseProfileSwipeInterestsToJson(
        ResponseProfileSwipeInterests instance) =>
    <String, dynamic>{
      'weekendActivities': instance.weekendActivities,
      'pets': instance.pets,
      'selfCare': instance.selfCare,
      'fnd': instance.fnd,
      'sports': instance.sports,
    };

ResponseProfileRequestBody _$ResponseProfileRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ResponseProfileRequestBody(
      json['id'] as String,
    );

Map<String, dynamic> _$ResponseProfileRequestBodyToJson(
        ResponseProfileRequestBody instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
