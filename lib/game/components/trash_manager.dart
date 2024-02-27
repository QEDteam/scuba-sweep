import 'dart:async' as da;
import 'dart:math';

import 'package:flame/components.dart';
import 'package:my_flutter_app/game/components/trash_component.dart';
import 'package:my_flutter_app/game/game/my_game.dart';
import 'package:my_flutter_app/game/helper/enums.dart';
import 'package:uuid/uuid.dart';

class TrashManager extends Component with HasGameRef<MyGame> {
  final List<TrashComponent> trashList = [];
  da.Timer timer = da.Timer(Duration.zero, () {});

  final uuid = const Uuid();

  final List<Future<Sprite>> plasticSprites = PlasticType.values.map((e) {
    final sprite = Sprite.load(e.imagePath);
    return sprite;
  }).toList();

  @override
  void update(double dt) {
    super.update(dt);
    trashList.removeWhere((trash) => trash.position.y > gameRef.size.y);
  }

  start() {
    timer = da.Timer.periodic(const Duration(seconds: 2), (_) => addTrash());
  }

  void addTrash() async {
    final randomPlastic = Random().nextInt(PlasticType.values.length);
    final trashComponent = TrashComponent(
      id: uuid.v4(),
      sprite: await plasticSprites[randomPlastic],
      positionX: Random().nextDouble() * gameRef.size.x,
    );
    gameRef.add(trashComponent);
    trashList.add(trashComponent);
  }

  reset() {
    timer.cancel();
    for (var trashComponent in trashList) {
      trashComponent.removeFromParent();
    }
  }
}
