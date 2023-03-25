class MeditationSvgAssets {
  static final MeditationSvgAssets _instance = MeditationSvgAssets._internal();

  factory MeditationSvgAssets() {
    return _instance;
  }

  MeditationSvgAssets._internal();

  Map<AssetName, String> assets = {
    AssetName.city: "assets/icons/city.svg",
    AssetName.search: "assets/icons/search.svg",
    AssetName.vectorMain: "assets/pics/VectorMainNews.svg",
    AssetName.vectorBottom: "assets/pics/Vector.svg",
    AssetName.vectorBottomReversed: "assets/pics/Vectorrev.svg",
    AssetName.vectorBottomBottom: "assets/pics/Vector00.svg",
    AssetName.vectorTop: "assets/pics/Vector-1.svg",
    AssetName.vectorTopTop: "assets/icons/Vector11.svg",
    AssetName.vectorTopReversed: "assets/icons/Vector-1rev.svg",
    AssetName.headphone: "assets/icons/headphone.svg",
    AssetName.tape: "assets/icons/tape.svg",
    AssetName.vectorSmallBottom: "assets/pics/VectorSmallBottom.svg",
    AssetName.vectorSmallTop: "assets/pics/VectorSmallTop.svg",
    AssetName.back: "assets/icons/back.svg",
    AssetName.heart: "assets/icons/heart.svg",
    AssetName.chart: "assets/icons/chart.svg",
    AssetName.discover: "assets/icons/discover.svg",
    AssetName.profile: "assets/icons/profile.svg",
    AssetName.schedule: "assets/icons/schedule.svg",
    AssetName.fizmatApp: "assets/icons/fizmat_app.svg",

  };
}

enum AssetName {
  city,
  search,
  vectorMain,
  vectorBottom,
  vectorBottomBottom,
  vectorBottomReversed,
  vectorTop,
  vectorTopTop,
  vectorTopReversed,
  headphone,
  tape,
  vectorSmallBottom,
  vectorSmallTop,
  back,
  heart,
  chart,
  discover,
  profile,
  schedule,
  fizmatApp
}
