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
    Club("1번째 동아리", "십자수 체험합니다!!", 1, 600, 300),
    Club("2번째 동아리", "안농안농 반가워~ 언제 어디서나 우리 동아리만 찾기를 바라요", 1, 700, 350),
    Club("3번째 동아리", "3번째 동아리인데 여기서는 십자수나 다른 프로그램을 운영하고 있습니다!", 1, 650, 420),
    Club("4번째 동아리", "DSG 동아리입니다. 아메리카노랑 아이스티 등 카페나 다른 음식도 팔고 있어요.", 1, 570, 470),
  ];
}