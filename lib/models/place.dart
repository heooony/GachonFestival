enum Place {
  freedom,
  stardom,
  gachonGov,
  wind,
  gradSchool,
  studUnion,
  schoolYard
}

extension PlaceExtension on Place {
  int get key {
    switch (this) {
      case Place.freedom: return 0;
      case Place.stardom: return 1;
      case Place.gachonGov: return 2;
      case Place.wind: return 3;
      case Place.gradSchool: return 4;
      case Place.studUnion: return 5;
      case Place.schoolYard: return 6;
    }
  }

  String get name {
    switch (this) {
      case Place.freedom: return "프리덤 광장";
      case Place.stardom: return "스타덤 광장";
      case Place.gachonGov: return "가천관";
      case Place.wind: return "바람개비";
      case Place.gradSchool: return "교육대학원";
      case Place.studUnion: return "학생회관";
      case Place.schoolYard: return "운동장";
    }
  }

  String get image {
    switch (this) {
      case Place.freedom: return "assets/images/map/freedom.png";
      case Place.stardom: return "assets/images/map/stardom.png";
      case Place.gachonGov: return "assets/images/map/gachon-gov.png";
      case Place.wind: return "assets/images/map/wind.png";
      case Place.gradSchool: return "assets/images/map/grad-school.png";
      case Place.studUnion: return "assets/images/map/stud-union.png";
      case Place.schoolYard: return "assets/images/map/school-yard.png";
    }
  }
}