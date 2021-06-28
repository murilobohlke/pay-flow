import 'dart:convert';

class BoletoModel {
  final String? name;
  final String? dueData;
  final String? barcode;
  final double? value;
  BoletoModel({
    this.name,
    this.dueData,
    this.barcode,
    this.value,
  });
 

  BoletoModel copyWith({
    String? name,
    String? dueData,
    String? barcode,
    double? value,
  }) {
    return BoletoModel(
      name: name ?? this.name,
      dueData: dueData ?? this.dueData,
      barcode: barcode ?? this.barcode,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dueData': dueData,
      'barcode': barcode,
      'value': value,
    };
  }

  factory BoletoModel.fromMap(Map<String, dynamic> map) {
    return BoletoModel(
      name: map['name'],
      dueData: map['dueData'],
      barcode: map['barcode'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BoletoModel.fromJson(String source) => BoletoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BoletoModel(name: $name, dueData: $dueData, barcode: $barcode, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BoletoModel &&
      other.name == name &&
      other.dueData == dueData &&
      other.barcode == barcode &&
      other.value == value;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      dueData.hashCode ^
      barcode.hashCode ^
      value.hashCode;
  }
}
