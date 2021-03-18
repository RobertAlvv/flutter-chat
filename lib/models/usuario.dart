
class Usuario {
    Usuario({
        this.online,
        this.nombre,
        this.email,
        this.uid,
    });

    bool online;
    String nombre;
    String email;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "email": email,
        "uid": uid,
    };
}
