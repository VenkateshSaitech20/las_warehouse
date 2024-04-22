import 'package:flutter/material.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ZoomImage extends StatefulWidget {
  final largeImage;

  const ZoomImage(this.largeImage, {super.key});

  @override
  State<ZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  PageController _pageController = PageController();

  int pageIndex = 0;

  onPageChanged(index) {
    pageIndex = index;
    print('Index : $index');
  }

  @override
  Widget build(BuildContext context) {
    print('widget.largeImage.length  ${widget.largeImage.length}');
    return Scaffold(
      backgroundColor: MyColors.primaryblue,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.close,
          color: Colors.red,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                widget.largeImage.length == 129
                    ? Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: PhotoViewGallery(
                              backgroundDecoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              pageOptions: <PhotoViewGalleryPageOptions>[
                                PhotoViewGalleryPageOptions(
                                  imageProvider: NetworkImage(
                                    widget.largeImage.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            PhotoViewGallery.builder(
                              backgroundDecoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              scrollPhysics: const BouncingScrollPhysics(),
                              builder: (BuildContext context, pageIndex) {
                                return PhotoViewGalleryPageOptions(
                                  imageProvider: NetworkImage(
                                    widget.largeImage[pageIndex]!,
                                  ),
                                  // initialScale: PhotoViewComputedScale.contained,
                                  // heroAttributes: PhotoViewHeroAttributes(
                                  //     tag: largeImage[pageIndex].imgId!),
                                );
                              },
                              itemCount: widget.largeImage.length,
                              loadingBuilder: (context, event) => Center(
                                child: SizedBox(
                                  width: 30.0,
                                  height: 30.0,
                                  child: CircularProgressIndicator(
                                    value: event == null
                                        ? 0
                                        : event.cumulativeBytesLoaded /
                                            event.expectedTotalBytes!,
                                  ),
                                ),
                              ),
                              // backgroundDecoration: widget.backgroundDecoration,
                              pageController: _pageController,
                              onPageChanged: onPageChanged(pageIndex),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 40,
                                        color: pageIndex == 0
                                            ? MyColors.grey
                                            : MyColors.primaryblue,
                                      ),
                                      onPressed: () {
                                        if (pageIndex > 0) {
                                          setState(() {
                                            pageIndex--;
                                            onPageChanged(pageIndex);
                                            _pageController.animateToPage(
                                              pageIndex,
                                              duration: const Duration(
                                                milliseconds: 500,
                                              ),
                                              curve: Curves.ease,
                                            );
                                          });
                                          // print('pageIndex : $pageIndex');
                                        }
                                      },
                                    ),
                                    const Expanded(
                                      child: SizedBox(width: 20),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 40,
                                        color: pageIndex ==
                                                widget.largeImage.length
                                            ? MyColors.grey
                                            : MyColors.primaryblue,
                                      ),
                                      onPressed: () {
                                        if (pageIndex <
                                            widget.largeImage.length) {
                                          setState(() {
                                            pageIndex++;
                                            onPageChanged(pageIndex);
                                            print(
                                              'pageIndex : $pageIndex',
                                            );
                                            _pageController.animateToPage(
                                              pageIndex,
                                              duration: const Duration(
                                                milliseconds: 500,
                                              ),
                                              curve: Curves.ease,
                                            );
                                          });
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
