/*
 * Copyright (C) 2020. by perol_notsf, All rights reserved
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixez/models/novel_recom_response.dart';
import 'package:pixez/network/api_client.dart';

class NovelBookmarkButton extends StatefulWidget {
  final Novel novel;

  const NovelBookmarkButton({Key key, @required this.novel}) : super(key: key);

  @override
  _NovelBookmarkButtonState createState() => _NovelBookmarkButtonState();
}

class _NovelBookmarkButtonState extends State<NovelBookmarkButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        ApiClient client = RepositoryProvider.of<ApiClient>(context);
        if (!widget.novel.isBookmarked) {
          try {
            await client.postNovelBookmarkAdd(widget.novel.id, "private");
            setState(() {
              widget.novel.isBookmarked = true;
            });
          } catch (e) {}
        } else {
          try {
            await client.postNovelBookmarkDelete(widget.novel.id);
            setState(() {
              widget.novel.isBookmarked = false;
            });
          } catch (e) {}
        }
      },
      child: IconButton(
        icon: widget.novel.isBookmarked
            ? Icon(Icons.bookmark)
            : Icon(Icons.bookmark_border),
        onPressed: () async {
          ApiClient client = RepositoryProvider.of<ApiClient>(context);
          if (!widget.novel.isBookmarked) {
            try {
              await client.postNovelBookmarkAdd(widget.novel.id, "public");
              setState(() {
                widget.novel.isBookmarked = true;
              });
            } catch (e) {}
          } else {
            try {
              await client.postNovelBookmarkDelete(widget.novel.id);
              setState(() {
                widget.novel.isBookmarked = false;
              });
            } catch (e) {}
          }
        },
      ),
    );
  }
}
