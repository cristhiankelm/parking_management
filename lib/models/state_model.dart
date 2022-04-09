class State {
  int? id;
  String? state;

  State({this.id, this.state});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['state'] = state;
    return data;
  }

  @override
  String toString() => "Departamento: $id, $state";
}
