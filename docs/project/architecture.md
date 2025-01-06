# Retip Architecture

Document presenting the app architecture divided by core and app 

## Core

Every basic functionality of the app.

- constants
    - assets_constants.dart
    - layout_constants.dart
- enums
- envs
- extensions
    - color_extension.dart
    - duration_extension.dart
    - int_extension.dart
    - sting_extension.dart
- l10n
    - retip_l10n.dart
- router
    - retip_router.dart
- theme
    - retip_theme.dart
- utils
    - debouncer.dart
    - sizer.dart
    - utils.dart

## Application

- data
    - models
        - album_model.dart
        - artist_model.dart
        - genre_model.dart
        - playlist_model.dart
        - track_model.dart
    - providers
        - just_audio_provider.dart
        - discogs_api_provider.dart
        - lastfm_api_provider.dart
        - musicbrainz_api_provider.dart
        - objectbox_provider.dart
        - on_audio_query_provider.dart
        - shared_preferences_provider.dart
    - repositories
        - audio_repository_implementation.dart
        - library_repository_implementation.dart
        - playlist_repository_implementation.dart
        - settings_repository_implementation.dart
- domain
    - cases
    - entities
        - album_entity.dart
        - artist_entity.dart
        - genre_entity.dart
        - playlist_entity.dart
        - track_entity.dart
    - repositories
        - audio_repository.dart
        - library_repository.dart
        - playlist_repository.dart
        - settings_repository.dart
- presentation
    - pages
        - album
        - artist
        - dev
        - genre
        - intro
        - home
        - playlist
        - settings
    - views
        - albums
        - artists
        - genres
        - library
        - player
        - playlists
        - search
        - tracks
    - widgets
        - buttons