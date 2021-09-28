import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/pages/tramites/inscripciones_page.dart';
import 'package:playas/src/pages/tramites/mercantil_page.dart';
import 'package:playas/src/pages/tramites/noposeerbien_page.dart';
import 'package:playas/src/pages/tramites/personal_page.dart';
import 'package:playas/src/pages/tramites/propiedad_page.dart';
import 'package:vrouter/vrouter.dart';

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
        indicatorLayout: PageIndicatorLayout.SCALE,
        control: SwiperControl(),
        fade: 1.0,
        loop: true,
        itemWidth: _screenSize.width,
        itemHeight: _screenSize.height,
        itemCount: actos!.length,
        //autoplay: true,
        //autoplayDelay: 1000,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          Acto acto = actos![index];

          return GestureDetector(
              onTap: () {
                switch (acto.abrv) {
                  case 'CERT-NO':
                    context.vRouter.to(NoposeerBienPage.route);
                    break;
                  case 'CERT-HIST':
                    context.vRouter.to(PropiedadPage.route);
                    break;
                  case 'INS':
                    context.vRouter.to(InscripcionesPage.route);
                    break;
                  case 'CERT-PERS':
                    context.vRouter.to(PersonalPage.route);
                    break;
                  case 'CERT-MERC':
                    context.vRouter.to(MercantilPage.route);
                    break;
                }
              },
              child: Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        acto.acto!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
