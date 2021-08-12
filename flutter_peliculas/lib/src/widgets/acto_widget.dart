import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/pages/tramites/noposeerbien_page.dart';
import 'package:playas/src/routes/rpm_application.dart';

class ActoCard extends StatelessWidget {
  final List<Acto>? actos;

  ActoCard({@required this.actos});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: 400,
      padding: EdgeInsets.only(top: 20.0),
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        pagination: SwiperPagination(
            margin: EdgeInsets.all(5.0),
            builder: DotSwiperPaginationBuilder(
                color: Colors.grey, activeColor: Colors.lightBlue)),
        layout: SwiperLayout.DEFAULT,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.6,
        itemBuilder: (BuildContext context, int index) {
          Acto acto = actos![index];

          return GestureDetector(
              onTap: () {
                switch (acto.abrv) {
                  case 'CERT-NO':
                    RpmApplication.router
                        .navigateTo(context, NoposeerBienPage.route);
                    break;
                }
              },
              child: Container(
                height: 100,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: acto.urlImage != null
                              ? FadeInImage(
                                  image: NetworkImage(acto.urlImage!),
                                  placeholder:
                                      AssetImage('assets/images/no-image.jpg'),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/no-image.jpg',
                                        fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.cover,
                                )
                              : Image.asset('assets/images/no-image.jpg',
                                  fit: BoxFit.cover)),
                    ),
                    Container(
                      child: Text(acto.acto!),
                    ),
                  ],
                ),
              ));
        },
        itemCount: actos!.length,
      ),
    );
  }
}
