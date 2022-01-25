import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wanderlust_app/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CustomTheme.lightTheme.colorScheme.primary,
                      CustomTheme.lightTheme.colorScheme.primaryVariant,
                    ],
                  ),
                ),
                padding: const EdgeInsets.only(
                    top: 15, left: 30, right: 30.0, bottom: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: <Widget>[
                          Transform.translate(
                            offset: const Offset(0, 6),
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                  sigmaY: 7,
                                  sigmaX: 7,
                                  tileMode: TileMode.decal),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                child: Opacity(
                                  opacity: 0.3,
                                  child: ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black, BlendMode.srcATop),
                                    child: SvgPicture.asset(
                                      'assets/logo.svg',
                                      color: Colors.white,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/logo.svg',
                            color: Colors.white,
                            height: 100,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 150, top: 0),
                        child: Text(
                          "Wanderlust",
                          style: GoogleFonts.montserrat(
                              fontSize: 48,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.6),
                                  offset: const Offset(0, 6),
                                  blurRadius: 16,
                                )
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: CustomTheme
                                    .lightTheme.colorScheme.secondary,
                                padding: const EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text("Sign In")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 50),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                padding: const EdgeInsets.all(20),
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/create_account');
                              },
                              child: const Text("Sign Up")),
                        ),
                      ),
                    ])),
          )
        ],
      ),
    );
  }
}
