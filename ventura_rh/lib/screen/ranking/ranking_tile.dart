import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'file:///D:/2020.3/Projeto%20de%20Bloco%20-%20Engenharia%20Disciplinada%20de%20Softwares/Projetos/VenturaHR/ventura_rh/lib/models/users/user_hr.dart';

class RankingTile extends StatelessWidget {
  final UserHR userHR;

  const RankingTile({Key key, this.userHR}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(16.0, 33.0),
          child: Container(
            width: 384.0,
            height: 141.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(5, 6),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(26.0, 39.0),
          child: GestureDetector(
            onTap: () => userHR.images.first,
            child: SizedBox(
              width: 129.0,
              height: 129.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 129.0, 129.0),
                    size: Size(129.0, 129.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(-26.0, 0.0, 189.0, 129.0),
                          size: Size(129.0, 129.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                          // Adobe XD layer: 'carol-pires-candida…' (shape)
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const AssetImage(''),
                                fit: BoxFit.fill,
                              ),
                              border: Border.all(
                                  width: 1.0, color: const Color(0xff707070)),
                            ),
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 129.0, 129.0),
                          size: Size(129.0, 129.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                          // Adobe XD layer: 'CIRCLO' (shape)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              color: const Color(0xffffffff),
                              border: Border.all(
                                  width: 1.0, color: const Color(0xff4b4d4d)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(5, 10),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(170.0, 39.0),
          child: GestureDetector(
            onTap: () => userHR.name,
            child: SizedBox(
              width: 188.0,
              height: 75.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 55.0, 125.0, 20.0),
                    size: Size(188.0, 75.0),
                    pinLeft: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Manoelita Romao',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        height: 8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(1.0, 0.0, 35.0, 20.0),
                    size: Size(188.0, 75.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Vaga',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        height: 8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 24.0, 162.0, 20.0),
                    size: Size(188.0, 75.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Text(
                      'Desenvolvedor Front End',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w300,
                        height: 8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(149.0, 55.0, 39.0, 20.0),
                    size: Size(188.0, 75.0),
                    pinRight: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Score',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        height: 8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(305.0, 123.0),
          child: GestureDetector(
            onTap: () => userHR.score,
            child: SizedBox(
              width: 70.0,
              height: 37.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 70.0, 33.0),
                    size: Size(70.0, 37.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                    // Adobe XD layer: 'score' (shape)
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(''),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(25.0, 17.0, 23.0, 20.0),
                    size: Size(70.0, 37.0),
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      '4.5',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w900,
                        height: 8,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
