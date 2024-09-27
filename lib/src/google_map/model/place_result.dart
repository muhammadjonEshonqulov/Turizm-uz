class PlaceResult {
  final String name;
  final Geometry geometry;
  final String? vicinity;
  final double? rating;
  final int? userRatingsTotal;
  final String placeId;
  final List<String> types;
  final String? businessStatus;
  final OpeningHours? openingHours;
  final List<Photo>? photos;
  final PlusCode? plusCode;
  final int? priceLevel;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? reference;
  final String? scope;

  PlaceResult({
    required this.name,
    required this.geometry,
    this.vicinity,
    this.rating,
    this.userRatingsTotal,
    required this.placeId,
    required this.types,
    this.businessStatus,
    this.openingHours,
    this.photos,
    this.plusCode,
    this.priceLevel,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.reference,
    this.scope,
  });

  factory PlaceResult.fromJson(Map<String, dynamic> json) {
    return PlaceResult(
      name: json['name'] as String,
      geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      vicinity: json['vicinity'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      userRatingsTotal: json['user_ratings_total'] as int?,
      placeId: json['place_id'] as String,
      types: List<String>.from(json['types'] as List),
      businessStatus: json['business_status'] as String?,
      openingHours: json['opening_hours'] != null
          ? OpeningHours.fromJson(json['opening_hours'] as Map<String, dynamic>)
          : null,
      photos: json['photos'] != null
          ? (json['photos'] as List)
          .map((photo) => Photo.fromJson(photo as Map<String, dynamic>))
          .toList()
          : null,
      plusCode: json['plus_code'] != null
          ? PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>)
          : null,
      priceLevel: json['price_level'] as int?,
      icon: json['icon'] as String?,
      iconBackgroundColor: json['icon_background_color'] as String?,
      iconMaskBaseUri: json['icon_mask_base_uri'] as String?,
      reference: json['reference'] as String?,
      scope: json['scope'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'geometry': geometry.toJson(),
      if (vicinity != null) 'vicinity': vicinity,
      if (rating != null) 'rating': rating,
      if (userRatingsTotal != null) 'user_ratings_total': userRatingsTotal,
      'place_id': placeId,
      'types': types,
      if (businessStatus != null) 'business_status': businessStatus,
      if (openingHours != null) 'opening_hours': openingHours!.toJson(),
      if (photos != null)
        'photos': photos!.map((photo) => photo.toJson()).toList(),
      if (plusCode != null) 'plus_code': plusCode!.toJson(),
      if (priceLevel != null) 'price_level': priceLevel,
      if (icon != null) 'icon': icon,
      if (iconBackgroundColor != null)
        'icon_background_color': iconBackgroundColor,
      if (iconMaskBaseUri != null) 'icon_mask_base_uri': iconMaskBaseUri,
      if (reference != null) 'reference': reference,
      if (scope != null) 'scope': scope,
    };
  }
}

class Geometry {
  final Location location;
  final Viewport? viewport;

  Geometry({required this.location, this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      viewport: json['viewport'] != null
          ? Viewport.fromJson(json['viewport'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      if (viewport != null) 'viewport': viewport!.toJson(),
    };
  }
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Viewport {
  final Location northeast;
  final Location southwest;

  Viewport({required this.northeast, required this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) {
    return Viewport(
      northeast: Location.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: Location.fromJson(json['southwest'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'northeast': northeast.toJson(),
      'southwest': southwest.toJson(),
    };
  }
}

class OpeningHours {
  final bool openNow;

  OpeningHours({required this.openNow});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openNow: json['open_now'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'open_now': openNow,
    };
  }
}

class Photo {
  final int height;
  final int width;
  final List<String> htmlAttributions;
  final String photoReference;

  Photo({
    required this.height,
    required this.width,
    required this.htmlAttributions,
    required this.photoReference,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      height: json['height'] as int,
      width: json['width'] as int,
      htmlAttributions: List<String>.from(json['html_attributions'] as List),
      photoReference: json['photo_reference'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'width': width,
      'html_attributions': htmlAttributions,
      'photo_reference': photoReference,
    };
  }
}

class PlusCode {
  final String compoundCode;
  final String globalCode;

  PlusCode({required this.compoundCode, required this.globalCode});

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json['compound_code'] as String,
      globalCode: json['global_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'compound_code': compoundCode,
      'global_code': globalCode,
    };
  }
}
