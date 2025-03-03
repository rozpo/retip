abstract class DebugRepository {
  bool getDebugShowCheckedModeBanner();

  bool getDebugRepaintRainbowEnabled();

  bool getDebugInvertOversizedImages();

  bool getShowPerformanceOverlay();

  void setDebugShowCheckedModeBanner(bool value);

  void setDebugRepaintRainbowEnabled(bool value);

  void setDebugInvertOversizedImages(bool value);

  void setShowPerformanceOverlay(bool value);
}
