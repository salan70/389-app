import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gallery_list_page_controller.g.dart';

@riverpod
GalleryListPageController galleryListPageController(
  GalleryListPageControllerRef ref,
) =>
    GalleryListPageController(ref);

class GalleryListPageController {
  GalleryListPageController(this._ref);

  final Ref _ref;

  
}
