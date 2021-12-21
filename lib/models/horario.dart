class Horario {
  Horario({
    this.lunes,
    this.martes,
    this.miercoles,
    this.jueves,
    this.viernes,
    this.sabado,
    this.domingo,
  });

  String? lunes;
  String? martes;
  String? miercoles;
  String? jueves;
  String? viernes;
  String? sabado;
  String? domingo;

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        lunes: json["lunes"],
        martes: json["martes"],
        miercoles: json["miercoles"],
        jueves: json["jueves"],
        viernes: json["viernes"],
        sabado: json["sabado"],
        domingo: json["domingo"],
      );

  Map<String, dynamic> toJson() => {
        "lunes": lunes,
        "martes": martes,
        "miercoles": miercoles,
        "jueves": jueves,
        "viernes": viernes,
        "sabado": sabado,
        "domingo": domingo,
      };
}
