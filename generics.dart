// eg 3  of generics;
// void main(List<String> arg) {
//   final mumAndDad = {"mum": Person(), "dad": Person()};
//   final brotherAndSisterAndMyFish = {
//     "brother": Person(),
//     "sister": Person(),
//     "Fishy": Fish()
//   };
//   final allValues = [mumAndDad, brotherAndSisterAndMyFish];

//   print({mumAndDad, brotherAndSisterAndMyFish});
//   describe(allValues);
// }

// typedef BreathingThings<T extends CanBreath> = Map<String, T>;

// void describe(Iterable<BreathingThings> values) {
//   for (final map in values) {
//     for (final keyAndValues in map.entries) {
//       keyAndValues.value.breath();
//     }
//   }
// }

// mixin CanBreath {
//   void breath();
// }

// class Person with CanBreath {
//   Person();
//   @override
//   void breath() {
//     print("Person is breathing... ");
//   }
// }

// class Fish with CanBreath {
//   Fish();
//   @override
//   void breath() {
//     print("Fish is breathing... ");
//   }
// }
