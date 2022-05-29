
class Advices{
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  Advices(
    this.position,{
      required this.name,
      required this.iconImage,
      required this.description,
      required this.images
    }
  );
}

List<Advices> consejos = [
  Advices(
    1,
    name: 'Tu salud es lo más importante',
    iconImage: 'assets/diabetesFree.png',
    description: 'El comer el azucar provoca que tu glicemia aumente y por ende que te enfermes, cuidate por favor',
    images: []
  ),
  Advices(
    2,
    name: 'Tu salud es lo más importante',
    iconImage: '',
    description: 'El comer el azucar provoca que tu glicemia aumente y por ende que te enfermes, cuidate por favor',
    images: []
  ),
  Advices(
    3,
    name: 'Tu salud es lo más importante',
    iconImage: '',
    description: 'El comer el azucar provoca que tu glicemia aumente y por ende que te enfermes, cuidate por favor',
    images: []
  ),
  Advices(
    4,
    name: 'Tu salud es lo más importante',
    iconImage: '',
    description: 'El comer el azucar provoca que tu glicemia aumente y por ende que te enfermes, cuidate por favor',
    images: []
  ),
  Advices(
    5,
    name: 'Tu salud es lo más importante',
    iconImage: '',
    description: 'El comer el azucar provoca que tu glicemia aumente y por ende que te enfermes, cuidate por favor',
    images: []
  ),

];