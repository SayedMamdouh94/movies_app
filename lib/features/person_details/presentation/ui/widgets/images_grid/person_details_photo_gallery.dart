import 'package:flutter/material.dart';
import 'package:movies_app/core/networking/tmdb_api_constants.dart';
import 'package:movies_app/core/services/image_save_service.dart';
import 'package:movies_app/core/widgets/custom_image.dart';
import 'package:movies_app/core/widgets/custom_scaffold.dart';
import 'package:movies_app/features/person_details/data/models/person_images_response_model.dart';

class PersonDetailsPhotoGallery extends StatefulWidget {
  const PersonDetailsPhotoGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<PersonImageModel> images;
  final int initialIndex;

  @override
  State<PersonDetailsPhotoGallery> createState() =>
      _PersonDetailsPhotoGalleryState();
}

class _PersonDetailsPhotoGalleryState extends State<PersonDetailsPhotoGallery> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _saveCurrentImage() {
    final currentImage = widget.images[_currentIndex];
    final imageUrl = TmdbApiConstants.getImageUrl(
      currentImage.filePath,
      size: 'original',
    );

    ImageSaveService.saveImageFromUrl(imageUrl: imageUrl, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Image View',
      actions: [
        IconButton(
          onPressed: () => _saveCurrentImage(),
          icon: const Icon(Icons.download),
          tooltip: 'Save Image',
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: PersonDetailsPhotoGalleryBody(
              images: widget.images,
              pageController: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PersonDetailsPhotoGalleryBody extends StatelessWidget {
  const PersonDetailsPhotoGalleryBody({
    super.key,
    required this.images,
    required this.pageController,
    this.onPageChanged,
  });

  final List<PersonImageModel> images;
  final PageController pageController;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return PersonDetailsPhotoGalleryItem(image: images[index]);
      },
    );
  }
}

class PersonDetailsPhotoGalleryItem extends StatelessWidget {
  const PersonDetailsPhotoGalleryItem({super.key, required this.image});

  final PersonImageModel image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 3.0,
        child: CustomImage(
          imageUrl: TmdbApiConstants.getImageUrl(
            image.filePath,
            size: 'original',
          ),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
          radius: 0,
        ),
      ),
    );
  }
}
