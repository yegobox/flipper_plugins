import 'package:flipper/routes.router.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flutter/material.dart';
import 'package:flipper_models/product.dart';

class SectionSelectUnit extends StatelessWidget {
  const SectionSelectUnit({Key? key, required this.product, required this.type})
      : super(key: key);
  final Product product;
  final String type;
  Text unitSelector(Product units) {
    late Text text = Text('Select Unit');

    if (product.unit != '') {
      text = Text(product.unit);
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Container(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            ProxyService.nav.navigateTo(Routes.units,
                arguments: ListUnitsArguments(type: type));
          },
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.4),
            dense: true,
            leading: const Text('Unit Type'),
            trailing: Wrap(
              children: [
                unitSelector(product),
                Theme(
                  data: ThemeData(
                    iconTheme: const IconThemeData(
                      color: Colors.black,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
