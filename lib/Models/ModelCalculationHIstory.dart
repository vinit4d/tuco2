// To parse this JSON data, do
//
//     final modelCalculationHistory = modelCalculationHistoryFromJson(jsonString);

import 'dart:convert';

ModelCalculationHistory modelCalculationHistoryFromJson(String str) => ModelCalculationHistory.fromJson(json.decode(str));

String modelCalculationHistoryToJson(ModelCalculationHistory data) => json.encode(data.toJson());

class ModelCalculationHistory {
    ModelCalculationHistory({
        this.status,
        this.message,
        this.data,
    });

    String? status;
    String? message;
    Data? data;

    factory ModelCalculationHistory.fromJson(Map<String, dynamic> json) => ModelCalculationHistory(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.trips,
    });

    List<Trip>? trips;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        trips: json["trips"] == null ? [] : List<Trip>.from(json["trips"]!.map((x) => Trip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "trips": trips == null ? [] : List<dynamic>.from(trips!.map((x) => x.toJson())),
    };
}

class Trip {
    Trip({
        this.id,
        this.from,
        this.to,
        this.roundTrip,
        this.startDate,
        this.tripDays,
        this.peoples,
        this.calculation,
    });

    int? id;
    String? from;
    String? to;
    int? roundTrip;
    DateTime? startDate;
    int? tripDays;
    int? peoples;
    Calculation? calculation;

    factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        roundTrip: json["round_trip"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        tripDays: json["trip_days"],
        peoples: json["peoples"],
        calculation: json["calculation"] == null ? null : Calculation.fromJson(json["calculation"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "round_trip": roundTrip,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "trip_days": tripDays,
        "peoples": peoples,
        "calculation": calculation?.toJson(),
    };
}

class Calculation {
    Calculation({
        this.tripId,
        this.transportEmissionTotal,
        this.accommodationEmissionTotal,
        this.totalEmissionPerPerson,
        this.totalEmission,
    });

    int? tripId;
    int? transportEmissionTotal;
    int? accommodationEmissionTotal;
    int? totalEmissionPerPerson;
    int? totalEmission;

    factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
        tripId: json["trip_id"],
        transportEmissionTotal: json["transport_emission_total"],
        accommodationEmissionTotal: json["accommodation_emission_total"],
        totalEmissionPerPerson: json["total_emission_per_person"],
        totalEmission: json["total_emission"],
    );

    Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "transport_emission_total": transportEmissionTotal,
        "accommodation_emission_total": accommodationEmissionTotal,
        "total_emission_per_person": totalEmissionPerPerson,
        "total_emission": totalEmission,
    };
}
