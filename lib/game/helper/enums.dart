
enum AnimationEffect {
  burst(
    effectName: 'burst',
    amount: 100,
    speed: 0.005,
    size: 192,
  ),
  shield(
    effectName: 'shield',
    amount: 60,
    speed: 0.025,
    size: 192,
  ),
  shimmer(
    effectName: 'shimmer',
    amount: 60,
    speed: 0.025,
    size: 192,
  ),
  punch(
    effectName: 'punch',
    amount: 30,
    speed: 0.015,
    size: 192,
  ),
  bubbles(
    effectName: 'bubble_trail',
    amount: 25,
    speed: 0.2,
    size: 384,
  ),
  ;

  final String effectName;
  final int amount;
  final double speed;
  final double size;

  const AnimationEffect({
    required this.effectName,
    required this.amount,
    required this.speed,
    required this.size,
  });
}

enum SpeedMode {
  slow(speed: 150),
  normal(speed: 250),
  fast(speed: 300),
  superFast(speed: 400),
  turbo(speed: 500),
  boost(speed: 700),
  ;

  final double speed;
  const SpeedMode({required this.speed});
}

enum Enemy {
  shark,
  pufferfish,
  jellyfish,
  ;

  String get imagePath {
    switch (this) {
      case Enemy.shark:
        return 'shark_r.png';
      case Enemy.jellyfish:
        return 'jelly.png';
      case Enemy.pufferfish:
        return 'puffer_fish.png';
    }
  }
}

enum PlasticType {
  bottle,
  glass,
  bag,
  straw,
  ;

  String get imagePath {
    switch (this) {
      case PlasticType.bottle:
        return 'bottle.png';
      case PlasticType.glass:
        return 'bottle_1.png';
      case PlasticType.bag:
        return 'plastic_bag.png';
      case PlasticType.straw:
        return 'straw.png';
    }
  }
}
