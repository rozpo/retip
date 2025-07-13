mixin RetipRoutes {
  // + Intro routes
  static const onboarding = '/onboarding';
  static const permissions = '/permissions';
  // - Intro routes

  // + Shell routes with navigator
  static const home = '/';
  static const search = '/search';
  static const library = '/library';

  static const album = '/library/album/:id';
  static const artist = '/library/artist/:id';
  static const genre = '/library/genre/:id';
  static const playlist = '/library/playlist/:id';
  static const track = '/library/track/:id';
  // - Shell routes with navigator

  // + Global routes
  static const player = '/player';
  static const profile = '/profile';
  static const history = '/history';
  static const storage = '/storage';
  static const settings = '/settings';
  // - Global routes

  // + Developer routes
  static const developer = '/developer';
  static const logger = '/logger';
  // - Developer routes
}
