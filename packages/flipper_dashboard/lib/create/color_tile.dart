import 'package:flipper_dashboard/customappbar.dart';
import 'package:flipper_dashboard/payable_view.dart';
import 'package:flutter/material.dart';
import 'package:flipper_models/view_models/product_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flipper_models/color.dart';

import 'list_divider.dart';

class ColorTile extends StatelessWidget {
  ColorTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: CustomAppBar(
            onPop: () {
              ProxyService.nav.back();
            },
            title: 'Edit product Tile',
            icon: Icons.keyboard_backspace,
            multi: 3,
            bottomSpacer: 52,
          ),
          body: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: model.product == null ||
                                      model.product.imageUrl == null
                                  ? TextField(
                                      maxLines: 4,
                                      autofocus: false,
                                      style: const TextStyle(
                                          fontSize: 22.0,
                                          color: Color(0xFFbdc6cf)),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: HexColor(
                                            model.currentColor == null
                                                ? '#0984e3'
                                                : model.currentColor),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : Image.network(
                                      model.product.imageUrl,
                                      frameBuilder: (context, child, frame,
                                          wasSynchronouslyLoaded) {
                                        if (wasSynchronouslyLoaded) {
                                          return child;
                                        }
                                        return AnimatedOpacity(
                                          child: child,
                                          opacity: frame == null ? 0 : 1,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                        );
                                      },
                                    ),
                            ),
                          ),
                          const Text('New Item')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const ListDivider(
                height: 10,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text('CHOOSE LABEL COLOR'),
              ),
              const ListDivider(
                height: 10,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Wrap(
                  children: buildStack(context, model.colors, model),
                ),
              ),
              const ListDivider(
                height: 10,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text('PHOTO LABEL'),
              ),
              const ListDivider(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: OutlineButton(
                        color: HexColor('#ecf0f1'),
                        child: const Text('Choose Photo'),
                        onPressed: () async {
                          model.browsePictureFromGallery(
                              productId: model.product.id);
                        },
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: OutlineButton(
                        color: HexColor('#ecf0f1'),
                        child: const Text('Take Photo'),
                        onPressed: () {
                          model.takePicture(productId: model.product.id);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => ProductViewModel(),
    );
  }

  List<Widget> buildStack(
      BuildContext context, List<PColor> colors, ProductViewModel model) {
    final List<Widget> stacks = [];

    if (colors.isNotEmpty) {
      for (var i = 0; i < colors.length; i++) {
        stacks.add(
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 80,
                width: 120,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: HexColor(colors[i].name!),
                    ),
                  ),
                  color: HexColor(colors[i].name!),
                  child: Text(''),
                  onPressed: () {
                    //reset all other color to not selected
                    model.switchColor(color: colors[i]);
                  },
                ),
              ),
              // FIXME: add checkmark on active color is not working propper.
              colors[i].active
                  ? IconButton(
                      alignment: Alignment.center,
                      icon: const Icon(Icons.check),
                      color: Colors.white,
                      onPressed: () {
                        model.switchColor(color: colors[i]);
                      },
                    )
                  : const Visibility(
                      visible: false,
                      child: SizedBox.shrink(),
                    )
            ],
          ),
        );
      }
    }
    return stacks;
  }
}
