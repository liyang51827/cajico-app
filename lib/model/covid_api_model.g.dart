// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidApiModel _$CovidApiModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CovidApiModel',
      json,
      ($checkedConvert) {
        final val = CovidApiModel(
          countries:
              $checkedConvert('countriesRoute', (v) => Countries.fromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {'countries': 'countriesRoute'},
    );

Map<String, dynamic> _$CovidApiModelToJson(CovidApiModel instance) =>
    <String, dynamic>{
      'countriesRoute': instance.countries,
    };

Countries _$CountriesFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Countries',
      json,
      ($checkedConvert) {
        final val = Countries(
          name: $checkedConvert('Name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'name': 'Name'},
    );

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'Name': instance.name,
    };
