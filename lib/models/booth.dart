enum Booth {
  major,
  club,
  foodTruck,
  fleaMarket,
  waiting,
  congestion,
  normal
}

extension BoothExtension on Booth {
  int get key {
    switch (this) {
      case Booth.major: return 0;
      case Booth.club: return 1;
      case Booth.foodTruck: return 2;
      case Booth.fleaMarket: return 3;
      case Booth.waiting: return 4;
      case Booth.congestion: return 5;
      case Booth.normal: return 6;
    }
  }

  String get name {
    switch (this) {
      case Booth.major: return "학과 부스";
      case Booth.club: return "동아리";
      case Booth.foodTruck: return "푸드트럭";
      case Booth.fleaMarket: return "플리마켓";
      case Booth.waiting: return "부스";
      case Booth.congestion: return "";
      case Booth.normal: return "";
    }
  }
}