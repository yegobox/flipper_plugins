import 'package:flipper_dashboard/payable_view.dart';
import 'package:flutter/material.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flipper/routes.router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductButtons extends StatelessWidget {
  const AddProductButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
      child: Container(
        width: double.infinity,
        height: 200.h,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 60.h,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: FlatButton(
                    color: Theme.of(context)
                        .copyWith(canvasColor: HexColor('#0097e6'))
                        .canvasColor,
                    onPressed: () async {
                      ProxyService.nav.navigateTo(Routes.product);
                    },
                    child: Text(
                      'Add Product',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Container(
                  color: Colors.white70,
                  width: double.infinity,
                  height: 60.h,
                  child: OutlineButton(
                    onPressed: () {},
                    child: const Text('Create Discount'),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60.h,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: FlatButton(
                    child: const Text('Dismiss'),
                    onPressed: () {
                      ProxyService.nav.back();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
