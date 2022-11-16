import 'package:json_annotation/json_annotation.dart';

part 'covid_api_model.g.dart';

@JsonSerializable()
class CovidApiModel {
  CovidApiModel({required this.countries});

  factory CovidApiModel.fromJson(dynamic json) => _$CovidApiModelFromJson(json);

  @JsonKey(name: 'countriesRoute')
  final Countries countries;

  Map<String, dynamic> toJson() => _$CovidApiModelToJson(this);
}

@JsonSerializable()
class Countries {
  Countries({required this.name});

  factory Countries.fromJson(dynamic json) => _$CountriesFromJson(json);

  @JsonKey(name: 'Name')
  final String name;
}
