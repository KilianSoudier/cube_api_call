// ignore_for_file: non_constant_identifier_names

class Ressources {
  int id_ressource;
  String titre;
  String langue_nom;
  String date_moderation;
  bool validation_moderation;
  String description;
  int age_minimum;
  int compteur_vue;

  Ressources(
      {required this.id_ressource,
      required this.titre,
      required this.langue_nom,
      required this.date_moderation,
      required this.validation_moderation,
      required this.description,
      required this.age_minimum,
      required this.compteur_vue});
}
