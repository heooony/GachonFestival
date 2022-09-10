import '../interfaces/image_provider.dart';
import '../interfaces/position.dart';

abstract class Group implements Position, ImageProvider {
  String? title;
  String? intro;
  int? openOrClose;
  double? xPosition;
  double? yPosition;
  abstract String iconImagePath;

  Group(this.title, this.intro, this.openOrClose, this.xPosition, this.yPosition);
}