// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get allow => 'Allow';

  @override
  String get album => 'Album';

  @override
  String get artist => 'Artist';

  @override
  String get cancel => 'Cancel';

  @override
  String get favourites => 'Favourites';

  @override
  String get grantPermission =>
      'Grant permission to access storage for a seamless music playback experience';

  @override
  String get home => 'Home';

  @override
  String get library => 'Library';

  @override
  String get openAppSettings => 'Open app settings';

  @override
  String get remove => 'Remove';

  @override
  String get retip => 'Retip';

  @override
  String get retipMusicPlayer => 'Retip Music Player';

  @override
  String get retipDescription =>
      'Retip is a beautiful and intuitive music player built using the Flutter. It provides a seamless and immersive experience for music enthusiasts, allowing them to enjoy their favorite tracks with ease.';

  @override
  String get retipMotto =>
      'If you think that in the era of streaming, the art of offline listening to music has not disappeared. It\'s a sure sign that you need a RETIP!';

  @override
  String get search => 'Search';

  @override
  String get searchForMusic => 'Search for music...';

  @override
  String get storagePermission => 'Storage access';

  @override
  String get track => 'Track';

  @override
  String get unknownTitle => 'Unknown Title';

  @override
  String get unknownAlbum => 'Unknown Album';

  @override
  String get unknownArtist => 'Unknown Artist';

  @override
  String get alertRemoveFromFavTitle => 'Remove from favourites';

  @override
  String get alertRemoveFromFavMsg =>
      'Are you sure to remove a track from favourites list?';

  @override
  String get albums => 'Albums';

  @override
  String get artists => 'Artists';

  @override
  String get tracks => 'Tracks';

  @override
  String get noAlbums => 'No albums found';

  @override
  String get noArtists => 'No artists found';

  @override
  String get noTracks => 'No tracks found';

  @override
  String get noPlaylists => 'No playlists found';

  @override
  String get addToTheFavourites => 'Add to the favourites';

  @override
  String get addToTheQueue => 'Add to the queue';

  @override
  String get addToThePlaylist => 'Add to the playlist';

  @override
  String get showAlbumArtist => 'Show album artist';

  @override
  String get showArtist => 'Show artist';

  @override
  String get viewAlbum => 'View album';

  @override
  String get sortAlphabetically => 'Sort alphabetically';

  @override
  String get sortByIndex => 'Sort by index';

  @override
  String get duration => 'Duration';

  @override
  String addedTo(String name) {
    return 'Added to $name';
  }

  @override
  String removedFrom(String name) {
    return 'Removed from $name';
  }

  @override
  String get play => 'Play';

  @override
  String get shuffle => 'Shuffle';

  @override
  String get addToFavourites => 'Add to favourites';

  @override
  String get removeFromFavourites => 'Remove from favourites';

  @override
  String get goToArtist => 'Go to artist';

  @override
  String get goToAlbum => 'Go to album';

  @override
  String get addToPlaylist => 'Add to playlist';

  @override
  String albumsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Albums',
      one: '1 Album',
      zero: 'No albums',
    );
    return '$_temp0';
  }

  @override
  String tracksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tracks',
      one: '1 Track',
      zero: 'No tracks',
    );
    return '$_temp0';
  }

  @override
  String get recentSearch => 'Recent search';

  @override
  String get playlist => 'Playlist';

  @override
  String get playlists => 'Playlists';

  @override
  String get explore => 'Explore';

  @override
  String get deletePlaylist => 'Delete playlist';

  @override
  String get renamePlaylist => 'Rename playlist';

  @override
  String get playlistDeleted => 'Playlist deleted';

  @override
  String get removeFromPlaylist => 'Remove from playlist';

  @override
  String get suggestedArtists => 'Artists for you';

  @override
  String get suggestedAlbums => 'Albums for you';

  @override
  String get somethingGotWrong => 'Something got wrong';

  @override
  String get settings => 'Settings';

  @override
  String get developer => 'Developer';

  @override
  String get info => 'Info';

  @override
  String get version => 'Version';

  @override
  String get liked => 'Liked';

  @override
  String get noFavYet => 'No favourites yet, add something from library';

  @override
  String get createNewPlaylist => 'Create new playlist';

  @override
  String get create => 'Create';

  @override
  String get rename => 'Rename';

  @override
  String get nameNewPlaylist => 'Name a new playlist';

  @override
  String get playlingQueue => 'Playing queue';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get checkForUpdate => 'Check for update';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get termsAndConditions => 'Terms and conditions';

  @override
  String get legalese => 'Copyright (c) 2024 Piotr Rozpończyk';

  @override
  String get licenses => 'Licenses';

  @override
  String get aboutApp => 'About application';

  @override
  String get appearance => 'Appearance';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get batterySaver => 'Battery saver';

  @override
  String get reduceApplicationAnimations => 'Reduce application animations';

  @override
  String get developerMenu => 'Developer menu';

  @override
  String get playback => 'Playback';

  @override
  String get autoplay => 'Autoplay';

  @override
  String get crossfade => 'Crossfade';

  @override
  String get equalizer => 'Equalizer';

  @override
  String get themeMode => 'Theme mode';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get on => 'On';

  @override
  String get off => 'Off';

  @override
  String get nothingIsPlaying => 'Nothing is playing';

  @override
  String get fileDetails => 'File details';

  @override
  String get title => 'Title';

  @override
  String get location => 'Location';

  @override
  String get genre => 'Genre';

  @override
  String get composer => 'Composer';

  @override
  String get dateAdded => 'Date added';

  @override
  String get dateModified => 'Date modified';

  @override
  String get size => 'Size';

  @override
  String get gridView => 'Grid view';

  @override
  String columnsCount(int count) {
    return 'Display $count columns';
  }

  @override
  String get generatedPlaylist => 'Generated playlist';

  @override
  String get showAll => 'Show all';

  @override
  String get keepPlayback => 'Keep playing queue';

  @override
  String get playOnAppStart => 'Start playing on app startup';

  @override
  String get resumePlaybackOn => 'Resume playback from last track';

  @override
  String get areYouSure => 'Are you sure? This action can\'t be undone';

  @override
  String get delete => 'Delete';

  @override
  String get myAwesomePlaylist => 'My awesome playlist';

  @override
  String get libraryScan => 'Library scan';

  @override
  String get scanForMusicDescription =>
      'Scan for music files on your device and add them to the library';
}
