import 'dart:convert';

class ResponseData {
  final String? status;
  final String? country;
  final String? countryCode;
  final String? region;
  final String? regionName;
  final String? city;
  final String? zip;
  final double? lat;
  final double? lon;
  final String? timezone;
  final String? isp;
  final String? org;
  final String? as;
  final String? query;
  ResponseData({
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.as,
    this.query,
  });

  ResponseData copyWith({
    String? status,
    String? country,
    String? countryCode,
    String? region,
    String? regionName,
    String? city,
    String? zip,
    double? lat,
    double? lon,
    String? timezone,
    String? isp,
    String? org,
    String? as,
    String? query,
  }) {
    return ResponseData(
      status: status ?? this.status,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      region: region ?? this.region,
      regionName: regionName ?? this.regionName,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      timezone: timezone ?? this.timezone,
      isp: isp ?? this.isp,
      org: org ?? this.org,
      as: as ?? this.as,
      query: query ?? this.query,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'country': country,
      'countryCode': countryCode,
      'region': region,
      'regionName': regionName,
      'city': city,
      'zip': zip,
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'isp': isp,
      'org': org,
      'as': as,
      'query': query,
    };
  }

  factory ResponseData.fromMap(Map<String, dynamic> map) {
    return ResponseData(
      status: map['status'] != null ? map['status'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      countryCode:
          map['countryCode'] != null ? map['countryCode'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      regionName:
          map['regionName'] != null ? map['regionName'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      zip: map['zip'] != null ? map['zip'] as String : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      lon: map['lon'] != null ? map['lon'] as double : null,
      timezone: map['timezone'] != null ? map['timezone'] as String : null,
      isp: map['isp'] != null ? map['isp'] as String : null,
      org: map['org'] != null ? map['org'] as String : null,
      as: map['as'] != null ? map['as'] as String : null,
      query: map['query'] != null ? map['query'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseData.fromJson(String source) =>
      ResponseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseData(status: $status, country: $country, countryCode: $countryCode, region: $region, regionName: $regionName, city: $city, zip: $zip, lat: $lat, lon: $lon, timezone: $timezone, isp: $isp, org: $org, as: $as, query: $query)';
  }

  @override
  bool operator ==(covariant ResponseData other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.country == country &&
        other.countryCode == countryCode &&
        other.region == region &&
        other.regionName == regionName &&
        other.city == city &&
        other.zip == zip &&
        other.lat == lat &&
        other.lon == lon &&
        other.timezone == timezone &&
        other.isp == isp &&
        other.org == org &&
        other.as == as &&
        other.query == query;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        country.hashCode ^
        countryCode.hashCode ^
        region.hashCode ^
        regionName.hashCode ^
        city.hashCode ^
        zip.hashCode ^
        lat.hashCode ^
        lon.hashCode ^
        timezone.hashCode ^
        isp.hashCode ^
        org.hashCode ^
        as.hashCode ^
        query.hashCode;
  }
}
