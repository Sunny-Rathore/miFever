class FliteModel {
  String? id;
  Price? price;
  List<Leg>? legs;
  bool? isSelfTransfer;
  bool? isProtectedSelfTransfer;
  FarePolicy? farePolicy;
  Eco? eco;
  FareAttributes? fareAttributes;
  List<String>? tags;
  bool? isMashUp;
  bool? hasFlexibleOptions;
  double? score;

  FliteModel({
    this.id,
    this.price,
    this.legs,
    this.isSelfTransfer,
    this.isProtectedSelfTransfer,
    this.farePolicy,
    this.eco,
    this.fareAttributes,
    this.tags,
    this.isMashUp,
    this.hasFlexibleOptions,
    this.score,
  });

  factory FliteModel.fromJson(Map<String, dynamic> json) => FliteModel(
        id: json["id"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        legs: json["legs"] == null
            ? []
            : List<Leg>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
        isSelfTransfer: json["isSelfTransfer"],
        isProtectedSelfTransfer: json["isProtectedSelfTransfer"],
        farePolicy: json["farePolicy"] == null
            ? null
            : FarePolicy.fromJson(json["farePolicy"]),
        eco: json["eco"] == null ? null : Eco.fromJson(json["eco"]),
        fareAttributes: json["fareAttributes"] == null
            ? null
            : FareAttributes.fromJson(json["fareAttributes"]),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        isMashUp: json["isMashUp"],
        hasFlexibleOptions: json["hasFlexibleOptions"],
        score: json["score"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price?.toJson(),
        "legs": legs == null
            ? []
            : List<dynamic>.from(legs!.map((x) => x.toJson())),
        "isSelfTransfer": isSelfTransfer,
        "isProtectedSelfTransfer": isProtectedSelfTransfer,
        "farePolicy": farePolicy?.toJson(),
        "eco": eco?.toJson(),
        "fareAttributes": fareAttributes?.toJson(),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "isMashUp": isMashUp,
        "hasFlexibleOptions": hasFlexibleOptions,
        "score": score,
      };
}

class Eco {
  double? ecoContenderDelta;

  Eco({
    this.ecoContenderDelta,
  });

  factory Eco.fromJson(Map<String, dynamic> json) => Eco(
        ecoContenderDelta: json["ecoContenderDelta"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ecoContenderDelta": ecoContenderDelta,
      };
}

class FareAttributes {
  FareAttributes();

  factory FareAttributes.fromJson(Map<String, dynamic> json) =>
      FareAttributes();

  Map<String, dynamic> toJson() => {};
}

class FarePolicy {
  bool? isChangeAllowed;
  bool? isPartiallyChangeable;
  bool? isCancellationAllowed;
  bool? isPartiallyRefundable;

  FarePolicy({
    this.isChangeAllowed,
    this.isPartiallyChangeable,
    this.isCancellationAllowed,
    this.isPartiallyRefundable,
  });

  factory FarePolicy.fromJson(Map<String, dynamic> json) => FarePolicy(
        isChangeAllowed: json["isChangeAllowed"],
        isPartiallyChangeable: json["isPartiallyChangeable"],
        isCancellationAllowed: json["isCancellationAllowed"],
        isPartiallyRefundable: json["isPartiallyRefundable"],
      );

  Map<String, dynamic> toJson() => {
        "isChangeAllowed": isChangeAllowed,
        "isPartiallyChangeable": isPartiallyChangeable,
        "isCancellationAllowed": isCancellationAllowed,
        "isPartiallyRefundable": isPartiallyRefundable,
      };
}

class Leg {
  String? id;
  LegDestination? origin;
  LegDestination? destination;
  int? durationInMinutes;
  int? stopCount;
  bool? isSmallestStops;
  DateTime? departure;
  DateTime? arrival;
  int? timeDeltaInDays;
  Carriers? carriers;
  List<Segment>? segments;

  Leg({
    this.id,
    this.origin,
    this.destination,
    this.durationInMinutes,
    this.stopCount,
    this.isSmallestStops,
    this.departure,
    this.arrival,
    this.timeDeltaInDays,
    this.carriers,
    this.segments,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        id: json["id"],
        origin: json["origin"] == null
            ? null
            : LegDestination.fromJson(json["origin"]),
        destination: json["destination"] == null
            ? null
            : LegDestination.fromJson(json["destination"]),
        durationInMinutes: json["durationInMinutes"],
        stopCount: json["stopCount"],
        isSmallestStops: json["isSmallestStops"],
        departure: json["departure"] == null
            ? null
            : DateTime.parse(json["departure"]),
        arrival:
            json["arrival"] == null ? null : DateTime.parse(json["arrival"]),
        timeDeltaInDays: json["timeDeltaInDays"],
        carriers: json["carriers"] == null
            ? null
            : Carriers.fromJson(json["carriers"]),
        segments: json["segments"] == null
            ? []
            : List<Segment>.from(
                json["segments"]!.map((x) => Segment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "origin": origin?.toJson(),
        "destination": destination?.toJson(),
        "durationInMinutes": durationInMinutes,
        "stopCount": stopCount,
        "isSmallestStops": isSmallestStops,
        "departure": departure?.toIso8601String(),
        "arrival": arrival?.toIso8601String(),
        "timeDeltaInDays": timeDeltaInDays,
        "carriers": carriers?.toJson(),
        "segments": segments == null
            ? []
            : List<dynamic>.from(segments!.map((x) => x.toJson())),
      };
}

class Carriers {
  List<Marketing>? marketing;
  String? operationType;

  Carriers({
    this.marketing,
    this.operationType,
  });

  factory Carriers.fromJson(Map<String, dynamic> json) => Carriers(
        marketing: json["marketing"] == null
            ? []
            : List<Marketing>.from(
                json["marketing"]!.map((x) => Marketing.fromJson(x))),
        operationType: json["operationType"],
      );

  Map<String, dynamic> toJson() => {
        "marketing": marketing == null
            ? []
            : List<dynamic>.from(marketing!.map((x) => x.toJson())),
        "operationType": operationType,
      };
}

class Marketing {
  int? id;
  String? logoUrl;
  String? name;

  Marketing({
    this.id,
    this.logoUrl,
    this.name,
  });

  factory Marketing.fromJson(Map<String, dynamic> json) => Marketing(
        id: json["id"],
        logoUrl: json["logoUrl"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logoUrl": logoUrl,
        "name": name,
      };
}

class LegDestination {
  String? id;
  String? name;
  String? displayCode;
  String? city;
  String? country;
  bool? isHighlighted;

  LegDestination({
    this.id,
    this.name,
    this.displayCode,
    this.city,
    this.country,
    this.isHighlighted,
  });

  factory LegDestination.fromJson(Map<String, dynamic> json) => LegDestination(
        id: json["id"],
        name: json["name"],
        displayCode: json["displayCode"],
        city: json["city"],
        country: json["country"],
        isHighlighted: json["isHighlighted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "displayCode": displayCode,
        "city": city,
        "country": country,
        "isHighlighted": isHighlighted,
      };
}

class Segment {
  String? id;
  SegmentDestination? origin;
  SegmentDestination? destination;
  DateTime? departure;
  DateTime? arrival;
  int? durationInMinutes;
  String? flightNumber;
  TingCarrier? marketingCarrier;
  TingCarrier? operatingCarrier;

  Segment({
    this.id,
    this.origin,
    this.destination,
    this.departure,
    this.arrival,
    this.durationInMinutes,
    this.flightNumber,
    this.marketingCarrier,
    this.operatingCarrier,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        id: json["id"],
        origin: json["origin"] == null
            ? null
            : SegmentDestination.fromJson(json["origin"]),
        destination: json["destination"] == null
            ? null
            : SegmentDestination.fromJson(json["destination"]),
        departure: json["departure"] == null
            ? null
            : DateTime.parse(json["departure"]),
        arrival:
            json["arrival"] == null ? null : DateTime.parse(json["arrival"]),
        durationInMinutes: json["durationInMinutes"],
        flightNumber: json["flightNumber"],
        marketingCarrier: json["marketingCarrier"] == null
            ? null
            : TingCarrier.fromJson(json["marketingCarrier"]),
        operatingCarrier: json["operatingCarrier"] == null
            ? null
            : TingCarrier.fromJson(json["operatingCarrier"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "origin": origin?.toJson(),
        "destination": destination?.toJson(),
        "departure": departure?.toIso8601String(),
        "arrival": arrival?.toIso8601String(),
        "durationInMinutes": durationInMinutes,
        "flightNumber": flightNumber,
        "marketingCarrier": marketingCarrier?.toJson(),
        "operatingCarrier": operatingCarrier?.toJson(),
      };
}

class SegmentDestination {
  String? flightPlaceId;
  String? displayCode;
  Parent? parent;
  String? name;
  String? type;
  String? country;

  SegmentDestination({
    this.flightPlaceId,
    this.displayCode,
    this.parent,
    this.name,
    this.type,
    this.country,
  });

  factory SegmentDestination.fromJson(Map<String, dynamic> json) =>
      SegmentDestination(
        flightPlaceId: json["flightPlaceId"],
        displayCode: json["displayCode"],
        parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
        name: json["name"],
        type: json["type"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "flightPlaceId": flightPlaceId,
        "displayCode": displayCode,
        "parent": parent?.toJson(),
        "name": name,
        "type": type,
        "country": country,
      };
}

class Parent {
  String? flightPlaceId;
  String? displayCode;
  String? name;
  String? type;

  Parent({
    this.flightPlaceId,
    this.displayCode,
    this.name,
    this.type,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        flightPlaceId: json["flightPlaceId"],
        displayCode: json["displayCode"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "flightPlaceId": flightPlaceId,
        "displayCode": displayCode,
        "name": name,
        "type": type,
      };
}

class TingCarrier {
  int? id;
  String? name;
  String? alternateId;
  int? allianceId;
  String? displayCode;

  TingCarrier({
    this.id,
    this.name,
    this.alternateId,
    this.allianceId,
    this.displayCode,
  });

  factory TingCarrier.fromJson(Map<String, dynamic> json) => TingCarrier(
        id: json["id"],
        name: json["name"],
        alternateId: json["alternateId"],
        allianceId: json["allianceId"],
        displayCode: json["displayCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternateId": alternateId,
        "allianceId": allianceId,
        "displayCode": displayCode,
      };
}

class Price {
  double? raw;
  String? formatted;
  String? pricingOptionId;

  Price({
    this.raw,
    this.formatted,
    this.pricingOptionId,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        raw: json["raw"]?.toDouble(),
        formatted: json["formatted"],
        pricingOptionId: json["pricingOptionId"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "formatted": formatted,
        "pricingOptionId": pricingOptionId,
      };
}
