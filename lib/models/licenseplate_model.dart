class LicensePlate {
  int? id;
  String? licensePlate;

  LicensePlate({
    this.id,
    this.licensePlate,
  });

  LicensePlate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    licensePlate = json['licenseplate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['licenseplate'] = licensePlate;
    return data;
  }

  @override
  String toString() => "Chapa: $id, $licensePlate";
}
