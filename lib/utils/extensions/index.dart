import 'dart:io';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String nomalized() => split('_').map((str) => str.toCapitalized()).join(' ');
}

extension FileExtention on FileSystemEntity {
  String get name {
    return this.path.split("/").last;
  }
}
