import 'group.dart';

class FleaMarket extends Group {
  String? title;
  String? intro;
  int? openOrClose;
  double? xPosition;
  double? yPosition;
  String iconImagePath = "assets/images/flea-market-pin.png";

  FleaMarket(this.title, this.intro, this.openOrClose, this.xPosition, this.yPosition) : super(title, intro, openOrClose, xPosition, yPosition);

  static List<FleaMarket> initialData = [
    FleaMarket("1번째 플리마켓", "벼룩 팔아요!!", 0, 300, 200),
    FleaMarket("2번째 플리마켓", "뭐든지 다 팝니다!!", 1, 350, 300),
    FleaMarket("3번째 플리마켓", "우리는 사실 뭐하는지 모르고 그냥 왔어요,, 죄송해요 다음엔 열심히 준비할게요.", 1, 910, 420),
    FleaMarket("4번째 플리마켓", "UX는 신경쓰지 않고 만들었다보니 조금 부족한 면이 있네요. 하지만 괜찮습니다!", 1, 800, 520),
  ];
}