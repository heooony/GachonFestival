import 'group.dart';

class Club extends Group {
  String? title;
  String? intro;
  int? openOrClose;
  double? xPosition;
  double? yPosition;
  String iconImagePath = "assets/images/club-pin.png";

  Club(this.title, this.intro, this.openOrClose, this.xPosition, this.yPosition) : super(title, intro, openOrClose, xPosition, yPosition);

  static List<Club> initialData = [
    Club("1번째 동아리", "십자수 체험합니다!!", 1, 1250, 300),
    Club("2번째 동아리", "안농안농 반가워~", 1, 1200, 350),
  ];
}