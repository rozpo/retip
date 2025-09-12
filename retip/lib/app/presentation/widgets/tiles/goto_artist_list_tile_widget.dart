import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/cards/leading_list_tile_card_widget.dart';
import 'package:retip/app/presentation/widgets/texts/single_line_text_widget.dart';
import 'package:retip/core/router/retip_route.dart';

class GotoArtistListTileWidget extends StatelessWidget {
  final int id;

  const GotoArtistListTileWidget(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineTextWidget('Go to Artist'),
      leading: LeadingListTileCardWidget(Icons.person),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.pop(context);
        RetipRoute.artist.push(context, pathParameters: {'id': id.toString()});
      },
    );
  }
}
