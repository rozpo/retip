// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'app/data/models/objectbox_track.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 8628733266468732975),
      name: 'ObjectboxTrack',
      lastPropertyId: const obx_int.IdUid(5, 7910679191234761431),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 4829770760447059960),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4091894946750053941),
            name: 'artist',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 6559330446911807740),
            name: 'album',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 1307712285081220774),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 7910679191234761431),
            name: 'location',
            type: 9,
            flags: 2080,
            indexId: const obx_int.IdUid(1, 6554449802220389109))
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(1, 8628733266468732975),
      lastIndexId: const obx_int.IdUid(1, 6554449802220389109),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    ObjectboxTrack: obx_int.EntityDefinition<ObjectboxTrack>(
        model: _entities[0],
        toOneRelations: (ObjectboxTrack object) => [],
        toManyRelations: (ObjectboxTrack object) => {},
        getId: (ObjectboxTrack object) => object.id,
        setId: (ObjectboxTrack object, int id) {
          object.id = id;
        },
        objectToFB: (ObjectboxTrack object, fb.Builder fbb) {
          final artistOffset = fbb.writeString(object.artist);
          final albumOffset = fbb.writeString(object.album);
          final titleOffset = fbb.writeString(object.title);
          final locationOffset = fbb.writeString(object.location);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, artistOffset);
          fbb.addOffset(2, albumOffset);
          fbb.addOffset(3, titleOffset);
          fbb.addOffset(4, locationOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final artistParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final albumParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final locationParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final object = ObjectboxTrack(
              id: idParam,
              artist: artistParam,
              album: albumParam,
              title: titleParam,
              location: locationParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [ObjectboxTrack] entity fields to define ObjectBox queries.
class ObjectboxTrack_ {
  /// See [ObjectboxTrack.id].
  static final id =
      obx.QueryIntegerProperty<ObjectboxTrack>(_entities[0].properties[0]);

  /// See [ObjectboxTrack.artist].
  static final artist =
      obx.QueryStringProperty<ObjectboxTrack>(_entities[0].properties[1]);

  /// See [ObjectboxTrack.album].
  static final album =
      obx.QueryStringProperty<ObjectboxTrack>(_entities[0].properties[2]);

  /// See [ObjectboxTrack.title].
  static final title =
      obx.QueryStringProperty<ObjectboxTrack>(_entities[0].properties[3]);

  /// See [ObjectboxTrack.location].
  static final location =
      obx.QueryStringProperty<ObjectboxTrack>(_entities[0].properties[4]);
}
