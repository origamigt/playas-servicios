import 'package:flutter/material.dart';
import 'package:playas/src/models/acto.dart';
import 'package:responsive_property/responsive_property.dart';

class TramitesCard extends StatelessWidget {
  final List<Acto>? actos;

  TramitesCard({@required this.actos});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive({
              mobileScreenScope: 2,
              tabletScreenScope: 2,
              desktopScreenScope: 2
            }).resolve(context)!,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.4),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: actos!.length,
          itemBuilder: (context, index) {
            Acto acto = actos![index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: acto.urlImage != null
                      ? FadeInImage(
                          image: NetworkImage(actos![index].urlImage!),
                          placeholder: AssetImage('assets/images/no-image.jpg'),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/no-image.jpg',
                                fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/images/no-image.jpg',
                          fit: BoxFit.cover),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0, left: 10),
                  width: 150,
                  child: Text(
                    acto.acto!,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                )
              ],
            );
          },
        ));
  }
}
