import 'package:flutter/material.dart';
import 'package:playas/src/models/acto.dart';

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
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: actos!.length,
          itemBuilder: (context, index) {
            Acto acto = actos![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  child: acto.urlImage != null
                      ? FadeInImage(
                          height: 150,
                          image: NetworkImage(actos![index].urlImage!),
                          placeholder: AssetImage('assets/images/no-image.jpg'),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/no-image.jpg',
                                fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/no-image.jpg',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
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
