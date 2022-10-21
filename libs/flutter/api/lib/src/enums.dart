enum CharacterSpecies { human, alien, unknown, empty }
enum CharacterStatus { alive, unknown, dead, empty }
enum CharacterGender { male, female, genderless, unknown, empty }

final characterSpeciesValues = {
  CharacterSpecies.alien: "Alien",
  CharacterSpecies.human: "Human",
  CharacterSpecies.unknown: "unknown",
  CharacterSpecies.empty: "",
};

final characterStatusValues = {
  CharacterStatus.alive: "Alive",
  CharacterStatus.dead: "Dead",
  CharacterStatus.empty: "",
};

final characterGenderValues = {
  CharacterGender.female: "Female",
  CharacterGender.male: "Male",
  CharacterGender.genderless: "Genderless",
  CharacterGender.unknown: "unknown",
  CharacterGender.empty: "",
};