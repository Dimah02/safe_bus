import 'accessibility_options.dart';
import 'address_component.dart';
import 'address_descriptor.dart';
import 'current_opening_hours.dart';
import 'display_name.dart';
import 'editorial_summary.dart';
import 'google_maps_links.dart';
import 'location.dart';
import 'photo.dart';
import 'plus_code.dart';
import 'primary_type_display_name.dart';
import 'regular_opening_hours.dart';
import 'review.dart';
import 'time_zone.dart';
import 'viewport.dart';

class PlaceDetailsModel {
  String? name;
  String? id;
  List<String>? types;
  String? nationalPhoneNumber;
  String? internationalPhoneNumber;
  String? formattedAddress;
  List<AddressComponent>? addressComponents;
  PlusCode? plusCode;
  Location? location;
  Viewport? viewport;
  double? rating;
  String? googleMapsUri;
  String? websiteUri;
  RegularOpeningHours? regularOpeningHours;
  int? utcOffsetMinutes;
  String? adrFormatAddress;
  String? businessStatus;
  int? userRatingCount;
  String? iconMaskBaseUri;
  String? iconBackgroundColor;
  DisplayName? displayName;
  PrimaryTypeDisplayName? primaryTypeDisplayName;
  CurrentOpeningHours? currentOpeningHours;
  String? primaryType;
  String? shortFormattedAddress;
  EditorialSummary? editorialSummary;
  List<Review>? reviews;
  List<Photo>? photos;
  AccessibilityOptions? accessibilityOptions;
  bool? pureServiceAreaBusiness;
  AddressDescriptor? addressDescriptor;
  GoogleMapsLinks? googleMapsLinks;
  TimeZone? timeZone;

  PlaceDetailsModel({
    this.name,
    this.id,
    this.types,
    this.nationalPhoneNumber,
    this.internationalPhoneNumber,
    this.formattedAddress,
    this.addressComponents,
    this.plusCode,
    this.location,
    this.viewport,
    this.rating,
    this.googleMapsUri,
    this.websiteUri,
    this.regularOpeningHours,
    this.utcOffsetMinutes,
    this.adrFormatAddress,
    this.businessStatus,
    this.userRatingCount,
    this.iconMaskBaseUri,
    this.iconBackgroundColor,
    this.displayName,
    this.primaryTypeDisplayName,
    this.currentOpeningHours,
    this.primaryType,
    this.shortFormattedAddress,
    this.editorialSummary,
    this.reviews,
    this.photos,
    this.accessibilityOptions,
    this.pureServiceAreaBusiness,
    this.addressDescriptor,
    this.googleMapsLinks,
    this.timeZone,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
      name: json['name'] as String?,
      id: json['id'] as String?,
      types: json['types'] as List<String>?,
      nationalPhoneNumber: json['nationalPhoneNumber'] as String?,
      internationalPhoneNumber: json['internationalPhoneNumber'] as String?,
      formattedAddress: json['formattedAddress'] as String?,
      addressComponents:
          (json['addressComponents'] as List<dynamic>?)
              ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
              .toList(),
      plusCode:
          json['plusCode'] == null
              ? null
              : PlusCode.fromJson(json['plusCode'] as Map<String, dynamic>),
      location:
          json['location'] == null
              ? null
              : Location.fromJson(json['location'] as Map<String, dynamic>),
      viewport:
          json['viewport'] == null
              ? null
              : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toDouble(),
      googleMapsUri: json['googleMapsUri'] as String?,
      websiteUri: json['websiteUri'] as String?,
      regularOpeningHours:
          json['regularOpeningHours'] == null
              ? null
              : RegularOpeningHours.fromJson(
                json['regularOpeningHours'] as Map<String, dynamic>,
              ),
      utcOffsetMinutes: json['utcOffsetMinutes'] as int?,
      adrFormatAddress: json['adrFormatAddress'] as String?,
      businessStatus: json['businessStatus'] as String?,
      userRatingCount: json['userRatingCount'] as int?,
      iconMaskBaseUri: json['iconMaskBaseUri'] as String?,
      iconBackgroundColor: json['iconBackgroundColor'] as String?,
      displayName:
          json['displayName'] == null
              ? null
              : DisplayName.fromJson(
                json['displayName'] as Map<String, dynamic>,
              ),
      primaryTypeDisplayName:
          json['primaryTypeDisplayName'] == null
              ? null
              : PrimaryTypeDisplayName.fromJson(
                json['primaryTypeDisplayName'] as Map<String, dynamic>,
              ),
      currentOpeningHours:
          json['currentOpeningHours'] == null
              ? null
              : CurrentOpeningHours.fromJson(
                json['currentOpeningHours'] as Map<String, dynamic>,
              ),
      primaryType: json['primaryType'] as String?,
      shortFormattedAddress: json['shortFormattedAddress'] as String?,
      editorialSummary:
          json['editorialSummary'] == null
              ? null
              : EditorialSummary.fromJson(
                json['editorialSummary'] as Map<String, dynamic>,
              ),
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList(),
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList(),
      accessibilityOptions:
          json['accessibilityOptions'] == null
              ? null
              : AccessibilityOptions.fromJson(
                json['accessibilityOptions'] as Map<String, dynamic>,
              ),
      pureServiceAreaBusiness: json['pureServiceAreaBusiness'] as bool?,
      addressDescriptor:
          json['addressDescriptor'] == null
              ? null
              : AddressDescriptor.fromJson(
                json['addressDescriptor'] as Map<String, dynamic>,
              ),
      googleMapsLinks:
          json['googleMapsLinks'] == null
              ? null
              : GoogleMapsLinks.fromJson(
                json['googleMapsLinks'] as Map<String, dynamic>,
              ),
      timeZone:
          json['timeZone'] == null
              ? null
              : TimeZone.fromJson(json['timeZone'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'types': types,
      'nationalPhoneNumber': nationalPhoneNumber,
      'internationalPhoneNumber': internationalPhoneNumber,
      'formattedAddress': formattedAddress,
      'addressComponents': addressComponents?.map((e) => e.toJson()).toList(),
      'plusCode': plusCode?.toJson(),
      'location': location?.toJson(),
      'viewport': viewport?.toJson(),
      'rating': rating,
      'googleMapsUri': googleMapsUri,
      'websiteUri': websiteUri,
      'regularOpeningHours': regularOpeningHours?.toJson(),
      'utcOffsetMinutes': utcOffsetMinutes,
      'adrFormatAddress': adrFormatAddress,
      'businessStatus': businessStatus,
      'userRatingCount': userRatingCount,
      'iconMaskBaseUri': iconMaskBaseUri,
      'iconBackgroundColor': iconBackgroundColor,
      'displayName': displayName?.toJson(),
      'primaryTypeDisplayName': primaryTypeDisplayName?.toJson(),
      'currentOpeningHours': currentOpeningHours?.toJson(),
      'primaryType': primaryType,
      'shortFormattedAddress': shortFormattedAddress,
      'editorialSummary': editorialSummary?.toJson(),
      'reviews': reviews?.map((e) => e.toJson()).toList(),
      'photos': photos?.map((e) => e.toJson()).toList(),
      'accessibilityOptions': accessibilityOptions?.toJson(),
      'pureServiceAreaBusiness': pureServiceAreaBusiness,
      'addressDescriptor': addressDescriptor?.toJson(),
      'googleMapsLinks': googleMapsLinks?.toJson(),
      'timeZone': timeZone?.toJson(),
    };
  }
}
