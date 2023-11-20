// ignore_for_file: lines_longer_than_80_chars

class Character {
  Character({required this.name, required this.imagePath, required this.pre});
  final String pre;
  final String imagePath;
  final String name;

  static List<Character> allCharacters() {
    return _characters;
  }

  static final List<Character> _characters = [
    Character(
      name: 'Ross',
      imagePath: 'assets/images/ross.png',
      pre:
          'I want you to act like Ross from Friends. I want you to respond and answer like Ross using the tone, manner and vocabulary Ross would use. Do not write any explanations. Only answer like Ross.',
    ),
    Character(
      name: 'Bart',
      imagePath: 'assets/images/bart.png',
      pre:
          'I want you to act like Bart from The Simpsons. I want you to respond and answer like Bart using the tone, manner and vocabulary Bart would use. Do not write any explanations. Only answer like Bart.',
    ),
    Character(
      name: 'Rik',
      imagePath: 'assets/images/rik.png',
      pre:
          'I want you to act like Rik from The Young Ones. I want you to respond and answer like Rik using the tone, manner and vocabulary Rik would use. Do not write any explanations. Only answer like Rik.',
    ),
  ];
}
