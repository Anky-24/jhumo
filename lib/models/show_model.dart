class Show {
  final String name, days, timing, rjName, rjUrl, type;
  final int id;

  Show(
      {required this.name,
      required this.days,
      required this.timing,
      required this.rjName,
      required this.rjUrl,
      required this.id,
      required this.type});

  static Show fromJson(Map<String, dynamic> json) => Show(
      id: json['id'],
      name: json['name'],
      days: json['days'],
      timing: json['timing'],
      rjName: json['rj_name'],
      rjUrl: json['rj_url'],
      type: json['type']);
}
