import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'retip_l10n_en.dart';
import 'retip_l10n_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of RetipL10n
/// returned by `RetipL10n.of(context)`.
///
/// Applications need to include `RetipL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/retip_l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RetipL10n.localizationsDelegates,
///   supportedLocales: RetipL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the RetipL10n.supportedLocales
/// property.
abstract class RetipL10n {
  RetipL10n(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RetipL10n of(BuildContext context) {
    return Localizations.of<RetipL10n>(context, RetipL10n)!;
  }

  static const LocalizationsDelegate<RetipL10n> delegate = _RetipL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About application'**
  String get aboutApp;

  /// No description provided for @addedTo.
  ///
  /// In en, this message translates to:
  /// **'Added to {name}'**
  String addedTo(String name);

  /// No description provided for @addToFavourites.
  ///
  /// In en, this message translates to:
  /// **'Add to favourites'**
  String get addToFavourites;

  /// No description provided for @addToPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Add to playlist'**
  String get addToPlaylist;

  /// No description provided for @addToTheFavourites.
  ///
  /// In en, this message translates to:
  /// **'Add to the favourites'**
  String get addToTheFavourites;

  /// No description provided for @addToThePlaylist.
  ///
  /// In en, this message translates to:
  /// **'Add to the playlist'**
  String get addToThePlaylist;

  /// No description provided for @addToTheQueue.
  ///
  /// In en, this message translates to:
  /// **'Add to the queue'**
  String get addToTheQueue;

  /// No description provided for @album.
  ///
  /// In en, this message translates to:
  /// **'Album'**
  String get album;

  /// No description provided for @albums.
  ///
  /// In en, this message translates to:
  /// **'Albums'**
  String get albums;

  /// No description provided for @albumsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No albums} one{1 Album} other{{count} Albums}}'**
  String albumsCount(int count);

  /// No description provided for @alertRemoveFromFavMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to remove a track from favourites list?'**
  String get alertRemoveFromFavMsg;

  /// No description provided for @alertRemoveFromFavTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove from favourites'**
  String get alertRemoveFromFavTitle;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This action can\'t be undone'**
  String get areYouSure;

  /// No description provided for @artist.
  ///
  /// In en, this message translates to:
  /// **'Artist'**
  String get artist;

  /// No description provided for @artists.
  ///
  /// In en, this message translates to:
  /// **'Artists'**
  String get artists;

  /// No description provided for @autoplay.
  ///
  /// In en, this message translates to:
  /// **'Autoplay'**
  String get autoplay;

  /// No description provided for @batterySaver.
  ///
  /// In en, this message translates to:
  /// **'Battery saver'**
  String get batterySaver;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @checkForUpdate.
  ///
  /// In en, this message translates to:
  /// **'Check for update'**
  String get checkForUpdate;

  /// No description provided for @columnsCount.
  ///
  /// In en, this message translates to:
  /// **'Display {count} columns'**
  String columnsCount(int count);

  /// No description provided for @composer.
  ///
  /// In en, this message translates to:
  /// **'Composer'**
  String get composer;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @createNewPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Create new playlist'**
  String get createNewPlaylist;

  /// No description provided for @crossfade.
  ///
  /// In en, this message translates to:
  /// **'Crossfade'**
  String get crossfade;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @dateAdded.
  ///
  /// In en, this message translates to:
  /// **'Date added'**
  String get dateAdded;

  /// No description provided for @dateModified.
  ///
  /// In en, this message translates to:
  /// **'Date modified'**
  String get dateModified;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deletePlaylist.
  ///
  /// In en, this message translates to:
  /// **'Delete playlist'**
  String get deletePlaylist;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @developerMenu.
  ///
  /// In en, this message translates to:
  /// **'Developer menu'**
  String get developerMenu;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @equalizer.
  ///
  /// In en, this message translates to:
  /// **'Equalizer'**
  String get equalizer;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @fileDetails.
  ///
  /// In en, this message translates to:
  /// **'File details'**
  String get fileDetails;

  /// No description provided for @generatedPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Generated playlist'**
  String get generatedPlaylist;

  /// No description provided for @genre.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genre;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @goToAlbum.
  ///
  /// In en, this message translates to:
  /// **'Go to album'**
  String get goToAlbum;

  /// No description provided for @goToArtist.
  ///
  /// In en, this message translates to:
  /// **'Go to artist'**
  String get goToArtist;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'Grant permission to access storage for a seamless music playback experience'**
  String get grantPermission;

  /// No description provided for @gridView.
  ///
  /// In en, this message translates to:
  /// **'Grid view'**
  String get gridView;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @keepPlayback.
  ///
  /// In en, this message translates to:
  /// **'Keep playing queue'**
  String get keepPlayback;

  /// No description provided for @legalese.
  ///
  /// In en, this message translates to:
  /// **'Copyright (c) 2024 Piotr Rozpończyk'**
  String get legalese;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @libraryScan.
  ///
  /// In en, this message translates to:
  /// **'Library scan'**
  String get libraryScan;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @liked.
  ///
  /// In en, this message translates to:
  /// **'Liked'**
  String get liked;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @myAwesomePlaylist.
  ///
  /// In en, this message translates to:
  /// **'My awesome playlist'**
  String get myAwesomePlaylist;

  /// No description provided for @nameNewPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Name a new playlist'**
  String get nameNewPlaylist;

  /// No description provided for @noAlbums.
  ///
  /// In en, this message translates to:
  /// **'No albums found'**
  String get noAlbums;

  /// No description provided for @noArtists.
  ///
  /// In en, this message translates to:
  /// **'No artists found'**
  String get noArtists;

  /// No description provided for @noFavYet.
  ///
  /// In en, this message translates to:
  /// **'No favourites yet, add something from library'**
  String get noFavYet;

  /// No description provided for @noPlaylists.
  ///
  /// In en, this message translates to:
  /// **'No playlists found'**
  String get noPlaylists;

  /// No description provided for @nothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get nothingFound;

  /// No description provided for @nothingIsPlaying.
  ///
  /// In en, this message translates to:
  /// **'Nothing is playing'**
  String get nothingIsPlaying;

  /// No description provided for @noTracks.
  ///
  /// In en, this message translates to:
  /// **'No tracks found'**
  String get noTracks;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Open app settings'**
  String get openAppSettings;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @playback.
  ///
  /// In en, this message translates to:
  /// **'Playback'**
  String get playback;

  /// No description provided for @playlingQueue.
  ///
  /// In en, this message translates to:
  /// **'Playing queue'**
  String get playlingQueue;

  /// No description provided for @playlist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get playlist;

  /// No description provided for @playlistDeleted.
  ///
  /// In en, this message translates to:
  /// **'Playlist deleted'**
  String get playlistDeleted;

  /// No description provided for @playlists.
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get playlists;

  /// No description provided for @playOnAppStart.
  ///
  /// In en, this message translates to:
  /// **'Start playing on app startup'**
  String get playOnAppStart;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @recentSearch.
  ///
  /// In en, this message translates to:
  /// **'Recent search'**
  String get recentSearch;

  /// No description provided for @reduceApplicationAnimations.
  ///
  /// In en, this message translates to:
  /// **'Reduce application animations'**
  String get reduceApplicationAnimations;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removedFrom.
  ///
  /// In en, this message translates to:
  /// **'Removed from {name}'**
  String removedFrom(String name);

  /// No description provided for @removeFromFavourites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favourites'**
  String get removeFromFavourites;

  /// No description provided for @removeFromPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Remove from playlist'**
  String get removeFromPlaylist;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @renamePlaylist.
  ///
  /// In en, this message translates to:
  /// **'Rename playlist'**
  String get renamePlaylist;

  /// No description provided for @resumePlaybackOn.
  ///
  /// In en, this message translates to:
  /// **'Resume playback from last track'**
  String get resumePlaybackOn;

  /// No description provided for @retip.
  ///
  /// In en, this message translates to:
  /// **'Retip'**
  String get retip;

  /// No description provided for @retipDescription.
  ///
  /// In en, this message translates to:
  /// **'Retip is a beautiful and intuitive music player built using the Flutter. It provides a seamless and immersive experience for music enthusiasts, allowing them to enjoy their favorite tracks with ease.'**
  String get retipDescription;

  /// No description provided for @retipMotto.
  ///
  /// In en, this message translates to:
  /// **'If you think that in the era of streaming, the art of offline listening to music has not disappeared. It\'s a sure sign that you need a RETIP!'**
  String get retipMotto;

  /// No description provided for @retipMusicPlayer.
  ///
  /// In en, this message translates to:
  /// **'Retip Music Player'**
  String get retipMusicPlayer;

  /// No description provided for @scanForMusicDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan for music files on your device and add them to the library'**
  String get scanForMusicDescription;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchForMusic.
  ///
  /// In en, this message translates to:
  /// **'Search for music...'**
  String get searchForMusic;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @showAlbumArtist.
  ///
  /// In en, this message translates to:
  /// **'Show album artist'**
  String get showAlbumArtist;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get showAll;

  /// No description provided for @showArtist.
  ///
  /// In en, this message translates to:
  /// **'Show artist'**
  String get showArtist;

  /// No description provided for @shuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffle;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @somethingGotWrong.
  ///
  /// In en, this message translates to:
  /// **'Something got wrong'**
  String get somethingGotWrong;

  /// No description provided for @sortAlphabetically.
  ///
  /// In en, this message translates to:
  /// **'Sort alphabetically'**
  String get sortAlphabetically;

  /// No description provided for @sortByIndex.
  ///
  /// In en, this message translates to:
  /// **'Sort by index'**
  String get sortByIndex;

  /// No description provided for @storagePermission.
  ///
  /// In en, this message translates to:
  /// **'Storage access'**
  String get storagePermission;

  /// No description provided for @suggestedAlbums.
  ///
  /// In en, this message translates to:
  /// **'Albums for you'**
  String get suggestedAlbums;

  /// No description provided for @suggestedArtists.
  ///
  /// In en, this message translates to:
  /// **'Artists for you'**
  String get suggestedArtists;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get termsAndConditions;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get themeMode;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @track.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get track;

  /// No description provided for @tracks.
  ///
  /// In en, this message translates to:
  /// **'Tracks'**
  String get tracks;

  /// No description provided for @tracksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No tracks} one{1 Track} other{{count} Tracks}}'**
  String tracksCount(int count);

  /// No description provided for @unknownAlbum.
  ///
  /// In en, this message translates to:
  /// **'Unknown Album'**
  String get unknownAlbum;

  /// No description provided for @unknownArtist.
  ///
  /// In en, this message translates to:
  /// **'Unknown Artist'**
  String get unknownArtist;

  /// No description provided for @unknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Unknown Title'**
  String get unknownTitle;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @viewAlbum.
  ///
  /// In en, this message translates to:
  /// **'View album'**
  String get viewAlbum;
}

class _RetipL10nDelegate extends LocalizationsDelegate<RetipL10n> {
  const _RetipL10nDelegate();

  @override
  Future<RetipL10n> load(Locale locale) {
    return SynchronousFuture<RetipL10n>(lookupRetipL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_RetipL10nDelegate old) => false;
}

RetipL10n lookupRetipL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return RetipL10nEn();
    case 'pl':
      return RetipL10nPl();
  }

  throw FlutterError(
      'RetipL10n.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
