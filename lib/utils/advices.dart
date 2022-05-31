// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Advices {
  final int position;
  final String name;
  final String iconImage;
  final Color backgroundColor;
  final String description;
  final List<String> images;

  Advices(this.position,
      {required this.name,
      required this.iconImage,
      required this.backgroundColor,
      required this.description,
      required this.images});
}

List<Advices> consejos = [
  Advices(1,
      name: 'Tu salud es lo más importante',
      iconImage: '',
      backgroundColor: Colors.redAccent,
      description:
          'El comer el azucar provoca que tu glicemia aumente y por ende que te enfermes, cuidate por favor',
      images: []),
  Advices(2,
      name: 'Haz más actividad física',
      iconImage: '',
      backgroundColor: Colors.deepOrangeAccent,
      description:
          '''La actividad física regular tiene muchos beneficios. El ejercicio puede ayudarte a:
Bajar de peso
Bajar tu nivel de glucosa sanguínea
Aumentar tu sensibilidad a la insulina, lo que ayuda a mantener tu glucosa sanguínea dentro de un rango normal''',
      images: []),
  Advices(3,
      name: 'Consume vegetales saludables',
      iconImage: '',
      backgroundColor: Colors.deepPurpleAccent,
      description:
          '''Los alimentos con un alto contenido de fibra promueven la pérdida de peso y reducen el riesgo de sufrir diabetes. Come una variedad de alimentos saludables con un alto contenido de fibra, por ejemplo:
Frutas, como tomates, pimientos y frutas de los árboles
Vegetales sin almidón, como hortalizas de hoja verde, brócoli y coliflor
Legumbres, como frijoles, garbanzos y lentejas
Cereales integrales, como pastas y panes integrales, arroz integral, avena entera y quinua''',
      images: []),
  Advices(4,
      name: 'Consume grasas saludables',
      iconImage: '',
      backgroundColor: Colors.tealAccent,
      description:
          '''Las grasas insaturadas, tanto monoinsaturadas, como poliinsaturadas, favorecen los niveles de colesterol saludable y la buena salud vascular y del corazón. Estas son algunas fuentes de grasas saludables:
Aceite de oliva, girasol, cártamo, semilla de algodón y canola
Frutos secos y semillas, como almendras, cacahuates, linaza y semillas de calabaza
Pescados grasos, como el salmón, la caballa, las sardinas, el atún y el bacalao''',
      images: []),
  Advices(5,
      name: 'Cuándo consultar a su médico',
      iconImage: '',
      backgroundColor: Colors.greenAccent,
      description:
          '''La American Diabetes Association (Asociación Americana de la Diabetes) recomienda exámenes de detección de rutina con pruebas de diagnóstico para la diabetes tipo 2 en todos los adultos de 45 años o más, y en los siguientes grupos: 
*Personas menores de 45 años que tienen sobrepeso u obesidad, y tienen uno o más factores de riesgo relacionados con la diabetes.
*Mujeres que han tenido diabetes gestacional.
*Personas a las que le han diagnosticado prediabetes.
*Niños con sobrepeso u obesidad, y que tienen antecedentes familiares de diabetes tipo 2 u otros factores de riesgo.
Habla con tu médico sobre tus inquietudes y cómo prevenir la diabetes. El médico verá con buenos ojos tu esfuerzo por prevenir la diabetes y podría darte más sugerencias, de acuerdo con tus antecedentes médicos y otros factores.''',
      images: []),
];
