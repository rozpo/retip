import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/presentation/widgets/atoms/rp_icon.dart';
import 'package:retip/app/presentation/widgets/atoms/single_line_text.dart';
import 'package:retip/app/presentation/widgets/atoms/spacer.dart';
import 'package:retip/app/presentation/widgets/molecules/more_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_divider.dart';
import 'package:retip/core/extensions/duration_extension.dart';
import 'package:retip/core/extensions/int_extension.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/utils/sizer.dart';

class FileDetailsTile extends StatelessWidget {
  final TrackEntity track;

  const FileDetailsTile({required this.track, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.info,
      text: l10n.fileDetails,
      onTap: () {
        Navigator.of(context).pop();
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          context: RetipRouter.rootNavKey.currentContext ?? context,
          builder: (context) {
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: Sizer.x1),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const RpIcon(icon: Icons.info),
                    title: SingleLineText(l10n.fileDetails),
                  ),
                  const RpDivider(),
                  const VerticalSpacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                    child: Row(
                      children: [
                        SingleLineText(
                          '${l10n.title} - ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SingleLineText(track.title),
                      ],
                    ),
                  ),
                  const VerticalSpacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                    child: Row(
                      children: [
                        SingleLineText(
                          '${l10n.album} - ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SingleLineText(track.album),
                      ],
                    ),
                  ),
                  const VerticalSpacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                    child: Row(
                      children: [
                        SingleLineText(
                          '${l10n.artist} - ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SingleLineText(track.artist),
                      ],
                    ),
                  ),
                  if (track.composer != null) ...[
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Row(
                        children: [
                          SingleLineText(
                            '${l10n.composer} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SingleLineText(track.composer!),
                        ],
                      ),
                    ),
                  ],
                  if (track.genre != null) ...[
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Row(
                        children: [
                          SingleLineText(
                            '${l10n.genre} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SingleLineText(track.genre!),
                        ],
                      ),
                    ),
                  ],
                  const VerticalSpacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                    child: Row(
                      children: [
                        SingleLineText(
                          '${l10n.duration} - ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SingleLineText(track.duration.text),
                      ],
                    ),
                  ),
                  const VerticalSpacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                    child: Row(
                      children: [
                        SingleLineText(
                          '${l10n.size} - ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SingleLineText(track.size.size),
                      ],
                    ),
                  ),
                  if (track.dateAdded != null) ...[
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Row(
                        children: [
                          SingleLineText(
                            '${l10n.dateAdded} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(track.dateAdded!),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (track.dateModified != null) ...[
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Row(
                        children: [
                          SingleLineText(
                            '${l10n.dateModified} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(track.dateModified!),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const VerticalSpacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: '${l10n.location} - ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: track.fileLocation),
                        ],
                      ),
                    ),
                  ),
                  if (kReleaseMode == false) ...[
                    const VerticalSpacer(),
                    ListTile(
                      leading: const RpIcon(icon: Icons.developer_board),
                      title: SingleLineText(l10n.developer),
                    ),
                    const RpDivider(),
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Text('isAlarm: ${track.isAlarm}'),
                    ),
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Text('isAudioBook: ${track.isAudioBook}'),
                    ),
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Text('isFavourite: ${track.isFavourite}'),
                    ),
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Text('isMusic: ${track.isMusic}'),
                    ),
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Text('isNotification: ${track.isNotification}'),
                    ),
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Text('isPodcast: ${track.isPodcast}'),
                    ),
                    const VerticalSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                      child: Text('isRingtone: ${track.isRingtone}'),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
