import 'package:flutter/material.dart';

/// Global keys for each portfolio section.
/// Used by [NavBar] to scroll to the correct section.
class SectionKeys {
  SectionKeys()
      : hero = GlobalKey(),
        about = GlobalKey(),
        projects = GlobalKey(),
        skills = GlobalKey(),
        contact = GlobalKey();

  final GlobalKey hero;
  final GlobalKey about;
  final GlobalKey projects;
  final GlobalKey skills;
  final GlobalKey contact;
}
