// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'retip_l10n.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class RetipL10nPl extends RetipL10n {
  RetipL10nPl([String locale = 'pl']) : super(locale);

  @override
  String get aboutApp => 'O aplikacji';

  @override
  String addedTo(String name) {
    return 'Dodano do $name';
  }

  @override
  String get addToFavourites => 'Dodaj do ulubionych';

  @override
  String get addToPlaylist => 'Dodaj do playlisty';

  @override
  String get addToTheFavourites => 'Dodaj do ulubionych';

  @override
  String get addToThePlaylist => 'Dodaj do playlisty';

  @override
  String get addToTheQueue => 'Dodaj do kolejki';

  @override
  String get album => 'Album';

  @override
  String get albums => 'Albumy';

  @override
  String albumsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Albumy',
      one: '1 Album',
      zero: 'Brak albumów',
    );
    return '$_temp0';
  }

  @override
  String get alertRemoveFromFavMsg =>
      'Czy na pewno chcesz usunąć utwór z listy ulubionych?';

  @override
  String get alertRemoveFromFavTitle => 'Usuń z ulubionych';

  @override
  String get allow => 'Zezwalaj';

  @override
  String get appearance => 'Wygląd';

  @override
  String get areYouSure => 'Czy na pewno? Tej akcji nie można cofnąć';

  @override
  String get artist => 'Artysta';

  @override
  String get artists => 'Artyści';

  @override
  String get autoplay => 'Automatyczne odtwarzanie';

  @override
  String get batterySaver => 'Tryb oszczędzania baterii';

  @override
  String get cancel => 'Anuluj';

  @override
  String get checkForUpdate => 'Sprawdź aktualizacje';

  @override
  String columnsCount(int count) {
    return 'Wyświetlaj $count kolumny';
  }

  @override
  String get composer => 'Kompozytor';

  @override
  String get create => 'Utwórz';

  @override
  String get createNewPlaylist => 'Utwórz nową playlistę';

  @override
  String get crossfade => 'Miksowanie';

  @override
  String get dark => 'Ciemny';

  @override
  String get darkMode => 'Tryb ciemny';

  @override
  String get dateAdded => 'Data dodania';

  @override
  String get dateModified => 'Data modyfikacji';

  @override
  String get delete => 'Usuń';

  @override
  String get deletePlaylist => 'Usuń playlistę';

  @override
  String get developer => 'Deweloper';

  @override
  String get developerMenu => 'Menu programisty';

  @override
  String get duration => 'Czas trwania';

  @override
  String get equalizer => 'Equalizer';

  @override
  String get explore => 'Odkrywaj';

  @override
  String get favourites => 'Ulubione';

  @override
  String get fileDetails => 'Szczegóły pliku';

  @override
  String get generatedPlaylist => 'Wygenerowana playlista';

  @override
  String get genre => 'Gatunek';

  @override
  String get genres => 'Gatunki';

  @override
  String get goToAlbum => 'Przejdź do albumu';

  @override
  String get goToArtist => 'Przejdź do artysty';

  @override
  String get grantPermission =>
      'Udziel zezwolenia na dostęp do pamięci masowej, aby zapewnić płynne odtwarzanie muzyki';

  @override
  String get gridView => 'Widok siatki';

  @override
  String get home => 'Strona główna';

  @override
  String get info => 'Informacje';

  @override
  String get keepPlayback => 'Kontynuuj kolejkę odtwarzania';

  @override
  String get legalese => 'Copyright (c) 2024 Piotr Rozpończyk';

  @override
  String get library => 'Biblioteka';

  @override
  String get libraryScan => 'Skanowanie biblioteki';

  @override
  String get licenses => 'Licencje';

  @override
  String get light => 'Jasny';

  @override
  String get liked => 'Lubię to';

  @override
  String get location => 'Lokalizacja';

  @override
  String get myAwesomePlaylist => 'Moja wspaniała playlista';

  @override
  String get nameNewPlaylist => 'Nadaj nazwę nowej playliście';

  @override
  String get noAlbums => 'Nie znaleziono albumów';

  @override
  String get noArtists => 'Nie znaleziono artystów';

  @override
  String get noFavYet => 'Brak ulubionych, dodaj coś z biblioteki';

  @override
  String get noPlaylists => 'Nie znaleziono playlist';

  @override
  String get nothingFound => 'Nic nie znaleziono';

  @override
  String get nothingIsPlaying => 'Nic nie jest odtwarzane';

  @override
  String get noTracks => 'Nie znaleziono utworów';

  @override
  String get off => 'Wyłączony';

  @override
  String get on => 'Włączony';

  @override
  String get openAppSettings => 'Otwórz ustawienia aplikacji';

  @override
  String get play => 'Odtwórz';

  @override
  String get playback => 'Odtwarzanie';

  @override
  String get playlingQueue => 'Kolejka odtwarzania';

  @override
  String get playlist => 'Playlista';

  @override
  String get playlistDeleted => 'Playlista została usunięta';

  @override
  String get playlists => 'Playlisty';

  @override
  String get playOnAppStart =>
      'Rozpocznij odtwarzanie po uruchomieniu aplikacji';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get recentSearch => 'Ostatnie wyszukiwania';

  @override
  String get reduceApplicationAnimations => 'Zmniejsz animacje aplikacji';

  @override
  String get remove => 'Usuń';

  @override
  String removedFrom(String name) {
    return 'Usunięto z $name';
  }

  @override
  String get removeFromFavourites => 'Usuń z ulubionych';

  @override
  String get removeFromPlaylist => 'Usuń z playlisty';

  @override
  String get rename => 'Zmień nazwę';

  @override
  String get renamePlaylist => 'Zmień nazwę playlisty';

  @override
  String get resumePlaybackOn => 'Wznów odtwarzanie od ostatniego utworu';

  @override
  String get retip => 'Retip';

  @override
  String get retipDescription =>
      'Retip to piękny i intuicyjny odtwarzacz muzyki stworzony przy użyciu Fluttera. Zapewnia płynne i wciągające wrażenia dla miłośników muzyki, umożliwiając łatwe słuchanie ulubionych utworów.';

  @override
  String get retipMotto =>
      'Jeśli uważasz, że w erze streamingu sztuka słuchania muzyki offline nie zniknęła. To pewny znak, że potrzebujesz RETIPa!';

  @override
  String get retipMusicPlayer => 'Odtwarzacz muzyki Retip';

  @override
  String get scanForMusicDescription =>
      'Skanuj pliki muzyczne na urządzeniu i dodaj je do biblioteki';

  @override
  String get search => 'Szukaj';

  @override
  String get searchForMusic => 'Szukaj muzyki...';

  @override
  String get settings => 'Ustawienia';

  @override
  String get showAlbumArtist => 'Pokaż artystę albumu';

  @override
  String get showAll => 'Pokaż wszystko';

  @override
  String get showArtist => 'Pokaż artystę';

  @override
  String get shuffle => 'Losuj';

  @override
  String get size => 'Rozmiar';

  @override
  String get somethingGotWrong => 'Coś poszło nie tak';

  @override
  String get sortAlphabetically => 'Sortuj alfabetycznie';

  @override
  String get sortByIndex => 'Sortuj według indeksu';

  @override
  String get storagePermission => 'Dostęp do pamięci masowej';

  @override
  String get suggestedAlbums => 'Albumy dla Ciebie';

  @override
  String get suggestedArtists => 'Artyści dla Ciebie';

  @override
  String get termsAndConditions => 'Warunki korzystania';

  @override
  String get themeMode => 'Tryb motywu';

  @override
  String get title => 'Tytuł';

  @override
  String get track => 'Utwór';

  @override
  String get tracks => 'Utwory';

  @override
  String tracksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Utwory',
      one: '1 Utwór',
      zero: 'Brak utworów',
    );
    return '$_temp0';
  }

  @override
  String get unknownAlbum => 'Nieznany album';

  @override
  String get unknownArtist => 'Nieznany artysta';

  @override
  String get unknownTitle => 'Nieznany tytuł';

  @override
  String get version => 'Wersja';

  @override
  String get viewAlbum => 'Zobacz album';
}
