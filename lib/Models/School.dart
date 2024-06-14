class School{
  int idSc;
  String name;

  School({
    required this.idSc,
    required this.name
  });

  String? data(){
    return "Escuela:\n$name";
  }
}