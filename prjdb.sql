
CREATE TABLE UserInfo (
	userID int IDENTITY(1,1),
	username VARCHAR(20) NOT NULL,
	password VARCHAR(20) NOT NULL,
	UNIQUE (username),
	PRIMARY KEY (userID)
)

CREATE TABLE Character(
	charID INT IDENTITY(1,1),
	name VARCHAR(50) NOT NULL,
	player VARCHAR(20) NOT NULL,
	classID INT NOT NULL,
	subclassID INT,
	level INT NOT NULL,
	raceID INT NOT NULL,
	experience INT NOT NULL, 
	alignment VARCHAR(2) NOT NULL,
	hitDie VARCHAR(10) NOT NULL,
	hitPointsOne VARCHAR(30) NOT NULL,
	hitPointsHigher VARCHAR(30) NOT NULL,
	
	PRIMARY Key (charNum),
	FOREIGN KEY (player) REFERENCES UserInfo(userID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (classID) REFERENCES Class(classID)
		ON DELETE SET NULL
		ON UPDATE SET NULL,
	FOREIGN KEY (subclassID) REFERENCES SubClass(subclassID)
		ON DELETE SET NULL
		ON UPDATE SET NULL,
	FOREIGN KEY (raceID) REFERENCES Races(raceID)
		ON DELETE SET NULL
		ON UPDATE SET NULL

)

CREATE TABLE Class(
	classID INT IDENTITY(1,1) AUTO_INCREMENT,
	className VARCHAR(30) NOT NULL,
	classDescription VARCHAR(6000) NOT NULL,
	hitDie VARCHAR(10) NOT NULL,
	hitPointsOne VARCHAR(30) NOT NULL,
)


CREATE TABLE Feats(
	featID INT IDENTITY(1,1) AUTO_INCREMENT,
	featName VARCHAR(30) NOT NULL,
	featsDescription VARCHAR(600) NOT NULL,
	prerequisite VARCHAR(100) NOT NULL
)


CREATE TABLE Spells(
	spellID INT IDENTITY(1,1) 
	spellName VARCHAR(30) NOT NULL,
	spellsDesription VARCHAR(600) NOT NULL,
	spellLevel INT NOT NULL,
	spellClass VARCHAR(30) NOT NULL
)

CREATE TABLE Skills(
	skillID INT IDENTITY(1,1) 
	skillName VARCHAR(30) NOT NULL,
	skillDescription VARCHAR(MAX) NOT NULL,
	ability INT,
	PRIMARY KEY (skillID)
)

CREATE TABLE Equipment(
	equipmentID INT IDENTITY(1,1) 
	equipmentName VARCHAR(30) NOT NULL,
	equipmentDescription VARCHAR(600) NOT NULL,
	gold INT NOT NULL
)

CREATE TABLE Leveling(
	levelingID INT IDENTITY(1,1) 
	level INT NOT NULL,
	experience INT NOT NULL,
	ProficiencyBonus INT NOT NULL
)

CREATE TABLE Races(
	raceID INT IDENTITY(1,1) 
	raceName VARCHAR(30) NOT NULL,
	abilityScoreIncrease VARCHAR(600) NOT NULL,
	raceDescription VARCHAR(600) NOT NULL
)

CREATE TABLE Languages(
	languageID INT IDENTITY(1,1) 
	languageName VARCHAR(30),
	languageDescription VARCHAR(600) NOT NULL
)


CREATE TABLE SubClass(
	subClassID INT IDENTITY(1,1),
	subClassName VARCHAR(50), 
	classID INT NOT NULL,
	description VARCHAR(6000),
	PRIMARY KEY (subClassID),
	FOREIGN KEY (classID)
	REFERENCES Class(classID)
			ON DELETE CASCADE
			ON UPDATE CASCADE
		
)


CREATE TABLE Weapons(
	weaponID INT IDENTITY(1,1), 
	weaponName VARCHAR(30) NOT NULL,
	weaponDice VARCHAR(10) NOT NULL,
	range INT,
	requiredProficiency INT,
	gold INT NOT NULL,
	PRIMARY KEY (weaponID),
	
)

CREATE TABLE Armor(
	armorID INT IDENTITY(1,1), 
	armorName VARCHAR(30) NOT NULL,
	armorClass INT,
	maxDexBonus INT,
	requiredProficiency INT,
	gold INT NOT NULL
	PRIMARY KEY (armorID)
)

CREATE TABLE Proficiencies(
	proficiencyID INT IDENTITY(1,1),
	proficiencyName VARCHAR(30) NOT NULL,
	PRIMARY KEY (proficiencyID)
)

CREATE TABLE ClassFeatures(
	classFeatureID INT IDENTITY(1,1),
	classFeatureName VARCHAR(50) NOT NULL,
	classFeatureDescription VARCHAR(6000),
	classID INT NOT NULL,
	subClassID INT,
	leavelEarned INT
	PRIMARY KEY (classFeatureID),
	FOREIGN KEY (classID) REFERENCES
		Class(classID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	FOREIGN KEY (subClassID) REFERENCES
		SubClass(subClassID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)

CREATE TABLE Ability(
	abilityID INT IDENTITY(1,1),
	abilityName VARCHAR(30) NOT NULL,
	abbreviation VARCHAR(3),
	PRIMARY KEY (abilityID)
)



CREATE TABLE ClassFeaturesKnown(
	charID INT,
	classFeaturesID INT,
	PRIMARY KEY (charID, classFeaturesID),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	FOREIGN KEY (classFeaturesID) REFERENCES
		ClassFeatures (classFeatureID)

)


CREATE TABLE SkillProficiency(
	charID INT,
	skillID INT,
	proficient INT,
	PRIMARY KEY (charID, skillID),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (skillID) REFERENCES
		Skills (skillID),
    CHECK (proficient >= 0),
    CHECK (proficient <=1)
)

CREATE TABLE AbilityScores(
	charID INT,
	abilityNum INT,
	score INT,
	PRIMARY KEY (charID, abilityNum),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (abilityNum) REFERENCES
		Ability (abilityID)
)

CREATE TABLE SpellsKnown(
	charID INT,
	spellID INT,
	PRIMARY KEY (charID, spellID),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (spellID) REFERENCES
		Spells (spellID)
)

CREATE TABLE FeatsKnown(
	charID INT,
	featID INT,
	PRIMARY KEY (charID, featID),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (featID) REFERENCES
		Feats (featID)
)

CREATE TABLE Money(
	charID INT,
	platinum INT DEFAULT 0,
	gold INT DEFAULT 0,
	silver INT DEFAULT 0,
	electrum INT DEFAULT 0,
	copper INT DEFAULT 0,
	PRIMARY KEY (charID),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)

CREATE TABLE CharacterSpellSlots(
	charID INT,
	classID INT,
	cantrip INT,
	level1 INT,
	level2 INT,
	level3 INT,
	level4 INT,
	level5 INT,
	level6 INT,
	level7 INT,
	level8 INT,
	level9 INT,
	PRIMARY KEY (charID, classID),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (classID) REFERENCES
		Class (classID)
)

CREATE TABLE ClassSpellSlots(
	classID INT,
	charLevel INT,
	cantrip INT,
	level1 INT,
	level2 INT,
	level3 INT,
	level4 INT,
	level5 INT,
	level6 INT,
	level7 INT,
	level8 INT,
	level9 INT,
	PRIMARY KEY (classID, charLevel),
	FOREIGN KEY (classID) REFERENCES
		Class (classID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
)


CREATE TABLE SavingThrows(
	charID INT,
	strength INT DEFAULT 0, 
	dexterity INT DEFAULT 0,
	constitution INT DEFAULT 0,
	intelligence INT DEFAULT 0,
	wisdom INT DEFAULT 0,
	charisma INT DEFAULT 0,
	PRIMARY KEY (charID),
	FOREIGN KEY (charID) REFERENCES
		Character (charID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CHECK (strength >= 0),
    CHECK (strength <=1),
	CHECK (dexterity >= 0),
    CHECK (dexterity <=1),
	CHECK (constitution >= 0),
    CHECK (constitution <=1),
	CHECK (intelligence >= 0),
    CHECK (intelligence <=1),
	CHECK (wisdom >= 0),
    CHECK (wisdom <=1),
	CHECK (charisma >= 0),
    CHECK (charisma <=1)
)

create table racialAbilities
(
    raceID int,
    abilityName varchar(40),
    abilityDescription varchar(max),
    primary key (raceID, abilityName),
    foreign key (raceID) REFERENCES
    races (raceID)
)

create table ClassSpellsKnown
(
	classID int,
	level int,
	spellsKnown int,
	invocationsKnown int,
	primary key (classID, level)
)


create table racialAbilitiesKnown
(
	idValue int identity(1,1),
	charID int,
	abilityName varchar(MAX),
	primary key (idValue)
)

INSERT INTO Ability
VALUES ('Strength', 'STR'),
		('Dexterity', 'DEX'),
		('Constitution', 'CON'),
		('Intelligence', 'INT'),
		('Wisdom', 'WIS'),
		('Charisma', 'CHA');

		
		
INSERT INTO Skills (ability, skillName, skillDescription)
VALUES 
(1, 'Athletics', 'Your Strength (Athletics) check covers difficult situations you encounter while climbing, jumping, or swimming. Examples include the following activities:<br /> You attempt to climb a sheer or slippery cliff, avoid hazards while scaling a wall, or cling to a surface while something is trying to knock you off. <br /> You try to jump an unusually long distance or pull off a stunt midjump. <br /> You struggle to swim or stay afloat in treacherous currents, storm-­tossed waves, or areas of thick seaweed. Or another creature tries to push or pull you underwater or otherwise interfere with your swimming. <br />'),
( 2, 'Acrobatics', 'Your Dexterity (Acrobatics) check covers your attempt to stay on your feet in a tricky situation, such as when you’re trying to run across a sheet of ice, balance on a tightrope, or stay upright on a rocking ship’s deck. The GM might also call for a Dexterity (Acrobatics) check to see if you can perform acrobatic stunts, including dives, rolls, somersaults, and flips.'),
(2, 'Sleight of Hand', 'Whenever you attempt an act of legerdemain or manual trickery, such as planting something on someone else or concealing an object on your person, make a Dexterity (Sleight of Hand) check. The GM might also call for a Dexterity (Sleight of Hand) check to determine whether you can lift a coin purse off another person or slip something out of another person’s pocket.'),
(2, 'Stealth', 'Make a Dexterity (Stealth) check when you attempt to conceal yourself from enemies, slink past guards, slip away without being noticed, or sneak up on someone without being seen or heard.'),
(4, 'Arcana', 'Your Intelligence (Arcana) check measures your ability to recall lore about spells, magic items, eldritch symbols, magical traditions, the planes of existence, and the inhabitants of those planes.'),
(4, 'History', 'Your Intelligence (History) check measures your ability to recall lore about historical events, legendary people, ancient kingdoms, past disputes, recent wars, and lost civilizations.'),
(4, 'Investigation', 'When you look around for clues and make deductions based on those clues, you make an Intelligence (Investigation) check. You might deduce the location of a hidden object, discern from the appearance of a wound what kind of weapon dealt it, or determine the weakest point in a tunnel that could cause it to collapse. Poring through ancient scrolls in search of a hidden fragment of knowledge might also call for an Intelligence (Investigation) check.'),
(4, 'Nature', 'Your Intelligence (Nature) check measures your ability to recall lore about terrain, plants and animals, the weather, and natural cycles.'),
(4, 'Religion', 'Your Intelligence (Religion) check measures your ability to recall lore about deities, rites and prayers, religious hierarchies, holy symbols, and the practices of secret cults.'),
(5, 'Animal Handling', 'When there is any question whether you can calm down a domesticated animal, keep a mount from getting spooked, or intuit an animal’s intentions, the GM might call for a Wisdom (Animal Handling) check. You also make a Wisdom (Animal Handling) check to control your mount when you attempt a risky maneuver.'),
(5, 'Insight', 'Your Wisdom (Insight) check decides whether you can determine the true intentions of a creature, such as when searching out a lie or predicting someone’s next move. Doing so involves gleaning clues from body language, speech habits, and changes in mannerisms.'),
(5, 'Medicine', 'A Wisdom (Medicine) check lets you try to stabilize a dying companion or diagnose an illness.'),
(5, 'Perception', 'Your Wisdom (Perception) check lets you spot, hear, or otherwise detect the presence of something. It measures your general awareness of your surroundings and the keenness of your senses. For example, you might try to hear a conversation through a closed door, eavesdrop under an open window, or hear monsters moving stealthily in the forest. Or you might try to spot things that are obscured or easy to miss, whether they are orcs lying in ambush on a road, thugs hiding in the shadows of an alley, or candlelight under a closed secret door.'),
(5, 'Survival', 'The GM might ask you to make a Wisdom (Survival) check to follow tracks, hunt wild game, guide your group through frozen wastelands, identify signs that owlbears live nearby, predict the weather, or avoid quicksand and other natural hazards.'),
(6, 'Deception', 'Your Charisma (Deception) check determines whether you can convincingly hide the truth, either verbally or through your actions. This deception can encompass everything from misleading others through ambiguity to telling outright lies. Typical situations include trying to fast-­‐‑ talk a guard, con a merchant, earn money through gambling, pass yourself off in a disguise, dull someone’s suspicions with false assurances, or maintain a straight face while telling a blatant lie.'),
(6, 'Intimidation', 'When you attempt to influence someone through overt threats, hostile actions, and physical violence, the GM might ask you to make a Charisma (Intimidation) check. Examples include trying to pry information out of a prisoner, convincing street thugs to back down from a confrontation, or using the edge of a broken bottle to convince a sneering vizier to reconsider a decision.'),
(6, 'Performance', 'Your Charisma (Performance) check determines how well you can delight an audience with music, dance, acting, storytelling, or some other form of entertainment.'),
(6, 'Persuasion', 'When you attempt to influence someone or a group of people with tact, social graces, or good nature, the GM might ask you to make a Charisma (Persuasion) check. Typically, you use persuasion when acting in good faith, to foster friendships, make cordial requests, or exhibit proper etiquette. Examples of persuading others include convincing a chamberlain to let your party see the king, negotiating peace between warring tribes, or inspiring a crowd of townsfolk.')



INSERT INTO Class 
VALUES

('Barbarian', 	'For some, their rage springs from a communion with fierce animal spirits. Others draw from a roiling reservoir of anger at a world full of pain. For every barbarian, rage is a power that fuels not just a battle frenzy but also uncanny reflexes, resilience, and feats of strength.', 	'D12', 	'12 + con', ' ' 	),
('Bard', 	'Whether scholar, skald, or scoundrel, a bard weaves magic through words and music to inspire allies, demoralize foes, manipulate minds, create illusions, and even heal wounds.', 	'D8',	'8 + con' , ' '	),
('Cleric', 	'Clerics are intermediaries between the mortal world and the distant planes of the gods. As varied as the gods they serve, clerics strive to embody the handiwork of their deities. No ordinary priest, a cleric is imbued with divine magic.', 	'D8', 	'8 + con' , ' '	),
('Druid', 	'Whether calling on the elemental forces of nature or emulating the creatures of the animal world, druids are an embodiment of nature’s resilience, cunning, and fury. They claim no mastery over nature. Instead, they see themselves as extensions of nature’s indomitable will.', 	'D8', 	'8 + con' , ' '	),
('Fighter', 	'Questing knights, conquering overlords, royal champions, elite foot soldiers, hardened mercenaries, and bandit kings—as fighters, they all share an unparalleled mastery with weapons and armor, and a thorough knowledge of the skills of combat. And they are well acquainted with death, both meting it out and staring it defiantly in the face.', 	'D10', 	'10 + con' , ' '	),
('Monk', 	'Whatever their discipline, monks are united in their ability to magically harness the energy that flows in their bodies. Whether channeled as a striking display of combat prowess or a subtler focus of defensive ability and speed, this energy infuses all that a monk does.', 	'D8', 	'8 + con' , ' '	),
('Paladin', 	'Whatever their origin and their mission, paladins are united by their oaths to stand against the forces of evil. Whether sworn before a god’s altar and the witness of a priest, in a sacred glade before nature spirits and fey beings, or in a moment of desperation and grief with the dead as the only witness, a paladin’s oath is a powerful bond. It is a source of power that turns a devout warrior into a blessed champion.', 	'D10', 	'10 + con' , ' '	),
('Ranger', 	'Far from the bustle of cities and towns, past the hedges that shelter the most distant farms from the terrors of the wild, amid the dense-packed trees of trackless forests and across wide and empty plains, rangers keep their unending watch.', 	'D10', 	'10 + con' , ' '	),
('Rogue', 	'Rogues rely on skill, stealth, and their foes’ vulnerabilities to get the upper hand in any situation. They have a knack for finding the solution to just about any problem, demonstrating a resourcefulness and versatility that is the cornerstone of any successful adventuring party.', 	'D8', 	'8 + con' , ' '	),
('Sorcerer', 	'Sorcerers carry a magical birthright conferred upon them by an exotic bloodline, some otherworldly influence, or exposure to unknown cosmic forces. One can’t study sorcery as one learns a language, any more than one can learn to live a legendary life. No one chooses sorcery; the power chooses the sorcerer.', 	'D6', 	'6 + con' , ' '	),
('Warlock', 	'Warlocks are seekers of the knowledge that lies hidden in the fabric of the multiverse. Through pacts made with mysterious beings of supernatural power, warlocks unlock magical effects both subtle and spectacular. Drawing on the ancient knowledge of beings such as fey nobles, demons, devils, hags, and alien entities of the Far Realm, warlocks piece together arcane secrets to bolster their own power.', 	'D8', 	'8 + con' , ' '	),
('Wizard',	'Wizards are supreme magic-users, defined and united as a class by the spells they cast. Drawing on the subtle weave of magic that permeates the cosmos, wizards cast spells of explosive fire, arcing lightning, subtle deception, and brute-force mind control. Their magic conjures monsters from other planes of existence, glimpses the future, or turns slain foes into zombies. Their mightiest spells change one substance into another, call meteors down from the sky, or open portals to other worlds.',	'D6',	'6 + con', ' '	)




INSERT INTO Proficiencies VALUES
(	'Abyssal'	),
(	'Alchemist''s Supplies'	),
(	'Bagpipes'	),
(	'Battleaxe'	),
(	'Blowgun'	),
(	'Brewer''s Supplies'	),
(	'Calligrapher''s Supplies'	),
(	'Carpenter''s Tools'	),
(	'Cartographer''s Tools'	),
(	'Celestial'	),
(	'Club'	),
(	'Cobbler''s Tools'	),
(	'Common'	),
(	'Cook''s Utensils'	),
(	'Dagger'	),
(	'Dart'	),
(	'Deep Speech'	),
(	'Dice Set'	),
(	'Disguise Kit'	),
(	'Draconic'	),
(	'Dragonchess Set'	),
(	'Drum'	),
(	'Dulcimer'	),
(	'Dwarvish'	),
(	'Elvish'	),
(	'Flail'	),
(	'Flute'	),
(	'Forgery Kit'	),
(	'Giant'	),
(	'Glaive'	),
(	'Glassblower''s Tools'	),
(	'Gnomish'	),
(	'Goblin'	),
(	'Greataxe'	),
(	'Greatclub'	),
(	'Greatsword'	),
(	'Halberd'	),
(	'Halfling'	),
(	'Hand Crossbow'	),
(	'Handaxe'	),
(	'Heavy Armor'	),
(	'Heavy Crossbow'	),
(	'Herbalism Kit'	),
(	'Horn'	),
(	'Improvised Weapon'	),
(	'Infernal'	),
(	'Javelin'	),
(	'Jeweler''s Tools'	),
(	'Lance'	),
(	'Land Vehicles'	),
(	'Leatherworker''s Tools'	),
(	'Light Armor'	),
(	'Light Crossbow'	),
(	'Light Hammer'	),
(	'Longbow'	),
(	'Longsword'	),
(	'Lute'	),
(	'Lyre'	),
(	'Mace'	),
(	'Martial Weapons'	),
(	'Mason''s Tools'	),
(	'Maul'	),
(	'Medicine'	),
(	'Medium Armor'	),
(	'Morningstar'	),
(	'Navigator''s Tools'	),
(	'Net'	),
(	'Orc'	),
(	'Painter''s Supplies'	),
(	'Pan Flute'	),
(	'Pike'	),
(	'Playing Card Set'	),
(	'Poisoner''s kit'	),
(	'Potter''s Tools'	),
(	'Primordial'	),
(	'Quarterstaff'	),
(	'Rapier'	),
(	'Scimitar'	),
(	'Shawm'	),
(	'Shields'	),
(	'Shortbow'	),
(	'Shortsword'	),
(	'Sickle'	),
(	'Simple Weapons'	),
(	'Sling'	),
(	'Smith''s Tools'	),
(	'Spear'	),
(	'Sylvan'	),
(	'Thieves'' Tools'	),
(	'Three-Dragon Ante Set'	),
(	'Tinker''s Tools'	),
(	'Trident'	),
(	'Unarmed Strike'	),
(	'Undercommon'	),
(	'Viol'	),
(	'War Pick'	),
(	'Warhammer'	),
(	'Water Vehicles'	),
(	'Weaver''s Tools'	),
(	'Whip'	),
(	'Woodcarver''s Tools'	);



INSERT INTO Races (raceName, raceDescription, ability1, ability2, ability1Increase, ability2Increase)  --str1002, dex1003, con1004  int1005, wis1006, cha1007
VALUES
('Eladrin', 'Creatures of magic with strong ties to nature, eladrin live in the twilight realm of the Feywild. Their cities sometimes cross over to the Material Plane, appearing briefly in mountain valleys or deep forest glades before fading back into the Feywild.', 1003, 2,  1005, 1),
('High Elf', 'As a high elf, you have a keen mind and a mastery of at least the basics of magic. In many of the worlds of D&D, there are two kinds of high elves. One type (which includes the gray elves and valley elves of Greyhawk, the Silvanesti of Dragonlance, and the sun elves of the Forgotten Realms) is haughty and reclusive, believing themselves to be superior to non-elves and even other elves. The other type (including the high elves of Greyhawk, the Qualinesti of Dragonlance, and the moon elves of the Forgotten Realms) are more common and more friendly, and often encountered among humans and other races.

The sun elves of Faerûn (also called gold elves or sunrise elves) have bronze skin and hair of copper, black, or golden blond. Their eyes are golden, silver, or black. Moon elves (also called silver elves or gray elves) are much paler, with alabaster skin sometimes tinged with blue. They often have hair of silver-white, black, or blue, but various shades of blond, brown, and red are not uncommon. Their eyes are blue or green and flecked with gold.', 1005, 1003, 1, 2 ),
('Wood Elf', 'As a wood elf, you have keen senses and intuition, and your fleet feet carry you quickly and stealthily through your native forests. This category includes the wild elves (grugach) of Greyhawk and the Kagonesti of Dragonlance, as well as the races called wood elves in Greyhawk and the Forgotten Realms. In Faerûn, wood elves (also called wild elves, green elves, or forest elves) are reclusive and distrusting of non-elves.

Wood elves’ skin tends to be copperish in hue, sometimes with traces of green. Their hair tends toward browns and blacks, but it is occasionally blond or copper-colored. Their eyes are green, brown, or hazel.', 1006, 1003, 1, 2 ),

('Dragonborn', 'Born of dragons, as their name proclaims, the dragonborn walk proudly through a world that greets them with fearful incomprehension. Shaped by draconic gods or the dragons themselves, dragonborn originally hatched from dragon eggs as a unique race, combining the best attributes of dragons and humanoids. Some dragonborn are faithful servants to true dragons, others form the ranks of soldiers in great wars, and still others find themselves adrift, with no clear calling in life.', 1002, 1007, 2, 1 ),
('Hill Dwarf', 'As a hill dwarf, you have keen senses, deep intuition, and remarkable resilience. The gold dwarves of Faerûn in their mighty southern kingdom are hill dwarves, as are the exiled Neidar and the debased Klar of Krynn in the Dragonlance setting.', 1004, 1006, 2, 1),
('Mountain Dwarf', 'As a mountain dwarf, you’re strong and hardy, accustomed to a difficult life in rugged terrain. You’re probably on the tall side (for a dwarf), and tend toward lighter coloration. The shield dwarves of northern Faerûn, as well as the ruling Hylar clan and the noble Daewar clan of Dragonlance, are mountain dwarves.', 1004, 1002, 2, 2),
('Forest Gnome', 'Forest gnomes are the smallest of the gnomes, averaging only 2 to 2 1/2 feet tall. Even the tallest forest gnome is less than 3 feet. They usually weigh around 25 to 30 pounds. Unlike other gnomes, they wear their hair and beards long, often almost to their feet when unbound. The males often trim their beards to a fine point or curl them into hornlike spikes extending to either side of their faces. Their skin is the color of bark, and their eyes are usually brown or blue. Their hair is brown or black, becoming gray or white with age.', 1005, 1003 ,2, 1),
('Deep Gnome', 'Forest gnomes and rock gnomes are the gnomes most commonly encountered in the lands of the surface world. There is another subrace of gnomes rarely seen by any surface-dweller: deep gnomes, also known as svirfneblin. Guarded, and suspicious of outsiders, svirfneblin are cunning and taciturn, but can be just as kind-hearted, loyal, and compassionate as their surface cousins.' , 1005, 1004 ,2, 1 ),
('Rock Gnome', 'As a Rock Gnome, you have a natural inventiveness and hardiness beyond that of other Gnomes.', 1005, 1003 , 2, 1),
('Half-Elf', 'Walking in two worlds but truly belonging to neither, half-elves combine what some say are the best qualities of their elf and human parents: human curiosity, inventiveness, and ambition tempered by the refined senses, love of nature, and artistic tastes of the elves. Some half-elves live among humans, set apart by their emotional and physical differences, watching friends and loved ones age while time barely touches them. Others live with the elves, growing restless as they reach adulthood in the timeless elven realms, while their peers continue to live as children. Many half-elves, unable to fit into either society, choose lives of solitary wandering or join with other misfits and outcasts in the adventuring life.', 1007, NULL, 2, NULL),
('Lightfoot Halfling', 'As a lightfoot halfling, you can easily hide from notice, even using other people as cover. You’re inclined to be affable and get along well with others. In the Forgotten Realms, lightfoot halflings have spread the farthest and thus are the most common variety.

Lightfoots are more prone to wanderlust than other halflings, and often dwell alongside other races or take up a nomadic life. In the world of Greyhawk, these halflings are called hairfeet or tallfellows.', 1003 , 1007, 2 , 1),
('Stout Halfling', 'As a stout halfling, you’re hardier than average and have some resistance to poison. Some say that stouts have dwarven blood. In the Forgotten Realms, these halflings are called stronghearts, and they’re most common in the south.', 1004, 1003 , 1, 2 ),
('Half-Orc', 'Whether united under the leadership of a mighty warlock or having fought to a standstill after years of conflict, orc and human tribes sometimes form alliances, joining forces into a larger horde to the terror of civilized lands nearby. When these alliances are sealed by marriages, half-orcs are born. Some half-orcs rise to become proud chiefs of orc tribes, their human blood giving them an edge over their full-blooded orc rivals. Some venture into the world to prove their worth among humans and other more civilized races. Many of these become adventurers, achieving greatness for their mighty deeds and notoriety for their barbaric customs and savage fury.', 1002, 1004, 2, 1),
('Human', 'In the reckonings of most worlds, humans are the youngest of the common races, late to arrive on the world scene and short-lived in comparison to dwarves, elves, and dragons. Perhaps it is because of their shorter lives that they strive to achieve as much as they can in the years they are given. Or maybe they feel they have something to prove to the elder races, and that’s why they build their mighty empires on the foundation of conquest and trade. Whatever drives them, humans are the innovators, the achievers, and the pioneers of the worlds.', NULL, NULL, NULL, NULL),
('Tiefling', 'To be greeted with stares and whispers, to suffer violence and insult on the street, to see mistrust and fear in every eye: this is the lot of the tiefling. And to twist the knife, tieflings know that this is because a pact struck generations ago infused the essence of Asmodeus—overlord of the Nine Hells—into their bloodline. Their appearance and their nature are not their fault but the result of an ancient sin, for which they and their children and their children’s children will always be held accountable.', 1007, 1005, 2, 1)





INSERT INTO racialAbilities
VALUES
( 6, 'Speed', 'Your base walking speed is 30 feet.'),
(6, 'Darkvision', 'Accustomed to twilit forests and the night sky, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(6, 'Keen Senses', 'You have proficiency in the Perception skill.'),
(6, 'Fey Ancestry', 'You have advantage on saving throws against being charmed, and magic can’t put you to sleep.'),
(6, 'Trance', 'Elves don’t need to sleep. Instead, they meditate deeply, remaining semiconscious, for 4 hours a day. (The Common word for such meditation is “trance.”) While meditating, you can dream after a fashion; such dreams are actually mental exercises that have become reflexive through years of practice. After resting in this way, you gain the same benefit that a human does from 8 hours of sleep.'),
(6, 'Elf Weapon Training', 'You have proficiency with the longsword, shortsword, shortbow, and longbow.'),
(6, 'Fey Step', 'You can cast the misty step spell once using this trait. You regain the ability to do so when you finish a short or long rest.'),

( 7, 'Speed', 'Your base walking speed is 30 feet.'),
(7, 'Darkvision', 'Accustomed to twilit forests and the night sky, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(7, 'Keen Senses', 'You have proficiency in the Perception skill.'),
(7, 'Fey Ancestry', 'You have advantage on saving throws against being charmed, and magic can’t put you to sleep.'),
(7, 'Trance', 'Elves don’t need to sleep. Instead, they meditate deeply, remaining semiconscious, for 4 hours a day. (The Common word for such meditation is “trance.”) While meditating, you can dream after a fashion; such dreams are actually mental exercises that have become reflexive through years of practice. After resting in this way, you gain the same benefit that a human does from 8 hours of sleep.'),
(7, 'Elf Weapon Training', 'You have proficiency with the longsword, shortsword, shortbow, and longbow.'),
(7, 'Cantrip', 'You know one cantrip of your choice from the wizard spell list. Intelligence is your spellcasting ability for it.'),
(7, 'Extra Language', 'You can speak, read, and write one extra language of your choice.'),


( 8, 'Fleet of Foot', 'Your base walking speed increases to 35 feet.'),
(8, 'Darkvision', 'Accustomed to twilit forests and the night sky, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(8, 'Keen Senses', 'You have proficiency in the Perception skill.'),
(8, 'Fey Ancestry', 'You have advantage on saving throws against being charmed, and magic can’t put you to sleep.'),
(8, 'Trance', 'Elves don’t need to sleep. Instead, they meditate deeply, remaining semiconscious, for 4 hours a day. (The Common word for such meditation is “trance.”) While meditating, you can dream after a fashion; such dreams are actually mental exercises that have become reflexive through years of practice. After resting in this way, you gain the same benefit that a human does from 8 hours of sleep.'),
(8, 'Elf Weapon Training', 'You have proficiency with the longsword, shortsword, shortbow, and longbow.'),
(8, 'Mask of the Wild', 'You can attempt to hide even when you are only lightly obscured by foliage, heavy rain, falling snow, mist, and other natural phenomena.'),
( 9, 'Speed', 'Your base walking speed is 30 feet.'), 
( 9, 'Draconic Ancestry', 'You have draconic ancestry. Choose one type of dragon from the Draconic Ancestry table. Your breath weapon and damage resistance are determined by the dragon type.'),
( 10, 'Speed', 'Your base walking speed is 25 feet.'), 
(10, 'Darkvision', 'Accustomed to life underground, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(10, 'Dwarven Resilience', 'You have advantage on saving throws against poison, and you have resistance against poison damage.'),
(10, 'Dwarven Combat Training', 'You have proficiency with the battleaxe, handaxe, light hammer, and warhammer.'),
(10, 'Tool proficiency', 'You gain proficiency with the artisan’s tools of your choice: smith’s tools, brewer’s supplies, or mason’s tools.'),
(10, 'Stonecunning', 'Whenever you make an Intelligence (History) check related to the origin of stonework, you are considered proficient in the History skill and add double your proficiency bonus to the check, instead of your normal proficiency bonus.'),
(10, 'Dwarven Toughness', 'Your hit point maximum increases by 1, and it increases by 1 every time you gain a level.'),
(11, 'Speed', 'Your base walking speed is 25 feet.'), 
(11, 'Darkvision', 'Accustomed to life underground, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(11, 'Dwarven Resilience', 'You have advantage on saving throws against poison, and you have resistance against poison damage.'),
(11, 'Dwarven Combat Training', 'You have proficiency with the battleaxe, handaxe, light hammer, and warhammer.'),
(11, 'Tool proficiency', 'You gain proficiency with the artisan’s tools of your choice: smith’s tools, brewer’s supplies, or mason’s tools.'),
(11, 'Stonecunning', 'Whenever you make an Intelligence (History) check related to the origin of stonework, you are considered proficient in the History skill and add double your proficiency bonus to the check, instead of your normal proficiency bonus.'),
(11, 'Proficiencies', 'You can replace all the proficiencies granted by the Dwarven Armor Training trait to another proficiency of your choice.'),
(11, 'Dwarven Armor Training', 'You have proficiency with light and medium armor.'),
(21, 'Speed', 'Your base walking speed is 30 feet.'),
(21, 'Darkvision', 'Thanks to your infernal heritage, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(21, 'Hellish Resistance', 'You have resistance to fire damage.'),
(21, 'Infernal Legacy', 'You know the thaumaturgy cantrip. When you reach 3rd level, you can cast the hellish rebuke spell as a 2nd-level spell once with this trait and regain the ability to do so when you finish a long rest. When you reach 5th level, you can cast the darkness spell once with this trait and regain the ability to do so when you finish a long rest. Charisma is your spellcasting ability for these spells.'),

(20, 'Ability Score Increase', ' Your ability scores each increase by 1.'),
(20, 'Speed', 'Your base walking speed is 30 feet.'),

(19, 'Speed', 'Your base walking speed is 30 feet.'),
(19, 'Darkvision', 'Thanks to your orc blood, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(19, 'Menacing', 'You gain proficiency in the Intimidation skill.'),
(19, 'Relentless Endurance', 'When you are reduced to 0 hit points but not killed outright, you can drop to 1 hit point instead. You can’t use this feature again until you finish a long rest.'),
(19, 'Savage Attacks', 'When you score a critical hit with a melee weapon attack, you can roll one of the weapon’s damage dice one additional time and add it to the extra damage of the critical hit.'),

(16, 'Speed', 'Your base walking speed is 25 feet.'),
(16, 'Lucky', 'When you roll a 1 on the d20 for an attack roll, ability check, or saving throw, you can reroll the die and must use the new roll.'),
(16, 'Brave', 'You have advantage on saving throws against being frightened.'),
(16, 'Halfling Nimbleness', 'You can move through the space of any creature that is of a size larger than yours.'),
(16, 'Naturally Stealthy', 'You can attempt to hide even when you are obscured only by a creature that is at least one size larger than you.'),
(17, 'Speed', 'Your base walking speed is 25 feet.'),
(17, 'Lucky', 'When you roll a 1 on the d20 for an attack roll, ability check, or saving throw, you can reroll the die and must use the new roll.'),
(17, 'Brave', 'You have advantage on saving throws against being frightened.'),
(17, 'Halfling Nimbleness', 'You can move through the space of any creature that is of a size larger than yours.'),
(17, 'Stout Resilience', 'You have advantage on saving throws against poison, and you have resistance against poison damage.'),

(15, 'Speed', 'Your base walking speed is 30 feet.'),
(15, 'Darkvision', 'Thanks to your elf blood, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can’t discern color in darkness, only shades of gray.'),
(15, 'Fey Ancestry', 'You have advantage on saving throws against being charmed, and magic can’t put you to sleep.'),
(15, 'Skill Versatility', 'You gain proficiency in two skills of your choice.'),

(12, 'Speed', 'Your base walking speed is 25 feet.'),
(12, 'Darkvision', 'Accustomed to life underground, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can''t discern color in darkness, only shades of gray.'),
(12, 'Gnome Cunning', 'You have advantage on all Intelligence, Wisdom, and Charisma saves against magic.'),
(12, 'Natural Illusionist', 'You know the Minor Illusion cantrip. Intelligence is your spellcasting modifier for it.'),
(12, 'Speak with Small Beasts', 'Through sound and gestures, you may communicate simple ideas with Small or smaller beasts.'),

(14, 'Artificer''s Lore', 'Whenever you make an Intelligence (History) check related to magical, alchemical, or technological items, you can add twice your proficiency bonus instead of any other proficiency bonus that may apply.'),
(14, 'Tinker', 'You have proficiency with artisan tools (tinker''s tools). Using those tools, you can spend 1 hour and 10 gp worth of materials to construct a Tiny clockwork device (AC 5, 1 hp). The device ceases to function after 24 hours (unless you spend 1 hour repairing it to keep the device functioning), or when you use your action to dismantle it; at that time, you can reclaim the materials used to create it. You can have up to three such devices active at a time. When you create a device, choose one of the following options:<br/>
Clockwork Toy. This toy is a clockwork animal, monster, or person, such as a frog, mouse, bird, dragon, or soldier. When placed on the ground, the toy moves 5 feet across the ground on each of your turns in a random direction. It makes noises as appropriate to the creature it represents.<br/>
Fire Starter. The device produces a miniature flame, which you can use to light a candle, torch, or campfire. Using the device requires your action.<br/>
Music Box. When opened, this music box plays a single song at a moderate volume. The box stops playing when it reaches the song''s end or when it is closed.<br/>
At your DM''s discretion, you may make other objects with effects similar in power to these. The Prestidigitation cantrip is a good baseline for such effects.'),
(14, 'Speed', 'Your base walking speed is 25 feet.'),
(14, 'Darkvision', 'Accustomed to life underground, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can''t discern color in darkness, only shades of gray.'),
(14, 'Gnome Cunning', 'You have advantage on all Intelligence, Wisdom, and Charisma saves against magic.'),

(13, 'Speed', 'Your base walking speed is 25 feet.'),
(13, 'Darkvision', 'Accustomed to life underground, you have superior vision in dark and dim conditions. You can see in dim light within 60 feet of you as if it were bright light, and in darkness as if it were dim light. You can''t discern color in darkness, only shades of gray.'),
(13, 'Gnome Cunning', 'You have advantage on all Intelligence, Wisdom, and Charisma saves against magic.'),
(13, 'Gifted Scribe', 'Whenever you make an Intelligence (History) or an Ability Check involving Calligrapher''s Supplies, you can roll a d4 and add the number rolled to the total ability check.'),
(13, 'Scribe''s Insight', 'You know the Message cantrip. You can also cast the Comprehend Languages spell with this trait. Starting at 3rd level, you can also cast the Magic Mouth spell with it. Once you cast either spell with this trait, you can''t cast that spell again until you finish a Long Rest. Intelligence is your Spellcasting Ability for these spells.'),
(13, 'Spells of the Mark', 'If you have the Spellcasting or Pact Magic class feature, the spells on the Mark of Scribing Spells table are added to the spell list of your Spellcasting class.')


INSERT INTO Feats
VALUES
(	'Actor',	'+1 in Cha., advantage on Deception and Performance checks, mimic the speech of a person or the sounds made by a creature.',	NULL	),
(	'Alert',	'+5 to initiative, you can''t be surprised, and creatures you don''t see don''t gain advantage on attack roll against you.',	NULL	),
(	'Athlete',	'+1 in Str. or Dex., you stand up and climb more quickly, and you can jump with only a 5-ft run.',	NULL	),
(	'Bountiful Luck',	'You can let an ally within 30 ft of you to reroll a 1 on a d20.',	'RACE:Halfling'	),
(	'Charger',	'As part of the Dash action you can make a melee attack with a +5 bonus if you move at least 10 ft before.',	NULL	),
(	'Crossbow Expert',	'You ignore the loading property of crossbows and don''t have disadvantage for being in contact with a creature when you shoot.',	NULL	),
(	'Defensive Duelist',	'You can add you proficiency bonus to your AC if you are wielding a finesse weapon.',	'ABILITY:DEXTERITY:13'	),
(	'Dragon Fear',	'+1 in Str., Con., or Cha. and your Breath Weapon can frighten instead of inflicting damages.',	'RACE:Dragonborn'	),
(	'Dragon Hide',	'+1 in Str., Con., or Cha., your AC becomes 13+Dex. modifier and your retractable claws deal 1d4+Str. modifier slashing damage.',	'RACE:Dragonborn'	),
(	'Drow High Magic',	'You can cast the detect magic spell (at will) and the levitate and dispel magic spells (1/long rest).',	'RACE:Elf'	),
(	'Dual Wieldwe',	'+1 to CA if you''re wielding a melee weapon in each hand, two-weapon fighting with non-light weapon, draw two weapons.',	NULL	),
(	'Dungeon Delver',	'Advantage to Perception and Investigation checks, to saving throws vs traps, and search for traps at normal pace.',	NULL	),
(	'Durable',	'+1 in Con. and for each Hit Dice you regain a minimum of hit points equals to 2 x your Constitution modifier.',	NULL	),
(	'Dwarf Fortitude',	'+1 in Con., and you can spend one Hit Die to heal yourself taking the Dodge action.',	'RACE:Dwarf'	),
(	'Elemental Adept',	'Your spells ignore resistance to a damage type (acid, cold, fire, lightning, or thunder) and treat any 1 in damage as a 2.',	'Must have a spellcaster class'	),
(	'Elven Accuracy',	'+1 in Dex., Int., Wis., or Cha., and you can reroll one attack roll if you have advantage.',	'RACE:Elf RACE:Half-Elf'	),
(	'Fade Away',	'+1 in Dex. or Int., and you can use your reaction to become invisible if you take damage.',	'RACE:Gnome'	),
(	'Fey Transportation',	'+1 in Int. or Cha., you speak Sylvan, and you can cast the misty step spell (1/short rest).',	'RACE:Elf'	),
(	'Flames of Phlegethos',	'+1 in Int. or Cha., reroll any 1 on fire spell damage, and cause flames to wreathe you if you cast a fire spell.',	'RACE:Tiefling'	),
(	'Grappler',	'You have advantage on attack rolls when grappling, and can try to restrained a creature grappled by you.',	'ABILITY:STRENGTH:13'	),
(	'Great Weapon Master',	'Extra attack after a melee critical hit and you can choose to take -5 to attack roll to add +10 to damage with an heavy weapon.',	NULL	),
(	'Healer',	'You can stabilize a creature and restore it to 1 hp, or restore [1d6+4+its number of Hit Dice] hp to it.',	NULL	),
(	'Heavily Armored',	'+1 in Str. and you gain proficiency with heavy armor.',	'PROFICIENCY:Medium Armor Proficiency'	),
(	'Heavy Armor Master',	'+1 in Str. and bludgeoning, piercing, and slashing damage are reduced by 3 if you are wearing an heavy armor.',	'PROFICIENCY:Heavy Armor Proficiency'	),
(	'Infernal Constitution',	'+1 in Con., resistance to cold and poison damage, and you have advantage on saving throws against being poisoned.',	'RACE:Tiefling'	),
(	'Inspiring Leader',	'Up to 6 creatures within 30 ft of you can gain temporary hp equal to your levei + your Cha. modifier.',	'ABILITY:CHARISMA:13'	),
(	'Keen Mind',	'+1 in Int., you know which way is north, when is the next sunrise/sunset, and recall any events within the past month.',	NULL	),
(	'Lightly Armored',	'+1 in Str. or Dex. and you gain profociency with light armor.',	NULL	),
(	'Linguist',	'+1 in Int., you learn three languages, and you can ably create ciphers.',	NULL	),
(	'Lucky',	'You can reroll one d20 or force to reroll an attack roll against you (3/long rest).',	NULL	),
(	'Mage Slayer',	'You can use a reaction to make a melee attack against a spellcaster and advantage on saving throws against spell within 5 ft.',	NULL	),
(	'Magic Initiate',	'You learn two cantrips and one 1st-level spell from one class.',	NULL	),
(	'Martial Adept',	'You learn two maneuvers from Battle Master archetype and gain one superiority die (d6).',	NULL	),
(	'Medium Armor Master',	'Wearing medium armor doesn’t impose disadvantage on your Dexterity (Stealth) checks. When you wear medium armor, you can add 3, rather than 2, to your AC if you have a Dexterity of 16 or higher.',	'Proficiency: Medium Armor'	),
(	'Mobile',	'Your speed increases by 10 feet.  When you use the Dash action, difficult terrain doesn’t cost you extra movement on that turn. When you make a melee attack against a creature, you don’t provoke opportunity attacks from that creature for the rest o f the turn, whether you hit or not.',	NULL	),
(	'Moderately Armored',	'Increase your Strength or Dexterity score by 1, to a maximum of 20.  You gain proficiency with medium armor and shields.',	'PROFICIENCY:Light Armor'	),
(	'Mounted Combatant',	'While you are mounted and aren’t incapacitated, you gain the following benefits: You have advantage on melee attack rolls against any unmounted creature that is smaller than your mount. You can force an attack targeted at your mount to target you instead. If your mount is subjected to an effect that allows it to make a Dexterity saving throw to take only half damage, it instead takes no damage if it succeeds on the saving throw, and only half damage if it fails.',	NULL	),
(	'Observant',	'Increase your Intelligence or Wisdom score by 1, to a maximum of 20. If you can see a creature’s mouth while it is speaking a language you understand, you can interpret what it’s saying by reading its lips. You have a +5 bonus to your passive Wisdom (Perception) and passive Intelligence (Investigation) scores.',	NULL	),
(	'Polearm Master',	'When you take the Attack action and attack with only a glaive, halberd, or quarterstaff, you can use a bonus action to make a melee attack with the opposite end of the weapon. The weapon’s damage die for this attack is a d4, and the attack deals bludgeoning damage. While you are wielding a glaive, halberd, pike, or quarterstaff, other creatures provoke an opportunity attack from you when they enter your reach.',	NULL	),
(	'Resilient',	'Choose one ability score. You gain the following benefits: Increase the chosen ability score by 1, to a maximum of 20. You gain proficiency in saving throws using the chosen ability.',	NULL	),
(	'Ritual Caster',	'You have learned a number of spells that you can cast as rituals. These spells are written in a ritual book, which you must have in hand while casting one of them.When you choose this feat, you acquire a ritual book holding two 1st-level spells of your choice. Choose one of the following classes: bard, cleric, druid, sorcerer, warlock, or wizard. You must choose your spells from that class’s spell list, and the spells you choose must have the ritual tag. The class you choose also determines your spellcasting ability for these spells: Charisma for bard, sorcerer, or warlock; Wisdom for cleric or druid; or Intelligence for wizard. If you come across a spell in written form, such as a magical spell scroll or a wizard’s spellbook, you might be able to add it to your ritual book. The spell must be on the spell list for the class you chose, the spell’s level can be no higher than half your level (rounded up), and it must have the ritual tag. The process of copying the spell into your ritual book takes 2 hours per level of the spell, and costs 50 gp per level. The cost represents material components you expend as you experiment with the spell to master it, as well as the fine inks you need to record it.',	'ABILITY:INTELLIGENCE 13 or WISDOM 13'	),
(	'Savage Attacker',	'Once per turn when you roll damage for a melee weapon attack, you can reroll the weapon’s damage dice and use either total.',	NULL	),
(	'Sentinel',	'When you hit a creature with an opportunity attack, the creature’s speed becomes 0 for the rest of the turn. Creatures within 5 feet of you provoke opportunity attacks from you even if they take the Disengage action before leaving your reach. When a creature within 5 feet of you makes an attack against a target other than you (and that target doesn’t have this feat), you can use your reaction to make a melee weapon attack against the attacking creature.',	NULL	),
(	'Sharpshooter',	'Attacking at long range doesn''t impose disadvantage on your ranged weapon attack rolls. Your ranged weapon attacks ignore half cover and three-quarters cover. Before you make an attack with a ranged weapon that you are proficient with, you can choose to take a - 5 penalty to the attack roll. If the attack hits, you add +10 to the attack’s damage.',	NULL	),
(	'Shield Master',	'You gain the following benefits while you are wielding a shield: If you take the Attack action on your turn, you can use a bonus action to try to shove a creature within 5 feet of you with your shield. If you aren’t incapacitated, you can add your shield’s AC bonus to any Dexterity saving throw you make against a spell or other harmful effect that targets only you. If you are subjected to an effect that allows you to make a Dexterity saving throw to take only half damage, you can use your reaction to take no damage if you succeed on the saving throw, interposing your shield between yourself and the source of the effect.',	NULL	),
(	'Skilled',	'You gain proficiency in any combination of three skills or tools of your choice.',	NULL	),
(	'Skulker',	'You can try to hide when you are lightly obscured from the creature from which you are hiding. When you are hidden from a creature and miss it with a ranged weapon attack, making the attack doesn''t reveal your position. Dim light doesn''t impose disadvantage on your Wisdom (Perception) checks relying on sight.',	'ABILITY:DEXTERITY 13'	),
(	'Spell Sniper',	'When you cast a spell that requires you to make an attack roll, the spell’s range is doubled. Your ranged spell attacks ignore half cover and three-quarters cover. You learn one cantrip that requires an attack roll. Choose the cantrip from the bard, cleric, druid, sorcerer, warlock, or wizard spell list. Your spellcasting ability for this cantrip depends on the spell list you chose from: Charisma for bard, sorcerer, or warlock; Wisdom for cleric or druid; or Intelligence for wizard.',	'The ability to cast at least one spell'	),
(	'Tavern Brawler',	'Increase your Strength or Constitution score by 1, to a maximum of 20. You are proficient with improvised weapons and unarmed strikes. Your unarmed strike uses a d4 for damage. When you hit a creature with an unarmed strike or an improvised weapon on your turn, you can use a bonus action to attempt to grapple the target.',	NULL	),
(	'Tough',	'Your hit point maximum increases by an amount equal to twice your level when you gain this feat. Whenever you gain a level thereafter, your hit point maximum increases by an additional 2 hit points.',	NULL	),
(	'War Caster',	'You have advantage on Constitution saving throws that you make to maintain your concentration on a spell when you take damage. You can perform the somatic components of spells even when you have weapons or a shield in one or both hands. When a hostile creature’s movement provokes an opportunity attack from you, you can use your reaction to cast a spell at the creature, rather than making an opportunity attack. The spell must have a casting time of 1 action and must target only that creature.',	'The ability to cast at least one spell'	),
(	'Weapon Master',	'Increase your Strength or Dexterity score by 1, to a maximum of 20. You gain proficiency with four weapons of your choice.',	NULL	)


INSERT INTO Languages
VALUES

('Common', 'Language of humans, halflings, half-elves, and half-orcs.'),
('Dwarvish',  'Spoken by dwarves.'),
('Elvish',  'Spoken by elves.'),
('Giant',  'Language of the giants and ogres.'),
('Gnomish',  'Spoken by gnomes'),
('Goblin',  'Language of goblinoids, hobgoblins, and bugbears.'),
('Halfling',  'Language of the halflings.'),
('Orc',  'Spoken by orcs and half-orcs.'),
('Draconic',  'Spoken by dragonborn, kobolds, and dragons.'),
('Abyssal',  'Language of demons, chaotic evil outsiders.'),
('Celestial',  'Spoken by angels and devas.'),
('Deep Speech',  'Cryptic tongue of mindflayers and beholders.'),
('Infernal',  'Spoken by devils and tieflings.'),
('Primordial',  'Language of elemental beings.'),
('Sylvan',  'Spoken by fey creatures like dryads and treants.'),
('Undercommon', 'Common language of the Underdark.') 

INSERT INTO Weapons
VALUES
('Club', '1d4', 0, 185, 'bludgeoning', 'light'),
('Dagger', '1d4', 0, 185, 'piercing', 'finesse, light'),
('Dagger, thrown', '1d4', 20, 185, 'piercing', 'finesse, light, thrown (range 20/60)'),
('Greatclub', '1d4', 0, 185, 'bludgeoning', 'two-handed'),
('Handaxe', '1d6', 0, 185, 'slashing', 'light'),
('Handaxe, thrown', '1d6', 20, 185, 'slashing', 'light, thrown (range 20/60)'),
('Light hammer', '1d4', 0, 185, 'bludgeoning', 'light'),
('Light hammer, thrown', '1d4', 20, 185, 'bludgeoning', 'light, thrown (range 20/60)'),
('Mace', '1d6', 0, 185, 'bludgeoning', NULL),
('Quarterstaff', '1d6', 0, 185, 'bludgeoning', 'versatile (1d8)'),
('Sickle', '1d4', 0, 185, 'slashing', 'light'),
('Spear', '1d6', 0, 185, 'piercing', 'versatile (1d8)'),
('Spear, thrown', '1d6', 20, 185, 'piercing', 'thrown (range 20/60)'),
('Javelin', '1d6', 0, 185, 'piercing', NULL),
('Javelin, thrown', '1d6', 30, 185, 'piercing', 'thrown (range 30/120)'),
('Crossbow', '1d8', 80, 185, 'piercing', 'ammunition (range 80/320), loading, two-handed'),
('Dart', '1d4', 20, 185, 'piercing', 'finesse, thrown (range 20/60)'),
('Shortbow', '1d6', 80, 185, 'piercing', 'ammunition (range 80/320), two-handed'),
('Sling', '1d4', 30, 185, 'bludgeoning', 'ammunition (range 30/120)'),
('Battleaxe', '1d8', 0, 161, 'slashing', 'versatile (1d10)'),
('Flail', '1d8', 0, 161, 'bludgeoning', NULL),
('Glaive', '1d10', 0, 161, 'slashing', 'heavy, reach, two-handed'),
('Greataxe', '1d12', 0, 161, 'slashing', 'heavy, two-handed'),
('Greatsword', '2d6', 0, 161, 'slashing', 'heavy, two-handed'),
('Halberd', '1d10', 0, 161, 'slashing', 'heavy, reach, two-handed'),
('Lance', '1d12', 0, 161, 'piercing', 'reach, special'),
('Longsword', '1d8', 0, 161, 'slashing', 'versatile (1d10)'),
('Maul', '2d6', 0, 161, 'bludgeoning', 'heavy, two-handed'),
('Morningstar', '1d8', 0, 161, 'piercing', NULL),
('Pike', '1d10', 0, 161, 'piercing', 'heavy, reach, two-handed'),
('Rapier', '1d8', 0, 161, 'piercing', 'finesse'),
('Scimitar', '1d6', 0, 161, 'slashing', 'finesse, light'),
('Shortsword', '1d6', 0, 161, 'piercing', 'finesse, light'),
('Trident', '1d6', 0, 161, 'piercing', 'versatile (1d8)'),
('Trident', '1d6', 20, 161, 'piercing', 'thrown (range 20/60)'),
('War pick', '1d8', 0, 161, 'piercing', NULL),
('Warhammer', '1d8', 0, 161, 'bludgeoning', 'versatile (1d10)'),
('Whip', '1d4', 0, 161, 'slashing', 'finesse, reach'),
('Blowgun', '1', 25, 161, 'piercing', 'ammunition (range 25/100), loading'),
('Crossbow, hand', '1d6', 30, 161, 'piercing', 'ammunition (range 30/120), light, loading'),
('Crossbow, heavy', '1d8', 100, 161, 'piercing', 'ammunition (range 100/400), heavy, loading, two-handed'),
('Longbow', '1d10', 150, 161, 'piercing', 'ammunition (range 150/600), heavy, two-handed'),
('Net', '-', 5, 161, 'piercing', 'special, thrown (range 5/15)')

INSERT INTO Armor
VALUES
('Padded', 11, 10, 153 , 5, 0),
('Leather', 11, 10, 153 , 10, 0),
('Studded leather', 12, 10, 153 , 45, 0),
('Hide', 12, 2, 165, 10, 0),
('Chain shirt', 13, 2, 165, 500, 0),
('Scale mail', 14, 2, 165, 500, 0),
('Breastplate', 14, 2, 165, 400, 0),
('Half plate', 15, 2, 165, 750, 0),
('Ring mail', 14, 0, 142, 30, 0),
('Chain mail', 16, 0, 142, 75, 13),
('Splint', 17, 0, 142, 200, 15),
('Plate', 18, 0, 142, 1500, 15)




INSERT INTO Spells
VALUES
('Dancing Lights', 'You create up to four torch--‐‑sized lights within range, making them appear as torches, lanterns, or glowing orbs that hover in the air for the duration. You can also combine the four lights into one glowing vaguely humanoid form of Medium size. Whichever form you choose, each light sheds dim light in a 10-foot radius.', '0', 'CLASS:Bard'),
('Light', 'You touch one object that is no larger than 10 feet in any dimension. Until the spell ends, the object sheds bright light in a 20-foot radius and dim light for an additional 20 feet. The light can be colored as you like. Completely covering the object with something opaque blocks the light. The spell ends if you cast it again or dismiss it as an action.', '0', 'CLASS:Bard'),
('Mage Hand', 'A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again. You can use your action to control the hand.You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.', '0', 'CLASS:Bard'),
('Mending', 'This spell repairs a single break or tear in an object you touch, such as a broken chain link, two halves of a broken key, a torn cloak, or a leaking wineskin. As long as the break or tear is no larger than 1 foot in any dimension, you mend it, leaving no trace of the former damage.', '0', 'CLASS:Bard'),
('Message', 'You point your finger toward a creature within range and whisper a message. The target (and only the target) hears the message and can reply in a whisper that only you can hear.', '0', 'CLASS:Bard'),
('Minor Illusion', 'You create a sound or an image of an object within range that lasts for the duration. The illusion also ends if you dismiss it as an action or cast this spell again.If you create a sound, its volume can range from a whisper to a scream. It can be your voice, someone else’s voice, a lion’s roar, a beating of drums, or any other sound you choose. The sound continues unabated throughout the duration, or you can make discrete sounds at different times before the spell ends. If you create an image of an object—such as a chair, muddy footprints, or a small chest—it must be no larger than a 5-foot cube. The image can’t create sound, light, smell, or any other sensory effect. Physical interaction with the image reveals it to be an illusion, because things can pass through it.', '0', 'CLASS:Bard'),
('Prestidigitation', 'You create an instantaneous, harmless sensory effect, such as a shower of sparks, a puff of wind, faint musical notes, or an odd odor. OR
You instantaneously light or snuff out a candle, a torch, or a small campfire. OR
You instantaneously clean or soil an object no larger than 1 cubic foot. OR
You chill, warm, or flavor up to 1 cubic foot of nonliving material for 1 hour. OR
You make a color, a small mark, or a symbol appear on an object or a surface for 1 hour. OR
You create a nonmagical trinket or an illusory image that can fit in your hand and that lasts until the end of your next turn.', '0', 'CLASS:Bard'),
('True Strike', 'You extend your hand and point a finger at a target in range. Your magic grants you a brief insight into the target’s defenses. On your next turn, you gain advantage on your first attack roll against the target, provided that this spell hasn’t ended.', '0', 'CLASS:Bard'),
('Vicious Mockery', 'You unleash a string of insults laced with subtle enchantments at a creature you can see within range. If the target can hear you (though it need not understand you), it must succeed on a Wisdom saving throw or take 1d4 psychic damage and have disadvantage on the next attack roll it makes before the end of its next turn.', '0', 'CLASS:Bard'),

('Animal Friendship', 'This spell lets you convince a beast that you mean it no harm. Choose a beast that you can see within range. It must see and hear you. If the beast''s Intelligence is 4 or higher, the spell fails. Otherwise, the beast must succeed on a Wisdom saving throw or be charmed by you for the spell''s duration. If you or one of your companions harms the target, the spells ends.', '1', 'CLASS:Bard'),
('Bane', 'Up to three creatures of your choice that you can see within range must make Charisma saving throws. Whenever a target that fails this saving throw makes an attack roll or a saving throw before the spell ends, the target must roll a d4 and subtract the number rolled from the attack roll or saving throw.', '1', 'CLASS:Bard'),
('Charm Person', 'You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.', '1', 'CLASS:Bard'),
('Comprehend Languages', 'For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text.', '1', 'CLASS:Bard'),
('Cure Wounds', 'A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Bard'),
('Detect Magic', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.', '1', 'CLASS:Bard'),
('Disguise Self', 'ou make yourself—including your clothing, armor, weapons, and other belongings on your person—look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can’t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you.', '1', 'CLASS:Bard'),
('Faerie Fire', 'Each object in a 20-foot cube within range is outlined in blue, green, or violet light (your choice). Any creature in the area when the spell is cast is also outlined in light if it fails a Dexterity saving throw. For the duration, objects and affected creatures shed dim light in a 10-foot radius.', '1', 'CLASS:Bard'),
('Feather Fall', 'Choose up to five falling creatures within range. A falling creature’s rate of descent slows to 60 feet per round until the spell ends. If the creature lands before the spell ends, it takes no falling damage and can land on its feet, and the spell ends for that creature.', '1', 'CLASS:Bard'),
('Healing Word', 'A creature of your choice that you can see within range regains hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Bard'),
('Hideous Laughter', 'A creature of your choice that you can see within range perceives everything as hilariously funny and falls into fits of laughter if this spell affects it. The target must succeed on a Wisdom saving throw or fall prone, becoming incapacitated and unable to stand up for the duration. A creature with an Intelligence score of 4 or less isn’t affected. At the end of each of its turns, and each time it takes damage, the target can make another Wisdom saving throw. The target has advantage on the saving throw if it’s triggered by damage. On a success, the spell ends.', '1', 'CLASS:Bard'),
('Identify', 'You choose one object that you must touch throughout the casting of the spell. If it is a magic item or some other magic-imbued object, you learn its properties and how to use them, whether it requires attunement to use, and how many charges it has, if any. You learn whether any spells are affecting the item and what they are. If the item was created by a spell, you learn which spell created it.', '1', 'CLASS:Bard'),
('Illusory Script', 'You write on parchment, paper, or some other suitable writing material and imbue it with a potent illusion that lasts for the duration. To you and any creatures you designate when you cast the spell, the writing appears normal, written in your hand, and conveys whatever meaning you intended when you wrote the text. To all others, the writing appears as if it were written in an unknown or magical script that is unintelligible. Alternatively, you can cause the writing to appear to be an entirely different message, written in a different hand and language, though the language must be one you know. Should the spell be dispelled, the original script and the illusion both disappear.', '1', 'CLASS:Bard'),
('Longstrider', 'You touch a creature. The target’s speed increases by 10 feet until the spell ends.', '1', 'CLASS:Bard'),
('Silent Image', 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 15-­‐‑foot cube. The image appears at a spot within range and lasts for the duration. The image is purely visual; it isn’t accompanied by sound, smell, or other sensory effects. You can use your action to cause the image to move to any spot within range. As the image changes location, you can alter its appearance so that its movements appear natural for the image. For example, if you create an image of a creature and move it, you can alter the image so that it appears to be walking. Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image.', '1', 'CLASS:Bard'),
('Sleep', 'This spell sends creatures into a magical slumber. Roll 5d8; the total is how many hit points of creatures this spell can affect. Creatures within 20 feet of a point you choose within range are affected in ascending order of their current hit points (ignoring unconscious creatures). Starting with the creature that has the lowest current hit points, each creature affected by this spell falls unconscious until the spell ends, the sleeper takes damage, or someone uses an action to shake or slap the sleeper awake. Subtract each creature’s hit points from the total before moving on to the creature with the next lowest hit points. A creature’s hit points must be equal to or less than the remaining total for that creature to be affected.', '1', 'CLASS:Bard'),
('Speak with Animals', 'You gain the ability to comprehend and verbally communicate with beasts for the duration. The knowledge and awareness of many beasts is limited by their intelligence, but at minimum, beasts can give you information about nearby locations and monsters, including whatever they can perceive or have perceived within the past day. You might be able to persuade a beast to perform a small favor for you, at the GM’s discretion.', '1', 'CLASS:Bard'),
('Thunderwave', 'A wave of thunderous force sweeps out from you. Each creature in a 15-­‐‑foot cube originating from you must make a Constitution saving throw. On a failed save, a creature takes 2d8 thunder damage and is pushed 10 feet away from you. On a successful save, the creature takes half as much damage and isn’t pushed.', '1', 'CLASS:Bard'),
('Unseen Servant', 'This spell creates an invisible, mindless, shapeless force that performs simple tasks at your command until the spell ends. The servant springs into existence in an unoccupied space on the ground within range. It has AC 10, 1 hit point, and a Strength of 2, and it can’t attack. If it drops to 0 hit points, the spell ends. Once on each of your turns as a bonus action, you can mentally command the servant to move up to 15 feet and interact with an object. The servant can perform simple tasks that a human servant could do, such as fetching things, cleaning, mending, folding clothes, lighting fires, serving food, and pouring wine. Once you give the command, the servant performs the task to the best of its ability until it completes the task, then waits for your next command. If you command the servant to perform a task that would move it more than 60 feet away from you, the spell ends.', '1', 'CLASS:Bard'),

('Animal Messanger', 'By means of this spell, you use an animal to deliver a message. Choose a Tiny beast you can see within range, such as a squirrel, a blue jay, or a bat. You specify a location, which you must have visited, and a recipient who matches a general description, such as “a man or woman dressed in the uniform of the town guard” or “a red-haired dwarf wearing a pointed hat.” You also speak a message of up to twenty-five words. The target beast travels for the duration of the spell toward the specified location, covering about 50 miles per 24 hours for a flying messenger, or 25 miles for other animals. When the messenger arrives, it delivers your message to the creature that you described, replicating the sound of your voice. The messenger speaks only to a creature matching the description you gave. If the messenger doesn’t reach its destination before the spell ends, the message is lost, and the beast makes its way back to where you cast this spell.', '2', 'CLASS:Bard'),
('Blindness/Deafness', 'You can blind or deafen a foe. Choose one creature that you can see within range to make a Constitution saving throw. If it fails, the target is either blinded or deafened (your choice) for the duration. At the end of each of its turns, the target can make a Constitution saving throw. On a success, the spell ends.', '2', 'CLASS:Bard'),
('Calm Emotions', 'You attempt to suppress strong emotions in a group of people. Each humanoid in a 20-­‐‑foot-­‐‑radius sphere centered on a point you choose within range must make a Charisma saving throw; a creature can choose to fail this saving throw if it wishes. If a creature fails its saving throw, choose one of the following two effects. You can suppress any effect causing a target to be charmed or frightened. When this spell ends, any suppressed effect resumes, provided that its duration has not expired in the meantime. Alternatively, you can make a target indifferent about creatures of your choice that it is hostile toward. This indifference ends if the target is attacked or harmed by a spell or if it witnesses any of its friends being harmed. When the spell ends, the creature becomes hostile again, unless the GM rules otherwise', '2', 'CLASS:Bard'),
('Detect Thoughts', 'For the duration, you can read the thoughts of certain creatures. When you cast the spell and as your action on each turn until the spell ends, you can focus your mind on any one creature that you can see within 30 feet of you. If the creature you choose has an Intelligence of 3 or lower or doesn’t speak any language, the creature is unaffected. You initially learn the surface thoughts of the creature—what is most on its mind in that moment. As an action, you can either shift your attention to another creature’s thoughts or attempt to probe deeper into the same creature’s mind. If you probe deeper, the target must make a Wisdom saving throw. If it fails, you gain insight into its reasoning (if any), its emotional state, and something that looms large in its mind (such as something it worries over, loves, or hates). If it succeeds, the spell ends. Either way, the target knows that you are probing into its mind, and unless you shift your attention to another creature’s thoughts, the creature can use its action on its turn to make an Intelligence check contested by your Intelligence check; if it succeeds, the spell ends.', '2', 'CLASS:Bard'),
('Enhance Ability', 'You touch a creature and bestow upon it a magical enhancement. Choose one of the following effects; the target gains that effect until the spell ends. 
	Bear’s Endurance: The target has advantage on Constitution checks. It also gains 2d6 temporary hit points, which are lost when the spell ends.
	Bull’s Strength: The target has advantage on Strength checks, and his or her carrying capacity doubles.
	Cat’s Grace: The target has advantage on Dexterity checks. It also doesn’t take damage from falling 20 feet or less if it isn’t incapacitated.
	Eagle’s Splendor: The target has advantage on Charisma checks.
	Fox’s Cunning: The target has advantage on Intelligence checks.
	Owl’s Wisdom: The target has advantage on Wisdom checks.', '2', 'CLASS:Bard'),
('Enthrall', 'You weave a distracting string of words, causing creatures of your choice that you can see within range and that can hear you to make a Wisdom saving throw. Any creature that can’t be charmed succeeds on this saving throw automatically, and if you or your companions are fighting a creature, it has advantage on the save. On a failed save, the target has disadvantage on Wisdom (Perception) checks made to perceive any creature other than you until the spell ends or until the target can no longer hear you. The spell ends if you are incapacitated or can no longer speak.', '2', 'CLASS:Bard'),
('Heat Metal', 'Choose a manufactured metal object, such as a metal weapon or a suit of heavy or medium metal armor, that you can see within range. You cause the object to glow red-hot. Any creature in physical contact with the object takes 2d8 fire damage when you cast the spell. Until the spell ends, you can use a bonus action on each of your subsequent turns to cause this damage again. If a creature is holding or wearing the object and takes the damage from it, the creature must succeed on a Constitution saving throw or drop the object if it can. If it doesn’t drop the object, it has disadvantage on attack rolls and ability checks until the start of your next turn.', '2', 'CLASS:Bard'),
('Hold Person', 'Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '2', 'CLASS:Bard'),
('Invisibility', 'A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person. The spell ends for a target that attacks or casts a spell.', '2', 'CLASS:Bard'),
('Knock', 'Choose an object that you can see within range. The object can be a door, a box, a chest, a set of manacles, a padlock, or another object that contains a mundane or magical means that prevents access. A target that is held shut by a mundane lock or that is stuck or barred becomes unlocked, unstuck, or unbarred. If the object has multiple locks, only one of them is unlocked. If you choose a target that is held shut with arcane lock, that spell is suppressed for 10 minutes, during which time the target can be opened and shut normally. When you cast the spell, a loud knock, audible from as far away as 300 feet, emanates from the target object.', '2', 'CLASS:Bard'),
('Lesser Restoration', 'You touch a creature and can end either one disease or one condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned.', '2', 'CLASS:Bard'),
('Locate Animals or Plants', 'Describe or name a specific kind of beast or plant. Concentrating on the voice of nature in your surroundings, you learn the direction and distance to the closest creature or plant of that kind within 5 miles, if any are present.', '2', 'CLASS:Bard'),
('Locate Object', 'Describe or name an object that is familiar to you. You sense the direction to the object’s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement. The spell can locate a specific object known to you, as long as you have seen it up close—within 30 feet—at least once. Alternatively, the spell can locate the nearest object of a particular kind, such as a certain kind of apparel, jewelry, furniture, tool, or weapon.', '2', 'CLASS:Bard'),
('Magic Mouth', 'You implant a message within an object in range, a message that is uttered when a trigger condition is met. Choose an object that you can see and that isn’t being worn or carried by another creature. Then speak the message, which must be 25 words or less, though it can be delivered over as long as 10 minutes. Finally, determine the circumstance that will trigger the spell to deliver your message. When that circumstance occurs, a magical mouth appears on the object and recites the message in your voice and at the same volume you spoke. If the object you chose has a mouth or something that looks like a mouth (for example, the mouth of a statue), the magical mouth appears there so that the words appear to come from the object’s mouth. When you cast this spell, you can have the spell end after it delivers its message, or it can remain and repeat its message whenever the trigger occurs.', '2', 'CLASS:Bard'),
('See Invisibility', 'For the duration, you see invisible creatures and objects as if they were visible, and you can see into the Ethereal Plane. Ethereal creatures and objects appear ghostly and translucent.', '2', 'CLASS:Bard'),
('Shatter', 'A sudden loud ringing noise, painfully intense, erupts from a point of your choice within range. Each creature in a 10-foot-radius sphere centered on that point must make a Constitution saving throw. A creature takes 3d8 thunder damage on a failed save, or half as much damage on a successful one. A creature made of inorganic material such as stone, crystal, or metal has disadvantage on this saving throw.', '2', 'CLASS:Bard'),
('Silence', 'For the duration, no sound can be created within or pass through a 20-­‐‑foot-­‐‑radius sphere centered on a point you choose within range. Any creature or object entirely inside the sphere is immune to thunder damage, and creatures are deafened while entirely inside it. Casting a spell that includes a verbal component is impossible there.', '2', 'CLASS:Bard'),
('Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence a creature you can see within range that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act ends the spell. The target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.', '2', 'CLASS:Bard'),
('Zone of Truth', 'You create a magical zone that guards against deception in a 15-foot-radius sphere centered on a point of your choice within range. Until the spell ends, a creature that enters the spell’s area for the first time on a turn or starts its turn there must make a Charisma saving throw. On a failed save, a creature can’t speak a deliberate lie while in the radius. You know whether each creature succeeds or fails on its saving throw.', '2', 'CLASS:Bard'),

('Bestow Curse', 'Roll a d20 at the end of each of your turns for the duration of the spell. On a roll of 11 or higher, you vanish from your current plane of existence and appear in the Ethereal Plane (the spell fails and the casting is wasted if you were already on that plane). At the start of your next turn, and when the spell ends if you are on the Ethereal Plane, you return to an unoccupied space of your choice that you can see within 10 feet of the space you vanished from. If no unoccupied space is available within that range, you appear in the nearest unoccupied space (chosen at random if more than one space is equally near). You can dismiss this spell as an action. While on the Ethereal Plane, you can see and hear the plane you originated from, which is cast in shades of gray, and you can’t see anything there more than 60 feet away. You can only affect and be affected by other creatures on the Ethereal Plane. Creatures that aren’t there can’t perceive you or interact with you, unless they have the ability to do so.', '3', 'CLASS:Bard'),
('Clairvoyance', 'You create an invisible sensor within range in a location familiar to you (a place you have visited or seen before) or in an obvious location that is unfamiliar to you (such as behind a door, around a corner, or in a grove of trees). The sensor remainsin place for the duration, and it can’t be attacked or otherwise interacted with. When you cast the spell, you choose seeing or hearing. You can use the chosen sense through the sensor as if you were in its space. As your action, you can switch between seeing and hearing. A creature that can see the sensor (such as a creature benefiting from see invisibility or truesight) sees a luminous, intangible orb about the size of your fist.', '3', 'CLASS:Bard'),
('Dispel Magic', 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.', '3', 'CLASS:Bard'),
('Fear', 'You project a phantasmal image of a creature’s worst fears. Each creature in a 30-foot cone must succeed on a Wisdom saving throw or drop whatever it is holding and become frightened for the duration. While frightened by this spell, a creature must take the Dash action and move away from you by the safest available route on each of its turns, unless there is nowhere to move. If the creature ends its turn in a location where it doesn’t have line of sight to you, the creature can make a Wisdom saving throw. On a successful save, the spell ends for that creature.', '3', 'CLASS:Bard'),
('Glyph of Warding', 'When you cast this spell, you inscribe a glyph that harms other creatures, either upon a surface (such as a table or a section of floor or wall) or within an object that can be closed (such as a book, a scroll, or a treasure chest) to conceal the glyph. If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered. You decide what triggers the glyph when you cast the spell. For glyphs inscribed on a surface, the most typical triggers include touching or standing on the glyph, removing another object covering the glyph, approaching within a certain distance of the glyph, or manipulating the object on which the glyph is inscribed. For glyphs inscribed within an object, the most common triggers include opening that object, approaching within a certain distance of the object, or seeing or reading the glyph. Once a glyph is triggered, this spell ends.', '3', 'CLASS:Bard'),
('Hypnotic Pattern', 'You create a twisting pattern of colors that weaves through the air inside a 30-­‐‑foot cube within range. The pattern appears for a moment and vanishes. Each creature in the area who sees the pattern must make a Wisdom saving throw. On a failed save, the creature becomes charmed for the duration. While charmed by this spell, the creature is incapacitated and has a speed of 0.', '3', 'CLASS:Bard'),
('Major Image', 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 20-­‐‑foot cube. The image appears at a spot that you can see within range and lasts for the duration. It seems completely real, including sounds, smells, and temperature appropriate to the thing depicted. You can’t create sufficient heat or cold to cause damage, a sound loud enough to deal thunder damage or deafen a creature, or a smell that might sicken a creature (like a troglodyte’s stench).', '3', 'CLASS:Bard'),
('Nondetection', 'For the duration, you hide a target that you touch from divination magic. The target can be a willing creature or a place or an object no larger than 10 feet in any dimension. The target can’t be targeted by any divination magic or perceived through magical scrying sensors.', '3', 'CLASS:Bard'),
('Plant Growth', 'This spell channels vitality into plants within a specific area. There are two possible uses for the spell, granting either immediate or long-term benefits. If you cast this spell using 1 action, choose a point within range. All normal plants in a 100-foot radius centered on that point become thick and overgrown. A creature moving through the area must spend 4 feet of movement for every 1 foot it moves.', '3', 'CLASS:Bard'),
('Sending', 'You send a short message of twenty-­‐‑five words or less to a creature with which you are familiar. The creature hears the message in its mind, recognizes you as the sender if it knows you, and can answer in a like manner immediately. The spell enables creatures with Intelligence scores of at least 1 to understand the meaning of your message.', '3', 'CLASS:Bard'),
('Speak with Dead', 'You grant the semblance of life and intelligence to a corpse of your choice within range, allowing it to answer the questions you pose. The corpse must still have a mouth and can’t be undead. The spell fails if the corpse was the target of this spell within the last 10 days. Until the spell ends, you can ask the corpse up to five questions. The corpse knows only what it knew in life, including the languages it knew. Answers are usually brief, cryptic, or repetitive, and the corpse is under no compulsion to offer a truthful answer if you are hostile to it or it recognizes you as an enemy. This spell doesn’t return the creature’s soul to its body, only its animating spirit. Thus, the corpse can’t learn new information, doesn’t comprehend anything that has happened since it died, and can’t speculate about future events.', '3', 'CLASS:Bard'),
('Speak with Plants', 'You imbue plants within 30 feet of you with limited sentience and animation, giving them the ability to communicate with you and follow your simple commands. You can question plants about events in the spell’s area within the past day, gaining information about creatures that have passed, weather, and other circumstances. You can also turn difficult terrain caused by plant growth (such as thickets and undergrowth) into ordinary terrain that lasts for the duration. Or you can turn ordinary terrain where plants are present into difficult terrain that lasts for the duration, causing vines and branches to hinder pursuers, for example. Plants might be able to perform other tasks on your behalf, at the GM’s discretion. The spell doesn’t enable plants to uproot themselves and move about, but they can freely move branches, tendrils, and stalks.', '3', 'CLASS:Bard'),
('Stinking Cloud', 'You create a 20-foot-radius sphere of yellow, nauseating gas centered on a point within range. The cloud spreads around corners, and its area is heavily obscured. The cloud lingers in the air for the duration. Each creature that is completely within the cloud at the start of its turn must make a Constitution saving throw against poison. On a failed save, the creature spends its action that turn retching and reeling. Creatures that don’t need to breathe or are immune to poison automatically succeed on this saving throw.', '3', 'CLASS:Bard'),
('Tiny Hut', 'A 10-foot-radius immobile dome of force springs into existence around and above you and remains stationary for the duration. The spell ends if you leave its area.Nine creatures of Medium size or smaller can fit inside the dome with you. The spell fails if its area includes a larger creature or more than nine creatures. Creatures and objects within the dome when you cast this spell can move through it freely. All other creatures and objects are barred from passing through it. Spells and other magical effects can’t extend through the dome or be cast through it. The atmosphere inside the space is comfortable and dry, regardless of the weather outside. Until the spell ends, you can command the interior to become dimly lit or dark. The dome is opaque from the outside, of any color you choose, but it is transparent from the inside.', '3', 'CLASS:Bard'),
('Tongues', 'This spell grants the creature you touch the ability to understand any spoken language it hears. Moreover, when the target speaks, any creature that knows at least one language and can hear the target understands what it says.', '3', 'CLASS:Bard'),

('Compulsion', 'Creatures of your choice that you can see within range and that can hear you must make a Wisdom saving throw. A target automatically succeeds on this saving throw if it can''t be charmed. On a failed save, a target is affected by this spell. Until the spell ends, you can use a bonus action on each of your turns to designate a direction that is horizontal to you. Each affected target must use as much of its movement as possible to move in that direction on its next turn. It can take its action before it moves. After moving in this way, it can make another Wisdom saving to try to end the effect.', '4', 'CLASS:Bard'),
('Confusion', 'This spell assaults and twists creatures’ minds, spawning delusions and provoking uncontrolled action. Each creature in a 10-foot-radius sphere centered on a point you choose within range must succeed on a Wisdom saving throw when you cast this spell or be affected by it. An affected target can’t take reactions and must roll a d10 at the start of each of its turns to determine its behavior for that turn.
	d10	Behavior
	1	The creature uses all its movement to move in a random direction.
		To determine the direction, roll a d8 and assign a direction to each die face.
		The creature doesn''t take an action this turn.
	2-6	The creature doesn''t move or take actions this turn.
	7-8	The creature uses its action to make a melee attack against a randomly determined creature within its reach. If there is no creature within its reach, the creature does nothing this turn.
	9-10The creature can act and move normally.', '4', 'CLASS:Bard'),
('Dimension Door', 'You teleport yourself from your current location to any other spot within range. You arrive at exactly the spot desired. It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction, such as “200 feet straight downward” or “upward to the northwest at a 45-degree angle, 300 feet.” You can bring along objects as long as their weight doesn’t exceed what you can carry.', '4', 'CLASS:Bard'),
('Freedom of Movement', 'You touch a willing creature. For the duration, the target’s movement is unaffected by difficult terrain, and spells and other magical effects can neither reduce the target’s speed nor cause the target to be paralyzed or restrained.', '4', 'CLASS:Bard'),
('Greater Invisibilty', 'You or a creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person.', '4', 'CLASS:Bard'),
('Hallucatory Terrain', 'You make natural terrain in a 150-made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Manufactured structures, equipment, and creatures within the area aren’t changed in appearance.', '4', 'CLASS:Bard'),
('Locate Creature', 'Describe or name a creature that is familiar to you. You sense the direction to the creature’s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement. The spell can locate a specific creature known to you, or the nearest creature of a specific kind (such as a human or a unicorn), so long as you have seen such a creature up close—within 30 feet—at least once. If the creature you described or named is in a different form, such as being under the effects of a polymorph spell, this spell doesn’t locate the creature.', '4', 'CLASS:Bard'),
('Polymorph', 'This spell transforms a creature that you can see within range into a new form. An unwilling creature must make a Wisdom saving throw to avoid the effect. The spell has no effect on a shapechanger or a creature with 0 hit points.', '4', 'CLASS:Bard'),

('Animate Objects', 'Objects come to life at your command. Choose up to ten nonmagical objects within range that are not being worn or carried. Medium targets count as two objects, Large targets count as four objects, Huge targets count as eight objects. You can’t animate any object larger than Huge. Each target animates and becomes a creature under your control until the spell ends or until reduced to 0 hit points.
	Size	HP	AC	Attack	Str	Dex
	Tiny	20	18	+8 to hit, 1d4 + 4 damage	4	`8
	Small	25	16	+6 to hit, 1d8 + 2 damage	6	14
	Medium	40	13	+5 to hit, 2d6 + 1 damage	10	12
	Large	50	10	+6 to hit, 2d10 + 2 damage	14	10
	Huge	80	10	+8 to hit, 2d12 + 4 damage	18	6', '5', 'CLASS:Bard'),
('Awaken', 'After spending the casting time tracing magical pathways within a precious gemstone, you touch a Huge or smaller beast or plant. The target must have either no Intelligence score or an Intelligence of 3 or less. The target gains an Intelligence of 10. The target also gains the ability to speak one language you know. If the target is a plant, it gains the ability to move its limbs, roots, vines, creepers, and so forth, and it gains senses similar to a human’s. Your GM chooses statistics appropriate for the awakened plant, such as the statistics for the awakened shrub or the awakened tree.', '5', 'CLASS:Bard'),
('Dream', 'This spell shapes a creature’s dreams. Choose a creature known to you as the target of this spell. The target must be on the same plane of existence as you. Creatures that don’t sleep, such as elves, can’t be contacted by this spell. You, or a willing creature you touch, enters a trance state, acting as a messenger. While in the trance, the messenger is aware of his or her surroundings, but can’t take actions or move. If the target is asleep, the messenger appears in the target’s dreams and can converse with the target as long as it remains asleep, through the duration of the spell. The messenger can also shape the environment of the dream, creating landscapes, objects, and other images. The messenger can emerge from the trance at any time, ending the effect of the spell early. The target recalls the dream perfectly upon waking. If the target is awake when you cast the spell, the messenger knows it, and can either end the trance (and the spell) or wait for the target to fall asleep, at which point the messenger appears in the target’s dreams.', '5', 'CLASS:Bard'),
('Geas', 'You place a magical command on a creature that you can see within range, forcing it to carry out some service or refrain from some action or course of activity as you decide. If the creature can understand you, it must succeed on a Wisdom saving throw or become charmed by you for the duration. While the creature is charmed by you, it takes 5d10 psychic damage each time it acts in a manner directly counter to your instructions, but no more than once each day. A creature that can’t understand you is unaffected by the spell. You can issue any command you choose, short of an activity that would result in certain death. Should you issue a suicidal command, the spell ends.You can end the spell early by using an action to dismiss it. A remove curse, greater restoration, or wish spell also ends it.', '5', 'CLASS:Bard'),
('Greater Restoration', 'You imbue a creature you touch with positive energy to undo a debilitating effect. You can reduce the target’s exhaustion level by one, or end one of the following effects on the target: One effect that charmed or petrified the target OR One curse, including the target''s attunement to a cursed magic item. OR Any reduction to one of the target''s ability scores. OR One effect reducing the target''s hit point maximum', '5', 'CLASS:Bard'),
('Hold Monster', 'Choose a creature that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. This spell has no effect on undead. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '5', 'CLASS:Bard'),
('Legend Lore', 'Name or describe a person, place, or object. The spell brings to your mind a brief summary of the significant lore about the thing you named. The lore might consist of current tales, forgotten stories, or even secret lore that has never been widely known. If the thing you named isn’t of legendary importance, you gain no information. The more information you already have about the thing, the more precise and detailed the information you receive is.', '5', 'CLASS:Bard'),
('Mass Cure Wounds', 'A wave of healing energy washes out from a point of your choice within range. Choose up to six creatures in a 30-foot-radius sphere centered on that point. Each target regains hit points equal to 3d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '5', 'CLASS:Bard'),
('Mislead', 'You become invisible at the same time that an illusory double of you appears where you are standing. The double lasts for the duration, but the invisibility ends if you attack or cast a spell. You can use your action to move your illusory double up to twice your speed and make it gesture, speak, and behave in whatever way you choose. You can see through its eyes and hear through its ears as if you were located where it is. On each of your turns as a bonus action, you can switch from using its senses to using your own, or back again. While you are using its senses, you are blinded and deafened in regard to your own surroundings.', '5', 'CLASS:Bard'),
('Modify Memory', 'You attempt to reshape another creature’s memories. One creature that you can see must make a Wisdom saving throw. If you are fighting the creature, it has advantage on the saving throw. On a failed save, the target becomes charmed by you for the duration. The charmed target is incapacitated and unaware of its surroundings, though it can still hear you. If it takes any damage or is targeted by another spell, this spell ends, and none of the target’s memories are modified. While this charm lasts, you can affect the target’s memory of an event that it experienced within the last 24 hours and that lasted no more than 10 minutes. You can permanently eliminate all memory of the event, allow the target to recall the event with perfect clarity and exacting detail, change its memory of the details of the event, or create a memory of some other event.', '5', 'CLASS:Bard'),
('Planar Binding', 'With this spell, you attempt to bind a celestial, an elemental, a fey, or a fiend to your service. The creature must be within range for the entire casting of the spell. (Typically, the creature is first summoned into the center of an inverted magic circle in order to keep it trapped while this spell is cast.) At the completion of the casting, the target must make a Charisma saving throw. On a failed save, it is bound to serve you for the duration. If the creature was summoned or created by another spell, that spell’s duration is extended to match the duration of this spell. A bound creature must follow your instructions to the best of its ability. You might command the creature to accompany you on an adventure, to guard a location, or to deliver a message. The creature obeys the letter of your instructions, but if the creature is hostile to you, it strives to twist your words to achieve its own objectives. If the creature carries out your instructions completely before the spell ends, it travels to you to report this fact if you are on the same plane of existence. If you are on a different plane of existence, it returns to the place where you bound it and remains there until the spell ends.', '5', 'CLASS:Bard'),
('Raise Dead', 'You return a dead creature you touch to life, provided that it has been dead no longer than 10 days. If the creature’s soul is both willing and at liberty to rejoin the body, the creature returns to life with 1 hit point. This spell also neutralizes any poisons and cures nonmagical diseases that affected the creature at the time it died. This spell doesn’t, however, remove magical diseases, curses, or similar effects; if these aren’t first removed prior to casting the spell, they take effect when the creature returns to life. The spell can’t return an undead creature to life. This spell closes all mortal wounds, but it doesn’t restore missing body parts. If the creature is lacking body parts or organs integral for its survival—its head, for instance—the spell automatically fails.', '5', 'CLASS:Bard'),
('Scrying', 'You can see and hear a particular creature you choose that is on the same plane of existence as you. The target must make a Wisdom saving throw, which is modified by how well you know the target and the sort of physical connection you have to it. If a target knows you’re casting this spell, it can fail the saving throw voluntarily if it wants to be observed. On a successful save, the target isn’t affected, and you can’t use this spell against it again for 24 hours. On a failed save, the spell creates an invisible sensor within 10 feet of the target. You can see and hear through the sensor as if you were there. The sensor moves with the target, remaining within 10 feet of it for the duration. A creature that can see invisible objects sees the sensor as a luminous orb about the size of your fist.', '5', 'CLASS:Bard'),
('Seeming', 'This spell allows you to change the appearance of any number of creatures that you can see within range. You give each target you choose a new, illusory appearance. An unwilling target can make a Charisma saving throw, and if it succeeds, it is unaffected by this spell. The spell disguises physical appearance as well as clothing, armor, weapons, and equipment. You can make each creature seem 1 foot shorter or taller and appear thin, fat, or in between. You can’t change a target’s body type, so you must choose a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you. The spell lasts for the duration, unless you use your action to dismiss it sooner.', '5', 'CLASS:Bard'),
('Teleportation Circle', 'As you cast the spell, you draw a 10-foot-diameter circle on the ground inscribed with sigils that link your location to a permanent teleportation circle of your choice whose sigil sequence you know and that is on the same plane of existence as you. A shimmering portal opens within the circle you drew and remains open until the end of your next turn. Any creature that enters the portal instantly appears within 5 feet of the destination circle or in the nearest unoccupied space if that space is occupied.', '5', 'CLASS:Bard'),

('Eyebite', 'For the spell’s duration, your eyes become an inky void imbued with dread power. One creature of your choice within 60 feet of you that you can see must succeed on a Wisdom saving throw or be affected by one of the following effects of your choice for the duration. On each of your turns until the spell ends, you can use your action to target another creature but can’t target a creature again if it has succeeded on a saving throw against this casting of eyebite.
	Asleep. The target falls unconscious. It wakes up if it takes any damage or if another creature uses its action to shake the sleeper awake.
	Panicked. The target is frightened of you. On each of its turns, the frightened creature must take the Dash action and move away from you by the safest and shortest available route, unless there is nowhere to move. If the target moves to a place at least 60 feet away from you where it can no longer see you, this effect ends.', '6', 'CLASS:Bard'),
('Find the Path', 'This spell allows you to find the shortest, most direct physical route to a specific fixed location that you are familiar with on the same plane of existence. If you name a destination on another plane of existence, a destination that moves (such as a mobile fortress), or a destination that isn’t specific (such as “a green dragon’s lair”), the spell fails. For the duration, as long as you are on the same plane of existence as the destination, you know how far it is and in what direction it lies. While you are traveling there, whenever you are presented with a choice of paths along the way, you automatically determine which path is the shortest and most direct route (but not necessarily the safest route) to the destination. ', '6', 'CLASS:Bard'),
('Guards and Wards', 'You create a ward that protects up to 2,500 square feet of floor space (an area 50 feet square, or one hundred 5-foot squares or twenty-five 10-foot squares). The warded area can be up to 20 feet tall, and shaped as you desire. You can ward several stories of a stronghold by dividing the area among them, as long as you can walk into each contiguous area while you are casting the spell. When you cast this spell, you can specify individuals that are unaffected by any or all of the effects that you choose. You can also specify a password that, when spoken aloud, makes the speaker immune to these effects. Guards and wards creates the following effects within the warded area.', '6', 'CLASS:Bard'),
('Irresistible Dance', 'Choose one creature that you can see within range. The target begins a comic dance in place: shuffling, tapping its feet, and capering for the duration. Creatures that can’t be charmed are immune to this spell. A dancing creature must use all its movement to dance without leaving its space and has disadvantage on Dexterity saving throws and attack rolls. While the target is affected by this spell, other creatures have advantage on attack rolls against it. As an action, a dancing creature makes a Wisdom saving throw to regain control of itself. On a successful save, the spell ends.', '6', 'CLASS:Bard'),
('Mass Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence up to twelve creatures of your choice that you can see within range and that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act automatically negates the effect of the spell. Each target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.', '6', 'CLASS:Bard'),
('Programmed Illusion', 'You create an illusion of an object, a creature, or some other visible phenomenon within range that activates when a specific condition occurs. The illusion is imperceptible until then. It must be no larger than a 30-­‐‑foot cube, and you decide when you cast the spell how the illusion behaves and what sounds it makes. This scripted performance can last up to 5 minutes. When the condition you specify occurs, the illusion springs into existence and performs in the manner you described. Once the illusion finishes performing, it disappears and remains dormant for 10 minutes. After this time, the illusion can be activated again.', '6', 'CLASS:Bard'),
('True Seeing', 'This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', '6', 'CLASS:Bard'),

('Arcane Sword', 'You create a sword-shaped plane of force that hovers within range. It lasts for the duration. When the sword appears, you make a melee spell attack against a target of your choice within 5 feet of the sword. On a hit, the target takes 3d10 force damage. Until the spell ends, you can use a bonus action on each of your turns to move the sword up to 20 feet to a spot you can see and repeat this attack against the same target or a different one.', '7', 'CLASS:Bard'),
('Etherealness', 'You step into the border regions of the Ethereal Plane, in the area where it overlaps with your current plane. You remain in the Border Ethereal for the duration or until you use your action to dismiss the spell. During this time, you can move in any direction. If you move up or down, every foot of movement costs an extra foot. You can see and hear the plane you originated from, but everything there looks gray, and you can’t see anything more than 60 feet away. While on the Ethereal Plane, you can only affect and be affected by other creatures on that plane. Creatures that aren’t on the Ethereal Plane can’t perceive you and can’t interact with you, unless a special ability or magic has given them the ability to do so. You ignore all objects and effects that aren’t on the Ethereal Plane, allowing you to move through objects you perceive on the plane you originated from. When the spell ends, you immediately return to the plane you originated from in the spot you currently occupy. If you occupy the same spot as a solid object or creature when this happens, you are immediately shunted to the nearest unoccupied space that you can occupy and take force damage equal to twice the number of feet you are moved.', '7', 'CLASS:Bard'),
('Forcecage', 'An immobile, invisible, cube-shaped prison composed of magical force springs into existence around an area you choose within range. The prison can be a cage or a solid box, as you choose. A prison in the shape of a cage can be up to 20 feet on a side and is made from 1/2-inch diameter bars spaced 1/2 inch apart.A prison in the shape of a box can be up to 10 feet on a side, creating a solid barrier that prevents any matter from passing through it and blocking any spells cast into or out from the area.When you cast the spell, any creature that is completely inside the cage’s area is trapped. Creatures only partially within the area, or those too large to fit inside the area, are pushed away from the center of the area until they are completely outside the area. A creature inside the cage can’t leave it by nonmagical means. If the creature tries to use teleportation or interplanar travel to leave the cage, it must first make a Charisma saving throw. On a success, the creature can use that magic to exit the cage. On a failure, the creature can’t exit the cage and wastes the use of the spell or effect. The cage also extends into the Ethereal Plane, blocking ethereal travel.', '7', 'CLASS:Bard'),
('Magnificent Mansion', 'You conjure an extradimensional dwelling in range that lasts for the duration. You choose where its one entrance is located. The entrance shimmers faintly and is 5 feet wide and 10 feet tall. You and any creature you designate when you cast the spell can enter the extradimensional dwelling as long as the portal remains open. You can open or close the portal if you are within 30 feet of it. While closed, the portal is invisible. Beyond the portal is a magnificent foyer with numerous chambers beyond. The atmosphere is clean, fresh, and warm.', '7', 'CLASS:Bard'),
('Mirage Arcane', 'You make terrain in an area up to 1 mile square look, sound, smell, and even feel like some other sort of terrain. The terrain’s general shape remains the same, however. Open fields or a road could be made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Similarly, you can alter the appearance of structures, or add them where none are present. The spell doesn’t disguise, conceal, or add creatures.The illusion includes audible, visual, tactile, and olfactory elements, so it can turn clear ground into difficult terrain (or vice versa) or otherwise impede movement through the area. Any piece of the illusory terrain (such as a rock or stick) that is removed from the spell’s area disappears immediately.', '7', 'CLASS:Bard'),
('Project Image', 'You create an illusory copy of yourself that lasts for the duration. The copy can appear at any location within range that you have seen before, regardless of intervening obstacles. The illusion looks and sounds like you but is intangible. If the illusion takes any damage, it disappears, and the spell ends. You can use your action to move this illusion up to twice your speed, and make it gesture, speak, and behave in whatever way you choose. It mimics your mannerisms perfectly. You can see through its eyes and hear through its ears as if you were in its space. On your turn as a bonus action, you can switch from using its senses to using your own, or back again. While you are using its senses, you are blinded and deafened in regard to your own surroundings.', '7', 'CLASS:Bard'),
('Regenerate', 'You touch a creature and stimulate its natural healing ability. The target regains 4d8 + 15 hit points. For the duration of the spell, the target regains 1 hit point at the start of each of its turns (10 hit points each minute). The target’s severed body members (fingers, legs, tails, and so on), if any, are restored after 2 minutes. If you have the severed part and hold it to the stump, the spell instantaneously causes the limb to knit to the stump.', '7', 'CLASS:Bard'),
('Ressurection', 'You touch a dead creature that has been dead for no more than a century, that didn’t die of old age, and that isn’t undead. If its soul is free and willing, the target returns to life with all its hit points. This spell neutralizes any poisons and cures normal diseases afflicting the creature when it died. It doesn’t, however, remove magical diseases, curses, and the like; if such effects aren’t removed prior to casting the spell, they afflict the target on its return to life. This spell closes all mortal wounds and restores any missing body parts. Coming back from the dead is an ordeal. The target takes a −4 penalty to all attack rolls, saving throws, and ability checks. Every time the target finishes a long rest, the penalty is reduced by 1 until it disappears.', '7', 'CLASS:Bard'),
('Symbol', 'When you cast this spell, you inscribe a harmful glyph either on a surface (such as a section of floor, a wall, or a table) or within an object that can be closed to conceal the glyph (such as a book, a scroll, or a treasure chest). If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered. You decide what triggers the glyph when you cast the spell. For glyphs inscribed on a surface, the most typical triggers include touching or stepping on the glyph, removing another object covering it, approaching within a certain distance of it, or manipulating the object that holds it. For glyphs inscribed within an object, the most common triggers are opening the object, approaching within a certain distance of it, or seeing or reading the glyph.', '7', 'CLASS:Bard'),
('Teleport', 'This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can’t be held or carried by an unwilling creature.', '7', 'CLASS:Bard'),

('Dominate Monster', 'You attempt to beguile a creature that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw. While the creature is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as “Attack that creature,” “Run over there,” or “Fetch that object.” If the creature completes the order and doesn’t receive further direction from you, it defends and preserves itself to the best of its ability.', '8', 'CLASS:Bard'),
('Feeble Mind', 'You blast the mind of a creature that you can see within range, attempting to shatter its intellect and personality. The target takes 4d6 psychic damage and must make an Intelligence saving throw. On a failed save, the creature’s Intelligence and Charisma scores become 1. The creature can’t cast spells, activate magic items, understand language, or communicate in any intelligible way. The creature can, however, identify its friends, follow them, and even protect them.', '8', 'CLASS:Bard'),
('Glibness', 'Until the spell ends, when you make a Charisma check, you can replace the number you roll with a 15. Additionally, no matter what you say, magic that would determine if you are telling the truth indicates that you are being truthful.', '8', 'CLASS:Bard'),
('Mind Blank', 'Until the spell ends, one willing creature you touch is immune to psychic damage, any effect that would sense its emotions or read its thoughts, divination spells, and the charmed condition. The spell even foils wish spells and spells or effects of similar power used to affect the target’s mind or to gain information about the target.', '8', 'CLASS:Bard'),
('Power Word Stun', 'You speak a word of power that can overwhelm the mind of one creature you can see within range, leaving it dumbfounded. If the target has 150 hit points or fewer, it is stunned. Otherwise, the spell has no effect. The stunned target must make a Constitution saving throw at the end of each of its turns. On a successful save, this stunning effect ends.', '8', 'CLASS:Bard'),

('Foresight', 'You touch a willing creature and bestow a limited ability to see into the immediate future. For the duration, the target can’t be surprised and has advantage on attack rolls, ability checks, and saving throws. Additionally, other creatures have disadvantage on attack rolls against the target for the duration. This spell immediately ends if you cast it again before its duration ends.', '9', 'CLASS:Bard'),
('Power Word Kill', 'You utter a word of power that can compel one creature you can see within range to die instantly. If the creature you choose has 100 hit points or fewer, it dies. Otherwise, the spell has no effect.', '9', 'CLASS:Bard'),
('True Polymorph', 'Choose one creature or nonmagical object that you can see within range. You transform the creature into a different creature, the creature into an object, or the object into a creature (the object must be neither worn nor carried by another creature). The transformation lasts for the duration, or until the target drops to 0 hit points or dies. If you concentrate on this spell for the full duration, the transformation lasts until it is dispelled. This spell has no effect on a shapechanger or a creature with 0 hit points. An unwilling creature can make a Wisdom saving throw, and if it succeeds, it isn’t affected by this spell.', '9', 'CLASS:Bard'),

('Guidance', 'You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one ability check of its choice. It can roll the die before or after making the ability check. The spell then ends.', '0', 'CLASS:Cleric'),
('Light', 'You touch one object that is no larger than 10 feet in any dimension. Until the spell ends, the object sheds bright light in a 20-foot radius and dim light for an additional 20 feet. The light can be colored as you like. Completely covering the object with something opaque blocks the light. The spell ends if you cast it again or dismiss it as an action.', '0', 'CLASS:Cleric'),
('Mending', 'This spell repairs a single break or tear in an object you touch, such as a broken chain link, two halves of a broken key, a torn cloak, or a leaking wineskin. As long as the break or tear is no larger than 1 foot in any dimension, you mend it, leaving no trace of the former damage. This spell can physically repair a magic item or construct, but the spell can’t restore magic to such an object.', '0', 'CLASS:Cleric'),
('Resistance', 'You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one saving throw of its choice. It can roll the die before or after making the saving throw. The spell then ends.', '0', 'CLASS:Cleric'),
('Sacred Flame', 'Flame-like radiance descends on a creature that you can see within range. The target must succeed on a Dexterity saving throw or take 1d8 radiant damage. The target gains no benefit from cover for this saving throw.', '0', 'CLASS:Cleric'),
('Spare the Dying', 'You touch a living creature that has 0 hit points. The creature becomes stable. This spell has no effect on undead or constructs.', '0', 'CLASS:Cleric'),
('Thaumaturgy', 'You manifest a minor wonder, a sign of supernatural power, within range. You create one of the following magical effects within range:
	Your voice booms up to three times as loud as normal for 1 minute.
	You cause flames to flicker, brighten, dim, or change color for 1 minute.
	You cause harmless tremors in the ground for 1 minute.
	You create an instantaneous sound that originates from a point of your choice within range, such as a rumble of thunder, the cry of a raven, or ominous whispers.
	You instantaneously cause an unlocked door or window to fly open or slam shut.
	You alter the appearance of your eyes for 1 minute.', '0', 'CLASS:Cleric'),

('Bane', 'Up to three creatures of your choice that you can see within range must make Charisma saving throws. Whenever a target that fails this saving throw makes an attack roll or a saving throw before the spell ends, the target must roll a d4 and subtract the number rolled from the attack roll or saving throw.', '1', 'CLASS:Cleric'),
('Bless', 'You bless up to three creatures of your choice within range. Whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw.', '1', 'CLASS:Cleric'),
('Command', 'You speak a one-word command to a creature you can see within range. The target must succeed on a Wisdom saving throw or follow the command on its next turn. The spell has no effect if the target is undead, if it doesn’t understand your language, or if your command is directly harmful to it. Some typical commands and their effects follow. You might issue a command other than one described here. If you do so, the GM determines how the target behaves. If the target can’t follow your command, the spell ends.', '1', 'CLASS:Cleric'),
('Create or Destroy Water', 'You either create or destroy water. Create Water: You create up to 10 gallons of clean water within range in an open container. Alternatively, the water falls as rain in a 30-foot cube within range, extinguishing exposed flames in the area. Destroy Water: You destroy up to 10 gallons of water in an open container within range. Alternatively, you destroy fog in a 30-foot cube within range.', '1', 'CLASS:Cleric'),
('Cure Wounds', 'A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Cleric'),
('Detect Evil and Good', 'For the duration, you know if there is an aberration, celestial, elemental, fey, fiend, or undead within 30 feet of you, as well as where the creature is located. Similarly, you know if there is a place or object within 30 feet of you that has been magically consecrated or desecrated.', '1', 'CLASS:Cleric'),
('Detect Magic', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.', '1', 'CLASS:Cleric'),
('Detect Poison and Disease', 'For the duration, you can sense the presence and location of poisons, poisonous creatures, and diseases within 30 feet of you. You also identify the kind of poison, poisonous creature, or disease in each case. The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt.', '1', 'CLASS:Cleric'),
('Guiding Bolt', 'A flash of light streaks toward a creature of your choice within range. Make a ranged spell attack against the target. On a hit, the target takes 4d6 radiant damage, and the next attack roll made against this target before the end of your next turn has advantage, thanks to the mystical dim light glittering on the target until then.', '1', 'CLASS:Cleric'),
('Healing Word', 'A creature of your choice that you can see within range regains hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Cleric'),
('Inflict Wounds', 'Make a melee spell attack against a creature you can reach. On a hit, the target takes 3d10 necrotic damage.', '1', 'CLASS:Cleric'),
('Purify Food and Drink', 'All nonmagical food and drink within a 5-foot-radius sphere centered on a point of your choice within range is purified and rendered free of poison and disease.', '1', 'CLASS:Cleric'),
('Sanctuary', 'You ward a creature within range against attack. Until the spell ends, any creature who targets the warded creature with an attack or a harmful spell must first make a Wisdom saving throw. On a failed save, the creature must choose a new target or lose the attack or spell. This spell doesn’t protect the warded creature from area effects, such as the explosion of a fireball. If the warded creature makes an attack or casts a spell that affects an enemy creature, this spell ends.', '1', 'CLASS:Cleric'),
('Shield of Faith', 'A shimmering field appears and surrounds a creature of your choice within range, granting it a +2 bonus to AC for the duration.', '1', 'CLASS:Cleric'),

('Aid', 'Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target’s hit point maximum and current hit points increase by 5 for the duration.', '2', 'CLASS:Cleric'),
('Augury', 'By casting gem-inlaid sticks, rolling dragon bones, laying out ornate cards, or employing some other divining tool, you receive an omen from an otherworldly entity about the results of a specific course of action that you plan to take within the next 30 minutes. The GM chooses from the following possible omens:
	Weal, for good results
	Woe, for bad results
	Weal and woe, for both
	Nothing, for actions that don’t have especially good or bad results', '2', 'CLASS:Cleric'),
('Blindness/Deafness', 'You can blind or deafen a foe. Choose one creature that you can see within range to make a Constitution saving throw. If it fails, the target is either blinded or deafened (your choice) for the duration. At the end of each of its turns, the target can make a Constitution saving throw. On a success, the spell ends.', '2', 'CLASS:Cleric'),
('Calm Emotions', 'You attempt to suppress strong emotions in a group of people. Each humanoid in a 20-­‐‑foot-­‐‑radius sphere centered on a point you choose within range must make a Charisma saving throw; a creature can choose to fail this saving throw if it wishes. If a creature fails its saving throw, choose one of the following two effects. You can suppress any effect causing a target to be charmed or frightened. When this spell ends, any suppressed effect resumes, provided that its duration has not expired in the meantime.', '2', 'CLASS:Cleric'),
('Continual Flame', 'A flame, equivalent in brightness to a torch, springs forth from an object that you touch. The effect looks like a regular flame, but it creates no heat and doesn’t use oxygen. A continual flame can be covered or hidden but not smothered or quenched.', '2', 'CLASS:Cleric'),
('Enhance Ability', 'You touch a creature and bestow upon it a magical enhancement. Choose one of the following effects; the target gains that effect until the spell ends. 
	Bear’s Endurance: The target has advantage on Constitution checks. It also gains 2d6 temporary hit points, which are lost when the spell ends.
	Bull’s Strength: The target has advantage on Strength checks, and his or her carrying capacity doubles.
	Cat’s Grace: The target has advantage on Dexterity checks. It also doesn’t take damage from falling 20 feet or less if it isn’t incapacitated.
	Eagle’s Splendor: The target has advantage on Charisma checks.
	Fox’s Cunning: The target has advantage on Intelligence checks.
	Owl’s Wisdom: The target has advantage on Wisdom checks.', '2', 'CLASS:Cleric'),
('Find Traps', 'You sense the presence of any trap within range that is within line of sight. A trap, for the purpose of this spell, includes anything that would inflict a sudden or unexpected effect you consider harmful or undesirable, which was specifically intended as such by its creator. Thus, the spell would sense an area affected by the alarm spell, a glyph of warding, or a mechanical pit trap, but it would not reveal a natural weakness in the floor, an unstable ceiling, or a hidden sinkhole.', '2', 'CLASS:Cleric'),
('Gentle Repose', 'You touch a corpse or other remains. For the duration, the target is protected from decay and can’t become undead.', '2', 'CLASS:Cleric'),
('Hold Person', 'Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '2', 'CLASS:Cleric'),
('Lesser Restoration', 'You touch a creature and can end either one disease or one condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned.', '2', 'CLASS:Cleric'),
('Locate Object', 'Describe or name an object that is familiar to you. You sense the direction to the object’s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement. The spell can locate a specific object known to you, as long as you have seen it up close—within 30 feet—at least once. Alternatively, the spell can locate the nearest object of a particular kind, such as a certain kind of apparel, jewelry, furniture, tool, or weapon.', '2', 'CLASS:Cleric'),
('Prayer', 'Up to six creatures of your choice that you can see within range each regain hit points equal to 2d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '2', 'CLASS:Cleric'),
('Protection from Poison', 'You touch a creature. If it is poisoned, you neutralize the poison. If more than one poison afflicts the target, you neutralize one poison that you know is present, or you neutralize one at random. For the duration, the target has advantage on saving throws against being poisoned, and it has resistance to poison damage.', '2', 'CLASS:Cleric'),
('Silence', 'For the duration, no sound can be created within or pass through a 20-­‐‑foot-­‐‑radius sphere centered on a point you choose within range. Any creature or object entirely inside the sphere is immune to thunder damage, and creatures are deafened while entirely inside it. Casting a spell that includes a verbal component is impossible there.', '2', 'CLASS:Cleric'),
('Spiritual Weapon', 'You create a floating, spectral weapon within range that lasts for the duration or until you cast this spell again. When you cast the spell, you can make a melee spell attack against a creature within 5 feet of the weapon. On a hit, the target takes force damage equal to 1d8 + your spellcasting ability modifier. As a bonus action on your turn, you can move the weapon up to 20 feet and repeat the attack against a creature within 5 feet of it. The weapon can take whatever form you choose. Clerics of deities who are associated with a particular weapon (as St. Cuthbert is known for his mace and Thor for his hammer) make this spell’s effect resemble that weapon.', '2', 'CLASS:Cleric'),
('Warding Bond', 'This spell wards a willing creature you touch and creates a mystic connection between you and the target until the spell ends. While the target is within 60 feet of you, it gains a +1 bonus to AC and saving throws, and it has resistance to all damage. Also, each time it takes damage, you take the same amount of damage. The spell ends if you drop to 0 hit points or if you and the target become separated by more than 60 feet. It also ends if the spell is cast again on either of the connected creatures. You can also dismiss the spell as an action.', '2', 'CLASS:Cleric'),
('Zone of Truth', 'You create a magical zone that guards against deception in a 15-foot-radius sphere centered on a point of your choice within range. Until the spell ends, a creature that enters the spell’s area for the first time on a turn or starts its turn there must make a Charisma saving throw. On a failed save, a creature can’t speak a deliberate lie while in the radius. You know whether each creature succeeds or fails on its saving throw.', '2', 'CLASS:Cleric'),

('Animate Dead', 'This spell creates an undead servant. Choose a pile of bones or a corpse of a Medium or Small humanoid within range. Your spell imbues the target with a foul mimicry of life, raising it as an undead creature. The target becomes a skeleton if you chose bones or a zombie if you chose a corpse (the GM has the creature’s game statistics). On each of your turns, you can use a bonus action to mentally command any creature you made with this spell if the creature is within 60 feet of you (if you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one). You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature only defends itself against hostile creatures. Once given an order, the creature continues to follow it until its task is complete.', '3', 'CLASS:Cleric'),
('Beacon of Hope', 'This spell bestows hope and vitality. Choose any number of creatures within range. For the duration, each target has advantage on Wisdom saving throws and death saving throws, and regains the maximum number of hit points possible from any healing.', '3', 'CLASS:Cleric'),
('Bestow Cures', 'You touch a creature, and that creature must succeed on a Wisdom saving throw or become cursed for the duration of the spell. When you cast this spell, choose the nature of the curse from the following options:
	Choose one ability score. While cursed, the target has disadvantage on ability checks and saving throws made with that ability score.
	While cursed, the target has disadvantage on attack rolls against you.
	While cursed, the target must make a Wisdom saving throw at the start of each of its turns. If it fails, it wastes its action that turn doing nothing.
	While the target is cursed, your attacks and spells deal an extra 1d8 necrotic damage to the target.', '3', 'CLASS:Cleric'),
('Clairvoyance', 'You create an invisible sensor within range in a location familiar to you (a place you have visited or seen before) or in an obvious location that is unfamiliar to you (such as behind a door, around a corner, or in a grove of trees). The sensor remainsin place for the duration, and it can’t be attacked or otherwise interacted with. When you cast the spell, you choose seeing or hearing. You can use the chosen sense through the sensor as if you were in its space. As your action, you can switch between seeing and hearing.', '3', 'CLASS:Cleric'),
('Create Food and Water', 'You create 45 pounds of food and 30 gallons of water on the ground or in containers within range, enough to sustain up to fifteen humanoids or five steeds for 24 hours. The food is bland but nourishing, and spoils if uneaten after 24 hours. The water is clean and doesn’t go bad.', '3', 'CLASS:Cleric'),
('Daylight', 'A 60-foot-radius sphere of light spreads out from a point you choose within range. The sphere is bright light and sheds dim light for an additional 60 feet. If you chose a point on an object you are holding or one that isn’t being worn or carried, the light shines from the object and moves with it. Completely covering the affected object with an opaque object, such as a bowl or a helm, blocks the light.', '3', 'CLASS:Cleric'),
('Dispel Magic', 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.', '3', 'CLASS:Cleric'),
('Glyph of Warding', 'When you cast this spell, you inscribe a glyph that harms other creatures, either upon a surface (such as a table or a section of floor or wall) or within an object that can be closed (such as a book, a scroll, or a treasure chest) to conceal the glyph. If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered. You decide what triggers the glyph when you cast the spell. For glyphs inscribed on a surface, the most typical triggers include touching or standing on the glyph, removing another object covering the glyph, approaching within a certain distance of the glyph, or manipulating the object on which the glyph is inscribed. For glyphs inscribed within an object, the most common triggers include opening that object, approaching within a certain distance of the object, or seeing or reading the glyph. Once a glyph is triggered, this spell ends.', '3', 'CLASS:Cleric'),
('Magic Circle', 'You create a 10-foot-radius, 20-foot-tall cylinder of magical energy centered on a point on the ground that you can see within range. Glowing runes appear wherever the cylinder intersects with the floor or other surface. Choose one or more of the following types of creatures: celestials, elementals, fey, fiends, or undead. The circle affects a creature of the chosen type in the following ways:
	The creature can’t willingly enter the cylinder by nonmagical means. If the creature tries to use teleportation or interplanar travel to do so, it must first succeed on a Charisma saving throw.
	The creature has disadvantage on attack rolls against targets within the cylinder.
	Targets within the cylinder can’t be charmed, frightened, or possessed by the creature.', '3', 'CLASS:Cleric'),
('Mass Healing Ward', 'As you call out words of restoration, up to six creatures of your choice that you can see within range regain hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '3', 'CLASS:Cleric'),
('Meld Into Stone', 'You step into a stone object or surface large enough to fully contain your body, melding yourself and all the equipment you carry with the stone for the duration. Using your movement, you step into the stone at a point you can touch. Nothing of your presence remains visible or otherwise detectable by nonmagical senses. While merged with the stone, you can’t see what occurs outside it, and any Wisdom (Perception) checks you make to hear sounds outside it are made with disadvantage. You remain aware of the passage of time and can cast spells on yourself while merged in the stone. You can use your movement to leave the stone where you entered it, which ends the spell. You otherwise can’t move. Minor physical damage to the stone doesn’t harm you, but its partial destruction or a change in its shape (to the extent that you no longer fit within it) expels you and deals 6d6 bludgeoning damage to you. The stone’s complete destruction (or transmutation into a different substance) expels you and deals 50 bludgeoning damage to you. If expelled, you fall prone in an unoccupied space closest to where you first entered.', '3', 'CLASS:Cleric'),
('Protection from Energy', 'For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder.', '3', 'CLASS:Cleric'),
('Remove Curse', 'At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its owner’s attunement to the object so it can be removed or discarded.', '3', 'CLASS:Cleric'),
('Revivify', 'You touch a creature that has died within the last minute. That creature returns to life with 1 hit point. This spell can’t return to life a creature that has died of old age, nor can it restore any missing body parts.', '3', 'CLASS:Cleric'),
('Sending', 'You send a short message of twenty-­‐‑five words or less to a creature with which you are familiar. The creature hears the message in its mind, recognizes you as the sender if it knows you, and can answer in a like manner immediately. The spell enables creatures with Intelligence scores of at least 1 to understand the meaning of your message.', '3', 'CLASS:Cleric'),
('Speak with Dead', 'You grant the semblance of life and intelligence to a corpse of your choice within range, allowing it to answer the questions you pose. The corpse must still have a mouth and can’t be undead. The spell fails if the corpse was the target of this spell within the last 10 days. Until the spell ends, you can ask the corpse up to five questions. The corpse knows only what it knew in life, including the languages it knew. Answers are usually brief, cryptic, or repetitive, and the corpse is under no compulsion to offer a truthful answer if you are hostile to it or it recognizes you as an enemy. This spell doesn’t return the creature’s soul to its body, only its animating spirit. Thus, the corpse can’t learn new information, doesn’t comprehend anything that has happened since it died, and can’t speculate about future events.', '3', 'CLASS:Cleric'),
('Spirit Guardians', 'You call forth spirits to protect you. They flit around you to a distance of 15 feet for the duration. If you are good or neutral, their spectral form appears angelic or fey (your choice). If you are evil, they appear fiendish. When you cast this spell, you can designate any number of creatures you can see to be unaffected by it. An affected creature’s speed is halved in the area, and when the creature enters the area for the first time on a turn or starts its turn there, it must make a Wisdom saving throw. On a failed save, the creature takes 3d8 radiant damage (if you are good or neutral) or 3d8 necrotic damage (if you are evil). On a successful save, the creature takes half as much damage.', '3', 'CLASS:Cleric'),
('Tongues', 'This spell grants the creature you touch the ability to understand any spoken language it hears. Moreover, when the target speaks, any creature that knows at least one language and can hear the target understands what it says.', '3', 'CLASS:Cleric'),
('Water Walk', 'The transmuted creatures can tread on any liquid as if it were firm ground. Mud, oil, snow, quicksand, running water, ice, and even lava can be traversed easily, since the subjects’ feet hover an inch or two above the surface. (Creatures crossing molten lava still take damage from the heat because they are near it.) The subjects can walk, run, charge, or otherwise move across the surface as if it were normal ground.', '3', 'CLASS:Cleric'),

('Banishment', 'You attempt to send one creature that you can see within range to another plane of existence. The target must succeed on a Charisma saving throw or be banished. If the target is native to the plane of existence you’re on, you banish the target to a harmless demiplane. While there, the target is incapacitated. The target remains there until the spell ends, at which point the target reappears in the space it left or in the nearest unoccupied space if that space is occupied. If the target is native to a different plane of existence than the one you’re on, the target is banished with a faint popping noise, returning to its home plane. If the spell ends before 1 minute has passed, the target reappears in the space it left or in the nearest unoccupied space if that space is occupied. Otherwise, the target doesn’t return.', '4', 'CLASS:Cleric'),
('Control Water', 'Until the spell ends, you control any freestanding water inside an area you choose that is a cube up to 100 feet on a side. You can choose from any of the following effects when you cast this spell. As an action on your turn, you can repeat the same effect or choose a different one.
	Flood. You cause the water level of all standing water in the area to rise by as much as 20 feet. If the area includes a shore, the flooding water spills over onto dry land. If you choose an area in a large body of water, you instead create a 20--‐‑foot tall wave that travels from one side of the area to the other and then crashes down. Any Huge or smaller vehicles in the wave’s path are carried with it to the other side. Any Huge or smaller vehicles struck by the wave have a 25 percent chance of capsizing. The water level remains elevated until the spell ends or you choose a different effect. If this effect produced a wave, the wave repeats on the start of your next turn while the flood effect lasts.
	Part Water. You cause water in the area to move apart and create a trench. The trench extends across the spell’s area, and the separated water forms a wall to either side. The trench remains until the spell ends or you choose a different effect. The water then slowly fills in the trench over the course of the next round until the normal water level is restored.
	Redirect Flow. You cause flowing water in the area to move in a direction you choose, even if the water has to flow over obstacles, up walls, or in other unlikely directions. The water in the area moves as you direct it, but once it moves beyond the spell’s area, it resumes its flow based on the terrain conditions. The water continues to move in the direction you chose until the spell ends or you choose a different effect.
	Whirlpool. This effect requires a body of water at least 50 feet square and 25 feet deep. You cause a whirlpool to form in the center of the area. The whirlpool forms a vortex that is 5 feet wide at the base, up to 50 feet wide at the top, and 25 feet tall. Any creature or object in the water and within 25 feet of the vortex is pulled 10 feet toward it. A creature can swim away from the vortex by making a Strength (Athletics) check against your spell save DC.', '4', 'CLASS:Cleric'),
('Death Ward', 'You touch a creature and grant it a measure of protection from death. The first time the target would drop to 0 hit points as a result of taking damage, the target instead drops to 1 hit point, and the spell ends.', '4', 'CLASS:Cleric'),
('Divination', 'Your magic and an offering put you in contact with a god or a god’s servants. You ask a single question concerning a specific goal, event, or activity to occur within 7 days. The GM offers a truthful reply. The reply might be a short phrase, a cryptic rhyme, or an omen.', '4', 'CLASS:Cleric'),
('Freedom of Movement', 'You touch a willing creature. For the duration, the target’s movement is unaffected by difficult terrain, and spells and other magical effects can neither reduce the target’s speed nor cause the target to be paralyzed or restrained.', '4', 'CLASS:Cleric'),
('Guardian of Faith', 'A Large spectral guardian appears and hovers for the duration in an unoccupied space of your choice that you can see within range. The guardian occupies that space and is indistinct except for a gleaming sword and shield emblazoned with the symbol of your deity.', '4', 'CLASS:Cleric'),
('Locate Creature', 'Describe or name a creature that is familiar to you. You sense the direction to the creature’s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement. The spell can locate a specific creature known to you, or the nearest creature of a specific kind (such as a human or a unicorn), so long as you have seen such a creature up close—within 30 feet—at least once. If the creature you described or named is in a different form, such as being under the effects of a polymorph spell, this spell doesn’t locate the creature.', '4', 'CLASS:Cleric'),
('Stone Shape', 'You touch a stone object of Medium size or smaller or a section of stone no more than 5 feet in any dimension and form it into any shape that suits your purpose. So, for example, you could shape a large rock into a weapon, idol, or coffer, or make a small passage through a wall, as long as the wall is less than 5 feet thick. You could also shape a stone door or its frame to seal the door shut. The object you create can have up to two hinges and a latch, but finer mechanical detail isn’t possible.', '4', 'CLASS:Cleric'),

('Commune', 'You contact your deity or a divine proxy and ask up to three questions that can be answered with a yes or no. You must ask your questions before the spell ends. You receive a correct answer for each question. Divine beings aren’t necessarily omniscient, so you might receive “unclear” as an answer if a question pertains to information that lies beyond the deity’s knowledge. In a case where a one-word answer could be misleading or contrary to the deity’s interests, the GM might offer a short phrase as an answer instead.', '5', 'CLASS:Cleric'),
('Contagion', 'Your touch inflicts disease. Make a melee spell attack against a creature within your reach. On a hit, you afflict the creature with a disease of your choice from any of the ones described below.
	Blinding Sickness. Pain grips the creature’s mind, and its eyes turn milky white. The creature has disadvantage on Wisdom checks and Wisdom saving throws and is blinded.
	Filth Fever. A raging fever sweeps through the creature’s body. The creature has disadvantage on Strength checks, Strength saving throws, and attack rolls that use Strength.
	Flesh Rot. The creature’s flesh decays. The creature has disadvantage on Charisma checks and vulnerability to all damage.
	Mindfire. The creature’s mind becomes feverish. The creature has disadvantage on Intelligence checks and Intelligence saving throws, and the creature behaves as if under the effects of the confusion spell during combat.
	Seizure. The creature is overcome with shaking. The creature has disadvantage on Dexterity checks, Dexterity saving throws, and attack rolls that use Dexterity.
	Slimy Doom. The creature begins to bleed uncontrollably. The creature has disadvantage on Constitution checks and Constitution saving throws. In addition, whenever the creature takes damage, it is stunned until the end of its next turn.', '5', 'CLASS:Cleric'),
('Dispel Evil and Good', 'Shimmering energy surrounds and protects you from fey, undead, and creatures originating from beyond the Material Plane. For the duration, celestials, elementals, fey, fiends, and undead have disadvantage on attack rolls against you. You can end the spell early by using either of the following special functions.
	Break Enchantment. As your action, you touch a creature you can reach that is charmed, frightened, or possessed by a celestial, an elemental, a fey, a fiend, or an undead. The creature you touch is no longer charmed, frightened, or possessed by such creatures.
	Dismissal. As your action, make a melee spell attack against a celestial, an elemental, a fey, a fiend, or an undead you can reach. On a hit, you attempt to drive the creature back to its home plane. The creature must succeed on a Charisma saving throw or be sent back to its home plane (if it isn’t there already). If they aren’t on their home plane, undead are sent to the Shadowfell, and fey are sent to the Feywild.', '5', 'CLASS:Cleric'),
('Flame Strike', 'A vertical column of divine fire roars down from the heavens in a location you specify. Each creature in a 10-foot-radius, 40-foot-high cylinder centered on a point within range must make a Dexterity saving throw. A creature takes 4d6 fire damage and 4d6 A vertical column of divine fire roars down from the heavens in a location you specify. Each creature in a 10-foot-radius, 40-foot-high cylinder centered on a point within range must make a Dexterity saving throw. A creature takes 4d6 fire damage and 4d6 radiant damage on a failed save, or half as much damage on a successful one.', '5', 'CLASS:Cleric'),
('Geas', 'You place a magical command on a creature that you can see within range, forcing it to carry out some service or refrain from some action or course of activity as you decide. If the creature can understand you, it must succeed on a Wisdom saving throw or become charmed by you for the duration. While the creature is charmed by you, it takes 5d10 psychic damage each time it acts in a manner directly counter to your instructions, but no more than once each day. A creature that can’t understand you is unaffected by the spell. You can issue any command you choose, short of an activity that would result in certain death. Should you issue a suicidal command, the spell ends.You can end the spell early by using an action to dismiss it. A remove curse, greater restoration, or wish spell also ends it.', '5', 'CLASS:Cleric'),
('Greater Restoration', 'You imbue a creature you touch with positive energy to undo a debilitating effect. You can reduce the target’s exhaustion level by one, or end one of the following effects on the target: One effect that charmed or petrified the target OR One curse, including the target''s attunement to a cursed magic item. OR Any reduction to one of the target''s ability scores. OR One effect reducing the target''s hit point maximum', '5', 'CLASS:Cleric'),
('Hallow', 'You touch a point and infuse an area around it with holy (or unholy) power. The area can have a radius up to 60 feet, and the spell fails if the radius includes an area already under the effect a hallow spell. The affected area is subject to the following effects. First, celestials, elementals, fey, fiends, and undead can’t enter the area, nor can such creatures charm, frighten, or possess creatures within it. Any creature charmed, frightened, or possessed by such a creature is no longer charmed, frightened, or possessed upon entering the area. You can exclude one or more of those types of creatures from this effect. Second, you can bind an extra effect to the area. Choose the effect from the following list, or choose an effect offered by the GM. Some of these effects apply to creatures in the area; you can designate whether the effect applies to all creatures, creatures that follow a specific deity or leader, or creatures of a specific sort, such as orcs or trolls. When a creature that would be affected enters the spell’s area for the first time on a turn or starts its turn there, it can make a Charisma saving throw. On a success, the creature ignores the extra effect until it leaves the area.', '5', 'CLASS:Cleric'),
('Insect Plague', 'Swarming, biting locusts fill a 20-foot-radius sphere centered on a point you choose within range. The sphere spreads around corners. The sphere remains for the duration, and its area is lightly obscured. The sphere’s area is difficult terrain. When the area appears, each creature in it must make a Constitution saving throw. A creature takes 4d10 piercing damage on a failed save, or half as much damage on a successful one. A creature must also make this saving throw when it enters the spell’s area for the first time on a turn or ends its turn there.', '5', 'CLASS:Cleric'),
('Legend Lore', 'Name or describe a person, place, or object. The spell brings to your mind a brief summary of the significant lore about the thing you named. The lore might consist of current tales, forgotten stories, or even secret lore that has never been widely known. If the thing you named isn’t of legendary importance, you gain no information. The more information you already have about the thing, the more precise and detailed the information you receive is.', '5', 'CLASS:Cleric'),
('Mass Cure Wounds', 'A wave of healing energy washes out from a point of your choice within range. Choose up to six creatures in a 30-foot-radius sphere centered on that point. Each target regains hit points equal to 3d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.A wave of healing energy washes out from a point of your choice within range. Choose up to six creatures in a 30-foot-radius sphere centered on that point. Each target regains hit points equal to 3d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '5', 'CLASS:Cleric'),
('Planar Binding', 'With this spell, you attempt to bind a celestial, an elemental, a fey, or a fiend to your service. The creature must be within range for the entire casting of the spell. (Typically, the creature is first summoned into the center of an inverted magic circle in order to keep it trapped while this spell is cast.) At the completion of the casting, the target must make a Charisma saving throw. On a failed save, it is bound to serve you for the duration. If the creature was summoned or created by another spell, that spell’s duration is extended to match the duration of this spell. A bound creature must follow your instructions to the best of its ability. You might command the creature to accompany you on an adventure, to guard a location, or to deliver a message. The creature obeys the letter of your instructions, but if the creature is hostile to you, it strives to twist your words to achieve its own objectives. If the creature carries out your instructions completely before the spell ends, it travels to you to report this fact if you are on the same plane of existence. If you are on a different plane of existence, it returns to the place where you bound it and remains there until the spell ends.', '5', 'CLASS:Cleric'),
('Raise Dead', 'You return a dead creature you touch to life, provided that it has been dead no longer than 10 days. If the creature’s soul is both willing and at liberty to rejoin the body, the creature returns to life with 1 hit point. This spell also neutralizes any poisons and cures nonmagical diseases that affected the creature at the time it died. This spell doesn’t, however, remove magical diseases, curses, or similar effects; if these aren’t first removed prior to casting the spell, they take effect when the creature returns to life. The spell can’t return an undead creature to life. This spell closes all mortal wounds, but it doesn’t restore missing body parts. If the creature is lacking body parts or organs integral for its survival—its head, for instance—the spell automatically fails.', '5', 'CLASS:Cleric'),
('Scrying', 'You can see and hear a particular creature you choose that is on the same plane of existence as you. The target must make a Wisdom saving throw, which is modified by how well you know the target and the sort of physical connection you have to it. If a target knows you’re casting this spell, it can fail the saving throw voluntarily if it wants to be observed. On a successful save, the target isn’t affected, and you can’t use this spell against it again for 24 hours. On a failed save, the spell creates an invisible sensor within 10 feet of the target. You can see and hear through the sensor as if you were there. The sensor moves with the target, remaining within 10 feet of it for the duration. A creature that can see invisible objects sees the sensor as a luminous orb about the size of your fist.', '5', 'CLASS:Cleric'),

('Blade Barrier', 'You create a vertical wall of whirling, razor-sharp blades made of magical energy. The wall appears within range and lasts for the duration. You can make a straight wall up to 100 feet long, 20 feet high, and 5 feet thick, or a ringed wall up to 60 feet in diameter, 20 feet high, and 5 feet thick. The wall provides three-quarters cover to creatures behind it, and its space is difficult terrain. When a creature enters the wall’s area for the first time on a turn or starts its turn there, the creature must make a Dexterity saving throw. On a failed save, the creature takes 6d10 slashing damage. On a successful save, the creature takes half as much damage.', '6', 'CLASS:Cleric'),
('Create Undead', 'You can cast this spell only at night. Choose up to three corpses of Medium or Small humanoids within range. Each corpse becomes a ghoul under your control. (The GM has game statistics for these creatures.) As a bonus action on each of your turns, you can mentally command any creature you animated with this spell if the creature is within 120 feet of you (if you control multiple creatures, you can command any or all of them at the same time, issuing the same command to each one). You decide what action the creature will take and where it will move during its next turn, or you can issue a general command, such as to guard a particular chamber or corridor. If you issue no commands, the creature only defends itself against hostile creatures. Once given an order, the creature continues to follow it until its task is complete. The creature is under your control for 24 hours, after which it stops obeying any command you have given it. To maintain control of the creature for another 24 hours, you must cast this spell on the creature before the current 24-hour period ends. This use of the spell reasserts your control over up to three creatures you have animated with this spell, rather than animating new ones.', '6', 'CLASS:Cleric'),
('Find the Path', 'This spell allows you to find the shortest, most direct physical route to a specific fixed location that you are familiar with on the same plane of existence. If you name a destination on another plane of existence, a destination that moves (such as a mobile fortress), or a destination that isn’t specific (such as “a green dragon’s lair”), the spell fails.', '6', 'CLASS:Cleric'),
('Forbiddance', 'You create a ward against magical travel that protects up to 40,000 square feet of floor space to a height of 30 feet above the floor. For the duration, creatures can’t teleport into the area or use portals, such as those created by the gate spell, to enter the area. The spell proofs the area against planar travel, and therefore prevents creatures from accessing the area by way of the Astral Plane, Ethereal Plane, Feywild, Shadowfell, or the plane shift spell. In addition, the spell damages types of creatures that you choose when you cast it. Choose one or more of the following: celestials, elementals, fey, fiends, and undead. When a chosen creature enters the spell’s area for the first time on a turn or starts its turn there, the creature takes 5d10 radiant or necrotic damage (your choice when you cast this spell).', '6', 'CLASS:Cleric'),
('Harm', 'You unleash a virulent disease on a creature that you can see within range. The target must make a Constitution saving throw. On a failed save, it takes 14d6 necrotic damage, or half as much damage on a successful save. The damage can’t reduce the target’s hit points below 1. If the target fails the saving throw, its hit point maximum is reduced for 1 hour by an amount equal to the necrotic damage it took. Any effect that removes a disease allows a creature’s hit point maximum to return to normal before that time passes.', '6', 'CLASS:Cleric'),
('Heal', 'Choose a creature that you can see within range. A surge of positive energy washes through the creature, causing it to regain 70 hit points. This spell also ends blindness, deafness, and any diseases affecting the target. This spell has no effect on constructs or undead.', '6', 'CLASS:Cleric'),
('Planar Ally', 'You beseech an otherworldly entity for aid. The being must be known to you: a god, a primordial, a demon prince, or some other being of cosmic power. That entity sends a celestial, an elemental, or a fiend loyal to it to aid you, making the creature appear in an unoccupied space within range. If you know a specific creature’s name, you can speak that name when you cast this spell to request that creature, though you might get a different creature anyway (GM’s choice). When the creature appears, it is under no compulsion to behave in any particular way. You can ask the creature to perform a service in exchange for payment, but it isn’t obliged to do so. The requested task could range from simple (fly us across the chasm, or help us fight a battle) to complex (spy on our enemies, or protect us during our foray into the dungeon). You must be able to communicate with the creature to bargain for its services.', '6', 'CLASS:Cleric'),
('True Seeing', 'This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', '6', 'CLASS:Cleric'),
('Word of Recall', 'You and up to five willing creatures within 5 feet of you instantly teleport to a previously designated sanctuary. You and any creatures that teleport with you appear in the nearest unoccupied space to the spot you designated when you prepared your sanctuary (see below). If you cast this spell without first preparing a sanctuary, the spell has no effect. You must designate a sanctuary by casting this spell within a location, such as a temple, dedicated to or strongly linked to your deity. If you attempt to cast the spell in this manner in an area that isn’t dedicated to your deity, the spell has no effect.', '6', 'CLASS:Cleric'),

('Conjure Celestial', 'You call forth an elemental servant. Choose an area of air, earth, fire, or water that fills a 10-foot cube within range. An elemental of challenge rating 5 or lower appropriate to the area you chose appears in an unoccupied space within 10 feet of it. For example, a fire elemental emerges from a bonfire, and an earth elemental rises up from the ground. The elemental disappears when it drops to 0 hit points or when the spell ends. The elemental is friendly to you and your companions for the duration. Roll initiative for the elemental, which has its own turns. It obeys any verbal commands that you issue to it (no action required by you). If you don’t issue any commands to the elemental, it defends itself from hostile creatures but otherwise takes no actions.', '7', 'CLASS:Cleric'),
('Divine Word', 'You utter a divine word, imbued with the power that shaped the world at the dawn of creation. Choose any number of creatures you can see within range. Each creature that can hear you must make a Charisma saving throw. On a failed save, a creature suffers an effect based on its current hit points: 
	50 hit points or fewer: deafened for 1 minute
	40 hit points or fewer: deafened and blinded for 10 minutes
	30 hit points or fewer: blinded, deafened, and stunned for 1 hour
	20 hit points or fewer: killed instantly', '7', 'CLASS:Cleric'),
('Etherealness', 'You step into the border regions of the Ethereal Plane, in the area where it overlaps with your current plane. You remain in the Border Ethereal for the duration or until you use your action to dismiss the spell. During this time, you can move in any direction. If you move up or down, every foot of movement costs an extra foot. You can see and hear the plane you originated from, but everything there looks gray, and you can’t see anything more than 60 feet away. While on the Ethereal Plane, you can only affect and be affected by other creatures on that plane. Creatures that aren’t on the Ethereal Plane can’t perceive you and can’t interact with you, unless a special ability or magic has given them the ability to do so. You ignore all objects and effects that aren’t on the Ethereal Plane, allowing you to move through objects you perceive on the plane you originated from.', '7', 'CLASS:Cleric'),
('Fire Storm', 'A storm made up of sheets of roaring flame appears in a location you choose within range. The area of the storm consists of up to ten 10-­‐‑foot cubes, which you can arrange as you wish. Each cube must have at least one face adjacent to the face of another cube. Each creature in the area must make a Dexterity saving throw. It takes 7d10 fire damage on a failed save, or half as much damage on a successful one. The fire damages objects in the area and ignites flammable objects that aren’t being worn or carried. If you choose, plant life in the area is unaffected by this spell.', '7', 'CLASS:Cleric'),
('Plane Shift', 'You and up to eight willing creatures who link hands in a circle are transported to a different plane of existence. You can specify a target destination in general terms, such as the City of Brass on the Elemental Plane of Fire or the palace of Dispater on the second level of the Nine Hells, and you appear in or near that destination. If you are trying to reach the City of Brass, for example, you might arrive in its Street of Steel, before its Gate of Ashes, or looking at the city from across the Sea of Fire, at the GM’s discretion.', '7', 'CLASS:Cleric'),
('Regenerate', 'You touch a creature and stimulate its natural healing ability. The target regains 4d8 + 15 hit points. For the duration of the spell, the target regains 1 hit point at the start of each of its turns (10 hit points each minute). The target’s severed body members (fingers, legs, tails, and so on), if any, are restored after 2 minutes. If you have the severed part and hold it to the stump, the spell instantaneously causes the limb to knit to the stump.', '7', 'CLASS:Cleric'),
('Resurrection', 'You touch a dead creature that has been dead for no more than a century, that didn’t die of old age, and that isn’t undead. If its soul is free and willing, the target returns to life with all its hit points. This spell neutralizes any poisons and cures normal diseases afflicting the creature when it died. It doesn’t, however, remove magical diseases, curses, and the like; if such effects aren’t removed prior to casting the spell, they afflict the target on its return to life. This spell closes all mortal wounds and restores any missing body parts.', '7', 'CLASS:Cleric'),
('Symbol', 'When you cast this spell, you inscribe a harmful glyph either on a surface (such as a section of floor, a wall, or a table) or within an object that can be closed to conceal the glyph (such as a book, a scroll, or a treasure chest). If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered. You decide what triggers the glyph when you cast the spell. For glyphs inscribed on a surface, the most typical triggers include touching or stepping on the glyph, removing another object covering it, approaching within a certain distance of it, or manipulating the object that holds it. For glyphs inscribed within an object, the most common triggers are opening the object, approaching within a certain distance of it, or seeing or reading the glyph.', '7', 'CLASS:Cleric'),

('Antimagic Field', 'A 10-foot-radius invisible sphere of antimagic surrounds you. This area is divorced from the magical energy that suffuses the multiverse. Within the sphere, spells can’t be cast, summoned creatures disappear, and even magic items become mundane. Until the spell ends, the sphere moves with you, centered on you. Spells and other magical effects, except those created by an artifact or a deity, are suppressed in the sphere and can’t protrude into it. A slot expended to cast a suppressed spell is consumed. While an effect is suppressed, it doesn’t function, but the time it spends suppressed counts against its duration.', '8', 'CLASS:Cleric'),
('Control Weather', 'You take control of the weather within 5 miles of you for the duration. You must be outdoors to cast this spell. Moving to a place where you don’t have a clear path to the sky ends the spell early. When you cast the spell, you change the current weather conditions, which are determined by the GM based on the climate and season. You can change precipitation, temperature, and wind. It takes 1d4 × 10 minutes for the new conditions to take effect. Once they do so, you can change the conditions again. When the spell ends, the weather gradually returns to normal.', '8', 'CLASS:Cleric'),
('Earthquake', 'You create a seismic disturbance at a point on the ground that you can see within range. For the duration, an intense tremor rips through the ground in a 100--‐‑foot--‐‑radius circle centered on that point and shakes creatures and structures in contact with the ground in that area. The ground in the area becomes difficult terrain. Each creature on the ground that is concentrating must make a Constitution saving throw. On a failed save, the creature’s concentration is broken. When you cast this spell and at the end of each turn you spend concentrating on it, each creature on the ground in the area must make a Dexterity saving throw. On a failed save, the creature is knocked prone.', '8', 'CLASS:Cleric'),
('Holy Aura', 'Divine light washes out from you and coalesces in a soft radiance in a 30-foot radius around you. Creatures of your choice in that radius when you cast this spell shed dim light in a 5-foot radius and have advantage on all saving throws, and other creatures have disadvantage on attack rolls against them until the spell ends. In addition, when a fiend or an undead hits an affected creature with a melee attack, the aura flashes with brilliant light. The attacker must succeed on a Constitution saving throw or be blinded until the spell ends.', '8', 'CLASS:Cleric'),

('Astral Projection', 'You and up to eight willing creatures within range project your astral bodies into the Astral Plane (the spell fails and the casting is wasted if you are already on that plane). The material body you leave behind is unconscious and in a state of suspended animation; it doesn’t need food or air and doesn’t age. Your astral body resembles your mortal form in almost every way, replicating your game statistics and possessions. The principal difference is the addition of a silvery cord that extends from between your shoulder blades and trails behind you, fading to invisibility after 1 foot. This cord is your tether to your material body. As long as the tether remains intact, you can find your way home. If the cord is cut—something that can happen only when an effect specifically states that it does—your soul and body are separated, killing you instantly.', '9', 'CLASS:Cleric'),
('Gate', 'You conjure a portal linking an unoccupied space you can see within range to a precise location on a different plane of existence. The portal is a circular opening, which you can make 5 to 20 feet in diameter. You can orient the portal in any direction you choose. The portal lasts for the duration. The portal has a front and a back on each plane where it appears. Travel through the portal is possible only by moving through its front. Anything that does so is instantly transported to the other plane, appearing in the unoccupied space nearest to the portal. Deities and other planar rulers can prevent portals created by this spell from opening in their presence or anywhere within their domains.', '9', 'CLASS:Cleric'),
('Mass Heal', 'A flood of healing energy flows from you into injured creatures around you. You restore up to 700 hit points, divided as you choose among any number of creatures that you can see within range. Creatures healed by this spell are also cured of all diseases and any effect making them blinded or deafened. This spell has no effect on undead or constructs.', '9', 'CLASS:Cleric'),
('True Resurrection', 'You touch a creature that has been dead for no longer than 200 years and that died for any reason except old age. If the creature’s soul is free and willing, the creature is restored to life with all its hit points. This spell closes all wounds, neutralizes any poison, cures all diseases, and lifts any curses affecting the creature when it died.', '9', 'CLASS:Cleric'),

('Druidcraft', 'Whispering to the spirits of nature, you create one of the following effects within range:
	You create a tiny, harmless sensory effect that predicts what the weather will be at your location for the next 24 hours. The effect might manifest as a golden orb for clear skies, a cloud for rain, falling snowflakes for snow, and so on. This effect persists for 1 round.
	You instantly make a flower blossom, a seed pod open, or a leaf bud bloom.
	You create an instantaneous, harmless sensory effect, such as falling leaves, a puff of wind, the sound of a small animal, or the faint odor of skunk. The effect must fit in a 5-foot cube.
	You instantly light or snuff out a candle, a torch, or a small campfire.', '0', 'CLASS:Druid'),
('Guidance', 'You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one ability check of its choice. It can roll the die before or after making the ability check. The spell then ends.', '0', 'CLASS:Druid'),
('Mending', 'This spell repairs a single break or tear in an object you touch, such as a broken chain link, two halves of a broken key, a torn cloak, or a leaking wineskin. As long as the break or tear is no larger than 1 foot in any dimension, you mend it, leaving no trace of the former damage.', '0', 'CLASS:Druid'),
('Poison Spray', 'You extend your hand toward a creature you can see within range and project a puff of noxious gas from your palm. The creature must succeed on a Constitution saving throw or take 1d12 poison damage.', '0', 'CLASS:Druid'),
('Produce Flame', 'A flickering flame appears in your hand. The flame remains there for the duration and harms neither you nor your equipment. The flame sheds bright light in a 10-­‐‑foot radius and dim light for an additional 10 feet. The spell ends if you dismiss it as an action or if you cast it again. You can also attack with the flame, although doing so ends the spell. When you cast this spell, or as an action on a later turn, you can hurl the flame at a creature within 30 feet of you. Make a ranged spell attack. On a hit, the target takes 1d8 fire damage.', '0', 'CLASS:Druid'),
('Resistance', 'You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one saving throw of its choice. It can roll the die before or after making the saving throw. The spell then ends.', '0', 'CLASS:Druid'),
('Shillelagh', 'The wood of a club or quarterstaff you are holding is imbued with nature’s power. For the duration, you can use your spellcasting ability instead of Strength for the attack and damage rolls of melee attacks using that weapon, and the weapon’s damage die becomes a d8. The weapon also becomes magical, if it isn’t already. The spell ends if you cast it again or if you let go of the weapon.', '0', 'CLASS:Druid'),

('Animal Friendship', 'This spell lets you convince a beast that you mean it no harm. Choose a beast that you can see within range. It must see and hear you. If the beast''s Intelligence is 4 or higher, the spell fails. Otherwise, the beast must succeed on a Wisdom saving throw or be charmed by you for the spell''s duration. If you or one of your companions harms the target, the spells ends.', '1', 'CLASS:Druid'),
('Charm Person', 'You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.', '1', 'CLASS:Druid'),
('Create or Destroy Water', 'You either create or destroy water. Create Water: You create up to 10 gallons of clean water within range in an open container. Alternatively, the water falls as rain in a 30-foot cube within range, extinguishing exposed flames in the area. Destroy Water: You destroy up to 10 gallons of water in an open container within range. Alternatively, you destroy fog in a 30-foot cube within range.', '1', 'CLASS:Druid'),
('Cure Wounds', 'A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Druid'),
('Detect Magic', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.', '1', 'CLASS:Druid'),
('Detect Poison and Disease', 'For the duration, you can sense the presence and location of poisons, poisonous creatures, and diseases within 30 feet of you. You also identify the kind of poison, poisonous creature, or disease in each case.', '1', 'CLASS:Druid'),
('Entangle', 'Grasping weeds and vines sprout from the ground in a 20-foot square starting from a point within range. For the duration, these plants turn the ground in the area into difficult terrain. A creature in the area when you cast the spell must succeed on a Strength saving throw or be restrained by the entangling plants until the spell ends. A creature restrained by the plants can use its action to make a Strength check against your spell save DC. On a success, it frees itself.', '1', 'CLASS:Druid'),
('Faerie Fire', 'Each object in a 20-foot cube within range is outlined in blue, green, or violet light (your choice). Any creature in the area when the spell is cast is also outlined in light if it fails a Dexterity saving throw. For the duration, objects and affected creatures shed dim light in a 10-foot radius.', '1', 'CLASS:Druid'),
('Goodberry', 'Up to ten berries appear in your hand and are infused with magic for the duration. A creature can use its action to eat one berry. Eating a berry restores 1 hit point, and the berry provides enough nourishment to sustain a creature for one day.', '1', 'CLASS:Druid'),
('Healing Word', 'A creature of your choice that you can see within range regains hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Druid'),
('Jump', 'You touch a creature. The creature’s jump distance is tripled until the spell ends.', '1', 'CLASS:Druid'),
('Longstrider', 'You touch a creature. The target’s speed increases by 10 feet until the spell ends.', '1', 'CLASS:Druid'),
('Purify Food and Drink', 'All nonmagical food and drink within a 5-foot-radius sphere centered on a point of your choice within range is purified and rendered free of poison and disease.', '1', 'CLASS:Druid'),
('Speak with Animals', 'You gain the ability to comprehend and verbally communicate with beasts for the duration. The knowledge and awareness of many beasts is limited by their intelligence, but at minimum, beasts can give you information about nearby locations and monsters, including whatever they can perceive or have perceived within the past day. You might be able to persuade a beast to perform a small favor for you, at the GM’s discretion.', '1', 'CLASS:Druid'),

('Animal Messanger', 'By means of this spell, you use an animal to deliver a message. Choose a Tiny beast you can see within range, such as a squirrel, a blue jay, or a bat. You specify a location, which you must have visited, and a recipient who matches a general description, such as “a man or woman dressed in the uniform of the town guard” or “a red-haired dwarf wearing a pointed hat.” You also speak a message of up to twenty-five words. The target beast travels for the duration of the spell toward the specified location, covering about 50 miles per 24 hours for a flying messenger, or 25 miles for other animals. When the messenger arrives, it delivers your message to the creature that you described, replicating the sound of your voice. The messenger speaks only to a creature matching the description you gave. If the messenger doesn’t reach its destination before the spell ends, the message is lost, and the beast makes its way back to where you cast this spell.', '2', 'CLASS:Druid'),
('Barkskin', 'You touch a willing creature. Until the spell ends, the target’s skin has a rough, bark-like appearance, and the target’s AC can’t be less than 16, regardless of what kind of armor it is wearing.', '2', 'CLASS:Druid'),
('Darkvision', 'You touch a willing creature to grant it the ability to see in the dark. For the duration, that creature has darkvision out to a range of 60 feet.', '2', 'CLASS:Druid'),
('Enhance Ability', 'You touch a creature and bestow upon it a magical enhancement. Choose one of the following effects; the target gains that effect until the spell ends. 
	Bear’s Endurance: The target has advantage on Constitution checks. It also gains 2d6 temporary hit points, which are lost when the spell ends.
	Bull’s Strength: The target has advantage on Strength checks, and his or her carrying capacity doubles.
	Cat’s Grace: The target has advantage on Dexterity checks. It also doesn’t take damage from falling 20 feet or less if it isn’t incapacitated.
	Eagle’s Splendor: The target has advantage on Charisma checks.
	Fox’s Cunning: The target has advantage on Intelligence checks.
	Owl’s Wisdom: The target has advantage on Wisdom checks.', '2', 'CLASS:Druid'),
('Find Traps', 'You sense the presence of any trap within range that is within line of sight. A trap, for the purpose of this spell, includes anything that would inflict a sudden or unexpected effect you consider harmful or undesirable, which was specifically intended as such by its creator. Thus, the spell would sense an area affected by the alarm spell, a glyph of warding, or a mechanical pit trap, but it would not reveal a natural weakness in the floor, an unstable ceiling, or a hidden sinkhole.', '2', 'CLASS:Druid'),
('Flame Blade', 'You evoke a fiery blade in your free hand. The blade is similar in size and shape to a scimitar, and it lasts for the duration. If you let go of the blade, it disappears, but you can evoke the blade again as a bonus action. You can use your action to make a melee spell attack with the fiery blade. On a hit, the target takes 3d6 fire damage. The flaming blade sheds bright light in a 10-foot radius and dim light for an additional 10 feet.', '2', 'CLASS:Druid'),
('Flaming Sphere', 'A 5-foot-diameter sphere of fire appears in an unoccupied space of your choice within range and lasts for the duration. Any creature that ends its turn within 5 feet of the sphere must make a Dexterity saving throw. The creature takes 2d6 fire damage on a failed save, or half as much damage on a successful one. As a bonus action, you can move the sphere up to 30 feet. If you ram the sphere into a creature, that creature must make the saving throw against the sphere’s damage, and the sphere stops moving this turn. When you move the sphere, you can direct it over barriers up to 5 feet tall and jump it across pits up to 10 feet wide. The sphere ignites flammable objects not being worn or carried, and it sheds bright light in a 20-­‐‑foot radius and dim light for an additional 20 feet.', '2', 'CLASS:Druid'),
('Gust of Wind', 'A line of strong wind 60 feet long and 10 feet wide blasts from you in a direction you choose for the spell’s duration. Each creature that starts its turn in the line must succeed on a Strength saving throw or be pushed 15 feet away from you in a direction following the line. Any creature in the line must spend 2 feet of movement for every 1 foot it moves when moving closer to you. The gust disperses gas or vapor, and it extinguishes candles, torches, and similar unprotected flames in the area. It causes protected flames, such as those of lanterns, to dance wildly and has a 50 percent chance to extinguish them.', '2', 'CLASS:Druid'),
('Heat Metal', 'Choose a manufactured metal object, such as a metal weapon or a suit of heavy or medium metal armor, that you can see within range. You cause the object to glow red-hot. Any creature in physical contact with the object takes 2d8 fire damage when you cast the spell. Until the spell ends, you can use a bonus action on each of your subsequent turns to cause this damage again. If a creature is holding or wearing the object and takes the damage from it, the creature must succeed on a Constitution saving throw or drop the object if it can. If it doesn’t drop the object, it has disadvantage on attack rolls and ability checks until the start of your next turn.', '2', 'CLASS:Druid'),
('Hold Person', 'Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '2', 'CLASS:Druid'),
('Lesser Restoration', 'You touch a creature and can end either one disease or one condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned.', '2', 'CLASS:Druid'),
('Locate Animals or Plants', 'Describe or name a specific kind of beast or plant. Concentrating on the voice of nature in your surroundings, you learn the direction and distance to the closest creature or plant of that kind within 5 miles, if any are present.', '2', 'CLASS:Druid'),
('Locate Object', 'Describe or name an object that is familiar to you. You sense the direction to the object’s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement. The spell can locate a specific object known to you, as long as you have seen it up close—within 30 feet—at least once. Alternatively, the spell can locate the nearest object of a particular kind, such as a certain kind of apparel, jewelry, furniture, tool, or weapon.', '2', 'CLASS:Druid'),
('Moonbeam', 'A silvery beam of pale light shines down in a 5-foot-radius, 40-foot-high cylinder centered on a point within range. Until the spell ends, dim light fills the cylinder. When a creature enters the spell’s area for the first time on a turn or starts its turn there, it is engulfed in ghostly flames that cause searing pain, and it must make a Constitution saving throw. It takes 2d10 radiant damage on a failed save, or half as much damage on a successful one. A shapechanger makes its saving throw with disadvantage. If it fails, it also instantly reverts to its original form and can’t assume a different form until it leaves the spell’s light. On each of your turns after you cast this spell, you can use an action to move the beam 60 feet in any direction.', '2', 'CLASS:Druid'),
('Pass without Trace', 'A veil of shadows and silence radiates from you, masking you and your companions from detection. For the duration, each creature you choose within 30 feet of you (including you) has a +10 bonus to Dexterity (Stealth) checks and can’t be tracked except by magical means. A creature that receives this bonus leaves behind no tracks or other traces of its passage.', '2', 'CLASS:Druid'),
('Protection from Poison', 'You touch a creature. If it is poisoned, you neutralize the poison. If more than one poison afflicts the target, you neutralize one poison that you know is present, or you neutralize one at random.', '2', 'CLASS:Druid'),
('Spike Growth', 'The ground in a 20-foot radius centered on a point within range twists and sprouts hard spikes and thorns. The area becomes difficult terrain for the duration. When a creature moves into or within the area, it takes 2d4 piercing damage for every 5 feet it travels. The transformation of the ground is camouflaged to look natural. Any creature that can’t see the area at the time the spell is cast must make a Wisdom (Perception) check against your spell save DC to recognize the terrain as hazardous before entering it.', '2', 'CLASS:Druid'),

('Call Lightning', 'A storm cloud appears in the shape of a cylinder that is 10 feet tall with a 60-foot radius, centered on a point you can see 100 feet directly above you. The spell fails if you can’t see a point in the air where the storm cloud could appear (for example, if you are in a room that can’t accommodate the cloud). When you cast the spell, choose a point you can see within range. A bolt of lightning flashes down from the cloud to that point. Each creature within 5 feet of that point must make a Dexterity saving throw. A creature takes 3d10 lightning damage on a failed save, or half as much damage on a successful one. On each of your  turns until the spell ends, you can use your action to call down lightning in this way again, targeting the same point or a different one. If you are outdoors in  stormy conditions when you cast this spell, the spell gives you control over the existing storm instead of creating a new one. Under such conditions, the spell’s damage increases by 1d10.', '3', 'CLASS:Druid'),
('Conjure Animals', 'You summon fey spirits that take the form of beasts and appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:
	One beast of challenge rating 2 or lower
	Two beasts of challenge rating 1 or lower
	Four beasts of challenge rating 1/2 or lower
	Eight beasts of challenge rating 1/4 or lower', '3', 'CLASS:Druid'),
('Daylight', 'A 60-foot-radius sphere of light spreads out from a point you choose within range. The sphere is bright light and sheds dim light for an additional 60 feet. If you chose a point on an object you are holding or one that isn’t being worn or carried, the light shines from the object and moves with it. Completely covering the affected object with an opaque object, such as a bowl or a helm, blocks the light.', '3', 'CLASS:Druid'),
('Dispel Magic', 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.', '3', 'CLASS:Druid'),
('Meld into Stone', 'You step into a stone object or surface large enough to fully contain your body, melding yourself and all the equipment you carry with the stone for the duration. Using your movement, you step into the stone at a point you can touch. Nothing of your presence remains visible or otherwise detectable by nonmagical senses. While merged with the stone, you can’t see what occurs outside it, and any Wisdom (Perception) checks you make to hear sounds outside it are made with disadvantage. You remain aware of the passage of time and can cast spells on yourself while merged in the stone. You can use your movement to leave the stone where you entered it, which ends the spell. You otherwise can’t move. Minor physical damage to the stone doesn’t harm you, but its partial destruction or a change in its shape (to the extent that you no longer fit within it) expels you and deals 6d6 bludgeoning damage to you. The stone’s complete destruction (or transmutation into a different substance) expels you and deals 50 bludgeoning damage to you. If expelled, you fall prone in an unoccupied space closest to where you first entered.', '3', 'CLASS:Druid'),
('Plant Growth', 'This spell channels vitality into plants within a specific area. There are two possible uses for the spell, granting either immediate or long-term benefits. If you cast this spell using 1 action, choose a point within range. All normal plants in a 100-foot radius centered on that point become thick and overgrown. A creature moving through the area must spend 4 feet of movement for every 1 foot it moves. You can exclude one or more areas of any size within the spell’s area from being affected.', '3', 'CLASS:Druid'),
('Protection from Energy', 'For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder.', '3', 'CLASS:Druid'),
('Sleet Storm', 'Until the spell ends, freezing rain and sleet fall in a 20-foot-tall cylinder with a 40-foot radius centered on a point you choose within range. The area is heavily obscured, and exposed flames in the area are doused. The ground in the area is covered with slick ice, making it difficult terrain. When a creature enters the spell’s area for the first time on a turn or starts its turn there, it must make a Dexterity saving throw. On a failed save, it falls prone.', '3', 'CLASS:Druid'),
('Speak with Plants', 'You imbue plants within 30 feet of you with limited sentience and animation, giving them the ability to communicate with you and follow your simple commands. You can question plants about events in the spell’s area within the past day, gaining information about creatures that have passed, weather, and other circumstances. You can also turn difficult terrain caused by plant growth (such as thickets and undergrowth) into ordinary terrain that lasts for the duration. Or you can turn ordinary terrain where plants are present into difficult terrain that lasts for the duration, causing vines and branches to hinder pursuers, for example. Plants might be able to perform other tasks on your behalf, at the GM’s discretion. The spell doesn’t enable plants to uproot themselves and move about, but they can freely move branches, tendrils, and stalks.', '3', 'CLASS:Druid'),
('Water Breathing', 'This spell grants up to ten willing creatures you can see within range the ability to breathe underwater until the spell ends. Affected creatures also retain their normal mode of respiration.', '3', 'CLASS:Druid'),
('Water Walk', 'The transmuted creatures can tread on any liquid as if it were firm ground. Mud, oil, snow, quicksand, running water, ice, and even lava can be traversed easily, since the subjects’ feet hover an inch or two above the surface. (Creatures crossing molten lava still take damage from the heat because they are near it.) The subjects can walk, run, charge, or otherwise move across the surface as if it were normal ground.', '3', 'CLASS:Druid'),
('Wind Wall', 'A wall of strong wind rises from the ground at a point you choose within range. You can make the wall up to 50 feet long, 15 feet high, and 1 foot thick. You can shape the wall in any way you choose so long as it makes one continuous path along the ground. The wall lasts for the duration. When the wall appears, each creature within its area must make a Strength saving throw. A creature takes 3d8 bludgeoning damage on a failed save, or half as much damage on a successful one.', '3', 'CLASS:Druid'),

('Blight', 'Necromantic energy washes over a creature of your choice that you can see within range, draining moisture and vitality from it. The target must make a Constitution saving throw. The target takes 8d8 necrotic damage on a failed save, or half as much damage on a successful one. This spell has no effect on undead or constructs. If you target a plant creature or a magical plant, it makes the saving throw with disadvantage, and the spell deals maximum damage to it. If you target a nonmagical plant that isn’t a creature, such as a tree or shrub, it doesn’t make a saving throw; it simply withers and dies.', '4', 'CLASS:Druid'),
('Confusion', 'This spell assaults and twists creatures’ minds, spawning delusions and provoking uncontrolled action. Each creature in a 10-foot-radius sphere centered on a point you choose within range must succeed on a Wisdom saving throw when you cast this spell or be affected by it. An affected target can’t take reactions and must roll a d10 at the start of each of its turns to determine its behavior for that turn.
	d10	Behavior
	1	The creature uses all its movement to move in a random direction.
		To determine the direction, roll a d8 and assign a direction to each die face.
		The creature doesn''t take an action this turn.
	2-6	The creature doesn''t move or take actions this turn.
	7-8	The creature uses its action to make a melee attack against a randomly determined creature within its reach. If there is no creature within its reach, the creature does nothing this turn.
	9-10The creature can act and move normally.', '4', 'CLASS:Druid'),
('Conjure Minor Elementals', 'You summon elementals that appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:
	One elemental of challenge rating 2 or lower
	Two elementals of challenge rating 1 or lower
	Four elementals of challenge rating 1/2 or lower
	Eight elementals of challenge rating 1/4 or lower', '4', 'CLASS:Druid'),
('Conjure Woodland Beings', 'You summon fey creatures that appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:
	One fey creature of challenge rating 2 or lower
	Two fey creatures of challenge rating 1 or lower
	Four fey creatures of challenge rating 1/2 or lower
	Eight fey creatures of challenge rating 1/4 or lower', '4', 'CLASS:Druid'),
('Control Water', 'Until the spell ends, you control any freestanding water inside an area you choose that is a cube up to 100 feet on a side. You can choose from any of the following effects when you cast this spell. As an action on your turn, you can repeat the same effect or choose a different one.
	Flood. You cause the water level of all standing water in the area to rise by as much as 20 feet. If the area includes a shore, the flooding water spills over onto dry land. If you choose an area in a large body of water, you instead create a 20--‐‑foot tall wave that travels from one side of the area to the other and then crashes down. Any Huge or smaller vehicles in the wave’s path are carried with it to the other side. Any Huge or smaller vehicles struck by the wave have a 25 percent chance of capsizing. The water level remains elevated until the spell ends or you choose a different effect. If this effect produced a wave, the wave repeats on the start of your next turn while the flood effect lasts.
	Part Water. You cause water in the area to move apart and create a trench. The trench extends across the spell’s area, and the separated water forms a wall to either side. The trench remains until the spell ends or you choose a different effect. The water then slowly fills in the trench over the course of the next round until the normal water level is restored.
	Redirect Flow. You cause flowing water in the area to move in a direction you choose, even if the water has to flow over obstacles, up walls, or in other unlikely directions. The water in the area moves as you direct it, but once it moves beyond the spell’s area, it resumes its flow based on the terrain conditions. The water continues to move in the direction you chose until the spell ends or you choose a different effect.
	Whirlpool. This effect requires a body of water at least 50 feet square and 25 feet deep. You cause a whirlpool to form in the center of the area. The whirlpool forms a vortex that is 5 feet wide at the base, up to 50 feet wide at the top, and 25 feet tall. Any creature or object in the water and within 25 feet of the vortex is pulled 10 feet toward it. A creature can swim away from the vortex by making a Strength (Athletics) check against your spell save DC.', '4', 'CLASS:Druid'),
('Dominate Beast', 'You attempt to beguile a beast that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw. While the beast is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as “Attack that creature,” “Run over there,” or “Fetch that object.” If the creature completes the order and doesn’t receive further direction from you, it defends and preserves itself to the best of its ability. You can use your action to take total and precise control of the target. Until the end of your next turn, the creature takes only the actions you choose, and doesn’t do anything that you don’t allow it to do. During this time, you can also cause the creature to use a reaction, but this requires you to use your own reaction as well.', '4', 'CLASS:Druid'),
('Freedom of Movement', 'You touch a willing creature. For the duration, the target’s movement is unaffected by difficult terrain, and spells and other magical effects can neither reduce the target’s speed nor cause the target to be paralyzed or restrained.', '4', 'CLASS:Druid'),
('Giant Insect', 'You transform up to ten centipedes, three spiders, five wasps, or one scorpion within range into giant versions of their natural forms for the duration. A centipede becomes a giant centipede, a spider becomes a giant spider, a wasp becomes a giant wasp, and a scorpion becomes a giant scorpion. Each creature obeys your verbal commands, and in combat, they act on your turn each round. The GM has the statistics for these creatures and resolves their actions and movement. A creature remains in its giant size for the duration, until it drops to 0 hit points, or until you use an action to dismiss the effect on it.', '4', 'CLASS:Druid'),
('Hallucinatory Terrain', 'You make natural terrain in a 150-made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Manufactured structures, equipment, and creatures within the area aren’t changed in appearance. The tactile characteristics of the terrain are unchanged, so creatures entering the area are likely to see through the illusion. If the difference isn’t obvious by touch, a creature carefully examining the illusion can attempt an Intelligence (Investigation) check against your spell save DC to disbelieve it. A creature who discerns the illusion for what it is, sees it as a vague image superimposed on the terrain.', '4', 'CLASS:Druid'),
('Ice Storm', 'A hail of rock-hard ice pounds to the ground in a 20-foot-radius, 40-foot-high cylinder centered on a point within range. Each creature in the cylinder must make a Dexterity saving throw. A creature takes 2d8 bludgeoning damage and 4d6 cold damage on a failed save, or half as much damage on a successful one. Hailstones turn the storm’s area of effect into difficult terrain until the end of your next turn.', '4', 'CLASS:Druid'),
('Locate Creature', 'Describe or name a creature that is familiar to you. You sense the direction to the creature’s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement. The spell can locate a specific creature known to you, or the nearest creature of a specific kind (such as a human or a unicorn), so long as you have seen such a creature up close—within 30 feet—at least once. If the creature you described or named is in a different form, such as being under the effects of a polymorph spell, this spell doesn’t locate the creature.', '4', 'CLASS:Druid'),
('Polymorph', 'This spell transforms a creature that you can see within range into a new form. An unwilling creature must make a Wisdom saving throw to avoid the effect. The spell has no effect on a shapechanger or a creature with 0 hit points. The transformation lasts for the duration, or until the target drops to 0 hit points or dies. The new form can be any beast whose challenge rating is equal to or less than the target’s (or the target’s level, if it doesn’t have a challenge rating). The target’s game statistics, including mental ability scores, are replaced by the statistics of the chosen beast. It retains its alignment and personality. The target assumes the hit points of its new form. When it reverts to its normal form, the creature returns to the number of hit points it had before it transformed. If it reverts as a result of dropping to 0 hit points, any excess damage carries over to its normal form. As long as the excess damage doesn’t reduce the creature’s normal form to 0 hit points, it isn’t knocked unconscious.', '4', 'CLASS:Druid'),
('Stone Shape', 'You touch a stone object of Medium size or smaller or a section of stone no more than 5 feet in any dimension and form it into any shape that suits your purpose. So, for example, you could shape a large rock into a weapon, idol, or coffer, or make a small passage through a wall, as long as the wall is less than 5 feet thick. You could also shape a stone door or its frame to seal the door shut. The object you create can have up to two hinges and a latch, but finer mechanical detail isn’t possible.', '4', 'CLASS:Druid'),
('Stoneskin', 'This spell turns the flesh of a willing creature you touch as hard as stone. Until the spell ends, the target has resistance to nonmagical bludgeoning, piercing, and slashing damage.', '4', 'CLASS:Druid'),
('Tree Stride', 'You gain the ability to enter a tree and move from inside it to inside another tree of the same kind within 500 feet. Both trees must be living and at least the same size as you. You must use 5 feet of movement to enter a tree. You instantly know the location of all other trees of the same kind within 500 feet and, as part of the move used to enter the tree, can either pass into one of those trees or step out of the tree you’re in. You appear in a spot of your choice within 5 feet of the destination tree, using another 5 feet of movement. If you have no movement left, you appear within 5 feet of the tree you entered.', '4', 'CLASS:Druid'),
('Wall of Fire', 'You create a wall of fire on a solid surface within range. You can make the wall up to 60 feet long, 20 feet high, and 1 foot thick, or a ringed wall up to 20 feet in diameter, 20 feet high, and 1 foot thick. The wall is opaque and lasts for the duration. When the wall appears, each creature within its area must make a Dexterity saving throw. On a failed save, a creature takes 5d8 fire damage, or half as much damage on a successful save. One side of the wall, selected by you when you cast this spell, deals 5d8 fire damage to each creature that ends its turn within 10 feet of that side or inside the wall. A creature takes the same damage when it enters the wall for the first time on a turn or ends its turn there. The other side of the wall deals no damage.', '4', 'CLASS:Druid'),

('Antilife Shell', 'A shimmering barrier extends out from you in a 10-foot radius and moves with you, remaining centered on you and hedging out creatures other than undead and constructs. The barrier lasts for the duration. The barrier prevents an affected creature from passing or reaching through. An affected creature can cast spells or make attacks with ranged or reach weapons through the barrier.', '5', 'CLASS:Druid'),
('Awaken', 'After spending the casting time tracing magical pathways within a precious gemstone, you touch a Huge or smaller beast or plant. The target must have either no Intelligence score or an Intelligence of 3 or less. The target gains an Intelligence of 10. The target also gains the ability to speak one language you know. If the target is a plant, it gains the ability to move its limbs, roots, vines, creepers, and so forth, and it gains senses similar to a human’s. Your GM chooses statistics appropriate for the awakened plant, such as the statistics for the awakened shrub or the awakened tree. The awakened beast or plant is charmed by you for 30 days or until you or your companions do anything harmful to it. When the charmed condition ends, the awakened creature chooses whether to remain friendly to you, based on how you treated it while it was charmed.', '5', 'CLASS:Druid'),
('Commune with Nature', 'You briefly become one with nature and gain knowledge of the surrounding territory. In the outdoors, the spell gives you knowledge of the land within 3 miles of you. In caves and other natural underground settings, the radius is limited to 300 feet.', '5', 'CLASS:Druid'),
('Conjure Elemental', 'You call forth an elemental servant. Choose an area of air, earth, fire, or water that fills a 10-foot cube within range. An elemental of challenge rating 5 or lower appropriate to the area you chose appears in an unoccupied space within 10 feet of it. For example, a fire elemental emerges from a bonfire, and an earth elemental rises up from the ground. The elemental disappears when it drops to 0 hit points or when the spell ends. The elemental is friendly to you and your companions for the duration. Roll initiative for the elemental, which has its own turns. It obeys any verbal commands that you issue to it (no action required by you). If you don’t issue any commands to the elemental, it defends itself from hostile creatures but otherwise takes no actions.', '5', 'CLASS:Druid'),
('Contagion', 'Your touch inflicts disease. Make a melee spell attack against a creature within your reach. On a hit, you afflict the creature with a disease of your choice from any of the ones described below.
	Blinding Sickness. Pain grips the creature’s mind, and its eyes turn milky white. The creature has disadvantage on Wisdom checks and Wisdom saving throws and is blinded.
	Filth Fever. A raging fever sweeps through the creature’s body. The creature has disadvantage on Strength checks, Strength saving throws, and attack rolls that use Strength.
	Flesh Rot. The creature’s flesh decays. The creature has disadvantage on Charisma checks and vulnerability to all damage.
	Mindfire. The creature’s mind becomes feverish. The creature has disadvantage on Intelligence checks and Intelligence saving throws, and the creature behaves as if under the effects of the confusion spell during combat.
	Seizure. The creature is overcome with shaking. The creature has disadvantage on Dexterity checks, Dexterity saving throws, and attack rolls that use Dexterity.
	Slimy Doom. The creature begins to bleed uncontrollably. The creature has disadvantage on Constitution checks and Constitution saving throws. In addition, whenever the creature takes damage, it is stunned until the end of its next turn.', '5', 'CLASS:Druid'),
('Geas', 'You place a magical command on a creature that you can see within range, forcing it to carry out some service or refrain from some action or course of activity as you decide. If the creature can understand you, it must succeed on a Wisdom saving throw or become charmed by you for the duration. While the creature is charmed by you, it takes 5d10 psychic damage each time it acts in a manner directly counter to your instructions, but no more than once each day. A creature that can’t understand you is unaffected by the spell. You can issue any command you choose, short of an activity that would result in certain death. Should you issue a suicidal command, the spell ends.', '5', 'CLASS:Druid'),
('Greater Restoration', 'You imbue a creature you touch with positive energy to undo a debilitating effect. You can reduce the target’s exhaustion level by one, or end one of the following effects on the target:
	One effect that charmed or petrified the target
	One curse, including the target''s attunement to a cursed magic item
	Any reduction to one of the target''s ability scores
	One effect reducing the target''s hit point maximum', '5', 'CLASS:Druid'),
('Insect Plague', 'Swarming, biting locusts fill a 20-foot-radius sphere centered on a point you choose within range. The sphere spreads around corners. The sphere remains for the duration, and its area is lightly obscured. The sphere’s area is difficult terrain. When the area appears, each creature in it must make a Constitution saving throw. A creature takes 4d10 piercing damage on a failed save, or half as much damage on a successful one. A creature must also make this saving throw when it enters the spell’s area for the first time on a turn or ends its turn there.', '5', 'CLASS:Druid'),
('Mass Cure Wounds', 'A wave of healing energy washes out from a point of your choice within range. Choose up to six creatures in a 30-foot-radius sphere centered on that point. Each target regains hit points equal to 3d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '5', 'CLASS:Druid'),
('Planar Binding', 'With this spell, you attempt to bind a celestial, an elemental, a fey, or a fiend to your service. The creature must be within range for the entire casting of the spell. (Typically, the creature is first summoned into the center of an inverted magic circle in order to keep it trapped while this spell is cast.) At the completion of the casting, the target must make a Charisma saving throw. On a failed save, it is bound to serve you for the duration. If the creature was summoned or created by another spell, that spell’s duration is extended to match the duration of this spell. A bound creature must follow your instructions to the best of its ability. You might command the creature to accompany you on an adventure, to guard a location, or to deliver a message. The creature obeys the letter of your instructions, but if the creature is hostile to you, it strives to twist your words to achieve its own objectives. If the creature carries out your instructions completely before the spell ends, it travels to you to report this fact if you are on the same plane of existence. If you are on a different plane of existence, it returns to the place where you bound it and remains there until the spell ends.', '5', 'CLASS:Druid'),
('Reincarnate', 'You touch a dead humanoid or a piece of a dead humanoid. Provided that the creature has been dead no longer than 10 days, the spell forms a new adult body for it and then calls the soul to enter that body. If the target’s soul isn’t free or willing to do so, the spell fails. The magic fashions a new body for the creature to inhabit, which likely causes the creature’s race to change. The GM rolls a d100 and consults the following table to determine what form the creature takes when restored to life, or the GM chooses a form.', '5', 'CLASS:Druid'),
('Scrying', 'You can see and hear a particular creature you choose that is on the same plane of existence as you. The target must make a Wisdom saving throw, which is modified by how well you know the target and the sort of physical connection you have to it. If a target knows you’re casting this spell, it can fail the saving throw voluntarily if it wants to be observed. On a successful save, the target isn’t affected, and you can’t use this spell against it again for 24 hours. On a failed save, the spell creates an invisible sensor within 10 feet of the target. You can see and hear through the sensor as if you were there. The sensor moves with the target, remaining within 10 feet of it for the duration. A creature that can see invisible objects sees the sensor as a luminous orb about the size of your fist.', '5', 'CLASS:Druid'),
('Tree Stride', 'You gain the ability to enter a tree and move from inside it to inside another tree of the same kind within 500 feet. Both trees must be living and at least the same size as you. You must use 5 feet of movement to enter a tree. You instantly know the location of all other trees of the same kind within 500 feet and, as part of the move used to enter the tree, can either pass into one of those trees or step out of the tree you’re in. You appear in a spot of your choice within 5 feet of the destination tree, using another 5 feet of movement. If you have no movement left, you appear within 5 feet of the tree you entered.', '5', 'CLASS:Druid'),
('Wall of Stone', 'A nonmagical wall of solid stone springs into existence at a point you choose within range. The wall is 6 inches thick and is composed of ten 10-foot-by-10-foot panels. Each panel must be contiguous with at least one other panel. Alternatively, you can create 10-foot-by-20-foot panels that are only 3 inches thick. If the wall cuts through a creature’s space when it appears, the creature is pushed to one side of the wall (your choice). If a creature would be surrounded on all sides by the wall (or the wall and another solid surface), that creature can make a Dexterity saving throw. On a success, it can use its reaction to move up to its speed so that it is no longer enclosed by the wall. The wall can have any shape you desire, though it can’t occupy the same space as a creature or object. The wall doesn’t need to be vertical or rest on any firm foundation. It must, however, merge with and be solidly supported by existing stone. Thus, you can use this spell to bridge a chasm or create a ramp.', '5', 'CLASS:Druid'),

('Conjure Fey', 'You summon a fey creature of challenge rating 6 or lower, or a fey spirit that takes the form of a beast of challenge rating 6 or lower. It appears in an unoccupied space that you can see within range. The fey creature disappears when it drops to 0 hit points or when the spell ends. The fey creature is friendly to you and your companions for the duration. Roll initiative for the creature, which has its own turns. It obeys any verbal commands that you issue to it (no action required by you), as long as they don’t violate its alignment. If you don’t issue any commands to the fey creature, it defends itself from hostile creatures but otherwise takes no actions.', '6', 'CLASS:Druid'),
('Find the Path', 'This spell allows you to find the shortest, most direct physical route to a specific fixed location that you are familiar with on the same plane of existence. If you name a destination on another plane of existence, a destination that moves (such as a mobile fortress), or a destination that isn’t specific (such as “a green dragon’s lair”), the spell fails. For the duration, as long as you are on the same plane of existence as the destination, you know how far it is and in what direction it lies. While you are traveling there, whenever you are presented with a choice of paths along the way, you automatically determine which path is the shortest and most direct route (but not necessarily the safest route) to the destination. ', '6', 'CLASS:Druid'),
('Heal', 'Choose a creature that you can see within range. A surge of positive energy washes through the creature, causing it to regain 70 hit points. This spell also ends blindness, deafness, and any diseases affecting the target. This spell has no effect on constructs or undead.', '6', 'CLASS:Druid'),
('Heroes'' Feast', 'ou bring forth a great feast, including magnificent food and drink. The feast takes 1 hour to consume and disappears at the end of that time, and the beneficial effects don’t set in until this hour is over. Up to twelve other creatures can partake of the feast. A creature that partakes of the feast gains several benefits. The creature is cured of all diseases and poison, becomes immune to poison and being frightened, and makes all Wisdom saving throws with advantage. Its hit point maximum also increases by 2d10, and it gains the same number of hit points. These benefits last for 24 hours.', '6', 'CLASS:Druid'),
('Move Earth', 'Choose an area of terrain no larger than 40 feet on a side within range. You can reshape dirt, sand, or clay in the area in any manner you choose for the duration. You can raise or lower the area’s elevation, create or fill in a trench, erect or flatten a wall, or form a pillar. The extent of any such changes can’t exceed half the area’s largest dimension. So, if you affect a 40-foot square, you can create a pillar up to 20 feet high, raise or lower the square’s elevation by up to 20 feet, dig a trench up to 20 feet deep, and so on. It takes 10 minutes for these changes to complete. At the end of every 10 minutes you spend concentrating on the spell, you can choose a new area of terrain to affect.', '6', 'CLASS:Druid'),
('Sunbeam', 'A beam of brilliant light flashes out from your hand in a 5-foot-wide, 60-foot-long line. Each creature in the line must make a Constitution saving throw. On a failed save, a creature takes 6d8 radiant damage and is blinded until your next turn. On a successful save, it takes half as much damage and isn’t blinded by this spell. Undead and oozes have disadvantage on this saving throw. You can create a new line of radiance as your action on any turn until the spell ends.', '6', 'CLASS:Druid'),
('Transport via Plants', 'This spell creates a magical link between a Large or larger inanimate plant within range and another plant, at any distance, on the same plane of existence. You must have seen or touched the destination plant at least once before. For the duration, any creature can step into the target plant and exit from the destination plant by using 5 feet of movement. ', '6', 'CLASS:Druid'),
('Wall of Thorns', 'You create a wall of tough, pliable, tangled brush bristling with needle-sharp thorns. The wall appears within range on a solid surface and lasts for the duration. You choose to make the wall up to 60 feet long, 10 feet high, and 5 feet thick or a circle that has a 20-foot diameter and is up to 20 feet high and 5 feet thick. The wall blocks line of sight. When the wall appears, each creature within its area must make a Dexterity saving throw. On a failed save, a creature takes 7d8 piercing damage, or half as much damage on a successful save.', '6', 'CLASS:Druid'),
('Wind Walk', 'You and up to ten willing creatures you can see within range assume a gaseous form for the duration, appearing as wisps of cloud. While in this cloud form, a creature has a flying speed of 300 feet and has resistance to damage from nonmagical weapons. The only actions a creature can take in this form are the Dash action or to revert to its normal form. Reverting takes 1 minute, during which time a creature is incapacitated and can’t move. Until the spell ends, a creature can revert to cloud form, which also requires the 1-minute transformation. If a creature is in cloud form and flying when the effect ends, the creature descends 60 feet per round for 1 minute until it lands, which it does safely. If it can’t land after 1 minute, the creature falls the remaining distance.', '6', 'CLASS:Druid'),

('Fire Storm', 'A storm made up of sheets of roaring flame appears in a location you choose within range. The area of the storm consists of up to ten 10-­‐‑foot cubes, which you can arrange as you wish. Each cube must have at least one face adjacent to the face of another cube. Each creature in the area must make a Dexterity saving throw. It takes 7d10 fire damage on a failed save, or half as much damage on a successful one.', '7', 'CLASS:Druid'),
('Mirage Arcane', 'You make terrain in an area up to 1 mile square look, sound, smell, and even feel like some other sort of terrain. The terrain’s general shape remains the same, however. Open fields or a road could be made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Similarly, you can alter the appearance of structures, or add them where none are present. The spell doesn’t disguise, conceal, or add creatures. The illusion includes audible, visual, tactile, and olfactory elements, so it can turn clear ground into difficult terrain (or vice versa) or otherwise impede movement through the area. Any piece of the illusory terrain (such as a rock or stick) that is removed from the spell’s area disappears immediately.', '7', 'CLASS:Druid'),
('Plane Shift', 'You and up to eight willing creatures who link hands in a circle are transported to a different plane of existence. You can specify a target destination in general terms, such as the City of Brass on the Elemental Plane of Fire or the palace of Dispater on the second level of the Nine Hells, and you appear in or near that destination. If you are trying to reach the City of Brass, for example, you might arrive in its Street of Steel, before its Gate of Ashes, or looking at the city from across the Sea of Fire, at the GM’s discretion.', '7', 'CLASS:Druid'),
('Regenerate', 'You touch a creature and stimulate its natural healing ability. The target regains 4d8 + 15 hit points. For the duration of the spell, the target regains 1 hit point at the start of each of its turns (10 hit points each minute). The target’s severed body members (fingers, legs, tails, and so on), if any, are restored after 2 minutes. If you have the severed part and hold it to the stump, the spell instantaneously causes the limb to knit to the stump.', '7', 'CLASS:Druid'),
('Reverse Gravity', 'This spell reverses gravity in a 50-foot-radius, 100-foot high cylinder centered on a point within range. All creatures and objects that aren’t somehow anchored to the ground in the area fall upward and reach the top of the area when you cast this spell. A creature can make a Dexterity saving throw to grab onto a fixed object it can reach, thus avoiding the fall. If some solid object (such as a ceiling) is encountered in this fall, falling objects and creatures strike it just as they would during a normal downward fall. If an object or creature reaches the top of the area without striking anything, it remains there, oscillating slightly, for the duration.', '7', 'CLASS:Druid'),

('Animal Shapes', 'Your magic turns others into beasts. Choose any number of willing creatures that you can see within range. You transform each target into the form of a Large or smaller beast with a challenge rating of 4 or lower. On subsequent turns, you can use your action to transform affected creatures into new forms. The transformation lasts for the duration for each target, or until the target drops to 0 hit points or dies. You can choose a different form for each target. A target’s game statistics are replaced by the statistics of the chosen beast, though the target retains its alignment and Intelligence, Wisdom, and Charisma scores. The target assumes the hit points of its new form, and when it reverts to its normal form, it returns to the number of hit points it had before it transformed. If it reverts as a result of dropping to 0 hit points, any excess damage carries over to its normal form. As long as the excess damage doesn’t reduce the creature’s normal form to 0hit points, it isn’t knocked unconscious. The creature is limited in the actions it can perform by the nature of its new form, and it can’t speak or cast spells.', '8', 'CLASS:Druid'),
('Antipathy/Sympathy', 'This spell attracts or repels creatures of your choice. You target something within range, either a Huge or smaller object or creature or an area that is no larger than a 200-foot cube. Then specify a kind of intelligent creature, such as red dragons, goblins, or vampires. You invest the target with an aura that either attracts or repels the specified creatures for the duration. Choose antipathy or sympathy as the aura’s effect.
	Antipathy: The enchantment causes creatures of the kind you designated to feel an intense urge to leave the area and avoid the target. When such a creature can see the target or comes within 60 feet of it, the creature must succeed on a Wisdom saving throw or become frightened. The creature remains frightened while it can see the target or is within 60 feet of it. While frightened by the target, the creature must use its movement to move to the nearest safe spot from which it can’t see the target. If the creature moves more than 60 feet from the target and can’t see it, the creature is no longer frightened, but the creature becomes frightened again if it regains sight of the target or moves within 60 feet of it.
	Sympathy: The enchantment causes the specified creatures to feel an intense urge to approach the target while within 60 feet of it or able to see it. When such a creature can see the target or comes within 60 feet of it, the creature must succeed on a Wisdom saving throw or use its movement on each of its turns to enter the area or move within reach of the target. When the creature has done so, it can’t willingly move away from the target. If the target damages or otherwise harms an affected creature, the affected creature can make a Wisdom saving throw to end the effect, as described below.', '8', 'CLASS:Druid'),
('Control Weather', 'You take control of the weather within 5 miles of you for the duration. You must be outdoors to cast this spell. Moving to a place where you don’t have a clear path to the sky ends the spell early. When you cast the spell, you change the current weather conditions, which are determined by the GM based on the climate and season. You can change precipitation, temperature, and wind. It takes 1d4 × 10 minutes for the new conditions to take effect. Once they do so, you can change the conditions again. When the spell ends, the weather gradually returns to normal.', '8', 'CLASS:Druid'),
('Earthquake', 'You create a seismic disturbance at a point on the ground that you can see within range. For the duration, an intense tremor rips through the ground in a 100--‐‑foot--‐‑radius circle centered on that point and shakes creatures and structures in contact with the ground in that area. The ground in the area becomes difficult terrain. Each creature on the ground that is concentrating must make a Constitution saving throw. On a failed save, the creature’s concentration is broken. When you cast this spell and at the end of each turn you spend concentrating on it, each creature on the ground in the area must make a Dexterity saving throw. On a failed save, the creature is knocked prone.', '8', 'CLASS:Druid'),
('Feeblemind', 'You blast the mind of a creature that you can see within range, attempting to shatter its intellect and personality. The target takes 4d6 psychic damage and must make an Intelligence saving throw. On a failed save, the creature’s Intelligence and Charisma scores become 1. The creature can’t cast spells, activate magic items, understand language, or communicate in any intelligible way. The creature can, however, identify its friends, follow them, and even protect them.', '8', 'CLASS:Druid'),
('Sunburst', 'Brilliant sunlight flashes in a 60-foot radius centered on a point you choose within range. Each creature in that light must make a Constitution saving throw. On a failed save, a creature takes 12d6 radiant damage and is blinded for 1 minute. On a successful save, it takes half as much damage and isn’t blinded by this spell. Undead and oozes have disadvantage on this saving throw. A creature blinded by this spell makes another Constitution saving throw at the end of each of its turns. On a successful save, it is no longer blinded. This spell dispels any darkness in its area that was created by a spell.', '8', 'CLASS:Druid'),

('Foresight', 'You touch a willing creature and bestow a limited ability to see into the immediate future. For the duration, the target can’t be surprised and has advantage on attack rolls, ability checks, and saving throws. Additionally, other creatures have disadvantage on attack rolls against the target for the duration.', '9', 'CLASS:Druid'),
('Shapechange', 'You assume the form of a different creature for the duration. The new form can be of any creature with a challenge rating equal to your level or lower. The creature can’t be a construct or an undead, and you must have seen the sort of creature at least once. You transform into an average example of that creature, one without any class levels or the Spellcasting trait. You assume the hit points and Hit Dice of the new form. When you revert to your normal form, you return to the number of hit points you had before you transformed. If you revert as a result of dropping to 0 hit points, any excess damage carries over to your normal form. As long as the excess damage doesn’t reduce your normal form to 0 hit points, you aren’t knocked unconscious. When you transform, you choose whether your equipment falls to the ground, merges into the new form, or is worn by it. Worn equipment functions as normal. The GM determines whether it is practical for the new form to wear a piece of equipment, based on the creature’s shape and size. Your equipment doesn’t change shape or size to match the new form, and any equipment that the new form can’t wear must either fall to the ground or merge into your new form. Equipment that merges has no effect in that state.', '9', 'CLASS:Druid'),
('Storm of Vengeance', 'A churning storm cloud forms, centered on a point you can see and spreading to a radius of 360 feet. Lightning flashes in the area, thunder booms, and strong winds roar. Each creature under the cloud (no more than 5,000 feet beneath the cloud) when it appears must make a Constitution saving throw. On a failed save, a creature takes 2d6 thunder damage and becomes deafened for 5 minutes.
	Each round you maintain concentration on this spell, the storm produces additional effects on your turn.
	Round 2. Acidic rain falls from the cloud. Each creature and object under the cloud takes 1d6 acid damage.
	Round 3. You call six bolts of lightning from the cloud to strike six creatures or objects of your choice beneath the cloud. A given creature or object can’t be struck by more than one bolt. A struck creature must make a Dexterity saving throw. The creature takes 10d6 lightning damage on a failed save, or half as much damage on a successful one.
	Round 4. Hailstones rain down from the cloud. Each creature under the cloud takes 2d6 bludgeoning damage.
	Round 5–10. Gusts and freezing rain assail the area under the cloud. The area becomes difficult terrain and is heavily obscured. Each creature there takes 1d6 cold damage. Ranged weapon attacks in the area are impossible. The wind and rain count as a severe distraction for the purposes of maintaining concentration on spells. Finally, gusts of strong wind (ranging from 20 to 50 miles per hour) automatically disperse fog, mists, and similar phenomena in the area, whether mundane or magical.', '9', 'CLASS:Druid'),
('True Resurrection', 'You touch a creature that has been dead for no longer than 200 years and that died for any reason except old age. If the creature’s soul is free and willing, the creature is restored to life with all its hit points. This spell closes all wounds, neutralizes any poison, cures all diseases, and lifts any curses affecting the creature when it died. The spell replaces damaged or missing organs and limbs. The spell can even provide a new body if the original no longer exists, in which case you must speak the creature’s name. The creature then appears in an unoccupied space you choose within 10 feet of you.', '9', 'CLASS:Druid'),

('Bless', 'You bless up to three creatures of your choice within range. Whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw.', '1', 'CLASS:Paladin'),
('Command', 'You speak a one-word command to a creature you can see within range. The target must succeed on a Wisdom saving throw or follow the command on its next turn. The spell has no effect if the target is undead, if it doesn’t understand your language, or if your command is directly harmful to it. Some typical commands and their effects follow. You might issue a command other than one described here. If you do so, the GM determines how the target behaves. If the target can’t follow your command, the spell ends.
	Approach. The target moves toward you by the shortest and most direct route, ending its turn if it moves within 5 feet of you.
	Drop. The target drops whatever it is holding and then ends its turn.
	Flee. The target spends its turn moving away from you by the fastest available means.
	Grovel. The target falls prone and then ends its turn.
	Halt. The target doesn’t move and takes no actions. A flying creature stays aloft, provided that it is able to do so. If it must move to stay aloft, it flies the minimum distance needed to remain in the air.', '1', 'CLASS:Paladin'),
('Cure Wounds', 'A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Paladin'),
('Detect Evil and Good', 'For the duration, you know if there is an aberration, celestial, elemental, fey, fiend, or undead within 30 feet of you, as well as where the creature is located. Similarly, you know if there is a place or object within 30 feet of you that has been magically consecrated or desecrated.', '1', 'CLASS:Paladin'),
('Detect Magic', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.', '1', 'CLASS:Paladin'),
('Detect Poison and Disease', 'or the duration, you can sense the presence and location of poisons, poisonous creatures, and diseases within 30 feet of you. You also identify the kind of poison, poisonous creature, or disease in each case.', '1', 'CLASS:Paladin'),
('Divine Favor', 'Your prayer empowers you with divine radiance. Until the spell ends, your weapon attacks deal an extra 1d4 radiant damage on a hit.', '1', 'CLASS:Paladin'),
('Heroism', 'A willing creature you touch is imbued with bravery. Until the spell ends, the creature is immune to being frightened and gains temporary hit points equal to your spellcasting ability modifier at the start of each of its turns. When the spell ends, the target loses any remaining temporary hit points from this spell.', '1', 'CLASS:Paladin'),
('Protection from Evil and Good', 'Until the spell ends, one willing creature you touch is protected against certain types of creatures: aberrations, celestials, elementals, fey, fiends, and undead. The protection grants several benefits. Creatures of those types have disadvantage on attack rolls against the target. The target also can’t be charmed, frightened, or possessed by them. If the target is already charmed, frightened, or possessed by such a creature, the target has advantage on any new saving throw against the relevant effect.', '1', 'CLASS:Paladin'),
('Purify Food and Water', 'All nonmagical food and drink within a 5-foot-radius sphere centered on a point of your choice within range is purified and rendered free of poison and disease.', '1', 'CLASS:Paladin'),
('Shield of Faith', 'A shimmering field appears and surrounds a creature of your choice within range, granting it a +2 bonus to AC for the duration.', '1', 'CLASS:Paladin'),

('Aid', 'Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target’s hit point maximum and current hit points increase by 5 for the duration.', '2', 'CLASS:Paladin'),
('Branding Smite', 'The next time you hit a creature with a weapon attack before this spell ends, the weapon gleams with astral radiance as you strike. The attack deals an extra 2d6 radiant damage to the target, which becomes visible if it''s invisible, and the target sheds dim light in a 5-foot radius and can''t become invisible until the spell ends.', '2', 'CLASS:Paladin'),
('Find Steed', 'You summon a spirit that assumes the form of an unusually intelligent, strong, and loyal steed, creating a long-­‐‑lasting bond with it. Appearing in an unoccupied space within range, the steed takes on a form that you choose: a warhorse, a pony, a camel, an elk, or a mastiff. (Your GM might allow other animals to be summoned as steeds.) The steed has the statistics of the chosen form, though it is a celestial, fey, or fiend (your choice) instead of its normal type. Additionally, if your steed has an Intelligence of 5 or less, its Intelligence becomes 6, and it gains the ability to understand one language of your choice that you speak. Your steed serves you as a mount, both in combat and out, and you have an instinctive bond with it that allows you to fight as a seamless unit. While mounted on your steed, you can make any spell you cast that targets only you also target your steed. When the steed drops to 0 hit points, it disappears, leaving behind no physical form. You can also dismiss your steed at any time as an action, causing it to disappear. In either case, casting this spell again summons the same steed, restored to its hit point maximum.', '2', 'CLASS:Paladin'),
('Lesser Restoration', 'You touch a creature and can end either one disease or one condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned.', '2', 'CLASS:Paladin'),
('Locate Object', 'Describe or name an object that is familiar to you. You sense the direction to the object’s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement. The spell can locate a specific object known to you, as long as you have seen it up close—within 30 feet—at least once. Alternatively, the spell can locate the nearest object of a particular kind, such as a certain kind of apparel, jewelry, furniture, tool, or weapon.', '2', 'CLASS:Paladin'),
('Magic Weapon', 'You touch a nonmagical weapon. Until the spell ends, that weapon becomes a magic weapon with a +1 bonus to attack rolls and damage rolls.', '2', 'CLASS:Paladin'),
('Protection from Poison', 'You touch a creature. If it is poisoned, you neutralize the poison. If more than one poison afflicts the target, you neutralize one poison that you know is present, or you neutralize one at random.', '2', 'CLASS:Paladin'),
('Zone of Truth', 'You create a magical zone that guards against deception in a 15-foot-radius sphere centered on a point of your choice within range. Until the spell ends, a creature that enters the spell’s area for the first time on a turn or starts its turn there must make a Charisma saving throw. On a failed save, a creature can’t speak a deliberate lie while in the radius. You know whether each creature succeeds or fails on its saving throw. An affected creature is aware of the spell and can thus avoid answering questions to which it would normally respond with a lie. Such a creature can be evasive in its answers as long as it remains within the boundaries of the truth.', '2', 'CLASS:Paladin'),

('Create Food and Water', 'You create 45 pounds of food and 30 gallons of water on the ground or in containers within range, enough to sustain up to fifteen humanoids or five steeds for 24 hours. The food is bland but nourishing, and spoils if uneaten after 24 hours. The water is clean and doesn’t go bad.', '3', 'CLASS:Paladin'),
('Daylight', 'A 60-foot-radius sphere of light spreads out from a point you choose within range. The sphere is bright light and sheds dim light for an additional 60 feet. If you chose a point on an object you are holding or one that isn’t being worn or carried, the light shines from the object and moves with it. Completely covering the affected object with an opaque object, such as a bowl or a helm, blocks the light.', '3', 'CLASS:Paladin'),
('Dispel Magic', 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.', '3', 'CLASS:Paladin'),
('Magic Circle', 'You create a 10-foot-radius, 20-foot-tall cylinder of magical energy centered on a point on the ground that you can see within range. Glowing runes appear wherever the cylinder intersects with the floor or other surface. Choose one or more of the following types of creatures: celestials, elementals, fey, fiends, or undead. The circle affects a creature of the chosen type in the following ways:
	The creature can’t willingly enter the cylinder by nonmagical means. If the creature tries to use teleportation or interplanar travel to do so, it must first succeed on a Charisma saving throw.
	The creature has disadvantage on attack rolls against targets within the cylinder.
	Targets within the cylinder can’t be charmed, frightened, or possessed by the creature.', '3', 'CLASS:Paladin'),
('Remove Curse', 'At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its owner’s attunement to the object so it can be removed or discarded.', '3', 'CLASS:Paladin'),
('Revivify', 'You touch a creature that has died within the last minute. That creature returns to life with 1 hit point. This spell can’t return to life a creature that has died of old age, nor can it restore any missing body parts.', '3', 'CLASS:Paladin'),

('Banishment', 'You attempt to send one creature that you can see within range to another plane of existence. The target must succeed on a Charisma saving throw or be banished. If the target is native to the plane of existence you’re on, you banish the target to a harmless demiplane. While there, the target is incapacitated. The target remains there until the spell ends, at which point the target reappears in the space it left or in the nearest unoccupied space if that space is occupied. If the target is native to a different plane of existence than the one you’re on, the target is banished with a faint popping noise, returning to its home plane. If the spell ends before 1 minute has passed, the target reappears in the space it left or in the nearest unoccupied space if that space is occupied. Otherwise, the target doesn’t return.', '4', 'CLASS:Paladin'),
('Death Ward', 'You touch a creature and grant it a measure of protection from death. The first time the target would drop to 0 hit points as a result of taking damage, the target instead drops to 1 hit point, and the spell ends. If the spell is still in effect when the target is subjected to an effect that would kill it instantaneously without dealing damage, that effect is instead negated against the target, and the spell ends.', '4', 'CLASS:Paladin'),
('Locate Creature', 'Describe or name a creature that is familiar to you. You sense the direction to the creature’s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement. The spell can locate a specific creature known to you, or the nearest creature of a specific kind (such as a human or a unicorn), so long as you have seen such a creature up close—within 30 feet—at least once. If the creature you described or named is in a different form, such as being under the effects of a polymorph spell, this spell doesn’t locate the creature.', '4', 'CLASS:Paladin'),

('Dispel Evil and Good', 'Shimmering energy surrounds and protects you from fey, undead, and creatures originating from beyond the Material Plane. For the duration, celestials, elementals, fey, fiends, and undead have disadvantage on attack rolls against you. You can end the spell early by using either of the following special functions.', '5', 'CLASS:Paladin'),
('Geas', 'You place a magical command on a creature that you can see within range, forcing it to carry out some service or refrain from some action or course of activity as you decide. If the creature can understand you, it must succeed on a Wisdom saving throw or become charmed by you for the duration. While the creature is charmed by you, it takes 5d10 psychic damage each time it acts in a manner directly counter to your instructions, but no more than once each day. A creature that can’t understand you is unaffected by the spell. You can issue any command you choose, short of an activity that would result in certain death. Should you issue a suicidal command, the spell ends.', '5', 'CLASS:Paladin'),
('Raise Dead', 'You return a dead creature you touch to life, provided that it has been dead no longer than 10 days. If the creature’s soul is both willing and at liberty to rejoin the body, the creature returns to life with 1 hit point. This spell also neutralizes any poisons and cures nonmagical diseases that affected the creature at the time it died. This spell doesn’t, however, remove magical diseases, curses, or similar effects; if these aren’t first removed prior to casting the spell, they take effect when the creature returns to life. The spell can’t return an undead creature to life. This spell closes all mortal wounds, but it doesn’t restore missing body parts. If the creature is lacking body parts or organs integral for its survival—its head, for instance—the spell automatically fails.', '5', 'CLASS:Paladin'),

('Alarm', 'You set an alarm against unwanted intrusion. Choose a door, a window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area. When you cast the spell, you can designate creatures that won’t set off the alarm. You also choose whether the alarm is mental or audible. A mental alarm alerts you with a ping in your mind if you are within 1 mile of the warded area. This ping awakens you if you are sleeping.', '1', 'CLASS:Ranger'),
('Animal Friendship', 'This spell lets you convince a beast that you mean it no harm. Choose a beast that you can see within range. It must see and hear you. If the beast''s Intelligence is 4 or higher, the spell fails. Otherwise, the beast must succeed on a Wisdom saving throw or be charmed by you for the spell''s duration. If you or one of your companions harms the target, the spells ends.', '1', 'CLASS:Ranger'),
('Cure Wounds', 'A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.', '1', 'CLASS:Ranger'),
('Detect Magic', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.', '1', 'CLASS:Ranger'),
('Detect Poison and Disease', 'For the duration, you can sense the presence and location of poisons, poisonous creatures, and diseases within 30 feet of you. You also identify the kind of poison, poisonous creature, or disease in each case.', '1', 'CLASS:Ranger'),
('Fog Cloud', 'You create a 20-foot-radius sphere of fog centered on a point within range. The sphere spreads around corners, and its area is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.', '1', 'CLASS:Ranger'),
('Goodberry', 'Up to ten berries appear in your hand and are infused with magic for the duration. A creature can use its action to eat one berry. Eating a berry restores 1 hit point, and the berry provides enough nourishment to sustain a creature for one day.', '1', 'CLASS:Ranger'),
('Hunter''s Mark', 'You choose a creature you can see within range and mystically mark it as your quarry. Until the spell ends, you deal an extra 1d6 damage to the target whenever you hit it with a weapon attack, and you have advantage on any Wisdom (Perception) or Wisdom (Survival) check you make to find it. If the target drops to 0 hit points before this spell ends, you can use a bonus action on a subsequent turn of yours to mark a new creature.', '1', 'CLASS:Ranger'),
('Jump', 'You touch a creature. The creature’s jump distance is tripled until the spell ends.', '1', 'CLASS:Ranger'),
('Longstrider', 'You touch a creature. The target’s speed increases by 10 feet until the spell ends.', '1', 'CLASS:Ranger'),
('Speak with Animals', 'You gain the ability to comprehend and verbally communicate with beasts for the duration. The knowledge and awareness of many beasts is limited by their intelligence, but at minimum, beasts can give you information about nearby locations and monsters, including whatever they can perceive or have perceived within the past day. You might be able to persuade a beast to perform a small favor for you, at the GM’s discretion.', '1', 'CLASS:Ranger'),

('Animal Messanger', 'By means of this spell, you use an animal to deliver a message. Choose a Tiny beast you can see within range, such as a squirrel, a blue jay, or a bat. You specify a location, which you must have visited, and a recipient who matches a general description, such as “a man or woman dressed in the uniform of the town guard” or “a red-haired dwarf wearing a pointed hat.” You also speak a message of up to twenty-five words. The target beast travels for the duration of the spell toward the specified location, covering about 50 miles per 24 hours for a flying messenger, or 25 miles for other animals. When the messenger arrives, it delivers your message to the creature that you described, replicating the sound of your voice. The messenger speaks only to a creature matching the description you gave. If the messenger doesn’t reach its destination before the spell ends, the message is lost, and the beast makes its way back to where you cast this spell.', '2', 'CLASS:Ranger'),
('Barkskin', 'You touch a willing creature. Until the spell ends, the target’s skin has a rough, bark-like appearance, and the target’s AC can’t be less than 16, regardless of what kind of armor it is wearing.', '2', 'CLASS:Ranger'),
('Darkvision', 'You touch a willing creature to grant it the ability to see in the dark. For the duration, that creature has darkvision out to a range of 60 feet.', '2', 'CLASS:Ranger'),
('Find Traps', 'You sense the presence of any trap within range that is within line of sight. A trap, for the purpose of this spell, includes anything that would inflict a sudden or unexpected effect you consider harmful or undesirable, which was specifically intended as such by its creator. Thus, the spell would sense an area affected by the alarm spell, a glyph of warding, or a mechanical pit trap, but it would not reveal a natural weakness in the floor, an unstable ceiling, or a hidden sinkhole.', '2', 'CLASS:Ranger'),
('Lesser Restoration', 'You touch a creature and can end either one disease or one condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned.', '2', 'CLASS:Ranger'),
('Locate Animals or Plants', 'Describe or name a specific kind of beast or plant. Concentrating on the voice of nature in your surroundings, you learn the direction and distance to the closest creature or plant of that kind within 5 miles, if any are present.', '2', 'CLASS:Ranger'),
('Locate Object', 'Describe or name an object that is familiar to you. You sense the direction to the object’s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement. The spell can locate a specific object known to you, as long as you have seen it up close—within 30 feet—at least once. Alternatively, the spell can locate the nearest object of a particular kind, such as a certain kind of apparel, jewelry, furniture, tool, or weapon.', '2', 'CLASS:Ranger'),
('Pass without Trace', 'A veil of shadows and silence radiates from you, masking you and your companions from detection. For the duration, each creature you choose within 30 feet of you (including you) has a +10 bonus to Dexterity (Stealth) checks and can’t be tracked except by magical means. A creature that receives this bonus leaves behind no tracks or other traces of its passage.', '2', 'CLASS:Ranger'),
('Protection from Poison', 'You touch a creature. If it is poisoned, you neutralize the poison. If more than one poison afflicts the target, you neutralize one poison that you know is present, or you neutralize one at random.', '2', 'CLASS:Ranger'),
('Silence', 'For the duration, no sound can be created within or pass through a 20-­‐‑foot-­‐‑radius sphere centered on a point you choose within range. Any creature or object entirely inside the sphere is immune to thunder damage, and creatures are deafened while entirely inside it. Casting a spell that includes a verbal component is impossible there.', '2', 'CLASS:Ranger'),
('Spike Growth', 'The ground in a 20-foot radius centered on a point within range twists and sprouts hard spikes and thorns. The area becomes difficult terrain for the duration. When a creature moves into or within the area, it takes 2d4 piercing damage for every 5 feet it travels. The transformation of the ground is camouflaged to look natural. Any creature that can’t see the area at the time the spell is cast must make a Wisdom (Perception) check against your spell save DC to recognize the terrain as hazardous before entering it.', '2', 'CLASS:Ranger'),

('Conjure Animals', 'You summon fey spirits that take the form of beasts and appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:
	One beast of challenge rating 2 or lower
	Two beasts of challenge rating 1 or lower
	Four beasts of challenge rating 1/2 or lower
	Eight beasts of challenge rating 1/4 or lower', '3', 'CLASS:Ranger'),
('Daylight', 'A 60-foot-radius sphere of light spreads out from a point you choose within range. The sphere is bright light and sheds dim light for an additional 60 feet. If you chose a point on an object you are holding or one that isn’t being worn or carried, the light shines from the object and moves with it. Completely covering the affected object with an opaque object, such as a bowl or a helm, blocks the light.', '3', 'CLASS:Ranger'),
('Nondetection', 'For the duration, you hide a target that you touch from divination magic. The target can be a willing creature or a place or an object no larger than 10 feet in any dimension. The target can’t be targeted by any divination magic or perceived through magical scrying sensors.', '3', 'CLASS:Ranger'),
('Plant Growth', 'This spell channels vitality into plants within a specific area. There are two possible uses for the spell, granting either immediate or long-term benefits. If you cast this spell using 1 action, choose a point within range. All normal plants in a 100-foot radius centered on that point become thick and overgrown. A creature moving through the area must spend 4 feet of movement for every 1 foot it moves. You can exclude one or more areas of any size within the spell’s area from being affected.', '3', 'CLASS:Ranger'),
('Protection from Energy', 'For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder.', '3', 'CLASS:Ranger'),
('Speak with Plants', 'You imbue plants within 30 feet of you with limited sentience and animation, giving them the ability to communicate with you and follow your simple commands. You can question plants about events in the spell’s area within the past day, gaining information about creatures that have passed, weather, and other circumstances. You can also turn difficult terrain caused by plant growth (such as thickets and undergrowth) into ordinary terrain that lasts for the duration. Or you can turn ordinary terrain where plants are present into difficult terrain that lasts for the duration, causing vines and branches to hinder pursuers, for example. Plants might be able to perform other tasks on your behalf, at the GM’s discretion. The spell doesn’t enable plants to uproot themselves and move about, but they can freely move branches, tendrils, and stalks.', '3', 'CLASS:Ranger'),
('Water Breathing', 'This spell grants up to ten willing creatures you can see within range the ability to breathe underwater until the spell ends. Affected creatures also retain their normal mode of respiration.', '3', 'CLASS:Ranger'),
('Water Walk', 'The transmuted creatures can tread on any liquid as if it were firm ground. Mud, oil, snow, quicksand, running water, ice, and even lava can be traversed easily, since the subjects’ feet hover an inch or two above the surface. (Creatures crossing molten lava still take damage from the heat because they are near it.) The subjects can walk, run, charge, or otherwise move across the surface as if it were normal ground.', '3', 'CLASS:Ranger'),
('Wind Wall', 'A wall of strong wind rises from the ground at a point you choose within range. You can make the wall up to 50 feet long, 15 feet high, and 1 foot thick. You can shape the wall in any way you choose so long as it makes one continuous path along the ground. The wall lasts for the duration. When the wall appears, each creature within its area must make a Strength saving throw. A creature takes 3d8 bludgeoning damage on a failed save, or half as much damage on a successful one.', '3', 'CLASS:Ranger'),

('Conjure Woodland Beings', 'You summon fey creatures that appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:
	One fey creature of challenge rating 2 or lower
	Two fey creatures of challenge rating 1 or lower
	Four fey creatures of challenge rating 1/2 or lower
	Eight fey creatures of challenge rating 1/4 or lower', '4', 'CLASS:Ranger'),
('Freedom of Movement', 'You touch a willing creature. For the duration, the target’s movement is unaffected by difficult terrain, and spells and other magical effects can neither reduce the target’s speed nor cause the target to be paralyzed or restrained. The target can also spend 5 feet of movement to automatically escape from nonmagical restraints, such as manacles or a creature that has it grappled. Finally, being underwater imposes no penalties on the target’s movement or attacks.', '4', 'CLASS:Ranger'),
('Locate Creature', 'Describe or name a creature that is familiar to you. You sense the direction to the creature’s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement. The spell can locate a specific creature known to you, or the nearest creature of a specific kind (such as a human or a unicorn), so long as you have seen such a creature up close—within 30 feet—at least once. If the creature you described or named is in a different form, such as being under the effects of a polymorph spell, this spell doesn’t locate the creature.', '4', 'CLASS:Ranger'),
('Stoneskin', 'This spell turns the flesh of a willing creature you touch as hard as stone. Until the spell ends, the target has resistance to nonmagical bludgeoning, piercing, and slashing damage.', '4', 'CLASS:Ranger'),

('Commune with Nature', 'You briefly become one with nature and gain knowledge of the surrounding territory. In the outdoors, the spell gives you knowledge of the land within 3 miles of you. In caves and other natural underground settings, the radius is limited to 300 feet.', '5', 'CLASS:Ranger'),
('Tree Stride', 'You gain the ability to enter a tree and move from inside it to inside another tree of the same kind within 500 feet. Both trees must be living and at least the same size as you. You must use 5 feet of movement to enter a tree. You instantly know the location of all other trees of the same kind within 500 feet and, as part of the move used to enter the tree, can either pass into one of those trees or step out of the tree you’re in. You appear in a spot of your choice within 5 feet of the destination tree, using another 5 feet of movement. If you have no movement left, you appear within 5 feet of the tree you entered.', '5', 'CLASS:Ranger'),


('Acid Splash', 'You hurl a bubble of acid. Choose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succeed on a Dexterity saving throw or take 1d6 acid damage.', '0', 'CLASS:Sorcerer'),
('Chill Touch', 'You create a ghostly, skeletal hand in the space of a creature within range. Make a ranged spell attack against the creature to assail it with the chill of the grave. On a hit, the target takes 1d8 necrotic damage, and it can’t regain hit points until the start of your next turn. Until then, the hand clings to the target.', '0', 'CLASS:Sorcerer'),
('Dancing Lights', 'You create up to four torch‑sized lights within range, making them appear as torches, lanterns, or glowing orbs that hover in the air for the duration. You can also combine the four lights into one glowing vaguely humanoid form of Medium size. Whichever form you choose, each light sheds dim light in a 10-foot radius.', '0', 'CLASS:Sorcerer'),
('Fire Bolt', 'You hurl a mote of fire at a creature or object within range. Make a ranged spell attack against the target. On a hit, the target takes 1d10 fire damage. A flammable object hit by this spell ignites if it isnt being worn or carried.', '0', 'CLASS:Sorcerer'),
('Light', 'You touch one object that is no larger than 10 feet in any dimension. Until the spell ends, the object sheds bright light in a 20-foot radius and dim light for an additional 20 feet. The light can be colored as you like. ', '0', 'CLASS:Sorcerer'),
('Mage Hand', 'A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again. You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.', '0', 'CLASS:Sorcerer'),
('Mending', 'This spell repairs a single break or tear in an object you touch, such as a broken chain link, two halves of a broken key, a torn cloak, or a leaking wineskin. As long as the break or tear is no larger than 1 foot in any dimension, you mend it, leaving no trace of the former damage.', '0', 'CLASS:Sorcerer'),
('Message', 'You point your finger toward a creature within range and whisper a message. The target (and only the target) hears the message and can reply in a whisper that only you can hear.', '0', 'CLASS:Sorcerer'),
('Minor Illusion', 'You create a sound or an image of an object within range that lasts for the duration. The illusion also ends if you dismiss it as an action or cast this spell again. If you create a sound, its volume can range from a whisper to a scream. It can be your voice, someone else’s voice, a lion’s roar, a beating of drums, or any other sound you choose. The sound continues unabated throughout the duration, or you can make discrete sounds at different times before the spell ends. If you create an image of an object—such as a chair, muddy footprints, or a small chest—it must be no larger than a 5-foot cube. The image can’t create sound, light, smell, or any other sensory effect. Physical interaction with the image reveals it to be an illusion, because things can pass through it.', '0', 'CLASS:Sorcerer'),
('Poison Spray', 'You extend your hand toward a creature you can see within range and project a puff of noxious gas from your palm. The creature must succeed on a Constitution saving throw or take 1d12 poison damage.', '0', 'CLASS:Sorcerer'),
('Prestidigitation', 'This spell is a minor magical trick that novice spellcasters use for practice. You create one of the following magical effects within range:
  You create an instantaneous, harmless sensory effect, such as a shower of sparks, a puff of wind, faint musical notes, or an odd odor.
  You instantaneously light or snuff out a candle, a torch, or a small campfire.
  You instantaneously clean or soil an object no larger than 1 cubic foot.
  You chill, warm, or flavor up to 1 cubic foot of nonliving material for 1 hour.
  You make a color, a small mark, or a symbol appear on an object or a surface for 1 hour.
  You create a nonmagical trinket or an illusory image that can fit in your hand and that lasts until the end of your next turn.', '0', 'CLASS:Sorcerer'),
('Ray of Frost', 'A frigid beam of blue-white light streaks toward a creature within range. Make a ranged spell attack against the target. On a hit, it takes 1d8 cold damage, and its speed is reduced by 10 feet until the start of your next turn.', '0', 'CLASS:Sorcerer'),
('Shocking Grasp', 'Lightning springs from your hand to deliver a shock to a creature you try to touch. Make a melee spell attack against the target. You have advantage on the attack roll if the target is wearing armor made of metal. On a hit, the target takes 1d8 lightning damage, and it can’t take reactions until the start of its next turn.', '0', 'CLASS:Sorcerer'),
('True Strike', 'You extend your hand and point a finger at a target in range. Your magic grants you a brief insight into the target’s defenses. On your next turn, you gain advantage on your first attack roll against the target, provided that this spell hasn’t ended.', '0', 'CLASS:Sorcerer'),


('Burning Hands', 'As you hold your hands with thumbs touching and fingers spread, a thin sheet of flames shoots forth from your outstretched fingertips. Each creature in a 15-foot cone must make a Dexterity saving throw. A creature takes 3d6 fire damage on a failed save, or half as much damage on a successful one. The fire ignites any flammable objects in the area that aren’t being worn or carried.', '1', 'CLASS:Sorcerer'),
('Charm Person', 'You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.', '1', 'CLASS:Sorcerer'),
('Color Spray', 'A dazzling array of flashing, colored light springs from your hand. Roll 6d10; the total is how many hit points of creatures this spell can effect. Creatures in a 15-foot cone originating from you are affected in ascending order of their current hit points (ignoring unconscious creatures and creatures that can’t see).', '1', 'CLASS:Sorcerer'),
('Comprehend Languages', 'For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text. This spell doesn’t decode secret messages in a text or a glyph, such as an arcane sigil, that isn’t part of a written language.', '1', 'CLASS:Sorcerer'),
('Detect Magic', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.', '1', 'CLASS:Sorcerer'),
('Disguise Self', 'You make yourself—including your clothing, armor, weapons, and other belongings on your person—look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can’t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you.', '1', 'CLASS:Sorcerer'),
('Expeditious Retreat', 'This spell allows you to move at an incredible pace. When you cast this spell, and then as a bonus action on each of your turns until the spell ends, you can take the Dash action.', '1', 'CLASS:Sorcerer'),
('False Life', 'Bolstering yourself with a necromantic facsimile of life, you gain 1d4 + 4 temporary hit points for the duration.This spell allows you to move at an incredible pace. When you cast this spell, and then as a bonus action on each of your turns until the spell ends, you can take the Dash action.', '1', 'CLASS:Sorcerer'),
('Feather Fall', 'Choose up to five falling creatures within range. A falling creature’s rate of descent slows to 60 feet per round until the spell ends. If the creature lands before the spell ends, it takes no falling damage and can land on its feet, and the spell ends for that creature.', '1', 'CLASS:Sorcerer'),
('Fog Cloud', 'You create a 20-foot-radius sphere of fog centered on a point within range. The sphere spreads around corners, and its area is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.', '1', 'CLASS:Sorcerer'),
('Jump', 'You touch a creature. The creature’s jump distance is tripled until the spell ends.', '1', 'CLASS:Sorcerer'),
('Mage Armor', 'You touch a willing creature who isn’t wearing armor, and a protective magical force surrounds it until the spell ends. The target’s base AC becomes 13 + its Dexterity modifier. The spell ends if the target dons armor or if you dismiss the spell as an action.', '1', 'CLASS:Sorcerer'),
('Magic Missile', 'You create three glowing darts of magical force. Each dart hits a creature of your choice that you can see within range. A dart deals 1d4 + 1 force damage to its target. The darts all strike simultaneously, and you can direct them to hit one creature or several.', '1', 'CLASS:Sorcerer'),
('Shield', 'An invisible barrier of magical force appears and protects you. Until the start of your next turn, you have a +5 bonus to AC, including against the triggering attack, and you take no damage from magic missile.', '1', 'CLASS:Sorcerer'),
('Silent Image', 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 15-­foot cube. The image appears at a spot within range and lasts for the duration. The image is purely visual; it isn’t accompanied by sound, smell, or other sensory effects.', '1', 'CLASS:Sorcerer'),
('Sleep', 'This spell sends creatures into a magical slumber. Roll 5d8; the total is how many hit points of creatures this spell can affect. Creatures within 20 feet of a point you choose within range are affected in ascending order of their current hit points (ignoring unconscious creatures).', '1', 'CLASS:Sorcerer'),
('Thunderwave', 'A wave of thunderous force sweeps out from you. Each creature in a 15‑foot cube originating from you must make a Constitution saving throw. On a failed save, a creature takes 2d8 thunder damage and is pushed 10 feet away from you. On a successful save, the creature takes half as much damage and isn’t pushed', '1', 'CLASS:Sorcerer'),


('Alter Self', 'You assume a different form. When you cast the spell, choose one of the following options, the effects of which last for the duration of the spell. While the spell lasts, you can end one option as an action to gain the benefits of a different one.', '2', 'CLASS:Sorcerer'),
('Blindness/Deafness', 'You can blind or deafen a foe. Choose one creature that you can see within range to make a Constitution saving throw. If it fails, the target is either blinded or deafened (your choice) for the duration. At the end of each of its turns, the target can make a Constitution saving throw. On a success, the spell ends.', '2', 'CLASS:Sorcerer'),
('Blur', 'Your body becomes blurred, shifting and wavering to all who can see you. For the duration, any creature has disadvantage on attack rolls against you. An attacker is immune to this effect if it doesn’t rely on sight, as with blindsight, or can see through illusions, as with truesight.', '2', 'CLASS:Sorcerer'),
('Darkness', 'Magical darkness spreads from a point you choose within range to fill a 15-foot-radius sphere for the duration. The darkness spreads around corners. A creature with darkvision can’t see through this darkness, and nonmagical light can’t illuminate it.', '2', 'CLASS:Sorcerer'),
('Darkvision', 'You touch a willing creature to grant it the ability to see in the dark. For the duration, that creature has darkvision out to a range of 60 feet.', '2', 'CLASS:Sorcerer'),
('Detect Thoughts', 'For the duration, you can read the thoughts of certain creatures. When you cast the spell and as your action on each turn until the spell ends, you can focus your mind on any one creature that you can see within 30 feet of you. If the creature you choose has an Intelligence of 3 or lower or doesn’t speak any language, the creature is unaffected.', '2', 'CLASS:Sorcerer'),
('Enhance Ability', 'You touch a creature and bestow upon it a magical enhancement. Choose one of the following effects; the target gains that effect until the spell ends.
  Bear’s Endurance. The target has advantage on Constitution checks. It also gains 2d6 temporary hit points, which are lost when the spell ends.
  Bull’s Strength. The target has advantage on Strength checks, and his or her carrying capacity doubles.
  Cat’s Grace. The target has advantage on Dexterity checks. It also doesn’t take damage from falling 20 feet or less if it isn’t incapacitated.
  Eagle’s Splendor. The target has advantage on Charisma checks.
  Fox’s Cunning. The target has advantage on Intelligence checks.
  Owl’s Wisdom. The target has advantage on Wisdom checks.', '2', 'CLASS:Sorcerer'),
('Enlarge/Reduce', 'You cause a creature or an object you can see within range to grow larger or smaller for the duration. Choose either a creature or an object that is neither worn nor carried. If the target is unwilling, it can make a Constitution saving throw. On a success, the spell has no effect. If the target is a creature, everything it is wearing and carrying changes size with it. Any item dropped by an affected creature returns to normal size at once.', '2', 'CLASS:Sorcerer'),
('Gust of Wind', 'A line of strong wind 60 feet long and 10 feet wide blasts from you in a direction you choose for the spell’s duration. Each creature that starts its turn in the line must succeed on a Strength saving throw or be pushed 15 feet away from you in a direction following the line. Any creature in the line must spend 2 feet of movement for every 1 foot it moves when moving closer to you.', '2', 'CLASS:Sorcerer'),
('Hold Person', 'Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '2', 'CLASS:Sorcerer'),
('Invisibility', 'A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person. The spell ends for a target that attacks or casts a spell.', '2', 'CLASS:Sorcerer'),
('Knock', 'Choose an object that you can see within range. The object can be a door, a box, a chest, a set of manacles, a padlock, or another object that contains a mundane or magical means that prevents access. A target that is held shut by a mundane lock or that is stuck or barred becomes unlocked, unstuck, or unbarred. If the object has multiple locks, only one of them is unlocked. When you cast the spell, a loud knock, audible from as far away as 300 feet, emanates from the target object.', '2', 'CLASS:Sorcerer'),
('Levitate', 'One creature or object of your choice that you can see within range rises vertically, up to 20 feet, and remains suspended there for the duration. The spell can levitate a target that weighs up to 500 pounds. An unwilling creature that succeeds on a Constitution saving throw is unaffected.', '2', 'CLASS:Sorcerer'),
('Mirror Image', 'Three illusory duplicates of yourself appear in your space. Until the spell ends, the duplicates move with you and mimic your actions, shifting position so it’s impossible to track which image is real. You can use your action to dismiss the illusory duplicates. Each time a creature targets you with an attack during the spell’s duration, roll a d20 to determine whether the attack instead targets one of your duplicates. If you have three duplicates, you must roll a 6 or higher to change the attack’s target to a duplicate. With two duplicates, you must roll an 8 or higher. With one duplicate, you must roll an 11 or higher.', '2', 'CLASS:Sorcerer'),
('Misty Step', 'Briefly surrounded by silvery mist, you teleport up to 30 feet to an unoccupied space that you can see.', '2', 'CLASS:Sorcerer'),
('Scorching Ray', 'You create three rays of fire and hurl them at targets within range. You can hurl them at one target or several. Make a ranged spell attack for each ray. On a hit, the target takes 2d6 fire damage.', '2', 'CLASS:Sorcerer'),
('See Invisibility', 'For the duration, you see invisible creatures and objects as if they were visible, and you can see into the Ethereal Plane. Ethereal creatures and objects appear ghostly and translucent.', '2', 'CLASS:Sorcerer'),
('Shatter', 'A sudden loud ringing noise, painfully intense, erupts from a point of your choice within range. Each creature in a 10-foot-radius sphere centered on that point must make a Constitution saving throw. A creature takes 3d8 thunder damage on a failed save, or half as much damage on a successful one. A creature made of inorganic material such as stone, crystal, or metal has disadvantage on this saving throw. A nonmagical object that isn’t being worn or carried also takes the damage if it’s in the spell’s area.', '2', 'CLASS:Sorcerer'),
('Spider Climb', 'Until the spell ends, one willing creature you touch gains the ability to move up, down, and across vertical surfaces and upside down along ceilings, while leaving its hands free. The target also gains a climbing speed equal to its walking speed.', '2', 'CLASS:Sorcerer'),
('Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence a creature you can see within range that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act ends the spell. The target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.', '2', 'CLASS:Sorcerer'),
('Web', 'You conjure a mass of thick, sticky webbing at a point of your choice within range. The webs fill a 20-foot cube from that point for the duration. The webs are difficult terrain and lightly obscure their area.', '2', 'CLASS:Sorcerer'),


('Blink', 'Roll a d20 at the end of each of your turns for the duration of the spell. On a roll of 11 or higher, you vanish from your current plane of existence and appear in the Ethereal Plane (the spell fails and the casting is wasted if you were already on that plane). At the start of your next turn, and when the spell ends if you are on the Ethereal Plane, you return to an unoccupied space of your choice that you can see within 10 feet of the space you vanished from. ', '3', 'CLASS:Sorcerer'),
('Clairvoyance', 'You create an invisible sensor within range in a location familiar to you (a place you have visited or seen before) or in an obvious location that is unfamiliar to you (such as behind a door, around a corner, or in a grove of trees). The sensor remains in place for the duration, and it can’t be attacked or otherwise interacted with.', '3', 'CLASS:Sorcerer'),
('Counterspell', 'You attempt to interrupt a creature in the process of casting a spell. If the creature is casting a spell of 3rd level or lower, its spell fails and has no effect. If it is casting a spell of 4th level or higher, make an ability check using your spellcasting ability. The DC equals 10 + the spells level. On a success, the creatures spell fails and has no effect.', '3', 'CLASS:Sorcerer'),
('Daylight', 'A 60-foot-radius sphere of light spreads out from a point you choose within range. The sphere is bright light and sheds dim light for an additional 60 feet.', '3', 'CLASS:Sorcerer'),
('Dispel Magic', 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.', '3', 'CLASS:Sorcerer'),
('Fear', 'You project a phantasmal image of a creature’s worst fears. Each creature in a 30-foot cone must succeed on a Wisdom saving throw or drop whatever it is holding and become frightened for the duration.', '3', 'CLASS:Sorcerer'),
('Fireball', 'A bright streak flashes from your pointing finger to a point you choose within range and then blossoms with a low roar into an explosion of flame. Each creature in a 20-foot-radius sphere centered on that point must make a Dexterity saving throw. A target takes 8d6 fire damage on a failed save, or half as much damage on a successful one. The fire spreads around corners. It ignites flammable objects in the area that aren’t being worn or carried.', '3', 'CLASS:Sorcerer'),
('Fly', 'You touch a willing creature. The target gains a flying speed of 60 feet for the duration. When the spell ends, the target falls if it is still aloft, unless it can stop the fall.', '3', 'CLASS:Sorcerer'),
('Gaseous Form', 'You transform a willing creature you touch, along with everything it’s wearing and carrying, into a misty cloud for the duration. The spell ends if the creature drops to 0 hit points. An incorporeal creature isn’t affected. While in this form, the target’s only method of movement is a flying speed of 10 feet. The target can enter and occupy the space of another creature. The target has resistance to nonmagical damage, and it has advantage on Strength, Dexterity, and Constitution saving throws. The target can pass through small holes, narrow openings, and even mere cracks, though it treats liquids as though they were solid surfaces. The target can’t fall and remains hovering in the air even when stunned or otherwise incapacitated.', '3', 'CLASS:Sorcerer'),
('Haste', 'Choose a willing creature that you can see within range. Until the spell ends, the target’s speed is doubled, it gains a +2 bonus to AC, it has advantage on Dexterity saving throws, and it gains an additional action on each of its turns. That action can be used only to take the Attack (one weapon attack only), Dash, Disengage, Hide, or Use an Object action.', '3', 'CLASS:Sorcerer'),
('Hypnotic Pattern', 'You create a twisting pattern of colors that weaves through the air inside a 30-­foot cube within range. The pattern appears for a moment and vanishes. Each creature in the area who sees the pattern must make a Wisdom saving throw. On a failed save, the creature becomes charmed for the duration. While charmed by this spell, the creature is incapacitated and has a speed of 0.', '3', 'CLASS:Sorcerer'),
('Lightning Bolt', 'A stroke of lightning forming a line 100 feet long and 5 feet wide blasts out from you in a direction you choose. Each creature in the line must make a Dexterity saving throw. A creature takes 8d6 lightning damage on a failed save, or half as much damage on a successful one. The lightning ignites flammable objects in the area that aren’t being worn or carried.', '3', 'CLASS:Sorcerer'),
('Major Image', 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 20-­‐‑foot cube. The image appears at a spot that you can see within range and lasts for the duration. It seems completely real, including sounds, smells, and temperature appropriate to the thing depicted. You can’t create sufficient heat or cold to cause damage, a sound loud enough to deal thunder damage or deafen a creature, or a smell that might sicken a creature (like a troglodyte’s stench).', '3', 'CLASS:Sorcerer'),
('Protection from Energy', 'For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder.', '3', 'CLASS:Sorcerer'),
('Sleet Storm', 'Until the spell ends, freezing rain and sleet fall in a 20-foot-tall cylinder with a 40-foot radius centered on a point you choose within range. The area is heavily obscured, and exposed flames in the area are doused. The ground in the area is covered with slick ice, making it difficult terrain. When a creature enters the spell’s area for the first time on a turn or starts its turn there, it must make a Dexterity saving throw. On a failed save, it falls prone.', '3', 'CLASS:Sorcerer'),
('Slow', 'You alter time around up to six creatures of your choice in a 40-foot cube within range. Each target must succeed on a Wisdom saving throw or be affected by this spell for the duration.', '3', 'CLASS:Sorcerer'),
('Stinking Cloud', 'You create a 20-foot-radius sphere of yellow, nauseating gas centered on a point within range. The cloud spreads around corners, and its area is heavily obscured. The cloud lingers in the air for the duration.', '3', 'CLASS:Sorcerer'),
('Tongues', 'This spell grants the creature you touch the ability to understand any spoken language it hears. Moreover, when the target speaks, any creature that knows at least one language and can hear the target understands what it says.', '3', 'CLASS:Sorcerer'),
('Water Breathing', 'This spell grants up to ten willing creatures you can see within range the ability to breathe underwater until the spell ends. Affected creatures also retain their normal mode of respiration.', '3', 'CLASS:Sorcerer'),
('Water Walk', 'The transmuted creatures can tread on any liquid as if it were firm ground. Mud, oil, snow, quicksand, running water, ice, and even lava can be traversed easily, since the subjects’ feet hover an inch or two above the surface. (Creatures crossing molten lava still take damage from the heat because they are near it.) The subjects can walk, run, charge, or otherwise move across the surface as if it were normal ground.', '3', 'CLASS:Sorcerer'),


('Banishment', 'You attempt to send one creature that you can see within range to another plane of existence. The target must succeed on a Charisma saving throw or be banished.', '4', 'CLASS:Sorcerer'),
('Blight', 'Necromantic energy washes over a creature of your choice that you can see within range, draining moisture and vitality from it. The target must make a Constitution saving throw. The target takes 8d8 necrotic damage on a failed save, or half as much damage on a successful one. This spell has no effect on undead or constructs.', '4', 'CLASS:Sorcerer'),
('Confusion', 'This spell assaults and twists creatures’ minds, spawning delusions and provoking uncontrolled action. Each creature in a 10-foot-radius sphere centered on a point you choose within range must succeed on a Wisdom saving throw when you cast this spell or be affected by it. An affected target can’t take reactions and must roll a d10 at the start of each of its turns to determine its behavior for that turn.', '4', 'CLASS:Sorcerer'),
('Dimension Door', 'You teleport yourself from your current location to any other spot within range. You arrive at exactly the spot desired. It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction, such as “200 feet straight downward” or “upward to the northwest at a 45-degree angle, 300 feet.” You can bring along objects as long as their weight doesn’t exceed what you can carry.', '4', 'CLASS:Sorcerer'),
('Dominate Beast', 'You attempt to beguile a beast that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.', '4', 'CLASS:Sorcerer'),
('Greater Invisibility', 'You or a creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person.', '4', 'CLASS:Sorcerer'),
('Ice Storm', 'A hail of rock-hard ice pounds to the ground in a 20-foot-radius, 40-foot-high cylinder centered on a point within range. Each creature in the cylinder must make a Dexterity saving throw. A creature takes 2d8 bludgeoning damage and 4d6 cold damage on a failed save, or half as much damage on a successful one. Hailstones turn the storm’s area of effect into difficult terrain until the end of your next turn.', '4', 'CLASS:Sorcerer'),
('Polymorph', 'This spell transforms a creature that you can see within range into a new form. An unwilling creature must make a Wisdom saving throw to avoid the effect. The spell has no effect on a shapechanger or a creature with 0 hit points.', '4', 'CLASS:Sorcerer'),
('Stoneskin', 'This spell turns the flesh of a willing creature you touch as hard as stone. Until the spell ends, the target has resistance to nonmagical bludgeoning, piercing, and slashing damage.', '4', 'CLASS:Sorcerer'),
('Wall of Fire', 'You create a wall of fire on a solid surface within range. You can make the wall up to 60 feet long, 20 feet high, and 1 foot thick, or a ringed wall up to 20 feet in diameter, 20 feet high, and 1 foot thick. The wall is opaque and lasts for the duration.', '4', 'CLASS:Sorcerer'),


('Animate Objects', 'Objects come to life at your command. Choose up to ten nonmagical objects within range that are not being worn or carried. Medium targets count as two objects, Large targets count as four objects, Huge targets count as eight objects. You can’t animate any object larger than Huge. Each target animates and becomes a creature under your control until the spell ends or until reduced to 0 hit points.', '5', 'CLASS:Sorcerer'),
('Cloudkill', 'You create a 20-foot-radius sphere of poisonous, yellow-green fog centered on a point you choose within range. The fog spreads around corners. It lasts for the duration or until strong wind disperses the fog, ending the spell. Its area is heavily obscured. When a creature enters the spell’s area for the first time on a turn or starts its turn there, that creature must make a Constitution saving throw. The creature takes 5d8 poison damage on a failed save, or half as much damage on a successful one. Creatures are affected even if they hold their breath or don’t need to breathe.', '5', 'CLASS:Sorcerer'),
('Cone of Cold', 'A blast of cold air erupts from your hands. Each creature in a 60-foot cone must make a Constitution saving throw. A creature takes 8d8 cold damage on a failed save, or half as much damage on a successful one. A creature killed by this spell becomes a frozen statue until it thaws.', '5', 'CLASS:Sorcerer'),
('Creation', 'You pull wisps of shadow material from the Shadowfell to create a nonliving object of vegetable matter within range: soft goods, rope, wood, or something similar. You can also use this spell to create mineral objects such as stone, crystal, or metal. The object created must be no larger than a 5-foot cube, and the object must be of a form and material that you have seen before.', '5', 'CLASS:Sorcerer'),
('Dominate Person', 'You attempt to beguile a humanoid that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.You pull wisps of shadow material from the Shadowfell to create a nonliving object of vegetable matter within range: soft goods, rope, wood, or something similar. You can also use this spell to create mineral objects such as stone, crystal, or metal. The object created must be no larger than a 5-foot cube, and the object must be of a form and material that you have seen before.', '5', 'CLASS:Sorcerer'),
('Hold Monster', 'Choose a creature that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. This spell has no effect on undead. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '5', 'CLASS:Sorcerer'),
('Insect Plague', 'Swarming, biting locusts fill a 20-foot-radius sphere centered on a point you choose within range. The sphere spreads around corners. The sphere remains for the duration, and its area is lightly obscured. The spheres area is difficult terrain.', '5', 'CLASS:Sorcerer'),
('Seeming', 'This spell allows you to change the appearance of any number of creatures that you can see within range. You give each target you choose a new, illusory appearance. An unwilling target can make a Charisma saving throw, and if it succeeds, it is unaffected by this spell.', '5', 'CLASS:Sorcerer'),
('Telekinesis', 'You gain the ability to move or manipulate creatures or objects by thought. When you cast the spell, and as your action each round for the duration, you can exert your will on one creature or object that you can see within range, causing the appropriate effect below. You can affect the same target round after round, or choose a new one at any time. If you switch targets, the prior target is no longer affected by the spell.', '5', 'CLASS:Sorcerer'),
('Teleportation Circle', 'As you cast the spell, you draw a 10-foot-diameter circle on the ground inscribed with sigils that link your location to a permanent teleportation circle of your choice whose sigil sequence you know and that is on the same plane of existence as you. A shimmering portal opens within the circle you drew and remains open until the end of your next turn. Any creature that enters the portal instantly appears within 5 feet of the destination circle or in the nearest unoccupied space if that space is occupied.', '5', 'CLASS:Sorcerer'),
('Wall of Stone', 'A nonmagical wall of solid stone springs into existence at a point you choose within range. The wall is 6 inches thick and is composed of ten 10-foot-by-10-foot panels. Each panel must be contiguous with at least one other panel. Alternatively, you can create 10-foot-by-20-foot panels that are only 3 inches thick.', '5', 'CLASS:Sorcerer'),


('Chain Lightning', 'You create a bolt of lightning that arcs toward a target of your choice that you can see within range. Three bolts then leap from that target to as many as three other targets, each of which must be within 30 feet of the first target. A target can be a creature or an object and can be targeted by only one of the bolts. A target must make a Dexterity saving throw. The target takes 10d8 lightning damage on a failed save, or half as much damage on a successful one.', '6', 'CLASS:Sorcerer'),
('Circle of Death', 'A sphere of negative energy ripples out in a 60-foot-radius sphere from a point within range. Each creature in that area must make a Constitution saving throw. A target takes 8d6 necrotic damage on a failed save, or half as much damage on a successful one.', '6', 'CLASS:Sorcerer'),
('Disintegrate', 'A thin green ray springs from your pointing finger to a target that you can see within range. The target can be a creature, an object, or a creation of magical force, such as the wall created by wall of force. A creature targeted by this spell must make a Dexterity saving throw. On a failed save, the target takes 10d6 + 40 force damage. If this damage reduces the target to 0 hit points, it is disintegrated.', '6', 'CLASS:Sorcerer'),
('Eyebite', 'For the spell’s duration, your eyes become an inky void imbued with dread power. One creature of your choice within 60 feet of you that you can see must succeed on a Wisdom saving throw or be affected by one of the following effects of your choice for the duration. On each of your turns until the spell ends, you can use your action to target another creature but can’t target a creature again if it has succeeded on a saving throw against this casting of eyebite.', '6', 'CLASS:Sorcerer'),
('Globe of Invulnerability', 'An immobile, faintly shimmering barrier springs into existence in a 10-foot radius around you and remains for the duration.', '6', 'CLASS:Sorcerer'),
('Mass Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence up to twelve creatures of your choice that you can see within range and that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act automatically negates the effect of the spell.', '6', 'CLASS:Sorcerer'),
('Move Earth', 'Choose an area of terrain no larger than 40 feet on a side within range. You can reshape dirt, sand, or clay in the area in any manner you choose for the duration. You can raise or lower the area’s elevation, create or fill in a trench, erect or flatten a wall, or form a pillar. The extent of any such changes can’t exceed half the area’s largest dimension.', '6', 'CLASS:Sorcerer'),
('Sunbeam', 'A beam of brilliant light flashes out from your hand in a 5-foot-wide, 60-foot-long line. Each creature in the line must make a Constitution saving throw. On a failed save, a creature takes 6d8 radiant damage and is blinded until your next turn. On a successful save, it takes half as much damage and isn’t blinded by this spell. Undead and oozes have disadvantage on this saving throw.', '6', 'CLASS:Sorcerer'),
('True Seeing', 'This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', '6', 'CLASS:Sorcerer'),
('Chain Lightning', 'You create a bolt of lightning that arcs toward a target of your choice that you can see within range. Three bolts then leap from that target to as many as three other targets, each of which must be within 30 feet of the first target. A target can be a creature or an object and can be targeted by only one of the bolts. A target must make a Dexterity saving throw. The target takes 10d8 lightning damage on a failed save, or half as much damage on a successful one.', '6', 'CLASS:Sorcerer'),
('Circle of Death', 'A sphere of negative energy ripples out in a 60-foot-radius sphere from a point within range. Each creature in that area must make a Constitution saving throw. A target takes 8d6 necrotic damage on a failed save, or half as much damage on a successful one.', '6', 'CLASS:Sorcerer'),
('Disintegrate', 'A thin green ray springs from your pointing finger to a target that you can see within range. The target can be a creature, an object, or a creation of magical force, such as the wall created by wall of force. A creature targeted by this spell must make a Dexterity saving throw. On a failed save, the target takes 10d6 + 40 force damage. If this damage reduces the target to 0 hit points, it is disintegrated.', '6', 'CLASS:Sorcerer'),
('Eyebite', 'For the spell’s duration, your eyes become an inky void imbued with dread power. One creature of your choice within 60 feet of you that you can see must succeed on a Wisdom saving throw or be affected by one of the following effects of your choice for the duration. On each of your turns until the spell ends, you can use your action to target another creature but can’t target a creature again if it has succeeded on a saving throw against this casting of eyebite.', '6', 'CLASS:Sorcerer'),
('Globe of Invulnerability', 'An immobile, faintly shimmering barrier springs into existence in a 10-foot radius around you and remains for the duration.', '6', 'CLASS:Sorcerer'),
('Mass Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence up to twelve creatures of your choice that you can see within range and that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act automatically negates the effect of the spell.', '6', 'CLASS:Sorcerer'),
('Move Earth', 'Choose an area of terrain no larger than 40 feet on a side within range. You can reshape dirt, sand, or clay in the area in any manner you choose for the duration. You can raise or lower the area’s elevation, create or fill in a trench, erect or flatten a wall, or form a pillar. The extent of any such changes can’t exceed half the area’s largest dimension.', '6', 'CLASS:Sorcerer'),
('Sunbeam', 'A beam of brilliant light flashes out from your hand in a 5-foot-wide, 60-foot-long line. Each creature in the line must make a Constitution saving throw. On a failed save, a creature takes 6d8 radiant damage and is blinded until your next turn. On a successful save, it takes half as much damage and isn’t blinded by this spell. Undead and oozes have disadvantage on this saving throw.', '6', 'CLASS:Sorcerer'),
('True Seeing', 'This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', '6', 'CLASS:Sorcerer'),


('Delayed Blast Fireball', 'A beam of yellow light flashes from your pointing finger, then condenses to linger at a chosen point within range as a glowing bead for the duration. When the spell ends, either because your concentration is broken or because you decide to end it, the bead blossoms with a low roar into an explosion of flame that spreads around corners.', '7', 'CLASS:Sorcerer'),
('Etherealness', 'You step into the border regions of the Ethereal Plane, in the area where it overlaps with your current plane. You remain in the Border Ethereal for the duration or until you use your action to dismiss the spell. During this time, you can move in any direction. If you move up or down, every foot of movement costs an extra foot. You can see and hear the plane you originated from, but everything there looks gray, and you can’t see anything more than 60 feet away. While on the Ethereal Plane, you can only affect and be affected by other creatures on that plane. Creatures that aren’t on the Ethereal Plane can’t perceive you and can’t interact with you, unless a special ability or magic has given them the ability to do so. You ignore all objects and effects that aren’t on the Ethereal Plane, allowing you to move through objects you perceive on the plane you originated from.', '7', 'CLASS:Sorcerer'),
('Finger of Death', 'You send negative energy coursing through a creature that you can see within range, causing it searing pain. The target must make a Constitution saving throw. It takes 7d8 + 30 necrotic damage on a failed save, or half as much damage on a successful one. A humanoid killed by this spell rises at the start of your next turn as a zombie that is permanently under your command, following your verbal orders to the best of its ability.', '7', 'CLASS:Sorcerer'),
('Fire Storm', 'A storm made up of sheets of roaring flame appears in a location you choose within range. The area of the storm consists of up to ten 10-­foot cubes, which you can arrange as you wish. Each cube must have at least one face adjacent to the face of another cube.', '7', 'CLASS:Sorcerer'),
('Plane Shift', 'You and up to eight willing creatures who link hands in a circle are transported to a different plane of existence. You can specify a target destination in general terms, such as the City of Brass on the Elemental Plane of Fire or the palace of Dispater on the second level of the Nine Hells, and you appear in or near that destination. If you are trying to reach the City of Brass, for example, you might arrive in its Street of Steel, before its Gate of Ashes, or looking at the city from across the Sea of Fire, at the GM’s discretion. Alternatively, if you know the sigil sequence of a teleportation circle on another plane of existence, this spell can take you to that circle. If the teleportation circle is too small to hold all the creatures you transported, they appear in the closest unoccupied spaces next to the circle.', '7', 'CLASS:Sorcerer'),
('Prismatic Spray', 'Eight multicolored rays of light flash from your hand. Each ray is a different color and has a different power and purpose. Each creature in a 60-foot cone must make a Dexterity saving throw. For each target, roll a d8 to determine which color ray affects it.', '7', 'CLASS:Sorcerer'),
('Reverse Gravity', 'This spell reverses gravity in a 50-foot-radius, 100-foot high cylinder centered on a point within range. All creatures and objects that aren’t somehow anchored to the ground in the area fall upward and reach the top of the area when you cast this spell. A creature can make a Dexterity saving throw to grab onto a fixed object it can reach, thus avoiding the fall.', '7', 'CLASS:Sorcerer'),
('Teleport', 'This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can’t be held or carried by an unwilling creature. The destination you choose must be known to you, and it must be on the same plane of existence as you. Your familiarity with the destination determines whether you arrive there successfully. The GM rolls d100 and consults the table.', '7', 'CLASS:Sorcerer'),


('Dominate Monster', 'You attempt to beguile a creature that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw. While the creature is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as “Attack that creature,” “Run over there,” or “Fetch that object.” If the creature completes the order and doesn’t receive further direction from you, it defends and preserves itself to the best of its ability.', '8', 'CLASS:Sorcerer'),
('Earthquake', 'You create a seismic disturbance at a point on the ground that you can see within range. For the duration, an intense tremor rips through the ground in a 100‑foot‑radius circle centered on that point and shakes creatures and structures in contact with the ground in that area.', '8', 'CLASS:Sorcerer'),
('Incendiary Cloud', 'A swirling cloud of smoke shot through with white-hot embers appears in a 20-foot-radius sphere centered on a point within range. The cloud spreads around corners and is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.', '8', 'CLASS:Sorcerer'),
('Power Word Stun', 'You speak a word of power that can overwhelm the mind of one creature you can see within range, leaving it dumbfounded. If the target has 150 hit points or fewer, it is stunned. Otherwise, the spell has no effect. The stunned target must make a Constitution saving throw at the end of each of its turns. On a successful save, this stunning effect ends.', '8', 'CLASS:Sorcerer'),
('Sunburst', 'Brilliant sunlight flashes in a 60-foot radius centered on a point you choose within range. Each creature in that light must make a Constitution saving throw. On a failed save, a creature takes 12d6 radiant damage and is blinded for 1 minute. On a successful save, it takes half as much damage and isn’t blinded by this spell.', '8', 'CLASS:Sorcerer'),


('Gate', 'You conjure a portal linking an unoccupied space you can see within range to a precise location on a different plane of existence. The portal is a circular opening, which you can make 5 to 20 feet in diameter. You can orient the portal in any direction you choose. The portal lasts for the duration. The portal has a front and a back on each plane where it appears. Travel through the portal is possible only by moving through its front. Anything that does so is instantly transported to the other plane, appearing in the unoccupied space nearest to the portal.', '9', 'CLASS:Sorcerer'),
('Meteor Swarm', 'Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.', '9', 'CLASS:Sorcerer'),
('Power Word Kill', 'You utter a word of power that can compel one creature you can see within range to die instantly. If the creature you choose has 100 hit points or fewer, it dies. Otherwise, the spell has no effect.', '9', 'CLASS:Sorcerer'),
('Time Stop', 'You briefly stop the flow of time for everyone but yourself. No time passes for other creatures, while you take 1d4 + 1 turns in a row, during which you can use actions and move as normal.', '9', 'CLASS:Sorcerer'),
('Wish', 'Wish is the mightiest spell a mortal creature can cast. By simply speaking aloud, you can alter the very foundations of reality in accord with your desires. The basic use of this spell is to duplicate any other spell of 8th level or lower. You don’t need to meet any requirements in that spell, including costly components. The spell simply takes effect.', '9', 'CLASS:Sorcerer'),


('Chill Touch', 'You create a ghostly, skeletal hand in the space of a creature within range. Make a ranged spell attack against the creature to assail it with the chill of the grave. On a hit, the target takes 1d8 necrotic damage, and it can’t regain hit points until the start of your next turn. Until then, the hand clings to the target.', '0', 'CLASS:Warlock'),
('Eldritch Blast', 'A beam of crackling energy streaks toward a creature within range. Make a ranged spell attack against the target. On a hit, the target takes 1d10 force damage. The spell creates more than one beam when you reach higher levels: two beams at 5th level, three beams at 11th level, and four beams at 17th level. You can direct the beams at the same target or at different ones. Make a separate attack roll for each beam. ', '0', 'CLASS:Warlock'),
('Mage Hand', 'A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again. You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.', '0', 'CLASS:Warlock'),
('Minor Illusion', 'You create a sound or an image of an object within range that lasts for the duration. The illusion also ends if you dismiss it as an action or cast this spell again. If you create a sound, its volume can range from a whisper to a scream. It can be your voice, someone else’s voice, a lion’s roar, a beating of drums, or any other sound you choose. The sound continues unabated throughout the duration, or you can make discrete sounds at different times before the spell ends. If you create an image of an object—such as a chair, muddy footprints, or a small chest—it must be no larger than a 5-foot cube. The image can’t create sound, light, smell, or any other sensory effect. Physical interaction with the image reveals it to be an illusion, because things can pass through it.', '0', 'CLASS:Warlock'),
('Poison Spray', 'You extend your hand toward a creature you can see within range and project a puff of noxious gas from your palm. The creature must succeed on a Constitution saving throw or take 1d12 poison damage.', '0', 'CLASS:Warlock'),
('Prestidigitation', 'This spell is a minor magical trick that novice spellcasters use for practice. You create one of the following magical effects within range:
  You create an instantaneous, harmless sensory effect, such as a shower of sparks, a puff of wind, faint musical notes, or an odd odor.
  You instantaneously light or snuff out a candle, a torch, or a small campfire.
  You instantaneously clean or soil an object no larger than 1 cubic foot.
  You chill, warm, or flavor up to 1 cubic foot of nonliving material for 1 hour.
  You make a color, a small mark, or a symbol appear on an object or a surface for 1 hour.
  You create a nonmagical trinket or an illusory image that can fit in your hand and that lasts until the end of your next turn.', '0', 'CLASS:Warlock'),
('True Strike', 'You extend your hand and point a finger at a target in range. Your magic grants you a brief insight into the target’s defenses. On your next turn, you gain advantage on your first attack roll against the target, provided that this spell hasn’t ended.', '0', 'CLASS:Warlock'),


('Charm Person', 'You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.', '1', 'CLASS:Warlock'),
('Comprehend Languages', 'For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text. This spell doesn’t decode secret messages in a text or a glyph, such as an arcane sigil, that isn’t part of a written language.', '1', 'CLASS:Warlock'),
('Expeditious Retreat', 'This spell allows you to move at an incredible pace. When you cast this spell, and then as a bonus action on each of your turns until the spell ends, you can take the Dash action.', '1', 'CLASS:Warlock'),
('Hellish Rebuke', 'You point your finger, and the creature that damaged you is momentarily surrounded by hellish flames. The creature must make a Dexterity saving throw. It takes 2d10 fire damage on a failed save, or half as much damage on a successful one.', '1', 'CLASS:Warlock'),
('Illusory Script', 'You write on parchment, paper, or some other suitable writing material and imbue it with a potent illusion that lasts for the duration. To you and any creatures you designate when you cast the spell, the writing appears normal, written in your hand, and conveys whatever meaning you intended when you wrote the text. To all others, the writing appears as if it were written in an unknown or magical script that is unintelligible. Alternatively, you can cause the writing to appear to be an entirely different message, written in a different hand and language, though the language must be one you know. Should the spell be dispelled, the original script and the illusion both disappear.', '1', 'CLASS:Warlock'),
('Protection from Evil and Good', 'Until the spell ends, one willing creature you touch is protected against certain types of creatures: aberrations, celestials, elementals, fey, fiends, and undead. The protection grants several benefits. Creatures of those types have disadvantage on attack rolls against the target. The target also can’t be charmed, frightened, or possessed by them. If the target is already charmed, frightened, or possessed by such a creature, the target has advantage on any new saving throw against the relevant effect.', '1', 'CLASS:Warlock'),
('Unseen Servant', 'This spell creates an invisible, mindless, shapeless force that performs simple tasks at your command until the spell ends. The servant springs into existence in an unoccupied space on the ground within range. It has AC 10, 1 hit point, and a Strength of 2, and it can’t attack. If it drops to 0 hit points, the spell ends. Once on each of your turns as a bonus action, you can mentally command the servant to move up to 15 feet and interact with an object. The servant can perform simple tasks that a human servant could do, such as fetching things, cleaning, mending, folding clothes, lighting fires, serving food, and pouring wine. Once you give the command, the servant performs the task to the best of its ability until it completes the task, then waits for your next command.', '1', 'CLASS:Warlock'),


('Darkness', 'Magical darkness spreads from a point you choose within range to fill a 15-foot-radius sphere for the duration. The darkness spreads around corners. A creature with darkvision can’t see through this darkness, and nonmagical light can’t illuminate it.', '2', 'CLASS:Warlock'),
('Enthrall', 'You weave a distracting string of words, causing creatures of your choice that you can see within range and that can hear you to make a Wisdom saving throw.', '2', 'CLASS:Warlock'),
('Hold Person', 'Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '2', 'CLASS:Warlock'),
('Invisibility', 'A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person. The spell ends for a target that attacks or casts a spell.', '2', 'CLASS:Warlock'),
('Mirror Image', 'Three illusory duplicates of yourself appear in your space. Until the spell ends, the duplicates move with you and mimic your actions, shifting position so it’s impossible to track which image is real. You can use your action to dismiss the illusory duplicates. Each time a creature targets you with an attack during the spell’s duration, roll a d20 to determine whether the attack instead targets one of your duplicates. If you have three duplicates, you must roll a 6 or higher to change the attack’s target to a duplicate. With two duplicates, you must roll an 8 or higher. With one duplicate, you must roll an 11 or higher.', '2', 'CLASS:Warlock'),
('Misty Step', 'Briefly surrounded by silvery mist, you teleport up to 30 feet to an unoccupied space that you can see.', '2', 'CLASS:Warlock'),
('Ray of Enfeeblement', 'A black beam of enervating energy springs from your finger toward a creature within range. Make a ranged spell attack against the target. On a hit, the target deals only half damage with weapon attacks that use Strength until the spell ends. At the end of each of the target’s turns, it can make a Constitution saving throw against the spell. On a success, the spell ends.', '2', 'CLASS:Warlock'),
('See Invisibility', 'For the duration, you see invisible creatures and objects as if they were visible, and you can see into the Ethereal Plane. Ethereal creatures and objects appear ghostly and translucent.', '2', 'CLASS:Warlock'),
('Shatter', 'A sudden loud ringing noise, painfully intense, erupts from a point of your choice within range. Each creature in a 10-foot-radius sphere centered on that point must make a Constitution saving throw. A creature takes 3d8 thunder damage on a failed save, or half as much damage on a successful one. A creature made of inorganic material such as stone, crystal, or metal has disadvantage on this saving throw. A nonmagical object that isn’t being worn or carried also takes the damage if it’s in the spell’s area.', '2', 'CLASS:Warlock'),
('Spider Climb', 'Until the spell ends, one willing creature you touch gains the ability to move up, down, and across vertical surfaces and upside down along ceilings, while leaving its hands free. The target also gains a climbing speed equal to its walking speed.', '2', 'CLASS:Warlock'),
('Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence a creature you can see within range that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act ends the spell. The target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.', '2', 'CLASS:Warlock'),


('Counterspell', 'You attempt to interrupt a creature in the process of casting a spell. If the creature is casting a spell of 3rd level or lower, its spell fails and has no effect. If it is casting a spell of 4th level or higher, make an ability check using your spellcasting ability. The DC equals 10 + the spells level. On a success, the creatures spell fails and has no effect.', '3', 'CLASS:Warlock'),
('Dispel Magic', 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.', '3', 'CLASS:Warlock'),
('Fear', 'You project a phantasmal image of a creature’s worst fears. Each creature in a 30-foot cone must succeed on a Wisdom saving throw or drop whatever it is holding and become frightened for the duration.', '3', 'CLASS:Warlock'),
('Fly', 'You touch a willing creature. The target gains a flying speed of 60 feet for the duration. When the spell ends, the target falls if it is still aloft, unless it can stop the fall.', '3', 'CLASS:Warlock'),
('Gaseous Form', 'You transform a willing creature you touch, along with everything it’s wearing and carrying, into a misty cloud for the duration. The spell ends if the creature drops to 0 hit points. An incorporeal creature isn’t affected. While in this form, the target’s only method of movement is a flying speed of 10 feet. The target can enter and occupy the space of another creature. The target has resistance to nonmagical damage, and it has advantage on Strength, Dexterity, and Constitution saving throws. The target can pass through small holes, narrow openings, and even mere cracks, though it treats liquids as though they were solid surfaces. The target can’t fall and remains hovering in the air even when stunned or otherwise incapacitated.', '3', 'CLASS:Warlock'),
('Hypnotic Pattern', 'You create a twisting pattern of colors that weaves through the air inside a 30-­‐‑foot cube within range. The pattern appears for a moment and vanishes. Each creature in the area who sees the pattern must make a Wisdom saving throw. On a failed save, the creature becomes charmed for the duration. While charmed by this spell, the creature is incapacitated and has a speed of 0.', '3', 'CLASS:Warlock'),
('Magic Circle', 'You create a 10-foot-radius, 20-foot-tall cylinder of magical energy centered on a point on the ground that you can see within range. Glowing runes appear wherever the cylinder intersects with the floor or other surface. Choose one or more of the following types of creatures: celestials, elementals, fey, fiends, or undead. The circle affects a creature of the chosen type in the following ways:
  The creature can’t willingly enter the cylinder by nonmagical means. If the creature tries to use teleportation or interplanar travel to do so, it must first succeed on a Charisma saving throw.
  The creature has disadvantage on attack rolls against targets within the cylinder.
  Targets within the cylinder can’t be charmed, frightened, or possessed by the creature.', '3', 'CLASS:Warlock'),
('Major Image', 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 20-­‐‑foot cube. The image appears at a spot that you can see within range and lasts for the duration. It seems completely real, including sounds, smells, and temperature appropriate to the thing depicted. You can’t create sufficient heat or cold to cause damage, a sound loud enough to deal thunder damage or deafen a creature, or a smell that might sicken a creature (like a troglodyte’s stench).', '3', 'CLASS:Warlock'),
('Remove Curse', 'At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its owner’s attunement to the object so it can be removed or discarded.', '3', 'CLASS:Warlock'),
('Tongues', 'This spell grants the creature you touch the ability to understand any spoken language it hears. Moreover, when the target speaks, any creature that knows at least one language and can hear the target understands what it says.', '3', 'CLASS:Warlock'),
('Vampiric Touch', 'The touch of your shadow-wreathed hand can siphon life force from others to heal your wounds. Make a melee spell attack against a creature within your reach. On a hit, the target takes 3d6 necrotic damage, and you regain hit points equal to half the amount of necrotic damage dealt. Until the spell ends, you can make the attack again on each of your turns as an action.', '3', 'CLASS:Warlock'),


('Banishment', 'You attempt to send one creature that you can see within range to another plane of existence. The target must succeed on a Charisma saving throw or be banished. If the target is native to the plane of existence you’re on, you banish the target to a harmless demiplane. While there, the target is incapacitated. The target remains there until the spell ends, at which point the target reappears in the space it left or in the nearest unoccupied space if that space is occupied.', '4', 'CLASS:Warlock'),
('Blight', 'Necromantic energy washes over a creature of your choice that you can see within range, draining moisture and vitality from it. The target must make a Constitution saving throw. The target takes 8d8 necrotic damage on a failed save, or half as much damage on a successful one. This spell has no effect on undead or constructs. If you target a plant creature or a magical plant, it makes the saving throw with disadvantage, and the spell deals maximum damage to it. If you target a nonmagical plant that isn’t a creature, such as a tree or shrub, it doesn’t make a saving throw; it simply withers and dies.', '4', 'CLASS:Warlock'),
('Dimension Door', 'You teleport yourself from your current location to any other spot within range. You arrive at exactly the spot desired. It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction, such as “200 feet straight downward” or “upward to the northwest at a 45-degree angle, 300 feet.” You can bring along objects as long as their weight doesn’t exceed what you can carry.', '4', 'CLASS:Warlock'),
('Hallucinatory Terrain', 'You make natural terrain in a 150-made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Manufactured structures, equipment, and creatures within the area aren’t changed in appearance.', '4', 'CLASS:Warlock'),


('Contact Other Plane', 'You mentally contact a demigod, the spirit of a long-dead sage, or some other mysterious entity from another plane. Contacting this extraplanar intelligence can strain or even break your mind. When you cast this spell, make a DC 15 Intelligence saving throw. On a failure, you take 6d6 psychic damage and are insane until you finish a long rest. While insane, you can’t take actions, can’t understand what other creatures say, can’t read, and speak only in gibberish. A greater restoration spell cast on you ends this effect.', '5', 'CLASS:Warlock'),
('Dream', 'This spell shapes a creature’s dreams. Choose a creature known to you as the target of this spell. The target must be on the same plane of existence as you. Creatures that don’t sleep, such as elves, can’t be contacted by this spell. You, or a willing creature you touch, enters a trance state, acting as a messenger. While in the trance, the messenger is aware of his or her surroundings, but can’t take actions or move.', '5', 'CLASS:Warlock'),
('Hold Monster', 'Choose a creature that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. This spell has no effect on undead. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '5', 'CLASS:Warlock'),
('Scrying', 'You can see and hear a particular creature you choose that is on the same plane of existence as you. The target must make a Wisdom saving throw, which is modified by how well you know the target and the sort of physical connection you have to it. If a target knows you’re casting this spell, it can fail the saving throw voluntarily if it wants to be observed.', '5', 'CLASS:Warlock'),


('Circle of Death', 'A sphere of negative energy ripples out in a 60-foot-radius sphere from a point within range. Each creature in that area must make a Constitution saving throw. A target takes 8d6 necrotic damage on a failed save, or half as much damage on a successful one.', '6', 'CLASS:Warlock'),
('Conjure Fey', 'You summon a fey creature of challenge rating 6 or lower, or a fey spirit that takes the form of a beast of challenge rating 6 or lower. It appears in an unoccupied space that you can see within range. The fey creature disappears when it drops to 0 hit points or when the spell ends. The fey creature is friendly to you and your companions for the duration. Roll initiative for the creature, which has its own turns. It obeys any verbal commands that you issue to it (no action required by you), as long as they don’t violate its alignment. If you don’t issue any commands to the fey creature, it defends itself from hostile creatures but otherwise takes no actions.', '6', 'CLASS:Warlock'),
('Create Undead', 'You can cast this spell only at night. Choose up to three corpses of Medium or Small humanoids within range. Each corpse becomes a ghoul under your control. (The GM has game statistics for these creatures.)', '6', 'CLASS:Warlock'),
('Eyebite', 'For the spell’s duration, your eyes become an inky void imbued with dread power. One creature of your choice within 60 feet of you that you can see must succeed on a Wisdom saving throw or be affected by one of the following effects of your choice for the duration. On each of your turns until the spell ends, you can use your action to target another creature but can’t target a creature again if it has succeeded on a saving throw against this casting of eyebite.', '6', 'CLASS:Warlock'),
('Flesh to Stone', 'You attempt to turn one creature that you can see within range into stone. If the target’s body is made of flesh, the creature must make a Constitution saving throw. On a failed save, it is restrained as its flesh begins to harden. On a successful save, the creature isn’t affected. A creature restrained by this spell must make another Constitution saving throw at the end of each of its turns. If it successfully saves against this spell three times, the spell ends. If it fails its saves three times, it is turned to stone and subjected to the petrified condition for the duration. The successes and failures don’t need to be consecutive; keep track of both until the target collects three of a kind.', '6', 'CLASS:Warlock'),
('Mass Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence up to twelve creatures of your choice that you can see within range and that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act automatically negates the effect of the spell.', '6', 'CLASS:Warlock'),
('True Seeing', 'This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', '6', 'CLASS:Warlock'),


('Etherealness', 'You step into the border regions of the Ethereal Plane, in the area where it overlaps with your current plane. You remain in the Border Ethereal for the duration or until you use your action to dismiss the spell. During this time, you can move in any direction. If you move up or down, every foot of movement costs an extra foot. You can see and hear the plane you originated from, but everything there looks gray, and you can’t see anything more than 60 feet away. While on the Ethereal Plane, you can only affect and be affected by other creatures on that plane. Creatures that aren’t on the Ethereal Plane can’t perceive you and can’t interact with you, unless a special ability or magic has given them the ability to do so. You ignore all objects and effects that aren’t on the Ethereal Plane, allowing you to move through objects you perceive on the plane you originated from.', '7', 'CLASS:Warlock'),
('Finger of Death', 'You send negative energy coursing through a creature that you can see within range, causing it searing pain. The target must make a Constitution saving throw. It takes 7d8 + 30 necrotic damage on a failed save, or half as much damage on a successful one. A humanoid killed by this spell rises at the start of your next turn as a zombie that is permanently under your command, following your verbal orders to the best of its ability.', '7', 'CLASS:Warlock'),
('Forcecage', 'An immobile, invisible, cube-shaped prison composed of magical force springs into existence around an area you choose within range. The prison can be a cage or a solid box, as you choose. A prison in the shape of a cage can be up to 20 feet on a side and is made from 1/2-inch diameter bars spaced 1/2 inch apart. A prison in the shape of a box can be up to 10 feet on a side, creating a solid barrier that prevents any matter from passing through it and blocking any spells cast into or out from the area.', '7', 'CLASS:Warlock'),
('Plane Shift', 'You and up to eight willing creatures who link hands in a circle are transported to a different plane of existence. You can specify a target destination in general terms, such as the City of Brass on the Elemental Plane of Fire or the palace of Dispater on the second level of the Nine Hells, and you appear in or near that destination. If you are trying to reach the City of Brass, for example, you might arrive in its Street of Steel, before its Gate of Ashes, or looking at the city from across the Sea of Fire, at the GM’s discretion. Alternatively, if you know the sigil sequence of a teleportation circle on another plane of existence, this spell can take you to that circle. If the teleportation circle is too small to hold all the creatures you transported, they appear in the closest unoccupied spaces next to the circle.', '7', 'CLASS:Warlock'),


('Demiplane', 'You create a shadowy door on a flat solid surface that you can see within range. The door is large enough to allow Medium creatures to pass through unhindered. When opened, the door leads to a demiplane that appears to be an empty room 30 feet in each dimension, made of wood or stone. When the spell ends, the door disappears, and any creatures or objects inside the demiplane remain trapped there, as the door also disappears from the other side. Each time you cast this spell, you can create a new demiplane, or have the shadowy door connect to a demiplane you created with a previous casting of this spell. Additionally, if you know the nature and contents of a demiplane created by a casting of this spell by another creature, you can have the shadowy door connect to its demiplane instead.', '8', 'CLASS:Warlock'),
('Dominate Monster', 'You attempt to beguile a creature that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw. While the creature is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as “Attack that creature,” “Run over there,” or “Fetch that object.” If the creature completes the order and doesn’t receive further direction from you, it defends and preserves itself to the best of its ability.', '8', 'CLASS:Warlock'),
('Feeblemind', 'You blast the mind of a creature that you can see within range, attempting to shatter its intellect and personality. The target takes 4d6 psychic damage and must make an Intelligence saving throw. On a failed save, the creature’s Intelligence and Charisma scores become 1. The creature can’t cast spells, activate magic items, understand language, or communicate in any intelligible way. The creature can, however, identify its friends, follow them, and even protect them. At the end of every 30 days, the creature can repeat its saving throw against this spell. If it succeeds on its saving throw, the spell ends. The spell can also be ended by greater restoration, heal, or wish.', '8', 'CLASS:Warlock'),
('Glibness', 'Until the spell ends, when you make a Charisma check, you can replace the number you roll with a 15. Additionally, no matter what you say, magic that would determine if you are telling the truth indicates that you are being truthful.', '8', 'CLASS:Warlock'),
('Power Word Stun', 'You speak a word of power that can overwhelm the mind of one creature you can see within range, leaving it dumbfounded. If the target has 150 hit points or fewer, it is stunned. Otherwise, the spell has no effect. The stunned target must make a Constitution saving throw at the end of each of its turns. On a successful save, this stunning effect ends.', '8', 'CLASS:Warlock'),


('Astral Projection', 'You and up to eight willing creatures within range project your astral bodies into the Astral Plane (the spell fails and the casting is wasted if you are already on that plane). The material body you leave behind is unconscious and in a state of suspended animation; it doesn’t need food or air and doesn’t age. Your astral body resembles your mortal form in almost every way, replicating your game statistics and possessions. The principal difference is the addition of a silvery cord that extends from between your shoulder blades and trails behind you, fading to invisibility after 1 foot. This cord is your tether to your material body. As long as the tether remains intact, you can find your way home. If the cord is cut—something that can happen only when an effect specifically states that it does—your soul and body are separated, killing you instantly.', '9', 'CLASS:Warlock'),
('Foresight', 'You touch a willing creature and bestow a limited ability to see into the immediate future. For the duration, the target can’t be surprised and has advantage on attack rolls, ability checks, and saving throws. Additionally, other creatures have disadvantage on attack rolls against the target for the duration. This spell immediately ends if you cast it again before its duration ends.
', '9', 'CLASS:Warlock'),
('Imprisonment', 'You create a magical restraint to hold a creature that you can see within range. The target must succeed on a Wisdom saving throw or be bound by the spell; if it succeeds, it is immune to this spell if you cast it again. While affected by this spell, the creature doesn’t need to breathe, eat, or drink, and it doesn’t age. Divination spells can’t locate or perceive the target.', '9', 'CLASS:Warlock'),
('Power Word Kill', 'You utter a word of power that can compel one creature you can see within range to die instantly. If the creature you choose has 100 hit points or fewer, it dies. Otherwise, the spell has no effect.', '9', 'CLASS:Warlock'),
('True Polymorph', 'Choose one creature or nonmagical object that you can see within range. You transform the creature into a different creature, the creature into an object, or the object into a creature (the object must be neither worn nor carried by another creature). The transformation lasts for the duration, or until the target drops to 0 hit points or dies. If you concentrate on this spell for the full duration, the transformation lasts until it is dispelled. This spell has no effect on a shapechanger or a creature with 0 hit points. An unwilling creature can make a Wisdom saving throw, and if it succeeds, it isn’t affected by this spell.', '9', 'CLASS:Warlock'),



('Acid Splash', 'You hurl a bubble of acid. Choose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succeed on a Dexterity saving throw or take 1d6 acid damage.', '0', 'CLASS:Wizard'),
('Chill Touch', 'You create a ghostly, skeletal hand in the space of a creature within range. Make a ranged spell attack against the creature to assail it with the chill of the grave. On a hit, the target takes 1d8 necrotic damage, and it can’t regain hit points until the start of your next turn. Until then, the hand clings to the target.', '0', 'CLASS:Wizard'),
('Dancing Lights', 'You create up to four torch‑sized lights within range, making them appear as torches, lanterns, or glowing orbs that hover in the air for the duration. You can also combine the four lights into one glowing vaguely humanoid form of Medium size. Whichever form you choose, each light sheds dim light in a 10-foot radius.', '0', 'CLASS:Wizard'),
('Fire Bolt', 'You hurl a mote of fire at a creature or object within range. Make a ranged spell attack against the target. On a hit, the target takes 1d10 fire damage. A flammable object hit by this spell ignites if it isnt being worn or carried.', '0', 'CLASS:Wizard'),
('Light', 'You touch one object that is no larger than 10 feet in any dimension. Until the spell ends, the object sheds bright light in a 20-foot radius and dim light for an additional 20 feet. The light can be colored as you like. ', '0', 'CLASS:Wizard'),
('Mage Hand', 'A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again. You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.', '0', 'CLASS:Wizard'),
('Mending', 'This spell repairs a single break or tear in an object you touch, such as a broken chain link, two halves of a broken key, a torn cloak, or a leaking wineskin. As long as the break or tear is no larger than 1 foot in any dimension, you mend it, leaving no trace of the former damage.', '0', 'CLASS:Wizard'),
('Message', 'You point your finger toward a creature within range and whisper a message. The target (and only the target) hears the message and can reply in a whisper that only you can hear.', '0', 'CLASS:Wizard'),
('Minor Illusion', 'You create a sound or an image of an object within range that lasts for the duration. The illusion also ends if you dismiss it as an action or cast this spell again. If you create a sound, its volume can range from a whisper to a scream. It can be your voice, someone else’s voice, a lion’s roar, a beating of drums, or any other sound you choose. The sound continues unabated throughout the duration, or you can make discrete sounds at different times before the spell ends. If you create an image of an object—such as a chair, muddy footprints, or a small chest—it must be no larger than a 5-foot cube. The image can’t create sound, light, smell, or any other sensory effect. Physical interaction with the image reveals it to be an illusion, because things can pass through it.', '0', 'CLASS:Wizard'),
('Poison Spray', 'You extend your hand toward a creature you can see within range and project a puff of noxious gas from your palm. The creature must succeed on a Constitution saving throw or take 1d12 poison damage.', '0', 'CLASS:Wizard'),
('Prestidigitation', 'This spell is a minor magical trick that novice spellcasters use for practice. You create one of the following magical effects within range:
  You create an instantaneous, harmless sensory effect, such as a shower of sparks, a puff of wind, faint musical notes, or an odd odor.
  You instantaneously light or snuff out a candle, a torch, or a small campfire.
  You instantaneously clean or soil an object no larger than 1 cubic foot.
  You chill, warm, or flavor up to 1 cubic foot of nonliving material for 1 hour.
  You make a color, a small mark, or a symbol appear on an object or a surface for 1 hour.
  You create a nonmagical trinket or an illusory image that can fit in your hand and that lasts until the end of your next turn.', '0', 'CLASS:Wizard'),
('Ray of Frost', 'A frigid beam of blue-white light streaks toward a creature within range. Make a ranged spell attack against the target. On a hit, it takes 1d8 cold damage, and its speed is reduced by 10 feet until the start of your next turn.', '0', 'CLASS:Wizard'),
('Shocking Grasp', 'Lightning springs from your hand to deliver a shock to a creature you try to touch. Make a melee spell attack against the target. You have advantage on the attack roll if the target is wearing armor made of metal. On a hit, the target takes 1d8 lightning damage, and it can’t take reactions until the start of its next turn.', '0', 'CLASS:Wizard'),
('True Strike', 'You extend your hand and point a finger at a target in range. Your magic grants you a brief insight into the target’s defenses. On your next turn, you gain advantage on your first attack roll against the target, provided that this spell hasn’t ended.', '0', 'CLASS:Wizard'),


('Alarm', 'You set an alarm against unwanted intrusion. Choose a door, a window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area.', '1', 'CLASS:Wizard'),
('Burning Hands', 'As you hold your hands with thumbs touching and fingers spread, a thin sheet of flames shoots forth from your outstretched fingertips. Each creature in a 15-foot cone must make a Dexterity saving throw. A creature takes 3d6 fire damage on a failed save, or half as much damage on a successful one. The fire ignites any flammable objects in the area that aren’t being worn or carried.', '1', 'CLASS:Wizard'),
('Charm Person', 'You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.', '1', 'CLASS:Wizard'),
('Color Spray', 'A dazzling array of flashing, colored light springs from your hand. Roll 6d10; the total is how many hit points of creatures this spell can effect. Creatures in a 15-foot cone originating from you are affected in ascending order of their current hit points (ignoring unconscious creatures and creatures that can’t see).', '1', 'CLASS:Wizard'),
('Comprehend Languages', 'For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text. This spell doesn’t decode secret messages in a text or a glyph, such as an arcane sigil, that isn’t part of a written language.', '1', 'CLASS:Wizard'),
('Detect Magic', 'For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.', '1', 'CLASS:Wizard'),
('Disguise Self', 'You make yourself—including your clothing, armor, weapons, and other belongings on your person—look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can’t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you.', '1', 'CLASS:Wizard'),
('Expeditious Retreat', 'This spell allows you to move at an incredible pace. When you cast this spell, and then as a bonus action on each of your turns until the spell ends, you can take the Dash action.', '1', 'CLASS:Wizard'),
('False Life', 'Bolstering yourself with a necromantic facsimile of life, you gain 1d4 + 4 temporary hit points for the duration.This spell allows you to move at an incredible pace. When you cast this spell, and then as a bonus action on each of your turns until the spell ends, you can take the Dash action.', '1', 'CLASS:Wizard'),
('Feather Fall', 'Choose up to five falling creatures within range. A falling creature’s rate of descent slows to 60 feet per round until the spell ends. If the creature lands before the spell ends, it takes no falling damage and can land on its feet, and the spell ends for that creature.', '1', 'CLASS:Wizard'),
('Find Familiar', 'You gain the service of a familiar, a spirit that takes an animal form you choose: bat, cat, crab, frog (toad), hawk, lizard, octopus, owl, poisonous snake, fish (quipper), rat, raven, sea horse, spider, or weasel. Appearing in an unoccupied space within range, the familiar has the statistics of the chosen form, though it is a celestial, fey, or fiend (your choice) instead of a beast. Your familiar acts independently of you, but it always obeys your commands. While your familiar is within 100 feet of you, you can communicate with it telepathically. ', '1', 'CLASS:Wizard'),
('Floating Disk', 'This spell creates a circular, horizontal plane of force, 3 feet in diameter and 1 inch thick, that floats 3 feet above the ground in an unoccupied space of your choice that you can see within range. The disk remains for the duration, and can hold up to 500 pounds. If more weight is placed on it, the spell ends, and everything on the disk falls to the ground.', '1', 'CLASS:Wizard'),
('Fog Cloud', 'You create a 20-foot-radius sphere of fog centered on a point within range. The sphere spreads around corners, and its area is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.', '1', 'CLASS:Wizard'),
('Grease', 'Slick grease covers the ground in a 10-foot square centered on a point within range and turns it into difficult terrain for the duration.', '1', 'CLASS:Wizard'),
('Hideous Laughter', 'A creature of your choice that you can see within range perceives everything as hilariously funny and falls into fits of laughter if this spell affects it.', '1', 'CLASS:Wizard'),
('Identify', 'You choose one object that you must touch throughout the casting of the spell. If it is a magic item or some other magic-imbued object, you learn its properties and how to use them, whether it requires attunement to use, and how many charges it has, if any. You learn whether any spells are affecting the item and what they are. If the item was created by a spell, you learn which spell created it.', '1', 'CLASS:Wizard'),
('Illusory Script', 'You write on parchment, paper, or some other suitable writing material and imbue it with a potent illusion that lasts for the duration.', '1', 'CLASS:Wizard'),
('Jump', 'You touch a creature. The creature’s jump distance is tripled until the spell ends.', '1', 'CLASS:Wizard'),
('Longstrider', 'You touch a creature. The target’s speed increases by 10 feet until the spell ends.', '1', 'CLASS:Wizard'),
('Mage Armor', 'You touch a willing creature who isn’t wearing armor, and a protective magical force surrounds it until the spell ends. The target’s base AC becomes 13 + its Dexterity modifier. The spell ends if the target dons armor or if you dismiss the spell as an action.', '1', 'CLASS:Wizard'),
('Magic Missile', 'You create three glowing darts of magical force. Each dart hits a creature of your choice that you can see within range. A dart deals 1d4 + 1 force damage to its target. The darts all strike simultaneously, and you can direct them to hit one creature or several.', '1', 'CLASS:Wizard'),
('Protection from Evil and Good', 'Until the spell ends, one willing creature you touch is protected against certain types of creatures: aberrations, celestials, elementals, fey, fiends, and undead. The protection grants several benefits. Creatures of those types have disadvantage on attack rolls against the target. The target also can’t be charmed, frightened, or possessed by them. If the target is already charmed, frightened, or possessed by such a creature, the target has advantage on any new saving throw against the relevant effect.', '1', 'CLASS:Wizard'),
('Shield', 'An invisible barrier of magical force appears and protects you. Until the start of your next turn, you have a +5 bonus to AC, including against the triggering attack, and you take no damage from magic missile.', '1', 'CLASS:Wizard'),
('Silent Image', 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 15-­foot cube. The image appears at a spot within range and lasts for the duration. The image is purely visual; it isn’t accompanied by sound, smell, or other sensory effects.', '1', 'CLASS:Wizard'),
('Sleep', 'This spell sends creatures into a magical slumber. Roll 5d8; the total is how many hit points of creatures this spell can affect. Creatures within 20 feet of a point you choose within range are affected in ascending order of their current hit points (ignoring unconscious creatures).', '1', 'CLASS:Wizard'),
('Thunderwave', 'A wave of thunderous force sweeps out from you. Each creature in a 15‑foot cube originating from you must make a Constitution saving throw. On a failed save, a creature takes 2d8 thunder damage and is pushed 10 feet away from you. On a successful save, the creature takes half as much damage and isn’t pushed', '1', 'CLASS:Wizard'),
('Unseen Servant', 'This spell creates an invisible, mindless, shapeless force that performs simple tasks at your command until the spell ends. The servant springs into existence in an unoccupied space on the ground within range. It has AC 10, 1 hit point, and a Strength of 2, and it can’t attack. If it drops to 0 hit points, the spell ends. Once on each of your turns as a bonus action, you can mentally command the servant to move up to 15 feet and interact with an object. The servant can perform simple tasks that a human servant could do, such as fetching things, cleaning, mending, folding clothes, lighting fires, serving food, and pouring wine. Once you give the command, the servant performs the task to the best of its ability until it completes the task, then waits for your next command.', '1', 'CLASS:Wizard'),


('Acid Arrow', 'A shimmering green arrow streaks toward a target within range and bursts in a spray of acid. Make a ranged spell attack against the target. On a hit, the target takes 4d4 acid damage immediately and 2d4 acid damage at the end of its next turn. On a miss, the arrow splashes the target with acid for half as much of the initial damage and no damage at the end of its next turn.', '2', 'CLASS:Wizard'),
('Alter Self', 'You assume a different form. When you cast the spell, choose one of the following options, the effects of which last for the duration of the spell. While the spell lasts, you can end one option as an action to gain the benefits of a different one.', '2', 'CLASS:Wizard'),
('Arcane Lock', 'You touch a closed door, window, gate, chest, or other entryway, and it becomes locked for the duration. You and the creatures you designate when you cast this spell can open the object normally. You can also set a password that, when spoken within 5 feet of the object, suppresses this spell for 1 minute. Otherwise, it is impassable until it is broken or the spell is dispelled or suppressed. Casting knock on the object suppresses arcane lock for 10 minutes.', '2', 'CLASS:Wizard'),
('Arcanists Magic Aura', 'You place an illusion on a creature or an object you touch so that divination spells reveal false information about it. The target can be a willing creature or an object that isn’t being carried or worn by another creature.', '2', 'CLASS:Wizard'),
('Blindness/Deafness', 'You can blind or deafen a foe. Choose one creature that you can see within range to make a Constitution saving throw. If it fails, the target is either blinded or deafened (your choice) for the duration. At the end of each of its turns, the target can make a Constitution saving throw. On a success, the spell ends.', '2', 'CLASS:Wizard'),
('Blur', 'Your body becomes blurred, shifting and wavering to all who can see you. For the duration, any creature has disadvantage on attack rolls against you. An attacker is immune to this effect if it doesn’t rely on sight, as with blindsight, or can see through illusions, as with truesight.', '2', 'CLASS:Wizard'),
('Continual Flame', 'A flame, equivalent in brightness to a torch, springs forth from an object that you touch. The effect looks like a regular flame, but it creates no heat and doesn’t use oxygen. A continual flame can be covered or hidden but not smothered or quenched.', '2', 'CLASS:Wizard'),
('Darkness', 'Magical darkness spreads from a point you choose within range to fill a 15-foot-radius sphere for the duration. The darkness spreads around corners. A creature with darkvision can’t see through this darkness, and nonmagical light can’t illuminate it.', '2', 'CLASS:Wizard'),
('Darkvision', 'You touch a willing creature to grant it the ability to see in the dark. For the duration, that creature has darkvision out to a range of 60 feet.', '2', 'CLASS:Wizard'),
('Detect Thoughts', 'For the duration, you can read the thoughts of certain creatures. When you cast the spell and as your action on each turn until the spell ends, you can focus your mind on any one creature that you can see within 30 feet of you. If the creature you choose has an Intelligence of 3 or lower or doesn’t speak any language, the creature is unaffected.', '2', 'CLASS:Wizard'),
('Enlarge/Reduce', 'You cause a creature or an object you can see within range to grow larger or smaller for the duration. Choose either a creature or an object that is neither worn nor carried. If the target is unwilling, it can make a Constitution saving throw. On a success, the spell has no effect. If the target is a creature, everything it is wearing and carrying changes size with it. Any item dropped by an affected creature returns to normal size at once.', '2', 'CLASS:Wizard'),
('Flaming Sphere', 'A 5-foot-diameter sphere of fire appears in an unoccupied space of your choice within range and lasts for the duration. Any creature that ends its turn within 5 feet of the sphere must make a Dexterity saving throw. The creature takes 2d6 fire damage on a failed save, or half as much damage on a successful one.', '2', 'CLASS:Wizard'),
('Gentle Repose', 'You touch a corpse or other remains. For the duration, the target is protected from decay and can’t become undead.', '2', 'CLASS:Wizard'),
('Gust of Wind', 'A line of strong wind 60 feet long and 10 feet wide blasts from you in a direction you choose for the spell’s duration. Each creature that starts its turn in the line must succeed on a Strength saving throw or be pushed 15 feet away from you in a direction following the line. Any creature in the line must spend 2 feet of movement for every 1 foot it moves when moving closer to you.', '2', 'CLASS:Wizard'),
('Hold Person', 'Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '2', 'CLASS:Wizard'),
('Invisibility', 'A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person. The spell ends for a target that attacks or casts a spell.', '2', 'CLASS:Wizard'),
('Knock', 'Choose an object that you can see within range. The object can be a door, a box, a chest, a set of manacles, a padlock, or another object that contains a mundane or magical means that prevents access. A target that is held shut by a mundane lock or that is stuck or barred becomes unlocked, unstuck, or unbarred. If the object has multiple locks, only one of them is unlocked. When you cast the spell, a loud knock, audible from as far away as 300 feet, emanates from the target object.', '2', 'CLASS:Wizard'),
('Levitate', 'One creature or object of your choice that you can see within range rises vertically, up to 20 feet, and remains suspended there for the duration. The spell can levitate a target that weighs up to 500 pounds. An unwilling creature that succeeds on a Constitution saving throw is unaffected.', '2', 'CLASS:Wizard'),
('Locate Object', 'Describe or name an object that is familiar to you. You sense the direction to the object’s location, as long as that object is within 1,000 feet of you. If the object is in motion, you know the direction of its movement. The spell can locate a specific object known to you, as long as you have seen it up close—within 30 feet—at least once. Alternatively, the spell can locate the nearest object of a particular kind, such as a certain kind of apparel, jewelry, furniture, tool, or weapon. This spell can’t locate an object if any thickness of lead, even a thin sheet, blocks a direct path between you and the object.', '2', 'CLASS:Wizard'),
('Magic Mouth', 'You implant a message within an object in range, a message that is uttered when a trigger condition is met. Choose an object that you can see and that isn’t being worn or carried by another creature. Then speak the message, which must be 25 words or less, though it can be delivered over as long as 10 minutes. Finally, determine the circumstance that will trigger the spell to deliver your message.', '2', 'CLASS:Wizard'),
('Magic Weapon', 'You touch a nonmagical weapon. Until the spell ends, that weapon becomes a magic weapon with a +1 bonus to attack rolls and damage rolls.', '2', 'CLASS:Wizard'),
('Mirror Image', 'Three illusory duplicates of yourself appear in your space. Until the spell ends, the duplicates move with you and mimic your actions, shifting position so it’s impossible to track which image is real. You can use your action to dismiss the illusory duplicates. Each time a creature targets you with an attack during the spell’s duration, roll a d20 to determine whether the attack instead targets one of your duplicates. If you have three duplicates, you must roll a 6 or higher to change the attack’s target to a duplicate. With two duplicates, you must roll an 8 or higher. With one duplicate, you must roll an 11 or higher.', '2', 'CLASS:Wizard'),
('Misty Step', 'Briefly surrounded by silvery mist, you teleport up to 30 feet to an unoccupied space that you can see.', '2', 'CLASS:Wizard'),
('Ray of Enfeeblement', 'A black beam of enervating energy springs from your finger toward a creature within range. Make a ranged spell attack against the target. On a hit, the target deals only half damage with weapon attacks that use Strength until the spell ends. At the end of each of the target’s turns, it can make a Constitution saving throw against the spell. On a success, the spell ends.', '2', 'CLASS:Wizard'),
('Rope Trick', 'You touch a length of rope that is up to 60 feet long. One end of the rope then rises into the air until the whole rope hangs perpendicular to the ground. At the upper end of the rope, an invisible entrance opens to an extradimensional space that lasts until the spell ends.', '2', 'CLASS:Wizard'),
('Scorching Ray', 'You create three rays of fire and hurl them at targets within range. You can hurl them at one target or several. Make a ranged spell attack for each ray. On a hit, the target takes 2d6 fire damage.', '2', 'CLASS:Wizard'),
('See Invisibility', 'For the duration, you see invisible creatures and objects as if they were visible, and you can see into the Ethereal Plane. Ethereal creatures and objects appear ghostly and translucent.', '2', 'CLASS:Wizard'),
('Shatter', 'A sudden loud ringing noise, painfully intense, erupts from a point of your choice within range. Each creature in a 10-foot-radius sphere centered on that point must make a Constitution saving throw. A creature takes 3d8 thunder damage on a failed save, or half as much damage on a successful one. A creature made of inorganic material such as stone, crystal, or metal has disadvantage on this saving throw. A nonmagical object that isn’t being worn or carried also takes the damage if it’s in the spell’s area.', '2', 'CLASS:Wizard'),
('Spider Climb', 'Until the spell ends, one willing creature you touch gains the ability to move up, down, and across vertical surfaces and upside down along ceilings, while leaving its hands free. The target also gains a climbing speed equal to its walking speed.', '2', 'CLASS:Wizard'),
('Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence a creature you can see within range that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act ends the spell. The target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.', '2', 'CLASS:Wizard'),
('Web', 'You conjure a mass of thick, sticky webbing at a point of your choice within range. The webs fill a 20-foot cube from that point for the duration. The webs are difficult terrain and lightly obscure their area.', '2', 'CLASS:Wizard'),


('Animate Dead', 'This spell creates an undead servant. Choose a pile of bones or a corpse of a Medium or Small humanoid within range. Your spell imbues the target with a foul mimicry of life, raising it as an undead creature. The target becomes a skeleton if you chose bones or a zombie if you chose a corpse (the GM has the creature’s game statistics).', '3', 'CLASS:Wizard'),
('Bestow Curse', 'You touch a creature, and that creature must succeed on a Wisdom saving throw or become cursed for the duration of the spell.', '3', 'CLASS:Wizard'),
('Blink', 'Roll a d20 at the end of each of your turns for the duration of the spell. On a roll of 11 or higher, you vanish from your current plane of existence and appear in the Ethereal Plane (the spell fails and the casting is wasted if you were already on that plane). At the start of your next turn, and when the spell ends if you are on the Ethereal Plane, you return to an unoccupied space of your choice that you can see within 10 feet of the space you vanished from. ', '3', 'CLASS:Wizard'),
('Clairvoyance', 'You create an invisible sensor within range in a location familiar to you (a place you have visited or seen before) or in an obvious location that is unfamiliar to you (such as behind a door, around a corner, or in a grove of trees). The sensor remains in place for the duration, and it can’t be attacked or otherwise interacted with.', '3', 'CLASS:Wizard'),
('Counterspell', 'You attempt to interrupt a creature in the process of casting a spell. If the creature is casting a spell of 3rd level or lower, its spell fails and has no effect. If it is casting a spell of 4th level or higher, make an ability check using your spellcasting ability. The DC equals 10 + the spells level. On a success, the creatures spell fails and has no effect.', '3', 'CLASS:Wizard'),
('Dispel Magic', 'Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.', '3', 'CLASS:Wizard'),
('Fear', 'You project a phantasmal image of a creature’s worst fears. Each creature in a 30-foot cone must succeed on a Wisdom saving throw or drop whatever it is holding and become frightened for the duration.', '3', 'CLASS:Wizard'),
('Fireball', 'A bright streak flashes from your pointing finger to a point you choose within range and then blossoms with a low roar into an explosion of flame. Each creature in a 20-foot-radius sphere centered on that point must make a Dexterity saving throw. A target takes 8d6 fire damage on a failed save, or half as much damage on a successful one. The fire spreads around corners. It ignites flammable objects in the area that aren’t being worn or carried.', '3', 'CLASS:Wizard'),
('Fly', 'You touch a willing creature. The target gains a flying speed of 60 feet for the duration. When the spell ends, the target falls if it is still aloft, unless it can stop the fall.', '3', 'CLASS:Wizard'),
('Gaseous Form', 'You transform a willing creature you touch, along with everything it’s wearing and carrying, into a misty cloud for the duration. The spell ends if the creature drops to 0 hit points. An incorporeal creature isn’t affected. While in this form, the target’s only method of movement is a flying speed of 10 feet. The target can enter and occupy the space of another creature. The target has resistance to nonmagical damage, and it has advantage on Strength, Dexterity, and Constitution saving throws. The target can pass through small holes, narrow openings, and even mere cracks, though it treats liquids as though they were solid surfaces. The target can’t fall and remains hovering in the air even when stunned or otherwise incapacitated.', '3', 'CLASS:Wizard'),
('Glyph of Warding', 'When you cast this spell, you inscribe a glyph that harms other creatures, either upon a surface (such as a table or a section of floor or wall) or within an object that can be closed (such as a book, a scroll, or a treasure chest) to conceal the glyph. If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered. The glyph is nearly invisible and requires a successful Intelligence (Investigation) check against your spell save DC to be found.', '3', 'CLASS:Wizard'),
('Haste', 'Choose a willing creature that you can see within range. Until the spell ends, the target’s speed is doubled, it gains a +2 bonus to AC, it has advantage on Dexterity saving throws, and it gains an additional action on each of its turns. That action can be used only to take the Attack (one weapon attack only), Dash, Disengage, Hide, or Use an Object action.', '3', 'CLASS:Wizard'),
('Hypnotic Pattern', 'You create a twisting pattern of colors that weaves through the air inside a 30-­foot cube within range. The pattern appears for a moment and vanishes. Each creature in the area who sees the pattern must make a Wisdom saving throw. On a failed save, the creature becomes charmed for the duration. While charmed by this spell, the creature is incapacitated and has a speed of 0.', '3', 'CLASS:Wizard'),
('Lightning Bolt', 'A stroke of lightning forming a line 100 feet long and 5 feet wide blasts out from you in a direction you choose. Each creature in the line must make a Dexterity saving throw. A creature takes 8d6 lightning damage on a failed save, or half as much damage on a successful one. The lightning ignites flammable objects in the area that aren’t being worn or carried.', '3', 'CLASS:Wizard'),
('Magic Circle', 'You create a 10-foot-radius, 20-foot-tall cylinder of magical energy centered on a point on the ground that you can see within range. Glowing runes appear wherever the cylinder intersects with the floor or other surface. Choose one or more of the following types of creatures: celestials, elementals, fey, fiends, or undead. The circle affects a creature of the chosen type in the following ways:
  The creature can’t willingly enter the cylinder by nonmagical means. If the creature tries to use teleportation or interplanar travel to do so, it must first succeed on a Charisma saving throw.
  The creature has disadvantage on attack rolls against targets within the cylinder.
  Targets within the cylinder can’t be charmed, frightened, or possessed by the creature.', '3', 'CLASS:Wizard'),
('Major Image', 'You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 20-­‐‑foot cube. The image appears at a spot that you can see within range and lasts for the duration. It seems completely real, including sounds, smells, and temperature appropriate to the thing depicted. You can’t create sufficient heat or cold to cause damage, a sound loud enough to deal thunder damage or deafen a creature, or a smell that might sicken a creature (like a troglodyte’s stench).', '3', 'CLASS:Wizard'),
('Phantom Steed', 'A Large quasi-real, horselike creature appears on the ground in an unoccupied space of your choice within range. You decide the creature’s appearance, but it is equipped with a saddle, bit, and bridle. Any of the equipment created by the spell vanishes in a puff of smoke if it is carried more than 10 feet away from the steed.', '3', 'CLASS:Wizard'),
('Protection from Energy', 'For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder.', '3', 'CLASS:Wizard'),
('Remove Curse', 'At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its owner’s attunement to the object so it can be removed or discarded.', '3', 'CLASS:Wizard'),
('Sending', 'You send a short message of twenty‑five words or less to a creature with which you are familiar. The creature hears the message in its mind, recognizes you as the sender if it knows you, and can answer in a like manner immediately. The spell enables creatures with Intelligence scores of at least 1 to understand the meaning of your message. You can send the message across any distance and even to other planes of existence, but if the target is on a different plane than you, there is a 5 percent chance that the message doesn’t arrive.', '3', 'CLASS:Wizard'),
('Sleet Storm', 'Until the spell ends, freezing rain and sleet fall in a 20-foot-tall cylinder with a 40-foot radius centered on a point you choose within range. The area is heavily obscured, and exposed flames in the area are doused. The ground in the area is covered with slick ice, making it difficult terrain. When a creature enters the spell’s area for the first time on a turn or starts its turn there, it must make a Dexterity saving throw. On a failed save, it falls prone.', '3', 'CLASS:Wizard'),
('Slow', 'You alter time around up to six creatures of your choice in a 40-foot cube within range. Each target must succeed on a Wisdom saving throw or be affected by this spell for the duration.', '3', 'CLASS:Wizard'),
('Stinking Cloud', 'You create a 20-foot-radius sphere of yellow, nauseating gas centered on a point within range. The cloud spreads around corners, and its area is heavily obscured. The cloud lingers in the air for the duration.', '3', 'CLASS:Wizard'),
('Tiny Hut', 'A 10-foot-radius immobile dome of force springs into existence around and above you and remains stationary for the duration. The spell ends if you leave its area.', '3', 'CLASS:Wizard'),
('Tongues', 'This spell grants the creature you touch the ability to understand any spoken language it hears. Moreover, when the target speaks, any creature that knows at least one language and can hear the target understands what it says.', '3', 'CLASS:Wizard'),
('Vampiric Touch', 'The touch of your shadow-wreathed hand can siphon life force from others to heal your wounds. Make a melee spell attack against a creature within your reach. On a hit, the target takes 3d6 necrotic damage, and you regain hit points equal to half the amount of necrotic damage dealt. Until the spell ends, you can make the attack again on each of your turns as an action.', '3', 'CLASS:Wizard'),
('Water Breathing', 'This spell grants up to ten willing creatures you can see within range the ability to breathe underwater until the spell ends. Affected creatures also retain their normal mode of respiration.', '3', 'CLASS:Wizard'),


('Arcane Eye', 'You create an invisible, magical eye within range that hovers in the air for the duration. You mentally receive visual information from the eye, which has normal vision and darkvision out to 30 feet. The eye can look in every direction.', '4', 'CLASS:Wizard'),
('Banishment', 'You attempt to send one creature that you can see within range to another plane of existence. The target must succeed on a Charisma saving throw or be banished.', '4', 'CLASS:Wizard'),
('Black Tentacles', 'Squirming, ebony tentacles fill a 20-foot square on ground that you can see within range. For the duration, these tentacles turn the ground in the area into difficult terrain.', '4', 'CLASS:Wizard'),
('Blight', 'Necromantic energy washes over a creature of your choice that you can see within range, draining moisture and vitality from it. The target must make a Constitution saving throw. The target takes 8d8 necrotic damage on a failed save, or half as much damage on a successful one. This spell has no effect on undead or constructs.', '4', 'CLASS:Wizard'),
('Confusion', 'This spell assaults and twists creatures’ minds, spawning delusions and provoking uncontrolled action. Each creature in a 10-foot-radius sphere centered on a point you choose within range must succeed on a Wisdom saving throw when you cast this spell or be affected by it. An affected target can’t take reactions and must roll a d10 at the start of each of its turns to determine its behavior for that turn.', '4', 'CLASS:Wizard'),
('Conjure Minor Elementals', 'You summon elementals that appear in unoccupied spaces that you can see within range. Choose one of the following options for what appears:
  One elemental of challenge rating 2 or lower
  Two elementals of challenge rating 1 or lower
  Four elementals of challenge rating 1/2 or lower
  Eight elementals of challenge rating 1/4 or lower
An elemental summoned by this spell disappears when it drops to 0 hit points or when the spell ends. The summoned creatures are friendly to you and your companions.', '4', 'CLASS:Wizard'),
('Control Water', 'Until the spell ends, you control any freestanding water inside an area you choose that is a cube up to 100 feet on a side. You can choose from any of the following effects when you cast this spell. As an action on your turn, you can repeat the same effect or choose a different one.', '4', 'CLASS:Wizard'),
('Dimension Door', 'You teleport yourself from your current location to any other spot within range. You arrive at exactly the spot desired. It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction, such as “200 feet straight downward” or “upward to the northwest at a 45-degree angle, 300 feet.” You can bring along objects as long as their weight doesn’t exceed what you can carry.', '4', 'CLASS:Wizard'),
('Fabricate', 'You convert raw materials into products of the same material. For example, you can fabricate a wooden bridge from a clump of trees, a rope from a patch of hemp, and clothes from flax or wool.', '4', 'CLASS:Wizard'),
('Faithful Hound', 'You conjure a phantom watchdog in an unoccupied space that you can see within range, where it remains for the duration, until you dismiss it as an action, or until you move more than 100 feet away from it. The hound is invisible to all creatures except you and can’t be harmed.', '4', 'CLASS:Wizard'),
('Fire Shield', 'Thin and wispy flames wreathe your body for the duration, shedding bright light in a 10-foot radius and dim light for an additional 10 feet. You can end the spell early by using an action to dismiss it. The flames provide you with a warm shield or a chill shield, as you choose. The warm shield grants you resistance to cold damage, and the chill shield grants you resistance to fire damage.', '4', 'CLASS:Wizard'),
('Greater Invisibility', 'You or a creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person.', '4', 'CLASS:Wizard'),
('Hallucinatory Terrain', 'You make natural terrain in a 150-made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road. Manufactured structures, equipment, and creatures within the area aren’t changed in appearance.', '4', 'CLASS:Wizard'),
('Ice Storm', 'A hail of rock-hard ice pounds to the ground in a 20-foot-radius, 40-foot-high cylinder centered on a point within range. Each creature in the cylinder must make a Dexterity saving throw. A creature takes 2d8 bludgeoning damage and 4d6 cold damage on a failed save, or half as much damage on a successful one. Hailstones turn the storm’s area of effect into difficult terrain until the end of your next turn.', '4', 'CLASS:Wizard'),
('Phantasmal Killer', 'You tap into the nightmares of a creature you can see within range and create an illusory manifestation of its deepest fears, visible only to that creature. The target must make a Wisdom saving throw. On a failed save, the target becomes frightened for the duration. At the end of each of the target’s turns before the spell ends, the target must succeed on a Wisdom saving throw or take 4d10 psychic damage. On a successful save, the spell ends.', '4', 'CLASS:Wizard'),
('Polymorph', 'This spell transforms a creature that you can see within range into a new form. An unwilling creature must make a Wisdom saving throw to avoid the effect. The spell has no effect on a shapechanger or a creature with 0 hit points.', '4', 'CLASS:Wizard'),
('Private Sanctum', 'You make an area within range magically secure. The area is a cube that can be as small as 5 feet to as large as 100 feet on each side. The spell lasts for the duration or until you use an action to dismiss it.', '4', 'CLASS:Wizard'),
('Resilient Sphere', 'A sphere of shimmering force encloses a creature or object of Large size or smaller within range. An unwilling creature must make a Dexterity saving throw. On a failed save, the creature is enclosed for the duration. Nothing—not physical objects, energy, or other spell effects—can pass through the barrier, in or out, though a creature in the sphere can breathe there. The sphere is immune to all damage, and a creature or object inside can’t be damaged by attacks or effects originating from outside, nor can a creature inside the sphere damage anything outside it.', '4', 'CLASS:Wizard'),
('Secret Chest', 'You hide a chest, and all its contents, on the Ethereal Plane. You must touch the chest and the miniature replica that serves as a material component for the spell. The chest can contain up to 12 cubic feet of nonliving material (3 feet by 2 feet by 2 feet).', '4', 'CLASS:Wizard'),
('Stone Shape', 'You touch a stone object of Medium size or smaller or a section of stone no more than 5 feet in any dimension and form it into any shape that suits your purpose.', '4', 'CLASS:Wizard'),
('Stoneskin', 'This spell turns the flesh of a willing creature you touch as hard as stone. Until the spell ends, the target has resistance to nonmagical bludgeoning, piercing, and slashing damage.', '4', 'CLASS:Wizard'),
('Wall of Fire', 'You create a wall of fire on a solid surface within range. You can make the wall up to 60 feet long, 20 feet high, and 1 foot thick, or a ringed wall up to 20 feet in diameter, 20 feet high, and 1 foot thick. The wall is opaque and lasts for the duration.', '4', 'CLASS:Wizard'),


('Animate Objects', 'Objects come to life at your command. Choose up to ten nonmagical objects within range that are not being worn or carried. Medium targets count as two objects, Large targets count as four objects, Huge targets count as eight objects. You can’t animate any object larger than Huge. Each target animates and becomes a creature under your control until the spell ends or until reduced to 0 hit points.', '5', 'CLASS:Wizard'),
('Arcane Hand', 'You create a Large hand of shimmering, translucent force in an unoccupied space that you can see within range. The hand lasts for the spell’s duration, and it moves at your command, mimicking the movements of your own hand.', '5', 'CLASS:Wizard'),
('Cloudkill', 'You create a 20-foot-radius sphere of poisonous, yellow-green fog centered on a point you choose within range. The fog spreads around corners. It lasts for the duration or until strong wind disperses the fog, ending the spell. Its area is heavily obscured. When a creature enters the spell’s area for the first time on a turn or starts its turn there, that creature must make a Constitution saving throw. The creature takes 5d8 poison damage on a failed save, or half as much damage on a successful one. Creatures are affected even if they hold their breath or don’t need to breathe.', '5', 'CLASS:Wizard'),
('Cone of Cold', 'A blast of cold air erupts from your hands. Each creature in a 60-foot cone must make a Constitution saving throw. A creature takes 8d8 cold damage on a failed save, or half as much damage on a successful one. A creature killed by this spell becomes a frozen statue until it thaws.', '5', 'CLASS:Wizard'),
('Conjure Elemental', 'You call forth an elemental servant. Choose an area of air, earth, fire, or water that fills a 10-foot cube within range. An elemental of challenge rating 5 or lower appropriate to the area you chose appears in an unoccupied space within 10 feet of it. The elemental disappears when it drops to 0 hit points or when the spell ends.', '5', 'CLASS:Wizard'),
('Contact Other Plane', 'You mentally contact a demigod, the spirit of a long-dead sage, or some other mysterious entity from another plane. Contacting this extraplanar intelligence can strain or even break your mind.', '5', 'CLASS:Wizard'),
('Creation', 'You pull wisps of shadow material from the Shadowfell to create a nonliving object of vegetable matter within range: soft goods, rope, wood, or something similar. You can also use this spell to create mineral objects such as stone, crystal, or metal. The object created must be no larger than a 5-foot cube, and the object must be of a form and material that you have seen before.', '5', 'CLASS:Wizard'),
('Dominate Person', 'You attempt to beguile a humanoid that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.You pull wisps of shadow material from the Shadowfell to create a nonliving object of vegetable matter within range: soft goods, rope, wood, or something similar. You can also use this spell to create mineral objects such as stone, crystal, or metal. The object created must be no larger than a 5-foot cube, and the object must be of a form and material that you have seen before.', '5', 'CLASS:Wizard'),
('Dream', 'This spell shapes a creature’s dreams. Choose a creature known to you as the target of this spell. The target must be on the same plane of existence as you. Creatures that don’t sleep, such as elves, can’t be contacted by this spell. You, or a willing creature you touch, enters a trance state, acting as a messenger. While in the trance, the messenger is aware of his or her surroundings, but can’t take actions or move.', '5', 'CLASS:Wizard'),
('Geas', 'You place a magical command on a creature that you can see within range, forcing it to carry out some service or refrain from some action or course of activity as you decide. If the creature can understand you, it must succeed on a Wisdom saving throw or become charmed by you for the duration. While the creature is charmed by you, it takes 5d10 psychic damage each time it acts in a manner directly counter to your instructions, but no more than once each day. A creature that can’t understand you is unaffected by the spell.', '5', 'CLASS:Wizard'),
('Hold Monster', 'Choose a creature that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. This spell has no effect on undead. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.', '5', 'CLASS:Wizard'),
('Legend Lore', 'Name or describe a person, place, or object. The spell brings to your mind a brief summary of the significant lore about the thing you named. The lore might consist of current tales, forgotten stories, or even secret lore that has never been widely known. If the thing you named isn’t of legendary importance, you gain no information. The more information you already have about the thing, the more precise and detailed the information you receive is.', '5', 'CLASS:Wizard'),
('Mislead', 'You become invisible at the same time that an illusory double of you appears where you are standing. The double lasts for the duration, but the invisibility ends if you attack or cast a spell. You can use your action to move your illusory double up to twice your speed and make it gesture, speak, and behave in whatever way you choose. You can see through its eyes and hear through its ears as if you were located where it is. On each of your turns as a bonus action, you can switch from using its senses to using your own, or back again. While you are using its senses, you are blinded and deafened in regard to your own surroundings.', '5', 'CLASS:Wizard'),
('Modify Memory', 'You attempt to reshape another creature’s memories. One creature that you can see must make a Wisdom saving throw. If you are fighting the creature, it has advantage on the saving throw. On a failed save, the target becomes charmed by you for the duration. The charmed target is incapacitated and unaware of its surroundings, though it can still hear you. If it takes any damage or is targeted by another spell, this spell ends, and none of the target’s memories are modified.', '5', 'CLASS:Wizard'),
('Passwall', 'A passage appears at a point of your choice that you can see on a wooden, plaster, or stone surface (such as a wall, a ceiling, or a floor) within range, and lasts for the duration. You choose the opening’s dimensions: up to 5 feet wide, 8 feet tall, and 20 feet deep. The passage creates no instability in a structure surrounding it.', '5', 'CLASS:Wizard'),
('Planar Binding', 'With this spell, you attempt to bind a celestial, an elemental, a fey, or a fiend to your service. The creature must be within range for the entire casting of the spell. (Typically, the creature is first summoned into the center of an inverted magic circle in order to keep it trapped while this spell is cast.) At the completion of the casting, the target must make a Charisma saving throw. On a failed save, it is bound to serve you for the duration. If the creature was summoned or created by another spell, that spell’s duration is extended to match the duration of this spell.', '5', 'CLASS:Wizard'),
('Seeming', 'This spell allows you to change the appearance of any number of creatures that you can see within range. You give each target you choose a new, illusory appearance. An unwilling target can make a Charisma saving throw, and if it succeeds, it is unaffected by this spell.', '5', 'CLASS:Wizard'),
('Telekinesis', 'You gain the ability to move or manipulate creatures or objects by thought. When you cast the spell, and as your action each round for the duration, you can exert your will on one creature or object that you can see within range, causing the appropriate effect below. You can affect the same target round after round, or choose a new one at any time. If you switch targets, the prior target is no longer affected by the spell.', '5', 'CLASS:Wizard'),
('Telepathic Bond', 'You forge a telepathic link among up to eight willing creatures of your choice within range, psychically linking each creature to all the others for the duration. Creatures with Intelligence scores of 2 or less aren’t affected by this spell. Until the spell ends, the targets can communicate telepathically through the bond whether or not they have a common language. The communication is possible over any distance, though it can’t extend to other planes of existence.', '5', 'CLASS:Wizard'),
('Teleportation Circle', 'As you cast the spell, you draw a 10-foot-diameter circle on the ground inscribed with sigils that link your location to a permanent teleportation circle of your choice whose sigil sequence you know and that is on the same plane of existence as you. A shimmering portal opens within the circle you drew and remains open until the end of your next turn. Any creature that enters the portal instantly appears within 5 feet of the destination circle or in the nearest unoccupied space if that space is occupied.', '5', 'CLASS:Wizard'),
('Wall of Force', 'An invisible wall of force springs into existence at a point you choose within range. The wall appears in any orientation you choose, as a horizontal or vertical barrier or at an angle. It can be free floating or resting on a solid surface. Nothing can physically pass through the wall.', '5', 'CLASS:Wizard'),
('Wall of Stone', 'A nonmagical wall of solid stone springs into existence at a point you choose within range. The wall is 6 inches thick and is composed of ten 10-foot-by-10-foot panels. Each panel must be contiguous with at least one other panel. Alternatively, you can create 10-foot-by-20-foot panels that are only 3 inches thick.', '5', 'CLASS:Wizard'),


('Chain Lightning', 'You create a bolt of lightning that arcs toward a target of your choice that you can see within range. Three bolts then leap from that target to as many as three other targets, each of which must be within 30 feet of the first target. A target can be a creature or an object and can be targeted by only one of the bolts. A target must make a Dexterity saving throw. The target takes 10d8 lightning damage on a failed save, or half as much damage on a successful one.', '6', 'CLASS:Wizard'),
('Circle of Death', 'A sphere of negative energy ripples out in a 60-foot-radius sphere from a point within range. Each creature in that area must make a Constitution saving throw. A target takes 8d6 necrotic damage on a failed save, or half as much damage on a successful one.', '6', 'CLASS:Wizard'),
('Contingency', 'Choose a spell of 5th level or lower that you can cast, that has a casting time of 1 action, and that can target you. You cast that spell—called the contingent spell—as part of casting contingency, expending spell slots for both, but the contingent spell doesn’t come into effect. Instead, it takes effect when a certain circumstance occurs. You describe that circumstance when you cast the two spells.', '6', 'CLASS:Wizard'),
('Create Undead', 'You can cast this spell only at night. Choose up to three corpses of Medium or Small humanoids within range. Each corpse becomes a ghoul under your control. (The GM has game statistics for these creatures.)', '6', 'CLASS:Wizard'),
('Disintegrate', 'A thin green ray springs from your pointing finger to a target that you can see within range. The target can be a creature, an object, or a creation of magical force, such as the wall created by wall of force. A creature targeted by this spell must make a Dexterity saving throw. On a failed save, the target takes 10d6 + 40 force damage. If this damage reduces the target to 0 hit points, it is disintegrated.', '6', 'CLASS:Wizard'),
('Eyebite', 'For the spell’s duration, your eyes become an inky void imbued with dread power. One creature of your choice within 60 feet of you that you can see must succeed on a Wisdom saving throw or be affected by one of the following effects of your choice for the duration. On each of your turns until the spell ends, you can use your action to target another creature but can’t target a creature again if it has succeeded on a saving throw against this casting of eyebite.', '6', 'CLASS:Wizard'),
('Flesh to Stone', 'You attempt to turn one creature that you can see within range into stone. If the target’s body is made of flesh, the creature must make a Constitution saving throw. On a failed save, it is restrained as its flesh begins to harden. On a successful save, the creature isn’t affected. A creature restrained by this spell must make another Constitution saving throw at the end of each of its turns. If it successfully saves against this spell three times, the spell ends. If it fails its saves three times, it is turned to stone and subjected to the petrified condition for the duration. The successes and failures don’t need to be consecutive; keep track of both until the target collects three of a kind.', '6', 'CLASS:Wizard'),
('Freezing Sphere', 'A frigid globe of cold energy streaks from your fingertips to a point of your choice within range, where it explodes in a 60-foot-radius sphere. Each creature within the area must make a Constitution saving throw. On a failed save, a creature takes 10d6 cold damage. On a successful save, it takes half as much damage.', '6', 'CLASS:Wizard'),
('Globe of Invulnerability', 'An immobile, faintly shimmering barrier springs into existence in a 10-foot radius around you and remains for the duration.', '6', 'CLASS:Wizard'),
('Guards and Wards', 'You create a ward that protects up to 2,500 square feet of floor space (an area 50 feet square, or one hundred 5-foot squares or twenty-five 10-foot squares). The warded area can be up to 20 feet tall, and shaped as you desire. You can ward several stories of a stronghold by dividing the area among them, as long as you can walk into each contiguous area while you are casting the spell. When you cast this spell, you can specify individuals that are unaffected by any or all of the effects that you choose. You can also specify a password that, when spoken aloud, makes the speaker immune to these effects. Guards and wards creates the following effects within the warded area.', '6', 'CLASS:Wizard'),
('Instant Summons', 'You touch an object weighing 10 pounds or less whose longest dimension is 6 feet or less. The spell leaves an invisible mark on its surface and invisibly inscribes the name of the item on the sapphire you use as the material component. Each time you cast this spell, you must use a different sapphire.', '6', 'CLASS:Wizard'),
('Irresistible Dance', 'Choose one creature that you can see within range. The target begins a comic dance in place: shuffling, tapping its feet, and capering for the duration. Creatures that can’t be charmed are immune to this spell. A dancing creature must use all its movement to dance without leaving its space and has disadvantage on Dexterity saving throws and attack rolls. While the target is affected by this spell, other creatures have advantage on attack rolls against it. As an action, a dancing creature makes a Wisdom saving throw to regain control of itself. On a successful save, the spell ends.', '6', 'CLASS:Wizard'),
('Magic Jar', 'Your body falls into a catatonic state as your soul leaves it and enters the container you used for the spell’s material component. While your soul inhabits the container, you are aware of your surroundings as if you were in the container’s space. You can’t move or use reactions. The only action you can take is to project your soul up to 100 feet out of the container, either returning to your living body (and ending the spell) or attempting to possess a humanoids body.', '6', 'CLASS:Wizard'),
('Mass Suggestion', 'You suggest a course of activity (limited to a sentence or two) and magically influence up to twelve creatures of your choice that you can see within range and that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act automatically negates the effect of the spell.', '6', 'CLASS:Wizard'),
('Move Earth', 'Choose an area of terrain no larger than 40 feet on a side within range. You can reshape dirt, sand, or clay in the area in any manner you choose for the duration. You can raise or lower the area’s elevation, create or fill in a trench, erect or flatten a wall, or form a pillar. The extent of any such changes can’t exceed half the area’s largest dimension.', '6', 'CLASS:Wizard'),
('Programmed Illusion', 'You create an illusion of an object, a creature, or some other visible phenomenon within range that activates when a specific condition occurs. The illusion is imperceptible until then. It must be no larger than a 30-­‐‑foot cube, and you decide when you cast the spell how the illusion behaves and what sounds it makes. This scripted performance can last up to 5 minutes.', '6', 'CLASS:Wizard'),
('Sunbeam', 'A beam of brilliant light flashes out from your hand in a 5-foot-wide, 60-foot-long line. Each creature in the line must make a Constitution saving throw. On a failed save, a creature takes 6d8 radiant damage and is blinded until your next turn. On a successful save, it takes half as much damage and isn’t blinded by this spell. Undead and oozes have disadvantage on this saving throw.', '6', 'CLASS:Wizard'),
('True Seeing', 'This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet.', '6', 'CLASS:Wizard'),
('Wall of Ice', 'You create a wall of ice on a solid surface within range. You can form it into a hemispherical dome or a sphere with a radius of up to 10 feet, or you can shape a flat surface made up of ten 10-foot-square panels. Each panel must be contiguous with another panel. In any form, the wall is 1 foot thick and lasts for the duration.', '6', 'CLASS:Wizard'),


('Arcane Sword', 'You create a sword-shaped plane of force that hovers within range. It lasts for the duration. When the sword appears, you make a melee spell attack against a target of your choice within 5 feet of the sword. On a hit, the target takes 3d10 force damage. Until the spell ends, you can use a bonus action on each of your turns to move the sword up to 20 feet to a spot you can see and repeat this attack against the same target or a different one.', '7', 'CLASS:Wizard'),
('Delayed Blast Fireball', 'A beam of yellow light flashes from your pointing finger, then condenses to linger at a chosen point within range as a glowing bead for the duration. When the spell ends, either because your concentration is broken or because you decide to end it, the bead blossoms with a low roar into an explosion of flame that spreads around corners.', '7', 'CLASS:Wizard'),
('Etherealness', 'You step into the border regions of the Ethereal Plane, in the area where it overlaps with your current plane. You remain in the Border Ethereal for the duration or until you use your action to dismiss the spell. During this time, you can move in any direction. If you move up or down, every foot of movement costs an extra foot. You can see and hear the plane you originated from, but everything there looks gray, and you can’t see anything more than 60 feet away. While on the Ethereal Plane, you can only affect and be affected by other creatures on that plane. Creatures that aren’t on the Ethereal Plane can’t perceive you and can’t interact with you, unless a special ability or magic has given them the ability to do so. You ignore all objects and effects that aren’t on the Ethereal Plane, allowing you to move through objects you perceive on the plane you originated from.', '7', 'CLASS:Wizard'),
('Finger of Death', 'You send negative energy coursing through a creature that you can see within range, causing it searing pain. The target must make a Constitution saving throw. It takes 7d8 + 30 necrotic damage on a failed save, or half as much damage on a successful one. A humanoid killed by this spell rises at the start of your next turn as a zombie that is permanently under your command, following your verbal orders to the best of its ability.', '7', 'CLASS:Wizard'),
('Forcecage', 'An immobile, invisible, cube-shaped prison composed of magical force springs into existence around an area you choose within range. The prison can be a cage or a solid box, as you choose. A prison in the shape of a cage can be up to 20 feet on a side and is made from 1/2-inch diameter bars spaced 1/2 inch apart. A prison in the shape of a box can be up to 10 feet on a side, creating a solid barrier that prevents any matter from passing through it and blocking any spells cast into or out from the area.', '7', 'CLASS:Wizard'),
('Magnificent Mansion', 'You conjure an extradimensional dwelling in range that lasts for the duration. You choose where its one entrance is located. The entrance shimmers faintly and is 5 feet wide and 10 feet tall. You and any creature you designate when you cast the spell can enter the extradimensional dwelling as long as the portal remains open. You can open or close the portal if you are within 30 feet of it. While closed, the portal is invisible.', '7', 'CLASS:Wizard'),
('Mirage Arcane', 'You make terrain in an area up to 1 mile square look, sound, smell, and even feel like some other sort of terrain. The terrain’s general shape remains the same, however. Open fields or a road could be made to resemble a swamp, hill, crevasse, or some other difficult or impassable terrain. A pond can be made to seem like a grassy meadow, a precipice like a gentle slope, or a rock-strewn gully like a wide and smooth road.', '7', 'CLASS:Wizard'),
('Plane Shift', 'You and up to eight willing creatures who link hands in a circle are transported to a different plane of existence. You can specify a target destination in general terms, such as the City of Brass on the Elemental Plane of Fire or the palace of Dispater on the second level of the Nine Hells, and you appear in or near that destination. If you are trying to reach the City of Brass, for example, you might arrive in its Street of Steel, before its Gate of Ashes, or looking at the city from across the Sea of Fire, at the GM’s discretion. Alternatively, if you know the sigil sequence of a teleportation circle on another plane of existence, this spell can take you to that circle. If the teleportation circle is too small to hold all the creatures you transported, they appear in the closest unoccupied spaces next to the circle.', '7', 'CLASS:Wizard'),
('Prismatic Spray', 'Eight multicolored rays of light flash from your hand. Each ray is a different color and has a different power and purpose. Each creature in a 60-foot cone must make a Dexterity saving throw. For each target, roll a d8 to determine which color ray affects it.', '7', 'CLASS:Wizard'),
('Project Image', 'You create an illusory copy of yourself that lasts for the duration. The copy can appear at any location within range that you have seen before, regardless of intervening obstacles. The illusion looks and sounds like you but is intangible. If the illusion takes any damage, it disappears, and the spell ends.', '7', 'CLASS:Wizard'),
('Reverse Gravity', 'This spell reverses gravity in a 50-foot-radius, 100-foot high cylinder centered on a point within range. All creatures and objects that aren’t somehow anchored to the ground in the area fall upward and reach the top of the area when you cast this spell. A creature can make a Dexterity saving throw to grab onto a fixed object it can reach, thus avoiding the fall.', '7', 'CLASS:Wizard'),
('Sequester', 'By means of this spell, a willing creature or an object can be hidden away, safe from detection for the duration. When you cast the spell and touch the target, it becomes invisible and can’t be targeted by divination spells or perceived through scrying sensors created by divination spells.', '7', 'CLASS:Wizard'),
('Simulacrum', 'You shape an illusory duplicate of one beast or humanoid that is within range for the entire casting time of the spell. The duplicate is a creature, partially real and formed from ice or snow, and it can take actions and otherwise be affected as a normal creature. It appears to be the same as the original, but it has half the creature’s hit point maximum and is formed without any equipment. Otherwise, the illusion uses all the statistics of the creature it duplicates.', '7', 'CLASS:Wizard'),
('Symbol', 'When you cast this spell, you inscribe a harmful glyph either on a surface (such as a section of floor, a wall, or a table) or within an object that can be closed to conceal the glyph (such as a book, a scroll, or a treasure chest). If you choose a surface, the glyph can cover an area of the surface no larger than 10 feet in diameter. If you choose an object, that object must remain in its place; if the object is moved more than 10 feet from where you cast this spell, the glyph is broken, and the spell ends without being triggered. The glyph is nearly invisible, requiring an Intelligence (Investigation) check against your spell save DC to find it.', '7', 'CLASS:Wizard'),
('Teleport', 'This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can’t be held or carried by an unwilling creature. The destination you choose must be known to you, and it must be on the same plane of existence as you. Your familiarity with the destination determines whether you arrive there successfully. The GM rolls d100 and consults the table.', '7', 'CLASS:Wizard'),


('Antimagic Field', 'A 10-foot-radius invisible sphere of antimagic surrounds you. This area is divorced from the magical energy that suffuses the multiverse. Within the sphere, spells can’t be cast, summoned creatures disappear, and even magic items become mundane. Until the spell ends, the sphere moves with you, centered on you. Spells and other magical effects, except those created by an artifact or a deity, are suppressed in the sphere and can’t protrude into it. A slot expended to cast a suppressed spell is consumed. While an effect is suppressed, it doesn’t function, but the time it spends suppressed counts against its duration.', '8', 'CLASS:Wizard'),
('Antipathy/Sympathy', 'This spell attracts or repels creatures of your choice. You target something within range, either a Huge or smaller object or creature or an area that is no larger than a 200-foot cube. Then specify a kind of intelligent creature, such as red dragons, goblins, or vampires. You invest the target with an aura that either attracts or repels the specified creatures for the duration. Choose antipathy or sympathy as the aura’s effect.', '8', 'CLASS:Wizard'),
('Clone', 'This spell grows an inert duplicate of a living creature as a safeguard against death. This clone forms inside a sealed vessel and grows to full size and maturity after 120 days; you can also choose to have the clone be a younger version of the same creature. It remains inert and endures indefinitely, as long as its vessel remains undisturbed.', '8', 'CLASS:Wizard'),
('Control Weather', 'You take control of the weather within 5 miles of you for the duration. You must be outdoors to cast this spell. Moving to a place where you don’t have a clear path to the sky ends the spell early. When you cast the spell, you change the current weather conditions, which are determined by the GM based on the climate and season. You can change precipitation, temperature, and wind. It takes 1d4 × 10 minutes for the new conditions to take effect. Once they do so, you can change the conditions again. When the spell ends, the weather gradually returns to normal.', '8', 'CLASS:Wizard'),
('Demiplane', 'You create a shadowy door on a flat solid surface that you can see within range. The door is large enough to allow Medium creatures to pass through unhindered. When opened, the door leads to a demiplane that appears to be an empty room 30 feet in each dimension, made of wood or stone. When the spell ends, the door disappears, and any creatures or objects inside the demiplane remain trapped there, as the door also disappears from the other side. Each time you cast this spell, you can create a new demiplane, or have the shadowy door connect to a demiplane you created with a previous casting of this spell. Additionally, if you know the nature and contents of a demiplane created by a casting of this spell by another creature, you can have the shadowy door connect to its demiplane instead.', '8', 'CLASS:Wizard'),
('Dominate Monster', 'You attempt to beguile a creature that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw. While the creature is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as “Attack that creature,” “Run over there,” or “Fetch that object.” If the creature completes the order and doesn’t receive further direction from you, it defends and preserves itself to the best of its ability.', '8', 'CLASS:Wizard'),
('Feeblemind', 'You blast the mind of a creature that you can see within range, attempting to shatter its intellect and personality. The target takes 4d6 psychic damage and must make an Intelligence saving throw. On a failed save, the creature’s Intelligence and Charisma scores become 1. The creature can’t cast spells, activate magic items, understand language, or communicate in any intelligible way. The creature can, however, identify its friends, follow them, and even protect them. At the end of every 30 days, the creature can repeat its saving throw against this spell. If it succeeds on its saving throw, the spell ends. The spell can also be ended by greater restoration, heal, or wish.', '8', 'CLASS:Wizard'),
('Incendiary Cloud', 'A swirling cloud of smoke shot through with white-hot embers appears in a 20-foot-radius sphere centered on a point within range. The cloud spreads around corners and is heavily obscured. It lasts for the duration or until a wind of moderate or greater speed (at least 10 miles per hour) disperses it.', '8', 'CLASS:Wizard'),
('Maze', 'You banish a creature that you can see within range into a labyrinthine demiplane. The target remains there for the duration or until it escapes the maze. The target can use its action to attempt to escape. When it does so, it makes a DC 20 Intelligence check. If it succeeds, it escapes, and the spell ends (a minotaur or goristro demon automatically succeeds).', '8', 'CLASS:Wizard'),
('Mind Blank', 'Until the spell ends, one willing creature you touch is immune to psychic damage, any effect that would sense its emotions or read its thoughts, divination spells, and the charmed condition. The spell even foils wish spells and spells or effects of similar power used to affect the target’s mind or to gain information about the target.', '8', 'CLASS:Wizard'),
('Power Word Stun', 'You speak a word of power that can overwhelm the mind of one creature you can see within range, leaving it dumbfounded. If the target has 150 hit points or fewer, it is stunned. Otherwise, the spell has no effect. The stunned target must make a Constitution saving throw at the end of each of its turns. On a successful save, this stunning effect ends.', '8', 'CLASS:Wizard'),
('Sunburst', 'Brilliant sunlight flashes in a 60-foot radius centered on a point you choose within range. Each creature in that light must make a Constitution saving throw. On a failed save, a creature takes 12d6 radiant damage and is blinded for 1 minute. On a successful save, it takes half as much damage and isn’t blinded by this spell.', '8', 'CLASS:Wizard'),


('Astral Projection', 'You and up to eight willing creatures within range project your astral bodies into the Astral Plane (the spell fails and the casting is wasted if you are already on that plane). The material body you leave behind is unconscious and in a state of suspended animation; it doesn’t need food or air and doesn’t age. Your astral body resembles your mortal form in almost every way, replicating your game statistics and possessions. The principal difference is the addition of a silvery cord that extends from between your shoulder blades and trails behind you, fading to invisibility after 1 foot. This cord is your tether to your material body. As long as the tether remains intact, you can find your way home. If the cord is cut—something that can happen only when an effect specifically states that it does—your soul and body are separated, killing you instantly.', '9', 'CLASS:Wizard'),
('Foresight', 'You touch a willing creature and bestow a limited ability to see into the immediate future. For the duration, the target can’t be surprised and has advantage on attack rolls, ability checks, and saving throws. Additionally, other creatures have disadvantage on attack rolls against the target for the duration. This spell immediately ends if you cast it again before its duration ends.', '9', 'CLASS:Wizard'),
('Gate', 'You conjure a portal linking an unoccupied space you can see within range to a precise location on a different plane of existence. The portal is a circular opening, which you can make 5 to 20 feet in diameter. You can orient the portal in any direction you choose. The portal lasts for the duration. The portal has a front and a back on each plane where it appears. Travel through the portal is possible only by moving through its front. Anything that does so is instantly transported to the other plane, appearing in the unoccupied space nearest to the portal.', '9', 'CLASS:Wizard'),
('Imprisonment', 'You create a magical restraint to hold a creature that you can see within range. The target must succeed on a Wisdom saving throw or be bound by the spell; if it succeeds, it is immune to this spell if you cast it again. While affected by this spell, the creature doesn’t need to breathe, eat, or drink, and it doesn’t age. Divination spells can’t locate or perceive the target.', '9', 'CLASS:Wizard'),
('Meteor Swarm', 'Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.', '9', 'CLASS:Wizard'),
('Power Word Kill', 'You utter a word of power that can compel one creature you can see within range to die instantly. If the creature you choose has 100 hit points or fewer, it dies. Otherwise, the spell has no effect.', '9', 'CLASS:Wizard'),
('Prismatic Wall', 'A shimmering, multicolored plane of light forms a vertical opaque wall—up to 90 feet long, 30 feet high, and 1 inch thick—centered on a point you can see within range. Alternatively, you can shape the wall into a sphere up to 30 feet in diameter centered on a point you choose within range. The wall remains in place for the duration. If you position the wall so that it passes through a space occupied by a creature, the spell fails, and your action and the spell slot are wasted. The wall sheds bright light out to a range of 100 feet and dim light for an additional 100 feet. You and creatures you designate at the time you cast the spell can pass through and remain near the wall without harm. If another creature that can see the wall moves to within 20 feet of it or starts its turn there, the creature must succeed on a Constitution saving throw or become blinded for 1 minute. The wall consists of seven layers, each with a different color. When a creature attempts to reach into or pass through the wall, it does so one layer at a time through all the wall’s layers.', '9', 'CLASS:Wizard'),
('Shapechange', 'You assume the form of a different creature for the duration. The new form can be of any creature with a challenge rating equal to your level or lower. The creature can’t be a construct or an undead, and you must have seen the sort of creature at least once. You transform into an average example of that creature, one without any class levels or the Spellcasting trait. Your game statistics are replaced by the statistics of the chosen creature, though you retain your alignment and Intelligence, Wisdom, and Charisma scores. You also retain all of your skill and saving throw proficiencies, in addition to gaining those of the creature. If the creature has the same proficiency as you and the bonus listed in its statistics is higher than yours, use the creature’s bonus in place of yours. You can’t use any legendary actions or lair actions of the new form.', '9', 'CLASS:Wizard'),
('Time Stop', 'You briefly stop the flow of time for everyone but yourself. No time passes for other creatures, while you take 1d4 + 1 turns in a row, during which you can use actions and move as normal.', '9', 'CLASS:Wizard'),
('True Polymorph', 'Choose one creature or nonmagical object that you can see within range. You transform the creature into a different creature, the creature into an object, or the object into a creature (the object must be neither worn nor carried by another creature). The transformation lasts for the duration, or until the target drops to 0 hit points or dies. If you concentrate on this spell for the full duration, the transformation lasts until it is dispelled. This spell has no effect on a shapechanger or a creature with 0 hit points. An unwilling creature can make a Wisdom saving throw, and if it succeeds, it isn’t affected by this spell.', '9', 'CLASS:Wizard'),
('Weird', 'Drawing on the deepest fears of a group of creatures, you create illusory creatures in their minds, visible only to them. Each creature in a 30-foot-radius sphere centered on a point of your choice within range must make a Wisdom saving throw. On a failed save, a creature becomes frightened for the duration. The illusion calls on the creature’s deepest fears, manifesting its worst nightmares as an implacable threat. At the end of each of the frightened creature’s turns, it must succeed on a Wisdom saving throw or take 4d10 psychic damage. On a successful save, the spell ends for that creature.', '9', 'CLASS:Wizard'),
('Wish', 'Wish is the mightiest spell a mortal creature can cast. By simply speaking aloud, you can alter the very foundations of reality in accord with your desires. The basic use of this spell is to duplicate any other spell of 8th level or lower. You don’t need to meet any requirements in that spell, including costly components. The spell simply takes effect.', '9', 'CLASS:Wizard')












INSERT INTO SubClass (subClassName, classID, description)
VALUES
('Path of the Berserker', 1002 , 'For some barbarians, rage is a means to an end—that end being violence. The Path of the Berserker is a path of untrammeled fury, slick with blood. As you enter the berserker’s rage, you thrill in the chaos of battle, heedless of your own health or well-being.'),
('Path of the Totem Warrior', 1002 , 'The Path of the Totem Warrior is a spiritual journey, as the barbarian accepts a spirit animal as guide, protector, and inspiration. In battle, your totem spirit fills you with supernatural might, adding magical fuel to your barbarian rage.')

INSERT INTO ClassFeatures (classFeatureName, classFeatureDescription, classID, subClassID, levelEarned)
VALUES
('Frenzy', 'You can go into a frenzy when you rage. If you do so, for the duration of your rage you can make a single melee weapon attack as a bonus action on each of your turns after this one. When your rage ends, you suffer one level of exhaustion.', 1002, 4, 3),
('Mindless Rage', 'You can’t be charmed or frightened while raging. If you are charmed or frightened when you enter your rage, the effect is suspended for the duration of the rage.', 1002, 4 , 6),
('Intimidating Presence', 'You can use your action to frighten someone with your menacing presence. When you do so, choose one creature that you can see within 30 feet of you. If the creature can see or hear you, it must succeed on a Wisdom saving throw (DC equal to 8 + your proficiency bonus + your Charisma modifier) or be frightened of you until the end of your next turn. On subsequent turns, you can use your action to extend the duration of this effect on the frightened creature until the end of your next turn. This effect ends if the creature ends its turn out of line of sight or more than 60 feet away from you. If the creature succeeds on its saving throw, you can’t use this feature on that creature again for 24 hours.', 1002, 4, 10),
('Retaliation', 'When you take damage from a creature that is within 5 feet of you, you can use your reaction to make a melee weapon attack against that creature.', 1002, 4, 14),
('Totem Spirit', 'When you adopt this path, you choose a totem spirit and gain its feature. You must make or acquire a physical totem object – an amulet or similar adornment – that incorporates fur or feathers, claws, teeth, or bones of the totem animal. At your option, you also gain minor physical attributes that are reminiscent of your totem spirit. For example, if you have a bear totem spirit, you might be unusually hairy and thick-skinned, or if your totem is the eagle, your eyes turn bright yellow.

Your totem animal might be an animal related to those listed here but more appropriate to your homeland. For example, you could choose a hawk or vulture in place of an eagle.

Bear. While raging, you have resistance to all damage except psychic damage. The spirit of the bear makes you tough enough to stand up to any punishment.

Eagle. While you''re raging and aren''t wearing heavy armor, other creatures have disadvantage on opportunity attack rolls against you, and you can use the Dash action as a bonus action on your turn. The spirit of the eagle makes you into a predator who can weave through the fray with ease.

Elk. While you''re raging and aren''t wearing heavy armor, your walking speed increases by 15 feet. The spirit of the elk makes you extraordinarily swift.

Tiger. While raging, you can add 10 feet to your long jump distance and 3 feet to your high jump distance. The spirit of the tiger empowers your leaps.

Wolf. While you''re raging, your friends have advantage on melee attack rolls against any creature within 5 feet of you that is hostile to you. The spirit of the wolf makes you a leader of hunters.', 1002, 5, 3),
('Spirit Seeker', 'When you adopt this path, you gain the ability to cast the Beast Sense and Speak with Animals spells, but only as rituals.', 1002, 5, 3),
('Aspect of the Beast', 'You gain a magical benefit based on the totem animal of your choice. You can choose the same animal you selected at 3rd level or a different one.

Bear. You gain the might of a bear. Your carrying capacity (including maximum load and maximum lift) is doubled, and you have advantage on Strength checks made to push, pull, lift, or break objects.

Eagle. You gain the eyesight of an eagle. You can see up to 1 mile away with no difficulty, able to discern even fine details as though looking at something no more than 100 feet away from you. Additionally, dim light doesn''t impose disadvantage on your Wisdom (Perception) checks.

Elk. Whether mounted or on foot, your travel pace is doubled, as is the travel pace of up to ten companions while they''re within 60 feet of you and you''re not incapacitated. The elk spirit helps you roam far and fast.

Tiger. You gain proficiency in two skills from the following list: Athletics, Acrobatics, Stealth, and Survival. The cat spirit hones your survival instincts.

Wolf. You gain the hunting sensibilities of a wolf. You can track other creatures while traveling at a fast pace, and you can move stealthily while traveling at a normal pace.', 1002, 5, 6),
('Spirit Walker', 'You can cast the Commune with Nature spell, but only as a ritual. When you do so, a spiritual version of one of the animals you chose for Totem Spirit or Aspect of the Beast appears to you to convey the information you seek.', 1002, 5, 10),
('Totemic Attunement', 'You gain a magical benefit based on a totem animal of your choice. You can choose the same animal you selected previously or a different one.

Bear. While you''re raging, any creature within 5 feet of you that''s hostile to you has disadvantage on attack rolls against targets other than you or another character with this feature. An enemy is immune to this effect if it can''t see or hear you or if it can''t be frightened.

Eagle. While raging, you have a flying speed equal to your current walking speed. This benefit works only in short bursts; you fall if you end your turn in the air and nothing else is holding you aloft.

Elk. While raging, you can use a bonus action during your move to pass through the space of a Large or smaller creature. That creature must succeed on a Strength saving throw (DC 8 + your Strength bonus + your proficiency bonus) or be knocked prone and take bludgeoning damage equal to 1d12 + your Strength modifier.

Tiger. While you''re raging, if you move at least 20 feet in a straight line toward a Large or smaller target right before making a melee weapon attack against it, you can use a bonus action to make an additional melee weapon attack against it.

Wolf. While you''re raging, you can use a bonus action on your turn to knock a Large or smaller creature prone when you hit it with melee weapon attack.', 1002, 5, 14),
('Rage', 'In battle, you fight with primal ferocity. On your turn, you can enter a rage as a bonus action.

While raging, you gain the following benefits if you aren’t wearing heavy armor:

You have advantage on Strength checks and Strength saving throws.
When you make a melee weapon attack using Strength, you gain a bonus to the damage roll that increases as you gain levels as a barbarian, as shown in the Rage Damage column of the Barbarian table.
You have resistance to bludgeoning, piercing, and slashing damage.
If you are able to cast spells, you can’t cast them or concentrate on them while raging.

Your rage lasts for 1 minute. It ends early if you are knocked unconscious or if your turn ends and you haven’t attacked a hostile creature since your last turn or taken damage since then. You can also end your rage on your turn as a bonus action.

Once you have raged the number of times shown for your barbarian level in the Rages column of the Barbarian table, you must finish a long rest before you can rage again.', 1002, NULL, 1),
('Unarmored Defense', 'While you are not wearing any armor, your Armor Class equals 10 + your Dexterity modifier + your Constitution modifier. You can use a shield and still gain this benefit.', 1002, NULL, 1),
('Reckless Attack', 'You can throw aside all concern for defense to attack with fierce desperation. When you make your first attack on your turn, you can decide to attack recklessly. Doing so gives you advantage on melee weapon attack rolls using Strength during this turn, but attack rolls against you have advantage until your next turn.', 1002, NULL, 2),
('Danger Sense', 'You gain an uncanny sense of when things nearby aren’t as they should be, giving you an edge when you dodge away from danger.

You have advantage on Dexterity saving throws against effects that you can see, such as traps and spells. To gain this benefit, you can’t be blinded, deafened, or incapacitated.', 1002, NULL, 2 ),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature. Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1002, NULL, 4 ),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature. Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1002, NULL, 8 ),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature. Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1002, NULL, 12 ),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature. Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1002, NULL, 16 ),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature. Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1002, NULL, 19 ),
('Extra Attack', 'You can attack twice, instead of once, whenever you take the Attack action on your turn.', 1002, NULL, 5),
('Fast Movement', 'Your speed increases by 10 feet while you aren’t wearing heavy armor.', 1002, NULL, 5 ),
('Feral Instinct', 'Your instincts are so honed that you have advantage on initiative rolls.

Additionally, if you are surprised at the beginning of combat and aren’t incapacitated, you can act normally on your first turn, but only if you enter your rage before doing anything else on that turn.', 1002, NULL, 7),
('Brutal Critical', 'You can roll one additional weapon damage die when determining the extra damage for a critical hit with a melee attack.', 1002, NULL, 9),
('Brutal Critical', 'You can roll two additional weapon damage die (instead of one) when determining the extra damage for a critical hit with a melee attack.', 1002, NULL, 13),
('Brutal Critical', 'You can roll three additional weapon damage die (instead of two) when determining the extra damage for a critical hit with a melee attack.', 1002, NULL, 17),
('Relentless Rage', 'Your rage can keep you fighting despite grievous wounds. If you drop to 0 hit points while you’re raging and don’t die outright, you can make a DC 10 Constitution saving throw. If you succeed, you drop to 1 hit point instead.

Each time you use this feature after the first, the DC increases by 5. When you finish a short or long rest, the DC resets to 10.', 1002, NULL, 11),
('Persistent Rage', 'Your rage is so fierce that it ends early only if you fall unconscious or if you choose to end it.', 1002, NULL, 15),
('Indomitable Might', 'If your total for a Strength check is less than your Strength score, you can use that score in place of the total.', 1002, NULL, 18),
('Primal Champion', 'You embody the power of the wilds. Your Strength and Constitution scores increase by 4. Your maximum for those scores is now 24.', 1002, NULL, 20)

INSERT INTO SubClass (subClassName, classID, description)
VALUES
('College of Lore', 1003 , 'Bards of the College of Lore know something about most things, collecting bits of knowledge from sources as diverse as scholarly tomes and peasant tales. Whether singing folk ballads in taverns or elaborate compositions in royal courts, these bards use their gifts to hold audiences spellbound. When the applause dies down, the audience members might find themselves questioning everything they held to be true, from their faith in the priesthood of the local temple to their loyalty to the king.'),
('College of Valor', 1003, 'Bards of the College of Valor are daring skalds whose tales keep alive the memory of the great heroes of the past, and thereby inspire a new generation of heroes. These bards gather in mead halls or around great bonfires to sing the deeds of the mighty, both past and present. They travel the land to witness great events firsthand and to ensure that the memory of those events doesn''t pass from the world. With their songs, they inspire others to reach the same heights of accomplishment as the heroes of old.')


INSERT INTO ClassFeatures (classFeatureName, classFeatureDescription, classID, subClassID, levelEarned)
VALUES
('Bardic Inspiration', 'You can inspire others through stirring words or music. To do so, you use a bonus action on your turn to choose one creature other than yourself within 60 feet of you who can hear you. That creature gains one Bardic Inspiration die, a d6.

Once within the next 10 minutes, the creature can roll the die and add the number rolled to one ability check, attack roll, or saving throw it makes. The creature can wait until after it rolls the d20 before deciding to use the Bardic Inspiration die, but must decide before the DM says whether the roll succeeds or fails. Once the Bardic Inspiration die is rolled, it is lost. A creature can have only one Bardic Inspiration die at a time.

You can use this feature a number of times equal to your Charisma modifier (a minimum of once). You regain any expended uses when you finish a long rest.', 1003 , NULL , 1),
('Bardic Inspiration', 'Your Bardic Inspiration die changes to a d8.', 1003 , NULL , 5),
('Bardic Inspiration', 'Your Bardic Inspiration die changes to a d10.', 1003 , NULL , 10),
('Bardic Inspiration', 'Your Bardic Inspiration die changes to a d12.', 1003 , NULL , 15),
('Jack of All Trades', 'You can add half your proficiency bonus, rounded down, to any ability check you make that doesn’t already include your proficiency bonus.', 1003 , NULL , 2 ),
('Song of Rest', 'You can use soothing music or oration to help revitalize your wounded allies during a short rest. If you or any friendly creatures who can hear your performance regain hit points at the end of the short rest by spending one or more Hit Dice, each of those creatures regains an extra 1d6 hit points.', 1003 , NULL , 2),
('Song of Rest', 'The extra hit points for your Song of Rest are now 1d8', 1003 , NULL , 9),
('Song of Rest', 'The extra hit points for your Song of Rest are now 1d10', 1003 , NULL , 13),
('Song of Rest', 'The extra hit points for your Song of Rest are now 1d12', 1003 , NULL , 17),
('Expertise', 'Choose two of your skill proficiencies. Your proficiency bonus is doubled for any ability check you make that uses either of the chosen proficiencies.', 1003 , NULL , 3),
('Font of Inspiration', 'You regain all of your expended uses of Bardic Inspiration when you finish a short or long rest.', 1003 , NULL , 5 ),
('Countercharm', 'You gain the ability to use musical notes or words of power to disrupt mind-influencing effects. As an action, you can start a performance that lasts until the end of your next turn. During that time, you and any friendly creatures within 30 feet of you have advantage on saving throws against being frightened or charmed. A creature must be able to hear you to gain this benefit. The performance ends early if you are incapacitated or silenced or if you voluntarily end it (no action required).', 1003 , NULL , 6),
('Expertise', 'Choose two more of your skill proficiencies. Your proficiency bonus is doubled for any ability check you make that uses either of the chosen proficiencies.', 1003 , NULL , 10),
('Magical Secrets', 'You have plundered magical knowledge from a wide spectrum of disciplines. Choose two spells from any classes, including this one. A spell you choose must be of a level you can cast, as shown on the Bard table, or a cantrip.

The chosen spells count as bard spells for you and are included in the number in the Spells Known column of the Bard table.', 1003 , NULL , 10),
('Magical Secrets', 'You learn two additional spells from any classes.', 1003 , NULL , 14),
('Magical Secrets', 'You learn two additional spells from any classes.', 1003 , NULL , 18),
('Superior Inspiration', 'When you roll initiative and have no uses of Bardic Inspiration left, you regain one use.', 1003 , NULL , 20 ),


('Peerless Skill', 'When you make an ability check, you can expend one use of Bardic Inspiration. Roll a Bardic Inspiration die and add the number rolled to your ability check. You can choose to do so after you roll the die for the ability check, but before the DM tells you whether you succeed or fail.', 1003 , 6 , 14 ),
('Additional Magical Secrets', 'You learn two spells of your choice from any class. A spell you choose must be of a level you can cast, as shown on the Bard table, or a cantrip. The chosen spells count as bard spells for you but don’t count against the number of bard spells you know.', 1003 , 6 , 6 ),
('Cutting Words', 'You learn how to use your wit to distract, confuse, and otherwise sap the confidence and competence of others. When a creature that you can see within 60 feet of you makes an attack roll, an ability check, or a damage roll, you can use your reaction to expend one of your uses of Bardic Inspiration, rolling a Bardic Inspiration die and subtracting the number rolled from the creature’s roll. You can choose to use this feature after the creature makes its roll, but before the DM determines whether the attack roll or ability check succeeds or fails, or before the creature deals its damage. The creature is immune if it can’t hear you or if it’s immune to being charmed.', 1003 , 6 , 3),

('Bonus Proficiencies', 'When you join the College of Valor, you gain proficiency with medium armor, shields, and martial weapons.', 1003 , 6 , 3 ),

('Bonus Proficiencies', 'When you join the College of Valor, you gain proficiency with medium armor, shields, and martial weapons.', 1003 , 7 , 3 ),
('Combat Inspiration', 'You learn to inspire others in battle. A creature that has a Bardic Inspiration die from you can roll that die and add the number rolled to a weapon damage roll it just made. Alternatively, when an attack roll is made against the creature, it can use its reaction to roll the Bardic Inspiration die and add the number rolled to its AC against that attack, after seeing the roll but before knowing whether it hits or misses.', 1003 , 7 , 3),
('Extra Attack', 'You can attack twice, instead of once, whenever you take the Attack action on your turn.', 1003 , 7 , 6 ),
('Battle Magic', 'You have mastered the art of weaving spellcasting and weapon use into a single harmonious act. When you use your action to cast a bard spell, you can make one weapon attack as a bonus action.', 1003 , 7 , 14)


4:15
INSERT INTO SubClass (subClassName, classID, description)
VALUES
('Knowledge Domain', 1004, 'The gods of knowledge – including Oghma, Boccob, Gilean, Aureon, and Thoth – value learning and understanding above all. Some teach that knowledge is to be gathered and shared in libraries and universities, or promote the practical knowledge of craft and invention. Some deities hoard knowledge and keep its secrets to themselves. And some promise their followers that they will gain tremendous power if they unlock the secrets of the multiverse. Followers of these gods study esoteric lore, collect old tomes, delve into the secret places of the earth, and learn all they can. Some gods of knowledge promote the practical knowledge of craft and invention, including smith deities like Gond, Reorx, Onatar, Moradin, Hephaestus, and Goibhniu.'),
('Life Domain', 1004, 'The Life domain focuses on the vibrant positive energy – one of the fundamental forces of the universe – that sustains all life. The gods of life promote vitality and health through healing the sick and wounded, caring for those in need, and driving away the forces of death and undeath. Almost any non-evil deity can claim influence over this domain, particularly agricultural deities (such as Chauntea, Arawai, and Demeter), sun gods (such as Lathander, Pelor, and Re-Horakhty), gods of healing or endurance (such as Ilmater, Mishakal, Apollo, and Diancecht), and gods of home and community (such as Hestia, Hathor, and Boldrci).'),
('Light Domain', 1004, 'Gods of light – including Helm, Lathander, Pholtus, Branchala, the Silver Flame, Belenus, Apollo, and Re-Horakhty – promote the ideals of rebirth and renewal, truth, vigilance, and beauty, often using the symbol of the sun. Some of these gods are portrayed as the sun itself or as a charioteer who guides the sun across the sky. Others are tireless sentinels whose eyes pierce every shadow and see through every deception. Some are deities of beauty and artistry, who teach that art is a vehicle for the soul''s improvement. Clerics of a god of light are enlightened souls infused with radiance and the power of their gods'' discerning vision, charged with chasing away lies and burning away darkness.'),
('Nature Domain', 1004, 'Gods of nature are as varied as the natural world itself; from inscrutable gods of the deep forests (such as Silvanus, Obad-Hai, Chislev, Balinor, and Pan) to friendly deities associated with particular springs and groves (such as Eldath). Druids revere nature as a whole and might serve one of these deities, practicing mysterious rites and reciting all-but-forgotten prayers in their own secret tongue. But many of these gods have clerics as well, champions who take a more active role in advancing the interests of a particular nature god. These clerics might hunt the evil monstrosities that despoil the woodlands, bless the harvest of the faithful, or wither the crops of those who anger their gods.'),
('Tempest Domain', 1004, 'Gods whose portfolios include the Tempest domain – including Talos, Umberlee, Kord, Zeboim, the Devourer, Zeus, and Thor – govern storms, sea, and, sky. They include gods of lightning and thunder, gods of earthquakes, some fire gods, and certain gods of violence, physical strength, and courage. In some pantheons, a god of this domain rules over other deities and is known for swift justice delivered by thunderbolts. In the pantheons of seafaring people, gods of this domain are ocean deities and the patrons of sailors. Tempest gods send their clerics to inspire fear in the common folk, either to keep those folk on the path of righteousness or to encourage them to offer sacrifices of propitiation to ward off divine wrath.'),
('Trickery Domain', 1004, 'Gods of trickery – such as Tymora, Beshaba, Olidammara, the Traveler, Garl Glittergold, and Loki – are mischief-makers and instigators who stand as a constant challenge to the accepted order among both gods and mortals. They''re patrons of thieves, scoundrels, gamblers, rebels, and liberators. Their clerics are a disruptive force in the world, puncturing pride, mocking tyrants, stealing from the rich, freeing captives, and flouting hollow traditions. They prefer subterfuge, pranks, deception, and theft rather than direct confrontation.'),
('War Domain', 1004, 'War has many manifestations. It can make heroes of ordinary people. It can be desperate and horrific, with acts of cruelty and cowardice eclipsing instances of excellence and courage. In either case, the gods of war watch over warriors and reward them for their great deeds. The clerics of such gods excel in battle, inspiring others to fight the good fight or offering acts of violence as prayers. Gods of war include champions of honor and chivalry (such as Torm, Heironeous, and Kiri-Jolith) as well as gods of destruction and pillage (such as Erythnul, the Fury, Gruumsh, and Ares) and gods of conquest and domination (such as Bane, Hextor, and Maglubiyet). Other war gods (such as Tempus, Nike, and Nuada) take a more neutral stance, promoting war in all its manifestations and supporting warriors in any circumstance.')


INSERT INTO ClassFeatures (classFeatureName, classFeatureDescription, classID, subClassID, levelEarned)
VALUES
('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its
 challenge rating is at or below 1/2 ', 1004, NULL, 5),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 1 ', 1004, NULL, 8),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 2 ', 1004, NULL, 11),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 3 ', 1004, NULL, 14),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 4 ', 1004, NULL, 17),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 19),
('Channel Divinity: Turn Undead', 'You present your holy symbol and speak a prayer censuring the undead. Each undead that can see or hear you within 30 feet of you must make a Wisdom saving throw. If the creature fails its saving throw, it is turned for 1 minute or until it takes any damage.

A turned creature must spend its turns trying to move as far away from you as it can, and it can’t willingly move to a space within 30 feet of you. It also can’t take reactions. For its action, it can use only the Dash action or try to escape from an effect that prevents it from moving. If there’s nowhere to move, the creature can use the Dodge action.', 1004, NULL, 2),
('Channel Divinity', 'You gain the ability to channel divine energy directly from your deity, using that energy to fuel magical effects. You start with two such effects: Turn Undead and an effect determined by your domain. Some domains grant you additional effects as you advance in levels, as noted in the domain description.

When you use your Channel Divinity, you choose which effect to create. You must then finish a short or long rest to use your Channel Divinity again.

Some Channel Divinity effects require saving throws. When you use such an effect from this class, the DC equals your cleric spell save DC. When you finish a short or long rest, you regain your expended uses.', 1004, NULL, 2 ),
('Channel Divinity', 'You can use your Channel Divinity twice between rests. When you finish a short or long rest, you regain your expended uses.', 1004, NULL, 6),
('Channel Divinity', 'You can use your Channel Divinity three times between rests. When you finish a short or long rest, you regain your expended uses.', 1004, NULL, 18),


('Blessings of Knowledge', 'You learn two languages of your choice. You also become proficient in your choice of two of the following skills: Arcana, History, Nature, or Religion.

Your proficiency bonus is doubled for any ability check you make that uses either of those skills.', 1004, 8, 1),
('Channel Divinity: Knowledge of the Ages', 'You can use your Channel Divinity to tap into a divine well of knowledge. As an action, you choose one skill or tool. For 10 minutes, you have proficiency with the chosen skill or tool.', 1004, 8, 2),
('Channel Divinity: Read Thoughts', 'You can use your Channel Divinity to read a creature''s thoughts. You can then use your access to the creature''s mind to command it.

As an action, choose one creature that you can see within 60 feet of you. That creature must make a Wisdom saving throw. If the creature succeeds on the saving throw, you can''t use this feature on it again until you finish a long rest.

If the creature fails its save, you can read its surface thoughts (those foremost in its mind, reflecting its current emotions and what it is actively thinking about) when it is within 60 feet of you. This effect lasts for 1 minute.

During that time, you can use your action to end this effect and cast the Suggestion spell on the creature without expending a spell slot. The target automatically fails its saving throw against the spell.', 1004, 8, 6 ),
('Potent Spellcasting', 'You add your Wisdom modifier to the damage you deal with any cleric cantrip.', 1004, 8, 8),
('Visions of the Past', 'You can call up visions of the past that relate to an object you hold or your immediate surroundings. You spend at least 1 minute in meditation and prayer, then receive dreamlike, shadowy glimpses of recent events. You can meditate in this way for a number of minutes equal to your Wisdom score and must maintain concentration during that time, as if you were casting a spell.

Once you use this feature, you can''t use it again until you finish a short or long rest.

Object Reading. Holding an object as you meditate, you can see visions of the object''s previous owner. After meditating for 1 minute, you learn how the owner acquired and lost the object, as well as the most recent significant event involving the object and that owner. If the object was owned by another creature in the recent past (within a number of days equal to your Wisdom score), you can spend 1 additional minute for each owner to learn the same information about that creature.

Area Reading. As you meditate, you see visions of recent events in your immediate vicinity (a room, street, tunnel, clearing, or the like, up to a 50-foot cube), going back a number of days equal to your Wisdom score. For each minute you meditate, you learn about one significant event, beginning with the most recent. Significant events typically involve powerful emotions, such as battles and betrayals, marriages and murders, births and funerals. However, they might also include more mundane events that are nevertheless important in your current situation.', 1004, 8, 17 ),
('Knowledge Domain Spells', 'You gain Command and Identify as domain spells', 1004, 8, 1),
('Knowledge Domain Spells', 'You gain Augury and Suggestion as domain spells', 1004, 8, 3),
('Knowledge Domain Spells', 'You gain Nondetection and Speak with Dead as domain spells', 1004, 8, 5),
('Knowledge Domain Spells', 'You gain Arcane Eye and Confusion as domain spells', 1004, 8, 7),
('Knowledge Domain Spells', 'You gain Legend Lore and Scrying as domain spells', 1004, 8, 9),
('Life Domain Spells', 'You gain Bless and Cure Wounds as domain spells', 1004, 9, 1),
('Life Domain Spells', 'You gain Lesser Restoration and Spiritual Weapon as domain spells', 1004, 9, 3),
('Life Domain Spells', 'You gain Beacon of Hope and Revivify as domain spells', 1004, 9, 5),
('Life Domain Spells', 'You gain Death Ward and Guardian of Faith as domain spells', 1004, 9, 7),
('Life Domain Spells', 'You gain Mass Cure Wounds and Raise Dead as domain spells', 1004, 9, 9),
('Bonus Proficiency', 'You gain proficiency with heavy armor.', 1004, 9, 1),
('Disciple of Life', 'Your healing spells are more effective. Whenever you use a spell of 1st level or higher to restore hit points to a creature, the creature regains additional hit points equal to 2 + the spell''s level.', 1004, 9, 1),
('Channel Divinity: Preserve Life', 'You can use your Channel Divinity to heal the badly injured.

As an action, you present your holy symbol and evoke healing energy that can restore a number of hit points equal to five times your cleric level. Choose any creatures within 30 feet of you, and divide those hit points among them. This feature can restore a creature to no more than half of its hit point maximum. You can''t use this feature on an undead or a construct.', 1004, 9, 2 ),
('Blessed Healer', 'The healing spells you cast on others heal you as well. When you cast a spell of 1st level or higher that restores hit points to a creature other than you, you regain hit points equal to 2 + the spell''s level.', 1004, 9, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 radiant damage to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 9, 8),
('Supreme Healing', 'When you would normally roll one or more dice to restore hit points with a spell, you instead use the highest number possible for each die. For example, instead of restoring 2d6 hit points to a creature, you restore 12.', 1004, 9, 17),

('Light Domain Spells', 'You gain Burning Hands and Faerie Fire as domain spells', 1004, 10, 1),
('Light Domain Spells', 'You gain Flaming Sphere and Scorching Ray as domain spells', 1004, 10, 3),
('Light Domain Spells', 'You gain Daylight and Fireball as domain spells', 1004, 10, 5),
('Light Domain Spells', 'You gain Guardian of Faith and Wall of Fire as domain spells', 1004, 10, 7),
('Light Domain Spells', 'You gain Flame Strike and Scrying as domain spells', 1004, 10, 9),
('Bonus Cantrip', 'You gain the Light cantrip if you don''t already know it.', 1004, 10, 1),
('Warding Flare', 'You can interpose divine light between yourself and an attacking enemy. When you are attacked by a creature within 30 feet of you that you can see, you can use your reaction to impose disadvantage on the attack roll, causing light to flare before the attacker before it hits or misses. An attacker that can''t be blinded is immune to this feature.

You can use this feature a number of times equal to your Wisdom modifier (a minimum of once). You regain all expended uses when you finish a long rest.', 1004, 10, 1),
('Channel Divinity: Radiance of the Dawn', 'You can use your Channel Divinity to harness sunlight, banishing darkness and dealing radiant damage to your foes.

As an action, you present your holy symbol, and any magical darkness within 30 feet of you is dispelled. Additionally, each hostile creature within 30 feet of you must make a Constitution saving throw. A creature takes radiant damage equal to 2d10 + your cleric level on a failed saving throw, and half as much damage on a successful one. A creature that has total cover from you is not affected.', 1004, 10, 2),
('Improved Flare', 'You can also use your Warding Flare feature when a creature that you can see within 30 feet of you attacks a creature other than you.', 1004, 10, 6),
('Potent Spellcasting', 'You add your Wisdom modifier to the damage you deal with any cleric cantrip.', 1004, 10, 8),
('Corona of Light', 'You can use your action to activate an aura of sunlight that lasts for 1 minute or until you dismiss it using another action. You emit bright light in a 60-foot radius and dim light 30 feet beyond that. Your enemies in the bright light have disadvantage on saving throws against any spell that deals fire or radiant damage.', 1004, 10, 17),


('Nature Domain Spells', 'You gain Animal Friendship and Speak with Animals as domain spells', 1004, 11, 1),
('Nature Domain Spells', 'You gain Barkskin and Spike Growth as domain spells', 1004, 11, 3),
('Nature Domain Spells', 'You gain Plant Growth and Wind Wall as domain spells', 1004, 11, 5),
('Nature Domain Spells', 'You gain Dominate Beast and Grasping Vine as domain spells', 1004, 11, 7),
('Nature Domain Spells', 'You gain Insect Plague and Tree Stride as domain spells', 1004, 11, 9),
('Acolyte of Nature', 'You learn one cantrip of your choice from the druid spell list. You also gain proficiency in one of the following skills of your choice: Animal Handling, Nature, or Survival.', 1004, 11, 1),
('Bonus Proficiency', 'You gain proficiency with heavy armor.', 1004, 11, 1),
('Channel Divinity: Charm Animals and Plants', 'You can use your Channel Divinity to charm animals and plants.

As an action, you present your holy symbol and invoke the name of your deity. Each beast or plant creature that can see you within 30 feet of you must make a Wisdom saving throw. If the creature fails its saving throw, it is charmed by you for 1 minute or until it takes damage. While it is charmed by you, it is friendly to you and other creatures you designate.', 1004, 11, 2),
('Dampen Elements', 'When you or a creature within 30 feet of you takes acid, cold, fire, lightning, or thunder damage, you can use your reaction to grant resistance to the creature against that instance of the damage.', 1004, 11, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 cold, fire, or lightning damage (your choice) to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 11, 8),
('Master of Nature', 'You gain the ability to command animals and plant creatures. While creatures are charmed by your Charm Animals and Plants feature, you can take a bonus action on your turn to verbally command what each of those creatures will do on its next turn.', 1004, 11, 17),
('Tempest Domain Spells', 'You gain Fog Cloud and Thunderwave as domain spells.', 1004, 12, 1),
('Tempest Domain Spells', 'You gain Gust of Wind and Shatter as domain spells.', 1004, 12, 3),
('Tempest Domain Spells', 'You gain Call Lightning and Sleet Storm as domain spells.', 1004, 12, 5),
('Tempest Domain Spells', 'You gain Control Water and Ice Storm as domain spells.', 1004, 12, 7),
('Tempest Domain Spells', 'You gain Destructive Wave and Insect Plague as domain spells.', 1004, 12, 9),
('Bonus Proficiencies', 'You gain proficiency with martial weapons and heavy armor.', 1004, 12,1 ),
('Wrath of the Storm', 'You can thunderously rebuke attackers. When a creature within 5 feet of you that you can see hits you with an attack, you can use your reaction to cause the creature to make a Dexterity saving throw. The creature takes 2d8 lightning or thunder damage (your choice) on a failed saving throw, and half as much damage on a successful one.

You can use this feature a number of times equal to your Wisdom modifier (a minimum of once). You regain all expended uses when you finish a long rest.', 1004, 12, 1 ),
('Channel Divinity: Destructive Wrath', 'You can use your Channel Divinity to wield the power of the storm with unchecked ferocity.

When you roll lightning or thunder damage, you can use your Channel Divinity to deal maximum damage, instead of rolling.', 1004, 12, 2),
('Thunderous Strike', 'When you deal lightning damage to a Large or smaller creature, you can also push it up to 10 feet away from you.', 1004, 12, 6 ),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 thunder damage to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 12, 8 ),
('Stormborn', 'You have a flying speed equal to your current walking speed whenever you are not underground or indoors.', 1004, 12, 17),


('Trickery domain spells', 'You gain Charm Person and Disguise Self as domain spells.', 1004, 13, 1),
('Trickery domain spells', 'You gain Mirror Image and Pass without Trace as domain spells.', 1004, 13, 3),
('Trickery domain spells', 'You gain Blink and Disple Magic as domain spells.', 1004, 13, 5),
('Trickery domain spells', 'You gain Dimension Door and Polymorph as domain spells.', 1004, 13, 7),
('Trickery domain spells', 'You gain Dominate Person and Modify Memory as domain spells.', 1004, 13, 9),
('Blessing of the Trickster', 'You can use your action to touch a willing creature other than yourself to give it advantage on Dexterity (Stealth) checks. This blessing lasts for 1 hour or until you use this feature again.', 1004, 13, 1),
('Channel Divinity: Invoke Duplicity', 'You can use your Channel Divinity to create an illusory duplicate of yourself.

As an action, you create a perfect illusion of yourself that lasts for 1 minute, or until you lose your concentration (as if you were concentrating on a spell). The illusion appears in an unoccupied space that you can see within 30 feet of you. As a bonus action on your turn, you can move the illusion up to 30 feet to a space you can see, but it must remain within 120 feet of you.

For the duration, you can cast spells as though you were in the illusion''s space, but you must use your own senses. Additionally, when both you and your illusion are within 5 feet of a creature that can see the illusion, you have advantage on attack rolls against that creature, given how distracting the illusion is to the target.', 1004, 13, 2),
('Channel Divinity: Cloak of Shadows', 'You can use your Channel Divinity to vanish.

As an action, you become invisible until the end of your next turn. You become visible if you attack or cast a spell.', 1004, 13, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with poison – a gift from your deity. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 poison damage to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 13, 8),
('Improved Duplicity', 'You can create up to four duplicates of yourself, instead of one, when you use Invoke Duplicity. As a bonus action on your turn, you can move any number of them up to 30 feet, to a maximum range of 120 feet.', 1004, 13,17 ),

('War domain spells', 'You gain Divine Favor and Shield of Faith as domain spells.', 1004, 14, 1),
('War domain spells', 'You gain Magic Weapon and Spiritual Weapon as domain spells.', 1004, 14, 3),
('War domain spells', 'You gain Crusader''s Mantle and Spirit Guardians as domain spells.', 1004, 14, 5),
('War domain spells', 'You gain Freedom of Movement and Stoneskin as domain spells.', 1004, 14, 7),
('War domain spells', 'You gain Flame Strike and Hold Monster as domain spells.', 1004, 14, 9),
('Bonus Proficiency', 'You gain proficiency with martial weapons and heavy armor.', 1004, 14, 1 ),
('War Priest', 'Your god delivers bolts of inspiration to you while you are engaged in battle. When you use the Attack action, you can make one weapon attack as a bonus action.

You can use this feature a number of times equal to your Wisdom modifier (a minimum of once). You regain all expended uses when you finish a long rest.', 1004, 14, 1),
('Channel Divinity: Guided Strike', 'You can use your Channel Divinity to strike with supernatural accuracy. When you make an attack roll, you can use your Channel Divinity to gain a +10 bonus to the roll. You make this choice after you see the roll, but before the DM says whether the attack hits or misses.', 1004, 14, 2),
('Channel Divinity: War God''s Blessing', 'When a creature within 30 feet of you makes an attack roll, you can use your reaction to grant that creature a +10 bonus to the roll, using your Channel Divinity. You make this choice after you see the roll, but before the DM says whether the attack hits or misses.', 1004, 14, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 damage of the same type dealt by the weapon to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 14, 8),
('Avatar of Battle', 'You gain resistance to bludgeoning, piercing, and slashing damage from nonmagical weapons.', 1004, 14, 17)


INSERT INTO SubClass (subClassName, classID, description)
VALUES
('Knowledge Domain', 1004, 'The gods of knowledge – including Oghma, Boccob, Gilean, Aureon, and Thoth – value learning and understanding above all. Some teach that knowledge is to be gathered and shared in libraries and universities, or promote the practical knowledge of craft and invention. Some deities hoard knowledge and keep its secrets to themselves. And some promise their followers that they will gain tremendous power if they unlock the secrets of the multiverse. Followers of these gods study esoteric lore, collect old tomes, delve into the secret places of the earth, and learn all they can. Some gods of knowledge promote the practical knowledge of craft and invention, including smith deities like Gond, Reorx, Onatar, Moradin, Hephaestus, and Goibhniu.'),
('Life Domain', 1004, 'The Life domain focuses on the vibrant positive energy – one of the fundamental forces of the universe – that sustains all life. The gods of life promote vitality and health through healing the sick and wounded, caring for those in need, and driving away the forces of death and undeath. Almost any non-evil deity can claim influence over this domain, particularly agricultural deities (such as Chauntea, Arawai, and Demeter), sun gods (such as Lathander, Pelor, and Re-Horakhty), gods of healing or endurance (such as Ilmater, Mishakal, Apollo, and Diancecht), and gods of home and community (such as Hestia, Hathor, and Boldrci).'),
('Light Domain', 1004, 'Gods of light – including Helm, Lathander, Pholtus, Branchala, the Silver Flame, Belenus, Apollo, and Re-Horakhty – promote the ideals of rebirth and renewal, truth, vigilance, and beauty, often using the symbol of the sun. Some of these gods are portrayed as the sun itself or as a charioteer who guides the sun across the sky. Others are tireless sentinels whose eyes pierce every shadow and see through every deception. Some are deities of beauty and artistry, who teach that art is a vehicle for the soul''s improvement. Clerics of a god of light are enlightened souls infused with radiance and the power of their gods'' discerning vision, charged with chasing away lies and burning away darkness.'),
('Nature Domain', 1004, 'Gods of nature are as varied as the natural world itself; from inscrutable gods of the deep forests (such as Silvanus, Obad-Hai, Chislev, Balinor, and Pan) to friendly deities associated with particular springs and groves (such as Eldath). Druids revere nature as a whole and might serve one of these deities, practicing mysterious rites and reciting all-but-forgotten prayers in their own secret tongue. But many of these gods have clerics as well, champions who take a more active role in advancing the interests of a particular nature god. These clerics might hunt the evil monstrosities that despoil the woodlands, bless the harvest of the faithful, or wither the crops of those who anger their gods.'),
('Tempest Domain', 1004, 'Gods whose portfolios include the Tempest domain – including Talos, Umberlee, Kord, Zeboim, the Devourer, Zeus, and Thor – govern storms, sea, and, sky. They include gods of lightning and thunder, gods of earthquakes, some fire gods, and certain gods of violence, physical strength, and courage. In some pantheons, a god of this domain rules over other deities and is known for swift justice delivered by thunderbolts. In the pantheons of seafaring people, gods of this domain are ocean deities and the patrons of sailors. Tempest gods send their clerics to inspire fear in the common folk, either to keep those folk on the path of righteousness or to encourage them to offer sacrifices of propitiation to ward off divine wrath.'),
('Trickery Domain', 1004, 'Gods of trickery – such as Tymora, Beshaba, Olidammara, the Traveler, Garl Glittergold, and Loki – are mischief-makers and instigators who stand as a constant challenge to the accepted order among both gods and mortals. They''re patrons of thieves, scoundrels, gamblers, rebels, and liberators. Their clerics are a disruptive force in the world, puncturing pride, mocking tyrants, stealing from the rich, freeing captives, and flouting hollow traditions. They prefer subterfuge, pranks, deception, and theft rather than direct confrontation.'),
('War Domain', 1004, 'War has many manifestations. It can make heroes of ordinary people. It can be desperate and horrific, with acts of cruelty and cowardice eclipsing instances of excellence and courage. In either case, the gods of war watch over warriors and reward them for their great deeds. The clerics of such gods excel in battle, inspiring others to fight the good fight or offering acts of violence as prayers. Gods of war include champions of honor and chivalry (such as Torm, Heironeous, and Kiri-Jolith) as well as gods of destruction and pillage (such as Erythnul, the Fury, Gruumsh, and Ares) and gods of conquest and domination (such as Bane, Hextor, and Maglubiyet). Other war gods (such as Tempus, Nike, and Nuada) take a more neutral stance, promoting war in all its manifestations and supporting warriors in any circumstance.')


INSERT INTO ClassFeatures (classFeatureName, classFeatureDescription, classID, subClassID, levelEarned)
VALUES
('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its
 challenge rating is at or below 1/2 ', 1004, NULL, 5),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 1 ', 1004, NULL, 8),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 2 ', 1004, NULL, 11),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 3 ', 1004, NULL, 14),
 ('Destroy Undead', 'When an undead fails its saving throw against your Turn Undead feature, the creature is instantly destroyed if its challenge rating is at or below 4 ', 1004, NULL, 17),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can’t increase an ability score above 20 using this feature.

Using the optional feats rule, you can forgo taking this feature to take a feat of your choice instead.', 1004, NULL, 19),
('Channel Divinity: Turn Undead', 'You present your holy symbol and speak a prayer censuring the undead. Each undead that can see or hear you within 30 feet of you must make a Wisdom saving throw. If the creature fails its saving throw, it is turned for 1 minute or until it takes any damage.

A turned creature must spend its turns trying to move as far away from you as it can, and it can’t willingly move to a space within 30 feet of you. It also can’t take reactions. For its action, it can use only the Dash action or try to escape from an effect that prevents it from moving. If there’s nowhere to move, the creature can use the Dodge action.', 1004, NULL, 2),
('Channel Divinity', 'You gain the ability to channel divine energy directly from your deity, using that energy to fuel magical effects. You start with two such effects: Turn Undead and an effect determined by your domain. Some domains grant you additional effects as you advance in levels, as noted in the domain description.

When you use your Channel Divinity, you choose which effect to create. You must then finish a short or long rest to use your Channel Divinity again.

Some Channel Divinity effects require saving throws. When you use such an effect from this class, the DC equals your cleric spell save DC. When you finish a short or long rest, you regain your expended uses.', 1004, NULL, 2 ),
('Channel Divinity', 'You can use your Channel Divinity twice between rests. When you finish a short or long rest, you regain your expended uses.', 1004, NULL, 6),
('Channel Divinity', 'You can use your Channel Divinity three times between rests. When you finish a short or long rest, you regain your expended uses.', 1004, NULL, 18),


('Blessings of Knowledge', 'You learn two languages of your choice. You also become proficient in your choice of two of the following skills: Arcana, History, Nature, or Religion.

Your proficiency bonus is doubled for any ability check you make that uses either of those skills.', 1004, 8, 1),
('Channel Divinity: Knowledge of the Ages', 'You can use your Channel Divinity to tap into a divine well of knowledge. As an action, you choose one skill or tool. For 10 minutes, you have proficiency with the chosen skill or tool.', 1004, 8, 2),
('Channel Divinity: Read Thoughts', 'You can use your Channel Divinity to read a creature''s thoughts. You can then use your access to the creature''s mind to command it.

As an action, choose one creature that you can see within 60 feet of you. That creature must make a Wisdom saving throw. If the creature succeeds on the saving throw, you can''t use this feature on it again until you finish a long rest.

If the creature fails its save, you can read its surface thoughts (those foremost in its mind, reflecting its current emotions and what it is actively thinking about) when it is within 60 feet of you. This effect lasts for 1 minute.

During that time, you can use your action to end this effect and cast the Suggestion spell on the creature without expending a spell slot. The target automatically fails its saving throw against the spell.', 1004, 8, 6 ),
('Potent Spellcasting', 'You add your Wisdom modifier to the damage you deal with any cleric cantrip.', 1004, 8, 8),
('Visions of the Past', 'You can call up visions of the past that relate to an object you hold or your immediate surroundings. You spend at least 1 minute in meditation and prayer, then receive dreamlike, shadowy glimpses of recent events. You can meditate in this way for a number of minutes equal to your Wisdom score and must maintain concentration during that time, as if you were casting a spell.

Once you use this feature, you can''t use it again until you finish a short or long rest.

Object Reading. Holding an object as you meditate, you can see visions of the object''s previous owner. After meditating for 1 minute, you learn how the owner acquired and lost the object, as well as the most recent significant event involving the object and that owner. If the object was owned by another creature in the recent past (within a number of days equal to your Wisdom score), you can spend 1 additional minute for each owner to learn the same information about that creature.

Area Reading. As you meditate, you see visions of recent events in your immediate vicinity (a room, street, tunnel, clearing, or the like, up to a 50-foot cube), going back a number of days equal to your Wisdom score. For each minute you meditate, you learn about one significant event, beginning with the most recent. Significant events typically involve powerful emotions, such as battles and betrayals, marriages and murders, births and funerals. However, they might also include more mundane events that are nevertheless important in your current situation.', 1004, 8, 17 ),
('Knowledge Domain Spells', 'You gain Command and Identify as domain spells', 1004, 8, 1),
('Knowledge Domain Spells', 'You gain Augury and Suggestion as domain spells', 1004, 8, 3),
('Knowledge Domain Spells', 'You gain Nondetection and Speak with Dead as domain spells', 1004, 8, 5),
('Knowledge Domain Spells', 'You gain Arcane Eye and Confusion as domain spells', 1004, 8, 7),
('Knowledge Domain Spells', 'You gain Legend Lore and Scrying as domain spells', 1004, 8, 9),
('Life Domain Spells', 'You gain Bless and Cure Wounds as domain spells', 1004, 9, 1),
('Life Domain Spells', 'You gain Lesser Restoration and Spiritual Weapon as domain spells', 1004, 9, 3),
('Life Domain Spells', 'You gain Beacon of Hope and Revivify as domain spells', 1004, 9, 5),
('Life Domain Spells', 'You gain Death Ward and Guardian of Faith as domain spells', 1004, 9, 7),
('Life Domain Spells', 'You gain Mass Cure Wounds and Raise Dead as domain spells', 1004, 9, 9),
('Bonus Proficiency', 'You gain proficiency with heavy armor.', 1004, 9, 1),
('Disciple of Life', 'Your healing spells are more effective. Whenever you use a spell of 1st level or higher to restore hit points to a creature, the creature regains additional hit points equal to 2 + the spell''s level.', 1004, 9, 1),
('Channel Divinity: Preserve Life', 'You can use your Channel Divinity to heal the badly injured.

As an action, you present your holy symbol and evoke healing energy that can restore a number of hit points equal to five times your cleric level. Choose any creatures within 30 feet of you, and divide those hit points among them. This feature can restore a creature to no more than half of its hit point maximum. You can''t use this feature on an undead or a construct.', 1004, 9, 2 ),
('Blessed Healer', 'The healing spells you cast on others heal you as well. When you cast a spell of 1st level or higher that restores hit points to a creature other than you, you regain hit points equal to 2 + the spell''s level.', 1004, 9, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 radiant damage to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 9, 8),
('Supreme Healing', 'When you would normally roll one or more dice to restore hit points with a spell, you instead use the highest number possible for each die. For example, instead of restoring 2d6 hit points to a creature, you restore 12.', 1004, 9, 17),

('Light Domain Spells', 'You gain Burning Hands and Faerie Fire as domain spells', 1004, 10, 1),
('Light Domain Spells', 'You gain Flaming Sphere and Scorching Ray as domain spells', 1004, 10, 3),
('Light Domain Spells', 'You gain Daylight and Fireball as domain spells', 1004, 10, 5),
('Light Domain Spells', 'You gain Guardian of Faith and Wall of Fire as domain spells', 1004, 10, 7),
('Light Domain Spells', 'You gain Flame Strike and Scrying as domain spells', 1004, 10, 9),
('Bonus Cantrip', 'You gain the Light cantrip if you don''t already know it.', 1004, 10, 1),
('Warding Flare', 'You can interpose divine light between yourself and an attacking enemy. When you are attacked by a creature within 30 feet of you that you can see, you can use your reaction to impose disadvantage on the attack roll, causing light to flare before the attacker before it hits or misses. An attacker that can''t be blinded is immune to this feature.

You can use this feature a number of times equal to your Wisdom modifier (a minimum of once). You regain all expended uses when you finish a long rest.', 1004, 10, 1),
('Channel Divinity: Radiance of the Dawn', 'You can use your Channel Divinity to harness sunlight, banishing darkness and dealing radiant damage to your foes.

As an action, you present your holy symbol, and any magical darkness within 30 feet of you is dispelled. Additionally, each hostile creature within 30 feet of you must make a Constitution saving throw. A creature takes radiant damage equal to 2d10 + your cleric level on a failed saving throw, and half as much damage on a successful one. A creature that has total cover from you is not affected.', 1004, 10, 2),
('Improved Flare', 'You can also use your Warding Flare feature when a creature that you can see within 30 feet of you attacks a creature other than you.', 1004, 10, 6),
('Potent Spellcasting', 'You add your Wisdom modifier to the damage you deal with any cleric cantrip.', 1004, 10, 8),
('Corona of Light', 'You can use your action to activate an aura of sunlight that lasts for 1 minute or until you dismiss it using another action. You emit bright light in a 60-foot radius and dim light 30 feet beyond that. Your enemies in the bright light have disadvantage on saving throws against any spell that deals fire or radiant damage.', 1004, 10, 17),


('Nature Domain Spells', 'You gain Animal Friendship and Speak with Animals as domain spells', 1004, 11, 1),
('Nature Domain Spells', 'You gain Barkskin and Spike Growth as domain spells', 1004, 11, 3),
('Nature Domain Spells', 'You gain Plant Growth and Wind Wall as domain spells', 1004, 11, 5),
('Nature Domain Spells', 'You gain Dominate Beast and Grasping Vine as domain spells', 1004, 11, 7),
('Nature Domain Spells', 'You gain Insect Plague and Tree Stride as domain spells', 1004, 11, 9),
('Acolyte of Nature', 'You learn one cantrip of your choice from the druid spell list. You also gain proficiency in one of the following skills of your choice: Animal Handling, Nature, or Survival.', 1004, 11, 1),
('Bonus Proficiency', 'You gain proficiency with heavy armor.', 1004, 11, 1),
('Channel Divinity: Charm Animals and Plants', 'You can use your Channel Divinity to charm animals and plants.

As an action, you present your holy symbol and invoke the name of your deity. Each beast or plant creature that can see you within 30 feet of you must make a Wisdom saving throw. If the creature fails its saving throw, it is charmed by you for 1 minute or until it takes damage. While it is charmed by you, it is friendly to you and other creatures you designate.', 1004, 11, 2),
('Dampen Elements', 'When you or a creature within 30 feet of you takes acid, cold, fire, lightning, or thunder damage, you can use your reaction to grant resistance to the creature against that instance of the damage.', 1004, 11, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 cold, fire, or lightning damage (your choice) to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 11, 8),
('Master of Nature', 'You gain the ability to command animals and plant creatures. While creatures are charmed by your Charm Animals and Plants feature, you can take a bonus action on your turn to verbally command what each of those creatures will do on its next turn.', 1004, 11, 17),
('Tempest Domain Spells', 'You gain Fog Cloud and Thunderwave as domain spells.', 1004, 12, 1),
('Tempest Domain Spells', 'You gain Gust of Wind and Shatter as domain spells.', 1004, 12, 3),
('Tempest Domain Spells', 'You gain Call Lightning and Sleet Storm as domain spells.', 1004, 12, 5),
('Tempest Domain Spells', 'You gain Control Water and Ice Storm as domain spells.', 1004, 12, 7),
('Tempest Domain Spells', 'You gain Destructive Wave and Insect Plague as domain spells.', 1004, 12, 9),
('Bonus Proficiencies', 'You gain proficiency with martial weapons and heavy armor.', 1004, 12,1 ),
('Wrath of the Storm', 'You can thunderously rebuke attackers. When a creature within 5 feet of you that you can see hits you with an attack, you can use your reaction to cause the creature to make a Dexterity saving throw. The creature takes 2d8 lightning or thunder damage (your choice) on a failed saving throw, and half as much damage on a successful one.

You can use this feature a number of times equal to your Wisdom modifier (a minimum of once). You regain all expended uses when you finish a long rest.', 1004, 12, 1 ),
('Channel Divinity: Destructive Wrath', 'You can use your Channel Divinity to wield the power of the storm with unchecked ferocity.

When you roll lightning or thunder damage, you can use your Channel Divinity to deal maximum damage, instead of rolling.', 1004, 12, 2),
('Thunderous Strike', 'When you deal lightning damage to a Large or smaller creature, you can also push it up to 10 feet away from you.', 1004, 12, 6 ),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 thunder damage to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 12, 8 ),
('Stormborn', 'You have a flying speed equal to your current walking speed whenever you are not underground or indoors.', 1004, 12, 17),


('Trickery domain spells', 'You gain Charm Person and Disguise Self as domain spells.', 1004, 13, 1),
('Trickery domain spells', 'You gain Mirror Image and Pass without Trace as domain spells.', 1004, 13, 3),
('Trickery domain spells', 'You gain Blink and Disple Magic as domain spells.', 1004, 13, 5),
('Trickery domain spells', 'You gain Dimension Door and Polymorph as domain spells.', 1004, 13, 7),
('Trickery domain spells', 'You gain Dominate Person and Modify Memory as domain spells.', 1004, 13, 9),
('Blessing of the Trickster', 'You can use your action to touch a willing creature other than yourself to give it advantage on Dexterity (Stealth) checks. This blessing lasts for 1 hour or until you use this feature again.', 1004, 13, 1),
('Channel Divinity: Invoke Duplicity', 'You can use your Channel Divinity to create an illusory duplicate of yourself.

As an action, you create a perfect illusion of yourself that lasts for 1 minute, or until you lose your concentration (as if you were concentrating on a spell). The illusion appears in an unoccupied space that you can see within 30 feet of you. As a bonus action on your turn, you can move the illusion up to 30 feet to a space you can see, but it must remain within 120 feet of you.

For the duration, you can cast spells as though you were in the illusion''s space, but you must use your own senses. Additionally, when both you and your illusion are within 5 feet of a creature that can see the illusion, you have advantage on attack rolls against that creature, given how distracting the illusion is to the target.', 1004, 13, 2),
('Channel Divinity: Cloak of Shadows', 'You can use your Channel Divinity to vanish.

As an action, you become invisible until the end of your next turn. You become visible if you attack or cast a spell.', 1004, 13, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with poison – a gift from your deity. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 poison damage to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 13, 8),
('Improved Duplicity', 'You can create up to four duplicates of yourself, instead of one, when you use Invoke Duplicity. As a bonus action on your turn, you can move any number of them up to 30 feet, to a maximum range of 120 feet.', 1004, 13,17 ),

('War domain spells', 'You gain Divine Favor and Shield of Faith as domain spells.', 1004, 14, 1),
('War domain spells', 'You gain Magic Weapon and Spiritual Weapon as domain spells.', 1004, 14, 3),
('War domain spells', 'You gain Crusader''s Mantle and Spirit Guardians as domain spells.', 1004, 14, 5),
('War domain spells', 'You gain Freedom of Movement and Stoneskin as domain spells.', 1004, 14, 7),
('War domain spells', 'You gain Flame Strike and Hold Monster as domain spells.', 1004, 14, 9),
('Bonus Proficiency', 'You gain proficiency with martial weapons and heavy armor.', 1004, 14, 1 ),
('War Priest', 'Your god delivers bolts of inspiration to you while you are engaged in battle. When you use the Attack action, you can make one weapon attack as a bonus action.

You can use this feature a number of times equal to your Wisdom modifier (a minimum of once). You regain all expended uses when you finish a long rest.', 1004, 14, 1),
('Channel Divinity: Guided Strike', 'You can use your Channel Divinity to strike with supernatural accuracy. When you make an attack roll, you can use your Channel Divinity to gain a +10 bonus to the roll. You make this choice after you see the roll, but before the DM says whether the attack hits or misses.', 1004, 14, 2),
('Channel Divinity: War God''s Blessing', 'When a creature within 30 feet of you makes an attack roll, you can use your reaction to grant that creature a +10 bonus to the roll, using your Channel Divinity. You make this choice after you see the roll, but before the DM says whether the attack hits or misses.', 1004, 14, 6),
('Divine Strike', 'You gain the ability to infuse your weapon strikes with divine energy. Once on each of your turns when you hit a creature with a weapon attack, you can cause the attack to deal an extra 1d8 damage of the same type dealt by the weapon to the target. When you reach 14th level, the extra damage increases to 2d8.', 1004, 14, 8),
('Avatar of Battle', 'You gain resistance to bludgeoning, piercing, and slashing damage from nonmagical weapons.', 1004, 14, 17)

4:15
INSERT INTO SubClass (subClassName, classID, description)
VALUES
('Circle of the Land', 1005, 'The Circle of the Land is made up of mystics and sages who safeguard ancient knowledge and rites through a vast oral tradition. These druids meet within sacred circles of trees or standing stones to whisper primal secrets in Druidic. The circle’s wisest members preside as the chief priests of communities that hold to the Old Faith and serve as advisors to the rulers of those folk. As a member of this circle, your magic is influenced by the land where you were initiated into the circle’s mysterious rites.'),
('Circle of the Moon', 1005, 'Druids of the Circle of the Moon are fierce guardians of the wilds. Their order gathers under the full moon to share news and trade warnings. They haunt the deepest parts of the wilderness, where they might go for weeks on end before crossing paths with another humanoid creature, let alone another druid.

Changeable as the moon, a druid of this circle might prowl as a great cat one night, soar over the treetops as an eagle the next day, and crash through the undergrowth in bear form to drive off a trespassing monster. The wild is in the druid''s blood.');



INSERT INTO ClassFeatures (classFeatureName, classFeatureDescription, classID, subClassID, levelEarned)
VALUES
('Druidic', 'You know Druidic, the secret language of druids. You can speak the language and use it to leave hidden messages. You and others who know this language automatically spot such a message. Others spot the message''s presence with a successful DC 15 Wisdom (Perception) check but can''t decipher it without magic.', 1005, NULL, 1),
('Wild Shape', 'You can use your action to magically assume the shape of a beast that you have seen before. You can use this feature twice. You regain expended uses when you finish a short or long rest.

Your druid level determines the beasts you can transform into, as shown in the Beast Shapes table. ', 1005, NULL, 2),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1005, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1005, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1005, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1005, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1005, NULL, 19),
('Timeless Body', 'The primal magic that you wield causes you to age more slowly. For every 10 years that pass, your body ages only 1 year.', 1005, NULL , 18),
('Beast Spells', 'You can cast many of your druid spells in any shape you assume using Wild Shape. You can perform the somatic and verbal components of a druid spell while in a beast shape, but you aren''t able to provide material components.', 1005, NULL, 18),
('Archdruid', 'You can use your Wild Shape an unlimited number of times.

Additionally, you can ignore the verbal and somatic components of your druid spells, as well as any material components that lack a cost and aren''t consumed by a spell. You gain this benefit in both your normal shape and your beast shape from Wild Shape.', 1005,NULL, 20),
('Bonus Cantrip', 'You learn one additional druid cantrip of your choice.', 1005, 15, 2),
('Natural Recovery', 'You can regain some of your magical energy by sitting in meditation and communing with nature. During a short rest, you choose expended spell slots to recover. The spell slots can have a combined level that is equal to or less than half your druid level (rounded up), and none of the slots can be 6th level or higher. You can''t use this feature again until you finish a long rest.

For example, when you are a 4th-level druid, you can recover up to two levels worth of spell slots. You can recover either a 2nd-level slot or two 1st-level slots.', 1005, 15, 2),
('Land''s Stride', 'Moving through nonmagical difficult terrain costs you no extra movement. You can also pass through nonmagical plants without being slowed by them and without taking damage from them if they have thorns, spines, or a similar hazard.

In addition, you have advantage on saving throws against plants that are magically created or manipulated to impede movement, such as those created by the Entangle spell.', 1005, 15, 6),
('Nature''s Ward', 'You can''t be charmed or frightened by elementals or fey, and you are immune to poison and disease.', 1005, 15, 10),
('Nature''s Sanctuary', 'Creatures of the natural world sense your connection to nature and become hesitant to attack you. When a beast or plant creature attacks you, that creature must make a Wisdom saving throw against your druid spell save DC. On a failed save, the creature must choose a different target, or the attack automatically misses. On a successful save, the creature is immune to this effect for 24 hours.

The creature is aware of this effect before it makes its attack against you.', 1005, 15, 14),


('Combat Wild Shape', 'You gain the ability to use Wild Shape on your turn as a bonus action, rather than as an action.

Additionally, while you are transformed by Wild Shape, you can use a bonus action to expend one spell slot to regain 1d8 hit points per level of the spell slot expended.', 1005, 16, 2 ),
('Circle Forms', 'The rites of your circle grant you the ability to transform into more dangerous animal forms. Starting at 2nd level, you can use your Wild Shape to transform into a beast with a challenge rating as high as 1. You ignore the Max. CR column of the Beast Shapes table, but must abide by the other limitations there.', 1005, 16, 2),
('Circle Forms', 'You can transform into a beast with a challenge rating as high as your druid level divided by 3, rounded down.', 1005, 16, 6),
('Primal Strike', 'Your attacks in beast form count as magical for the purpose of overcoming resistance and immunity to nonmagical attacks and damage.', 1005, 16, 6 ),
('Elemental Wild Shape', 'You can expend two uses of Wild Shape at the same time to transform into an air elemental, an earth elemental, a fire elemental, or a water elemental.', 1005, 16, 10),
('Thousand Forms', 'You have learned to use magic to alter your physical form in more subtle ways. You can cast the Alter Self spell at will.', 1005, 16, 14)


INSERT INTO SubClass (subClassName, classID, description)
VALUES
('Way of the Four Elements', 1007,'You follow a monastic tradition that teaches you to harness the elements. When you focus your ki, you can align yourself with the forces of creation and bend the four elements to your will, using them as an extension of your body. Some members of this tradition dedicate themselves to a single element, but others weave the elements together.

Many monks of this tradition tattoo their bodies with representations of their ki powers, commonly imagined as coiling dragons, but also as phoenixes, fish, plants, mountains, and cresting waves.'),
('Way of the Open Hand', 1007,'Monks of the Way of the Open Hand are the ultimate masters of martial arts combat, whether armed or unarmed. They learn techniques to push and trip their opponents, manipulate ki to heal damage to their bodies, and practice advanced meditation that can protect them from harm.'),
('Way of the Shadow', 1007,'Monks of the Way of Shadow follow a tradition that values stealth and subterfuge. These monks might be called ninjas or shadowdancers, and they serve as spies and assassins. Sometimes the members of a ninja monastery are family members, forming a clan sworn to secrecy about their arts and missions. Other monasteries are more like thieves'' guilds, hiring out their services to nobles, rich merchants, or anyone else who can pay their fees. Regardless of their methods, the heads of these monasteries expect the unquestioning obedience of their students.'),

('Oath of the Ancients', 1008,'The Oath of the Ancients is as old as the race of elves and the rituals of the druids. Sometimes called fey knights, green knights, or horned knights, paladins who swear this oath cast their lot with the side of the light in the cosmic struggle against darkness because they love the beautiful and life-giving things of the world, not necessarily because they believe in principles of honor, courage, and justice. They adorn their armor and clothing with images of growing things-leaves, antlers, or flowers-to reflect their commitment to preserving life and light in the world.'),
('Oath of Devotion', 1008,'The Oath of Devotion binds a paladin to the loftiest ideals of justice, virtue, and order. Sometimes called cavaliers, white knights, or holy warriors, these paladins meet the ideal of the knight in shining armor, acting with honor in pursuit of justice and the greater good. They hold themselves to the highest standards of conduct, and some, for better or worse, hold the rest of the world to the same standards. Many who swear this oath are devoted to gods of law and good and use their gods'' tenets as the measure of their devotion. They hold angels – the perfect servants of good – as their ideals, and incorporate images of angelic wings into their helmets or coats of arms.'),
('Oath of Vengeance', 1008,'The Oath of Vengeance is a solemn commitment to punish those who have committed a grievous sin. When evil forces slaughter helpless villagers, when an entire people turns against the will of the gods, when a thieves'' guild grows too violent and powerful, when a dragon rampages through the countryside – at times like these, paladins arise and swear an Oath of Vengeance to set right that which has gone wrong. To these paladins – sometimes called avengers or dark knights – their own purity is not as important as delivering justice.'),

('Beast Master Conclave', 1009,'The Beast Master archetype embodies a friendship between the civilized races and the beasts of the world. United in focus, beast and ranger work as one to fight the monstrous foes that threaten civilization and the wilderness alike. Emulating the Beast Master archetype means committing yourself to this ideal, working in partnership with an animal as its companion and friend.'),
('Hunter Conclave', 1009,'Some rangers seek to master weapons to better protect civilization from the terrors of the wilderness. Members of the Hunter Conclave learn specialized fighting techniques for use against the most dire threats, from rampaging ogres and hordes of orcs to towering giants and terrifying dragons.'),

('Arcane Trickster', 1010,'Some rogues enhance their fine-honed skills of stealth and agility with magic, learning tricks of enchantment and illusion. These rogues include pickpockets and burglars, but also pranksters, mischief-makers, and a significant number of adventurers.'),
('Assassin', 1010,'You focus your training on the grim art of death. Those who adhere to this archetype are diverse: hired killers, spies, bounty hunters, and even specially anointed priests trained to exterminate the enemies of their deity. Stealth, poison, and disguise help you eliminate your foes with deadly efficiency.'),
('Thief', 1010,'You hone your skills in the larcenous arts. Burglars, bandits, cutpurses, and other criminals typically follow this archetype, but so do rogues who prefer to think of themselves as professional treasure seekers, explorers, delvers, and investigators. In addition to improving your agility and stealth, you learn skills useful for delving into ancient ruins, reading unfamiliar languages, and using magic items you normally couldn''t employ.'),

('Draconic Bloodline', 1011,'Your innate magic comes from draconic magic that was mingled with your blood or that of your ancestors. Most often, sorcerers with this origin trace their descent back to a mighty sorcerer of ancient times who made a bargain with a dragon or who might even have claimed a dragon parent. Some of these bloodlines are well established in the world, but most are obscure. Any given sorcerer could be the first of a new bloodline, as a result of a pact or some other exceptional circumstance.'),
('Wild Magic', 1011,'Your innate magic comes from the wild forces of chaos that underlie the order of creation. You might have endured exposure to some form of raw magic, perhaps through a planar portal leading to Limbo, the Elemental Planes, or the mysterious Far Realm. Perhaps you were blessed by a powerful fey creature or marked by a demon. Or your magic could be a fluke of your birth, with no apparent cause or reason. However it came to be, this chaotic magic churns within you, waiting for any outlet.'),

('Archfey', 1012,'Your patron is a lord or lady of the fey, a creature of legend who holds secrets that were forgotten before the mortal races were born. This being''s motivations are often inscrutable, and sometimes whimsical, and might involve a striving for greater magical power or the settling of age-old grudges. Beings of this sort include the Prince of Frost; the Queen of Air and Darkness, ruler of the Gloaming Court; Titania of the Summer Court; her consort Oberon, the Green Lord; Hyrsam, the Prince of Fools; and ancient hags.'),
('Fiend', 1012,'You have made a pact with a fiend from the lower planes of existence, a being whose aims are evil, even if you strive against those aims. Such beings desire the corruption or destruction of all things, ultimately including you. Fiends powerful enough to forge a pact include demon lords such as Demogorgon, Orcus, Fraz''Urb-luu, and Baphomet; archdevils such as Asmodeus, Dispater, Mephistopheles, and Belial; pit fiends and balors that are especially mighty; and ultroloths and other lords of the yugoloths.'),
('Great Old One', 1012,'Your patron is a mysterious entity whose nature is utterly foreign to the fabric of reality. It might come from the Far Realm, the space beyond reality, or it could be one of the elder gods known only in legends. Its motives are incomprehensible to mortals, and its knowledge so immense and ancient that even the greatest libraries pale in comparison to the vast secrets it holds. The Great Old One might be unaware of your existence or entirely indifferent to you, but the secrets you have learned allow you to draw your magic from it.'),

('School of Conjuration', 1013,'As a conjurer, you favor spells that produce objects and creatures out of thin air. You can conjure billowing clouds of killing fog or summon creatures from elsewhere to fight on your behalf. As your mastery grows, you learn spells of transportation and can teleport yourself across vast distances, even to other planes of existence, in an instant.'),
('School of Divination', 1013,'The counsel of a diviner is sought by royalty and commoners alike, for all seek a clearer understanding of the past, present, and future. As a diviner, you strive to part the veils of space, time, and consciousness so that you can see clearly. You work to master spells of discernment, remote viewing, supernatural knowledge, and foresight.')


INSERT INTO ClassFeatures (classFeatureName, classFeatureDescription, classID, subClassID, levelEarned)
VALUES
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1007, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1007, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1007, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1007, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1007, NULL, 19),
('Deflect Missiles', 'Starting at 3rd level, you can use your reaction to deflect or catch the missile when you are hit by a ranged weapon attack. When you do so, the damage you take from the attack is reduced by 1d10 + your Dexterity modifier + your monk level.

If you reduce the damage to 0, you can catch the missile if it is small enough for you to hold in one hand and you have at least one hand free. If you catch a missile in this way, you can spend 1 ki point to make a ranged attack with a range of 20/60 using the weapon or piece of ammunition you just caught, as part of the same reaction. You make this attack with proficiency, regardless of your weapon proficiencies, and the missile counts as a monk weapon for the attack.', 1007, NULL, 3),
('Unarmored Movement', 'Starting at 2nd level, your speed increases by 10 feet while you are not wearing armor or wielding a shield. This bonus increases when you reach certain monk levels, as shown in the Monk table.

At 9th level, you gain the ability to move along vertical surfaces and across liquids on your turn without falling during the move.',1007 , NULL,2 ),
('Ki', 'Starting at 2nd level, your training allows you to harness the mystic energy of ki. Your access to this energy is represented by a number of ki points. Your monk level determines the number of points you have, as shown in the Ki Points column of the Monk table.

You can spend these points to fuel various ki features. You start knowing three such features: Flurry of Blows, Patient Defense, and Step of the Wind. You learn more ki features as you gain levels in this class.

When you spend a ki point, it is unavailable until you finish a short or long rest, at the end of which you draw all of your expended ki back into yourself. You must spend at least 30 minutes of the rest meditating to regain your ki points.

Some of your ki features require your target to make a saving throw to resist the feature''s effects. The saving throw DC is calculated as follows:

Ki save DC = 8 + your proficiency bonus + your Wisdom modifier

Flurry of Blows. Immediately after you take the Attack action on your turn, you can spend 1 ki point to make two unarmed strikes as a bonus action.
Patient Defense. You can spend 1 ki point to take the Dodge action as a bonus action on your turn.
Step of the Wind. You can spend 1 ki point to take the Disengage or Dash action as a bonus action on your turn, and your jump distance is doubled for the turn.',1007 ,NULL , 2),
('Martial Arts', 'At 1st level, your practice of martial arts gives you mastery of combat styles that use unarmed strikes and monk weapons, which are shortswords and any simple melee weapons that don''t have the two-handed or heavy property.

You gain the following benefits while you are unarmed or wielding only monk weapons and you aren''t wearing armor or wielding a shield:

You can use Dexterity instead of Strength for the attack and damage rolls of your unarmed strikes and monk weapons.
You can roll a d4 in place of the normal damage of your unarmed strike or monk weapon. This die changes as you gain monk levels, as shown in the Martial Arts column of the Monk table.
When you use the Attack action with an unarmed strike or a monk weapon on your turn, you can make one unarmed strike as a bonus action. For example, if you take the Attack action and attack with a quarterstaff, you can also make an unarmed strike as a bonus action, assuming you haven''t already taken a bonus action this turn.
Certain monasteries use specialized forms of the monk weapons. For example, you might use a club that is two lengths of wood connected by a short chain (called a nunchaku) or a sickle with a shorter, straighter blade (called a kama). Whatever name you use for a monk weapon, you can use the game statistics provided for the weapon on the Weapons page.

Ki',1007 , NULL, 1),
('Unarmored Defense', 'Beginning at 1st level, while you are wearing no armor and not wielding a shield, your AC equals 10 + your Dexterity modifier + your Wisdom modifier.',1007 , NULL, 1),
('Slow Fall', 'Beginning at 4th level, you can use your reaction when you fall to reduce any falling damage you take by an amount equal to five times your monk level.',1007 , NULL,4 ),
('Extra Attack', 'Beginning at 5th level, you can attack twice, instead of once, whenever you take the Attack action on your turn.', 1007 , NULL, 5),
('Stunning Strike', 'Starting at 5th level, you can interfere with the flow of ki in an opponent''s body. When you hit another creature with a melee weapon attack, you can spend 1 ki point to attempt a stunning strike. The target must succeed on a Constitution saving throw or be stunned until the end of your next turn.', 1007 , NULL, 5),
('Ki-Empowered Strikes', 'Starting at 6th level, your unarmed strikes count as magical for the purpose of overcoming resistance and immunity to nonmagical attacks and damage.', 1007 , NULL,6 ),
('Evasion', 'At 7th level, your instinctive agility lets you dodge out of the way of certain area effects, such as a blue dragon''s lightning breath or a fireball spell. When you are subjected to an effect that allows you to make a Dexterity saving throw to take only half damage, you instead take no damage if you succeed on the saving throw, and only half damage if you fail.', 1007 , NULL, 7),
('Stillness of Mind', 'Starting at 7th level, you can use your action to end one effect on yourself that is causing you to be charmed or frightened.', 1007 , NULL,7 ),
('Purity of Body', 'At 10th level, your mastery of the ki flowing through you makes you immune to disease and poison.', 1007 , NULL, 10),
('Tongue of the Sun and Moon', 'Starting at 13th level, you learn to touch the ki of other minds so that you understand all spoken languages. Moreover, any creature that can understand a language can understand what you say.', 1007 , NULL,13),
('Diamond Soul', 'Beginning at 14th level, your mastery of ki grants you proficiency in all saving throws.

Additionally, whenever you make a saving throw and fail, you can spend 1 ki point to reroll it and take the second result.', 1007 , NULL,14 ),
('Timeless Body', 'At 15th level, your ki sustains you so that you suffer none of the frailty of old age, and you can''t be aged magically. You can still die of old age, however. In addition, you no longer need food or water.', 1007 , NULL, 15),
('Empty Body', 'Beginning at 18th level, you can use your action to spend 4 ki points to become invisible for 1 minute. During that time, you also have resistance to all damage but force damage.

Additionally, you can spend 8 ki points to cast the Astral Projection spell, without needing material components. When you do so, you can''t take any other creatures with you.', 1007 , NULL, 18),
('Perfect Self', 'At 20th level, when you roll for initiative and have no ki points remaining, you regain 4 ki points.', 1007 , NULL, 20),
('Casting Elemental Spells', 'When you choose this tradition at 3rd level, you learn magical disciplines that harness the power of the four elements. A discipline requires you to spend ki points each time you use it.

You know the Elemental Attunement discipline and one other elemental discipline of your choice. You learn one additional elemental discipline of your choice at 6th, 11th, and 17th level.

Whenever you learn a new elemental discipline, you can also replace one elemental discipline that you already know with a different discipline.

Casting Elemental Spells. Some elemental disciplines allow you to cast spells. See chapter 10 for the general rules of spellcasting. To cast one of these spells, you use its casting time and other rules, but you don''t need to provide material components for it.

Once you reach 5th level in this class, you can spend additional ki points to increase the level of an elemental discipline spell that you cast, provided that the spell has an enhanced effect at a higher level, as Burning Hands does. The spell''s level increases by 1 for each additional ki point you spend. For example, if you are a 5th-level monk and use Sweeping Cinder Strike to cast Burning Hands, you can spend 3 ki points to cast it as a 2nd-level spell (the discipline''s base cost of 2 ki points plus 1).

The maximum number of ki points you can spend to cast a spell in this way (including its base ki point cost and any additional ki points you spend to increase its level) is determined by your monk level, as shown in the Spells and Ki Points table.',1007 , 17, 3),
('Ki points per spell', 'You can now spend 3 ki points per spell.',1007 , 17, 5),
('Ki points per spell', 'You can now spend 4 ki points per spell.',1007 , 17, 9),
('Ki points per spell', 'You can now spend 5 ki points per spell.',1007 , 17, 13),
('Ki points per spell', 'You can now spend 6 ki points per spell.',1007 , 17, 17),
('Open Hand Technique', 'Starting when you choose this tradition at 3rd level, you can manipulate your enemy''s ki when you harness your own. Whenever you hit a creature with one of the attacks granted by your Flurry of Blows, you can impose one of the following effects on that target:

It must succeed on a Dexterity saving throw or be knocked prone.
It must make a Strength saving throw. If it fails, you can push it up to 15 feet away from you.
It can''t take reactions until the end of your next turn.', 1007, 18 , 3),
('Wholeness of Body', 'At 6th level, you gain the ability to heal yourself. As an action, you can regain hit points equal to three times your monk level. You must finish a long rest before you can use this feature again.', 1007, 18  , 6),
('Tranquility', 'Beginning at 11th level, you can enter a special meditation that surrounds you with an aura of peace. At the end of a long rest, you gain the effect of a Sanctuary spell that lasts until the start of your next long rest (the spell can end early as normal). The saving throw DC for the spell equals 8 + your Wisdom modifier + your proficiency bonus.', 1007, 18  , 11),
('Quivering Palm', 'At 17th level, you gain the ability to set up lethal vibrations in someone''s body. When you hit a creature with an unarmed strike, you can spend 3 ki points to start these imperceptible vibrations, which last for a number of days equal to your monk level. The vibrations are harmless unless you use your action to end them. To do so, you and the target must be on the same plane of existence. When you use this action, the creature must make a Constitution saving throw. If it fails, it is reduced to 0 hit points. If it succeeds, it takes 10d10 necrotic damage.

You can have only one creature under the effect of this feature at a time. You can choose to end the vibrations harmlessly without using an action.', 1007, 18  , 17),
('Shadow Arts', 'Starting when you choose this tradition at 3rd level, you can use your ki to duplicate the effects of certain spells. As an action, you can spend 2 ki points to cast Darkness, Darkvision, Pass without Trace, or Silence, without providing material components. Additionally, you gain the Minor Illusion cantrip if you don''t already know it.', 1007 , 19 , 2),
('Shadow Step', 'At 6th level, you gain the ability to step from one shadow into another. When you are in dim light or darkness, as a bonus action you can teleport up to 60 feet to an unoccupied space you can see that is also in dim light or darkness. You then have advantage on the first melee attack you make before the end of the turn.', 1007 , 19 , 6),
('Cloak of Shadows', 'By 11th level, you have learned to become one with the shadows. When you are in an area of dim light or darkness, you can use your action to become invisible. You remain invisible until you make an attack, cast a spell, or are in an area of bright light.', 1007 , 19 , 11),
('Opportunist', 'At 17th level, you can exploit a creature''s momentary distraction when it is hit by an attack. Whenever a creature within 5 feet of you is hit by an attack made by a creature other than you, you can use your reaction to make a melee attack against that creature.', 1007 , 19 , 17),

('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1008, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1008, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1008, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1008, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1008, NULL, 19),
('Divine Smite', 'Starting at 2nd level, when you hit a creature with a melee weapon attack, you can expend one spell slot to deal radiant damage to the target, in addition to the weapon''s damage. The extra damage is 2d8 for a 1st-level spell slot, plus 1d8 for each spell level higher than 1st, to a maximum of 5d8. The damage increases by 1d8 if the target is an undead or a fiend, to a maximum of 6d8.', 1008,NULL , 2),
('Divine Health', 'By 3rd level, the divine magic flowing through you makes you immune to disease.', 1008,NULL , 3),
('Extra Attack','Beginning at 5th level, you can attack twice, instead of once, whenever you take the Attack action on your turn.', 1008,NULL ,5 ),
('Aura of Protection','Starting at 6th level, whenever you or a friendly creature within 10 feet of you must make a saving throw, the creature gains a bonus to the saving throw equal to your Charisma modifier (with a minimum bonus of +1). You must be conscious to grant this bonus.

At 18th level, the range of this aura increases to 30 feet.', 1008,NULL ,6 ),
('Aura of Courage','Starting at 10th level, you and friendly creatures within 10 feet of you can''t be frightened while you are conscious.

At 18th level, the range of this aura increases to 30 feet.', 1008,NULL , 10),
('Improved Divine Smite','By 11th level, you are so suffused with righteous might that all your melee weapon strikes carry divine power with them. Whenever you hit a creature with a melee weapon, the creature takes an extra 1d8 radiant damage.', 1008,NULL , 11),
('Cleansing Touch','Beginning at 14th level, you can use your action to end one spell on yourself or on one willing creature that you touch.

You can use this feature a number of times equal to your Charisma modifier (a minimum of once). You regain expended uses when you finish a long rest.', 1008,NULL , 14),
('Channel Divinity', 'When you take this oath at 3rd level, you gain the following two Channel Divinity options.

Nature''s Wrath. You can use your Channel Divinity to invoke primeval forces to ensnare a foe. As an action, you can cause spectral vines to spring up and reach for a creature within 10 feet of you that you can see. The creature must succeed on a Strength or Dexterity saving throw (its choice) or be restrained. While restrained by the vines, the creature repeats the saving throw at the end of each of its turns. On a success, it frees itself and the vines vanish.
Turn the Faithless. You can use your Channel Divinity to utter ancient words that are painful for fey and fiends to hear. As an action, you present your holy symbol, and each fey or fiend within 30 feet of you that can hear you must make a Wisdom saving throw. On a failed save, the creature is turned for 1 minute or until it takes damage.
A turned creature must spend its turns trying to move as far away from you as it can, and it can''t willingly move to a space within 30 feet of you. It also can''t take reactions. For its action, it can use only the Dash action or try to escape from an effect that prevents it from moving. If there''s nowhere to move, the creature can use the Dodge action.

If the creature''s true form is concealed by an illusion, shapeshifting, or other effect, that form is revealed while it is turned.', 1008, 20 , 3),
('Aura of Warding','Beginning at 7th level, ancient magic lies so heavily upon you that it forms an eldritch ward. You and friendly creatures within 10 feet of you have resistance to damage from spells.

At 18th level, the range of this aura increases to 30 feet.', 1008,20 , 7),
('Undying Sentinel','Starting at 15th level, when you are reduced to 0 hit points and are not killed outright, you can choose to drop to 1 hit point instead. Once you use this ability, you can''t use it again until you finish a long rest.

Additionally, you suffer none of the drawbacks of old age, and you can''t be aged magically.', 1008,20 , 15),
('Elder Champion','At 20th level, you can assume the form of an ancient force of nature, taking on an appearance you choose. For example, your skin might turn green or take on a bark-like texture, your hair might become leafy or moss-like, or you might sprout antlers or a lion-like mane.

Using your action, you undergo a transformation. For 1 minute, you gain the following benefits:

At the start of each of your turns, you regain 10 hit points.
Whenever you cast a paladin spell that has a casting time of 1 action, you can cast it using a bonus action instead.
Enemy creatures within 10 feet of you have disadvantage on saving throws against your paladin spells and Channel Divinity options.
Once you use this feature, you can''t use it again until you finish a long rest.', 1008,20 , 20 ),
('Channel Divinity','When you take this oath at 3rd level, you gain the following two Channel Divinity options.

Sacred Weapon. As an action, you can imbue one weapon that you are holding with positive energy, using your Channel Divinity. For 1 minute, you add your Charisma modifier to attack rolls made with that weapon (with a minimum bonus of +1). The weapon also emits bright light in a 20-foot radius and dim light 20 feet beyond that. If the weapon is not already magical, it becomes magical for the duration.
You can end this effect on your turn as part of any other action. If you are no longer holding or carrying this weapon, or if you fall unconscious, this effect ends.
Turn the Unholy. As an action, you present your holy symbol and speak a prayer censuring fiends and undead, using your Channel Divinity. Each fiend or undead that can see or hear you within 30 feet of you must make a Wisdom saving throw. If the creature fails its saving throw, it is turned for 1 minute or until it takes damage.
A turned creature must spend its turns trying to move as far away from you as it can, and it can''t willingly move to a space within 30 feet of you. It also can''t take reactions. For its action, it can use only the Dash action or try to escape from an effect that prevents it from moving. If there''s nowhere to move, the creature can use the Dodge action.', 1008,21 , 3),
('Aura of Devotion','Starting at 7th level, you and friendly creatures within 10 feet of you can''t be charmed while you are conscious.

At 18th level, the range of this aura increases to 30 feet.', 1008,21 , 7),
('Purity of Spirit','Beginning at 15th level, you are always under the effects of a Protection from Evil and Good spell.', 1008,21 , 15 ),
('Holy Nimbus','At 20th level, as an action, you can emanate an aura of sunlight. For 1 minute, bright light shines from you in a 30-foot radius, and dim light shines 30 feet beyond that.

Whenever an enemy creature starts its turn in the bright light, the creature takes 10 radiant damage.

In addition, for the duration, you have advantage on saving throws against spells cast by fiends or undead.

Once you use this feature, you can''t use it again until you finish a long rest.', 1008,21 , 20),
('Channel Divinity','When you take this oath at 3rd level, you gain the following two Channel Divinity options.

Abjure Enemy. As an action, you present your holy symbol and speak a prayer of denunciation, using your Channel Divinity. Choose one creature within 60 feet of you that you can see. That creature must make a Wisdom saving throw, unless it is immune to being frightened. Fiends and undead have disadvantage on this saving throw.
On a failed save, the creature is frightened for 1 minute or until it takes any damage. While frightened, the creature''s speed is 0, and it can''t benefit from any bonus to its speed.
On a successful save, the creature''s speed is halved for 1 minute or until the creature takes any damage.
Vow of Enmity. As a bonus action, you can utter a vow of enmity against a creature you can see within 10 feet of you, using your Channel Divinity. You gain advantage on attack rolls against the creature for 1 minute or until it drops to 0 hit points or falls unconscious.', 1008,22 , 3),
('Relentless Avenger','By 7th level, your supernatural focus helps you close off a foe''s retreat. When you hit a creature with an opportunity attack, you can move up to half your speed immediately after the attack and as part of the same reaction. This movement doesn''t provoke opportunity attacks.', 1008,22 , 7),
('Soul of Vengeance','Starting at 15th level, the authority with which you speak your Vow of Enmity gives you greater power over your foe. When a creature under the effect of your Vow of Enmity makes an attack, you can use your reaction to make a melee weapon attack against that creature if it is within range.', 1008,22 ,15 ),
('Avenging Angel','At 20th level, you can assume the form of an angelic avenger. Using your action, you undergo a transformation. For 1 hour, you gain the following benefits:

Wings sprout from your back and grant you a flying speed of 60 feet.
You emanate an aura of menace in a 30-foot radius. The first time any enemy creature enters the aura or starts its turn there during a battle, the creature must succeed on a Wisdom saving throw or become frightened of you for 1 minute or until it takes any damage. Attack rolls against the frightened creature have advantage.
Once you use this feature, you can''t use it again until you finish a long rest.', 1008,22 , 20),


('Favored Enemy','Beginning at 1st level, you have significant experience studying, tracking, hunting, and even talking to a certain type of enemy commonly encountered in the wilds.

Choose a type of favored enemy: beasts, fey, humanoids, monstrosities, or undead. You gain a +2 bonus to damage rolls with weapon attacks against creatures of the chosen type. Additionally, you have advantage on Wisdom (Survival) checks to track your favored enemies, as well as on Intelligence checks to recall information about them.

When you gain this feature, you also learn one language of your choice, typically one spoken by your favored enemy or creatures associated with it. However, you are free to pick any language you wish to learn.', 1009,NULL , 1),
('Natural Explorer','
You are a master of navigating the natural world, and you react with swift and decisive action when attacked. This grants you the following benefits:

You ignore difficult terrain.
You have advantage on initiative rolls.
On your first turn during combat, you have advantage on attack rolls against creatures that have not yet acted.
In addition, you are skilled at navigating the wilderness. You gain the following benefits when traveling for an hour or more:

Difficult terrain doesn’t slow your group’s travel.
Your group can’t become lost except by magical means.
Even when you are engaged in another activity while traveling (such as foraging, navigating, or tracking), you remain alert to danger.
If you are traveling alone, you can move stealthily at a normal pace.
When you forage, you find twice as much food as you normally would.
While tracking other creatures, you also learn their exact number, their sizes, and how long ago they passed through the area.', 1009,NULL , 1),
('Fighting Style','At 2nd level, you adopt a particular style of fighting as your specialty. Choose one of the following options. You can''t take a Fighting Style option more than once, even if you later get to choose again.

Archery. You gain a +2 bonus to attack rolls you make with ranged weapons.
Close Quarters Shooter (UA). When making a ranged attack while you are within 5 feet of a hostile creature, you do not have disadvantage on the attack roll. Your ranged attacks ignore half cover and three-quarters cover against targets within 30 feet of you. You have a +1 bonus to attack rolls on ranged attacks.
Defense. While you are wearing armor, you gain a +1 bonus to AC.
Dueling. When you are wielding a melee weapon in one hand and no other weapons, you gain a +2 bonus to damage rolls with that weapon.
Mariner (UA). As long as you are not wearing heavy armor or using a shield, you have a swimming speed and a climbing speed equal to your normal speed, and you gain a +1 bonus to armor class.
Tunnel Fighter (UA). As a bonus action, you can enter a defensive stance that lasts until the start of your next turn. While in your defensive stance, you can make opportunity attacks without using your reaction, and you can use your reaction to make a melee attack against a creature that moves more than 5 feet while within your reach.
Two-Weapon Fighting. When you engage in two-weapon fighting, you can add your ability modifier to the damage of the second attack.
Druidic Warrior (UA). You learn two cantrips of your choice from the druid spell list. They count as ranger spells for you, and Wisdom is your spellcasting ability for them. Whenever you gain a level in this class, you can replace one of these cantrips with another cantrip from the druid spell list.
Blind Fighting (UA). Being unable to see a creature doesn’t impose disadvantage on your attack rolls against it, provided the creature isn’t hidden from you.
Interception (UA). When a creature you can see hits a target that is within 5 feet of you with an attack, you can use your reaction to reduce the damage the target takes by 1d10 + your proficiency bonus (to a minimum of 0 damage). You must be wielding a shield or a simple or martial weapon to use this reaction.
Thrown Weapon Fighting (UA). You can draw a weapon that has the thrown property as part of the attack you make with the weapon.
In addition, when you hit with a ranged attack using a thrown weapon, you gain a +1 bonus to the damage roll.
Unarmed Fighting (UA). Your unarmed strikes can deal bludgeoning damage equal to 1d6 + your Strength modifier. If you strike with two free hands, the d6 becomes a d8.
When you successfully start a grapple, you can deal 1d4 bludgeoning damage to the grappled creature. Until the grapple ends, you can also deal this damage to the creature whenever you hit it with a melee attack.', 1009,NULL , 2),
('Primeval Awareness','Beginning at 3rd level, your mastery of ranger lore allows you to establish a powerful link to beasts and to the land around you.

You have an innate ability to communicate with beasts, and they recognize you as a kindred spirit. Through sounds and gestures, you can communicate simple ideas to a beast as an action, and can read its basic mood and intent. You learn its emotional state, whether it is affected by magic of any sort, its short-term needs (such as food or safety), and actions you can take (if any) to persuade it to not attack.

You cannot use this ability against a creature that you have attacked within the past 10 minutes.

Additionally, you can attune your senses to determine if any of your favored enemies lurk nearby. By spending 1 uninterrupted minute in concentration (as if you were concentrating on a spell), you can sense whether any of your favored enemies are present within 5 miles of you. This feature reveals which of your favored enemies are present, their numbers, and the creatures’ general direction and distance (in miles) from you.

If there are multiple groups of your favored enemies within range, you learn this information for each group.', 1009,NULL ,3 ),
('Greater Favored Enemy','At 6th level, you are ready to hunt even deadlier game. Choose a type of greater favored enemy: aberrations, celestials, constructs, dragons, elementals, fiends, or giants. You gain all the benefits against this chosen enemy that you normally gain against your favored enemy, including an additional language. Your bonus to damage rolls against all your favored enemies increases to +4.

Additionally, you have advantage on saving throws against the spells and abilities used by a greater favored enemy.', 1009,NULL , 6),
('Fleet of Foot','Beginning at 8th level, you can use the Dash action as a bonus action on your turn.', 1009,NULL , 8),
('Hide in Plain Sight','Starting at 10th level, you can remain perfectly still for long periods of time to set up ambushes.

When you attempt to hide on your turn, you can opt to not move on that turn. If you avoid moving, creatures that attempt to detect you take a −10 penalty to their Wisdom (Perception) checks until the start of your next turn. You lose this benefit if you move or fall prone, either voluntarily or because of some external effect. You are still automatically detected if any effect or action causes you to no longer be hidden.

If you are still hidden on your next turn, you can continue to remain motionless and gain this benefit until you are detected.', 1009,NULL ,10),
('Vanish','Starting at 14th level, you can use the Hide action as a bonus action on your turn. Also, you can''t be tracked by nonmagical means, unless you choose to leave a trail.', 1009,NULL ,14 ),
('Feral Senses','At 18th level, you gain preternatural senses that help you fight creatures you can''t see. When you attack a creature you can''t see, your inability to see it doesn''t impose disadvantage on your attack rolls against it.

You are also aware of the location of any invisible creature within 30 feet of you, provided that the creature isn''t hidden from you and you aren''t blinded or deafened.', 1009,NULL , 18),
('Foe Slayer','At 20th level, you become an unparalleled hunter of your enemies. Once on each of your turns, you can add your Wisdom modifier to the attack roll or the damage roll of an attack you make against one of your favored enemies. You can choose to use this feature before or after the roll, but before any effects of the roll are applied.', 1009,NULL , 20 ),

('Ranger''s Companion','At 3rd level, you gain a beast companion that accompanies you on your adventures and is trained to fight alongside you. Choose a beast that is no larger than Medium and that has a challenge rating of 1/4 or lower (appendix D presents statistics for the hawk, mastiff, and panther as examples). Add your proficiency bonus to the beast’s AC, attack rolls, and damage rolls, as well as to any saving throws and skills it is proficient in. Its hit point maximum equals its normal maximum or four times your ranger level, whichever is higher. Like any creature, the beast can spend Hit Dice during a short rest.

The beast obeys your commands as best as it can. It takes its turn on your initiative. On your turn, you can verbally command the beast where to move (no action required by you). You can use your action to verbally command it to take the Attack, Dash, Disengage, or Help action. If you don’t issue a command, the beast takes the Dodge action. Once you have the Extra Attack feature, you can make one weapon attack yourself when you command the beast to take the Attack action. While traveling through your favored terrain with only the beast, you can move stealthily at a normal pace.

If you are incapacitated or absent, the beast acts on its own, focusing on protecting you and itself. The beast never requires your command to use its reaction, such as when making an opportunity attack.

If the beast dies, you can obtain another one by spending 8 hours magically bonding with another beast that isn’t hostile to you, either the same type of beast as before or a different one.', 1009, 23, 3),
('Extra Attack','Beginning at 5th level, you can attack twice, instead of once, whenever you take the Attack action on your turn.', 1009, 23, 5),
('Exceptional Training','Beginning at 7th level, on any of your turns when your beast companion doesn’t attack, you can use a
bonus action to command the beast to take the Dash, Disengage, or Help action on its turn. In addition, the beast’s attacks now count as magical for the purpose of overcoming resistance and immunity to nonmagical attacks and damage.', 1009, 23,7 ),
('Bestial Fury','Starting at 11th level, when you command your beast companion to take the Attack action, the beast can make two attacks, or it can take the Multiattack action if it has that action.', 1009, 23, 11),
('Share Spells','Beginning at 15th level, when you cast a spell targeting yourself, you can also affect your beast companion with the spell if the beast is within 30 feet of you.', 1009, 23, 15),


('Hunter''s Prey','At 3rd level, you gain one of the following features of your choice.

Colossus Slayer. Your tenacity can wear down the most potent foes. When you hit a creature with a weapon attack, the creature takes an extra 1d8 damage if it’s below its hit point maximum. You can deal this extra damage only once per turn.
Giant Killer. When a Large or larger creature within 5 feet of you hits or misses you with an attack, you can use your reaction to attack that creature immediately after its attack, provided that you can see the creature.
Horde Breaker. Once on each of your turns when you make a weapon attack, you can make another attack with the same weapon against a different creature that is within 5 feet of the original target and within range of your weapon.', 1009,24 ,3 ),
('Defensive Tactics','At 7th level, you gain one of the following features of your choice.

Escape the Horde. Opportunity attacks against you are made with disadvantage.
Multiattack Defense. When a creature hits you with an attack, you gain a +4 bonus to AC against all subsequent attacks made by that creature for the rest of the turn.
Steel Will. You have advantage on saving throws against being frightened.', 1009,24 , 7),
('Multiattack','At 11th level, you gain one of the following features of your choice.

Volley. You can use your action to make a ranged attack against any number of creatures within 10 feet of a point you can see within your weapon’s range. You must have ammunition for each target, as normal, and you make a separate attack roll for each target
Whirlwind Attack. You can use your action to make melee attacks against any number of creatures within 5 feet of you, with a separate attack roll for each target.', 1009,24 , 11),
('Superior Hunter''s Defense','At 15th level, you gain one of the following features of your choice.

Evasion. When you are subjected to an effect, such as a red dragon’s fiery breath or a lightning bolt spell, that allows you to make a Dexterity saving throw to take only half damage, you instead take no damage if you succeed on a saving throw, and only half damage if you fail
Stand Against the Tide. When a hostile creature misses you with a melee attack, you can use your reaction to force that creature to repeat the same attack against another creature (other than itself) of your choice.
Uncanny Dodge. When an attacker that you can see hits you with an attack, you can use your reaction to halve the attack’s damage against you.', 1009,24 , 15 ),

('Expertise','At 1st level, choose two of your skill proficiencies, or one of your skill proficiencies and your proficiency with thieves'' tools. Your proficiency bonus is doubled for any ability check you make that uses either of the chosen proficiencies.

At 6th level, you can choose two more of your proficiencies (in skills or with thieves'' tools) to gain this benefit.', 1010, NULL , 1),
('Sneak Attack','Beginning at 1st level, you know how to strike subtly and exploit a foe''s distraction. Once per turn, you can deal an extra 1d6 damage to one creature you hit with an attack if you have advantage on the attack roll. The attack must use a finesse or a ranged weapon.

You don''t need advantage on the attack roll if another enemy of the target is within 5 feet of it, that enemy isn''t incapacitated, and you don''t have disadvantage on the attack roll.

The amount of the extra damage increases as you gain levels in this class, as shown in the Sneak Attack column of the Rogue table.', 1010, NULL , 1),
('Thieves'' Cant', 'During your rogue training you learned thieves'' cant, a secret mix of dialect, jargon, and code that allows you to hide messages in seemingly normal conversation. Only another creature that knows thieves'' cant understands such messages. It takes four times longer to convey such a message than it does to speak the same idea plainly.

In addition, you understand a set of secret signs and symbols used to convey short, simple messages, such as whether an area is dangerous or the territory of a thieves'' guild, whether loot is nearby, or whether the people in an area are easy marks or will provide a safe house for thieves on the run.', 1010, NULL ,1 ),
('Cunning Action','Starting at 2nd level, your quick thinking and agility allow you to move and act quickly. You can take a bonus action on each of your turns in combat. This action can be used only to take the Dash, Disengage, or Hide action.', 1010, NULL ,2),
('Uncanny Dodge','Starting at 5th level, when an attacker that you can see hits you with an attack, you can use your reaction to halve the attack''s damage against you.', 1010, NULL ,5),
('Evasion','Beginning at 7th level, you can nimbly dodge out of the way of certain area effects, such as a red dragon''s fiery breath or an Ice Storm spell. When you are subjected to an effect that allows you to make a Dexterity saving throw to take only half damage, you instead take no damage if you succeed on the saving throw, and only half damage if you fail.', 1010, NULL ,7 ),
('Reliable Talent','By 11th level, you have refined your chosen skills until they approach perfection. Whenever you make an ability check that lets you add your proficiency bonus, you can treat a d20 roll of 9 or lower as a 10.', 1010, NULL , 11),
('Blindsense','Starting at 14th level, if you are able to hear, you are aware of the location of any hidden or invisible creature within 10 feet of you.', 1010, NULL ,14 ),
('Slippery Mind','By 15th level, you have acquired greater mental strength. You gain proficiency in Wisdom saving throws.', 1010, NULL , 15),
('Elusive','Beginning at 18th level, you are so evasive that attackers rarely gain the upper hand against you. No attack roll has advantage against you while you aren''t incapacitated.', 1010, NULL , 18),
('Stroke of Luck','At 20th level, you have an uncanny knack for succeeding when you need to. If your attack misses a target within range, you can turn the miss into a hit. Alternatively, if you fail an ability check, you can treat the d20 roll as a 20.

Once you use this feature, you can''t use it again until you finish a short or long rest.', 1010, NULL , 20),

('Fast Hands','Starting at 3rd level, you can use the bonus action granted by your Cunning Action to make a Dexterity (Sleight of Hand) check, use your thieves'' tools to disarm a trap or open a lock, or take the Use an Object action.', 1010, 25 ,3),
('Second-Story Work','When you choose this archetype at 3rd level, you gain the ability to climb faster than normal; climbing no longer costs you extra movement.

In addition, when you make a running jump, the distance you cover increases by a number of feet equal to your Dexterity modifier.', 1010, 25 ,3 ),
('Supreme Sneak','Starting at 9th level, you have advantage on a Dexterity (Stealth) check if you move no more than half your speed on the same turn.', 1010, 25 , 9),
('Use Magic Device','By 13th level, you have learned enough about the workings of magic that you can improvise the use of items even when they are not intended for you. You ignore all class, race, and level requirements on the use of magic items.', 1010, 25 , 13),
('Thief''s Reflexes','When you reach 17th level, you have become adept at laying ambushes and quickly escaping danger. You can take two turns during the first round of any combat. You take your first turn at your normal initiative and your second turn at your initiative minus 10. You can''t use this feature when you are surprised.', 1010, 25 , 17),



('Bonus Proficiencies','When you choose this archetype at 3rd level, you gain proficiency with the disguise kit and the poisoner''s kit.', 1010, 26 , 3),
('Assassinate','Starting at 3rd level, you are at your deadliest when you get the drop on your enemies. You have advantage on attack rolls against any creature that hasn''t taken a turn in the combat yet. In addition, any hit you score against a creature that is surprised is a critical hit.', 1010, 26 , 3 ),
('Infiltration Expertise','Starting at 9th level, you can unfailingly create false identities for yourself. You must spend seven days and 25 gp to establish the history, profession, and affiliations for an identity. You can''t establish an identity that belongs to someone else. For example, you might acquire appropriate clothing, letters of introduction, and official- looking certification to establish yourself as a member of a trading house from a remote city so you can insinuate yourself into the company of other wealthy merchants.

Thereafter, if you adopt the new identity as a disguise, other creatures believe you to be that person until given an obvious reason not to.', 1010, 26 , 9),
('Impostor','At 13th level, you gain the ability to unerringly mimic another person''s speech, writing, and behavior. You must spend at least three hours studying these three components of the person''s behavior, listening to speech, examining handwriting, and observing mannerisms.

Your ruse is indiscernible to the casual observer. If a wary creature suspects something is amiss, you have advantage on any Charisma (Deception) check you make to avoid detection.', 1010, 26 ,13 ),
('Death Strike','Starting at 17th level, you become a master of instant death. When you attack and hit a creature that is surprised, it must make a Constitution saving throw (DC 8 + your Dexterity modifier + your proficiency bonus). On a failed save, double the damage of your attack against the creature.', 1010, 26 , 17),



('Spellcasting','When you reach 3rd level, you augment your martial prowess with the ability to cast spells.

Cantrips
You learn three cantrips: Mage Hand and two other cantrips of your choice from the wizard spell list. You learn another wizard cantrip of your choice at 10th level.', 1010, 27 , 3 ),
('Mage Hand Legerdemain','Starting at 3rd level, when you cast Mage Hand, you can make the spectral hand invisible, and you can perform the following additional tasks with it:

You can stow one object the hand is holding in a container worn or carried by another creature.
You can retrieve an object in a container worn or carried by another creature.
You can use thieves'' tools to pick locks and disarm traps at range.
You can perform one of these tasks without being noticed by a creature if you succeed on a Dexterity (Sleight of Hand) check contested by the creature''s Wisdom (Perception) check.

In addition, you can use the bonus action granted by your Cunning Action to control the hand.', 1010, 27 , 3 ),
('Magical Ambush','Starting at 9th level, if you are hidden from a creature when you cast a spell on it, the creature has disadvantage on any saving throw it makes against the spell this turn.', 1010, 27 ,9),
('Versatile Trickster','At 13th level, you gain the ability to distract targets with your Mage Hand. As a bonus action on your turn, you can designate a creature within 5 feet of the spectral hand created by the spell. Doing so gives you advantage on attack rolls against that creature until the end of the turn.', 1010, 27 ,13),
('Spell Thief','At 17th level, you gain the ability to magically steal the knowledge of how to cast a spell from another spellcaster.

Immediately after a creature casts a spell that targets you or includes you in its area of effect, you can use your reaction to force the creature to make a saving throw with its spellcasting ability modifier. The DC equals your spell save DC. On a failed save, you negate the spell''s effect against you, and you steal the knowledge of the spell if it is at least 1st level and of a level you can cast (it doesn''t need to be a wizard spell). For the next 8 hours, you know the spell and can cast it using your spell slots. The creature can''t cast that spell until the 8 hours have passed.

Once you use this feature, you can''t use it again until you finish a long rest.', 1010, 27 ,17 ),


('Font of Magic','At 2nd level, you tap into a deep wellspring of magic within yourself. This wellspring is represented by sorcery points, which allow you to create a variety of magical effects.

Sorcery Points. You have 2 sorcery points, and you gain more as you reach higher levels, as shown in the Sorcery Points column of the Sorcerer table. You can never have more sorcery points than shown on the table for your level. You regain all spent sorcery points when you finish a long rest.
Flexible Casting. You can use your sorcery points to gain additional spell slots, or sacrifice spell slots to gain additional sorcery points. You learn other ways to use your sorcery points as you reach higher levels.
Creating Spell Slots. You can transform unexpended sorcery points into one spell slot as a bonus action on your turn. The Creating Spell Slots table shows the cost of creating a spell slot of a given level. You can create spell slots no higher in level than 5th. The created spell slots vanish at the end of a long rest.
Converting a Spell Slot to Sorcery Points. As a bonus action on your turn, you can expend one spell slot and gain a number of sorcery points equal to the slot''s level.', 1011, NULL, 2),
('Metamagic','At 3rd level, you gain the ability to twist your spells to suit your needs. You gain two of the following Metamagic options of your choice. You gain another one at 10th and 17th level.

You can use only one Metamagic option on a spell when you cast it, unless otherwise noted.

Careful Spell. When you cast a spell that forces other creatures to make a saving throw, you can protect some of those creatures from the spell''s full force. To do so, you spend 1 sorcery point and choose a number of those creatures up to your Charisma modifier (minimum of one creature). A chosen creature automatically succeeds on its saving throw against the spell.
Distant Spell. When you cast a spell that has a range of 5 feet or greater, you can spend 1 sorcery point to double the range of the spell.
When you cast a spell that has a range of touch, you can spend 1 sorcery point to make the range of the spell 30 feet.
Empowered Spell. When you roll damage for a spell, you can spend 1 sorcery point to reroll a number of the damage dice up to your Charisma modifier (minimum of one). You must use the new rolls.
You can use Empowered Spell even if you have already used a different Metamagic option during the casting of the spell.
Extended Spell. When you cast a spell that has a duration of 1 minute or longer, you can spend 1 sorcery point to double its duration, to a maximum duration of 24 hours.
Heightened Spell. When you cast a spell that forces a creature to make a saving throw to resist its effects, you can spend 3 sorcery points to give one target of the spell disadvantage on its first saving throw made against the spell.
Quickened Spell. When you cast a spell that has a casting time of 1 action, you can spend 2 sorcery points to change the casting time to 1 bonus action for this casting.
Subtle Spell. When you cast a spell, you can spend 1 sorcery point to cast it without any somatic or verbal components.
Transmuted Spell. When you cast a spell that deals a type of damage from the following list, you can spend 1 sorcery point to change that damage type to one of the other listed types: acid, cold, fire, lightning, poison, thunder.
Twinned Spell. When you cast a spell that targets only one creature and doesn''t have a range of self, you can spend a number of sorcery points equal to the spell''s level to target a second creature in range with the same spell (1 sorcery point if the spell is a cantrip). To be eligible for Twinned Spell, a spell must be incapable of targeting more than one creature at the spell''s current level.
Seeking Spell (UA). When you cast a spell that requires you to make a spell attack roll or that forces a target to make a Dexterity saving throw, you can spend 1 sorcery point to ignore the effects of half- and three-quarters cover against targets of the spell.
Unerring Spell (UA). If you make an attack roll for a spell and miss, you can spend 2 sorcery points to reroll the attack roll. You must use the result of the second roll.
You can use Unerring Spell even if you have already used a different Metamagic option during the casting of the spell.', 1011, NULL, 3),
('Sorcerous Versatility','When you reach 4th level, and again at 8th, 12th, 16th, and 19th level, you can do one of the following, representing the magic within you flowing in new ways:

Replace one of the options you chose for the Metamagic feature with a different Metamagic option available to you.
Replace one cantrip you learned from this class'' spellcasting feature with another cantrip from the sorcerer spell list.', 1011, NULL, 4),
('Magical Guidance','When you reach 5th level, you can tap into your inner wellspring of magic to try and conjure success from failure. When you make an ability check that fails, you can spend 1 sorcery point to reroll the d20, and you must use the new roll, potentially turning the failure into a success.', 1011, NULL,5),
('Sorcerous Restoration','At 20th level, you regain 4 expended sorcery points whenever you finish a short rest.', 1011, NULL, 20 ),


('Wild Magic Surge','Starting when you choose this origin at 1st level, your spellcasting can unleash surges of untamed magic. Immediately after you cast a sorcerer spell of 1st level or higher, the DM can have you roll a d20. If you roll a 1, roll on the Wild Magic Surge table to create a random magical effect.', 1011, 29, 1),
('Tides of Chaos','Starting at 1st level, you can manipulate the forces of chance and chaos to gain advantage on one attack roll, ability check, or saving throw. Once you do so, you must finish a long rest before you can use this feature again.

Any time before you regain the use of this feature, the DM can have you roll on the Wild Magic Surge table immediately after you cast a sorcerer spell of 1st level or higher. You then regain the use of this feature.', 1011, 29, 1 ),
('Bend Luck','Starting at 6th level, you have the ability to twist fate using your wild magic. When another creature you can see makes an attack roll, an ability check, or a saving throw, you can use your reaction and spend 2 sorcery points to roll 1d4 and apply the number rolled as a bonus or penalty (your choice) to the creature''s roll. You can do so after the creature rolls but before any effects of the roll occur.', 1011, 29, 6),
('Controlled Chaos','At 14th level, you gain a modicum of control over the surges of your wild magic. Whenever you roll on the Wild Magic Surge table, you can roll twice and use either number.', 1011, 29, 14),
('Spell Bombardment','Beginning at 18th level, the harmful energy of your spells intensifies. When you roll damage for a spell and roll the highest number possible on any of the dice, choose one of those dice, roll it again and add that roll to the damage. You can use the feature only once per turn.', 1011, 29, 18),


('Draconic Resilience','As magic flows through your body, it causes physical traits of your dragon ancestors to emerge. At 1st level, your hit point maximum increases by 1 and increases by 1 again whenever you gain a level in this class.

Additionally, parts of your skin are covered by a thin sheen of dragon-like scales. When you aren''t wearing armor, your AC equals 13 + your Dexterity modifier.', 1011, 28, 1),
('Dragon Ancestor','At 1st level, you choose one type of dragon as your ancestor. The damage type associated with each dragon is used by features you gain later.', 1011, 28, 1),
('Elemental Affinity','Starting at 6th level, when you cast a spell that deals damage of the type associated with your draconic ancestry, add your Charisma modifier to that damage. At the same time, you can spend 1 sorcery point to gain resistance to that damage type for 1 hour.', 1011, 28, 6),
('Dragon Wings','At 14th level, you gain the ability to sprout a pair of dragon wings from your back, gaining a flying speed equal to your current speed. You can create these wings as a bonus action on your turn. They last until you dismiss them as a bonus action on your turn.

You can''t manifest your wings while wearing armor unless the armor is made to accommodate them, and clothing not made to accommodate your wings might be destroyed when you manifest them.', 1011, 28, 14),
('Draconic Presence','Beginning at 18th level, you can channel the dread presence of your dragon ancestor, causing those around you to become awestruck or frightened. As an action, you can spend 5 sorcery points to draw on this power and exude an aura of awe or fear (your choice) to a distance of 60 feet. For 1 minute or until you lose your concentration (as if you were casting a concentration spell), each hostile creature that starts its turn in this aura must succeed on a Wisdom saving throw or be charmed (if you chose awe) or frightened (if you chose fear) until the aura ends. A creature that succeeds on this saving throw is immune to your aura for 24 hours.', 1011, 28, 18 ),



('Otherworldly Patron','At 1st level, you have struck a bargain with an otherworldly being of your choice. Your choice grants you features at 1st level and again at 6th, 10th, and 14th level.', 1012, NULL, 1),
('Eldritch Invocations','In your study of occult lore, you have unearthed eldritch invocations, fragments of forbidden knowledge that imbue you with an abiding magical ability.

At 2nd level, you gain two eldritch invocations of your choice. When you gain certain warlock levels, you gain additional invocations of your choice, as shown in the Invocations Known column of the Warlock table.

Additionally, when you gain a level in this class, you can choose one of the invocations you know and replace it with another invocation that you could learn at that level.

A level prerequisite in an invocation refers to warlock level, not character level.', 1012, NULL, 2 ),
('Pact Boon','At 3rd level, your otherworldly patron bestows a gift upon you for your loyal service. You gain one of the following features of your choice.

Pact of the Blade
You can use your action to create a pact weapon in your empty hand. You can choose the form that this melee weapon takes each time you create it. You are proficient with it while you wield it. This weapon counts as magical for the purpose of overcoming resistance and immunity to nonmagical attacks and damage.
Your pact weapon disappears if it is more than 5 feet away from you for 1 minute or more. It also disappears if you use this feature again, if you dismiss the weapon (no action required), or if you die.
You can transform one magic weapon into your pact weapon by performing a special ritual while you hold the weapon. You perform the ritual over the course of 1 hour, which can be done during a short rest.
You can then dismiss the weapon, shunting it into an extradimensional space, and it appears whenever you create your pact weapon thereafter. You can''t affect an artifact or a sentient weapon in this way. The weapon ceases being your pact weapon if you die, if you perform the 1-hour ritual on a different weapon, or if you use a 1-hour ritual to break your bond to it. The weapon appears at your feet if it is in the extradimensional space when the bond breaks.
Pact of the Chain
You learn the Find Familiar spell and can cast it as a ritual. The spell doesn''t count against your number of spells known.
When you cast the spell, you can choose one of the normal forms for your familiar or one of the following special forms: imp, pseudodragon, quasit, or sprite.
Additionally, when you take the Attack action, you can forgo one of your own attacks to allow your familiar to use its reaction to make one attack of its own.
Pact of the Tome
Your patron gives you a grimoire called a Book of Shadows. When you gain this feature, choose three cantrips from any class''s spell list. While the book is on your person, you can cast those cantrips at will. They are considered warlock spells for you, and they needn''t be from the same spell list. They don''t count against your number of cantrips known.
If you lose your Book of Shadows, you can perform a 1-hour ceremony to receive a replacement from your patron. This ceremony can be performed during a short or long rest, and it destroys the previous book. The book turns to ash when you die.
Pact of the Star Chain (UA)
Prerequisite: Seeker Patron
The Seeker grants you a chain forged from starlight, decorated with seven gleaming motes of brightness. While the chain is on your person, you know the Augury spell and can cast it as a ritual. The spell doesn’t count against your number of spells known.
Additionally, you can invoke the Seeker’s power to gain advantage on an Intelligence check while you carry this item. Once you use this ability, you cannot use it again until you complete a short or long rest.
If you lose your Star Chain, you can perform a 1-hour ceremony to receive a replacement from the Seeker. The ceremony can be performed during a short or long rest, and it destroys the previous chain. The chain disappears in a flash of light when you die.
The exact form of this item might be different depending on your patron. The Star Chain is inspired by the Greyhawk deity Celestian.
Pact of the Talisman (UA)
Your patron gives you a special amulet, a talisman that can aid you, or anyone else who wears it, when the need is great. When the wearer makes an ability check with a skill in which they lack proficiency, they can add a d4 to the roll.
If you lose the talisman, you can perform a 1-hour ceremony to receive a replacement from your patron. This ceremony can be performed during a short or long rest, and it destroys the previous amulet.
The talisman turns to ash when you die.', 1012, NULL,3 ),
('Mystic Arcanum','At 11th level, your patron bestows upon you a magical secret called an arcanum. Choose one 6th-level spell from the warlock spell list as this arcanum.

You can cast your arcanum spell once without expending a spell slot. You must finish a long rest before you can do so again.

At higher levels, you gain more warlock spells of your choice that can be cast in this way: one 7th-level spell at 13th level, one 8th-level spell at 15th level, and one 9th-level spell at 17th level. You regain all uses of your Mystic Arcanum when you finish a long rest.', 1012, NULL, 11),
('Eldritch Master','
At 20th level, you can draw on your inner reserve of mystical power while entreating your patron to regain expended spell slots. You can spend 1 minute entreating your patron for aid to regain all your expended spell slots from your Pact Magic feature. Once you regain spell slots with this feature, you must finish a long rest before you can do so again.', 1012, NULL, 20),


('Fey Presence','Starting at 1st level, your patron bestows upon you the ability to project the beguiling and fearsome presence of the fey. As an action, you can cause each creature in a 10-foot cube originating from you to make a Wisdom saving throw against your warlock spell save DC. The creatures that fail their saving throws are all charmed or frightened by you (your choice) until the end of your next turn.

Once you use this feature, you can''t use it again until you finish a short or long rest.', 1012, 30,1 ),
('Misty Escape','Starting at 6th level, you can vanish in a puff of mist in response to harm. When you take damage, you can use your reaction to turn invisible and teleport up to 60 feet to an unoccupied space you can see. You remain invisible until the start of your next turn or until you attack or cast a spell.

Once you use this feature, you can''t use it again until you finish a short or long rest.', 1012, 30, 6),
('Beguiling Defenses','Beginning at 10th level, your patron teaches you how to turn the mind-affecting magic of your enemies against them. You are immune to being charmed, and when another creature attempts to charm you, you can use your reaction to attempt to turn the charm back on that creature. The creature must succeed on a Wisdom saving throw against your warlock spell save DC or be charmed by you for 1 minute or until the creature takes any damage.', 1012, 30, 10),
('Dark Delirium','Starting at 14th level, you can plunge a creature into an illusory realm. As an action, choose a creature that you can see within 60 feet of you. It must make a Wisdom saving throw against your warlock spell save DC. On a failed save, it is charmed or frightened by you (your choice) for 1 minute or until your concentration is broken (as if you are concentrating on a spell). This effect ends early if the creature takes any damage.

Until this illusion ends, the creature thinks it is lost in a misty realm, the appearance of which you choose. The creature can see and hear only itself, you, and the illusion.

You must finish a short or long rest before you can use this feature again.', 1012, 30, 14),

('Dark One''s Blessing','Starting at 1st level, when you reduce a hostile creature to 0 hit points, you gain temporary hit points equal to your Charisma modifier + your warlock level (minimum of 1).', 1012, 31, 1),
('Dark One''s Own Luck','Starting at 6th level, you can call on your patron to alter fate in your favor. When you make an ability check or a saving throw, you can use this feature to add a d10 to your roll. You can do so after seeing the initial roll but before any of the roll''s effects occur.

Once you use this feature, you can''t use it again until you finish a short or long rest.', 1012, 31, 6),
('Fiendish Resilience','Starting at 10th level, you can choose one damage type when you finish a short or long rest. You gain resistance to that damage type until you choose a different one with this feature. Damage from magical weapons or silver weapons ignores this resistance.', 1012, 31, 10),
('Hurl Through Hell','Starting at 14th level, when you hit a creature with an attack, you can use this feature to instantly transport the target through the lower planes. The creature disappears and hurtles through a nightmare landscape.

At the end of your next turn, the target returns to the space it previously occupied, or the nearest unoccupied space. If the target is not a fiend, it takes 10d10 psychic damage as it reels from its horrific experience.

Once you use this feature, you can''t use it again until you finish a long rest.', 1012, 31, 14),

('Awakened Mind','Starting at 1st level, your alien knowledge gives you the ability to touch the minds of other creatures. You can telepathically speak to any creature you can see within 30 feet of you. You don''t need to share a language with the creature for it to understand your telepathic utterances, but the creature must be able to understand at least one language.', 1012, 32, 1),
('Entropic Ward','At 6th level, you learn to magically ward yourself against attack and to turn an enemy''s failed strike into good luck for yourself. When a creature makes an attack roll against you, you can use your reaction to impose disadvantage on that roll. If the attack misses you, your next attack roll against the creature has advantage if you make it before the end of your next turn.

Once you use this feature, you can''t use it again until you finish a short or long rest.', 1012, 32, 6),
('Thought Shield','Starting at 10th level, your thoughts can''t be read by telepathy or other means unless you allow it. You also have resistance to psychic damage, and whenever a creature deals psychic damage to you, that creature takes the same amount of damage that you do.', 1012, 32, 10),
('Create Thrall','At 14th level, you gain the ability to infect a humanoid''s mind with the alien magic of your patron. You can use your action to touch an incapacitated humanoid. That creature is then charmed by you until a Remove Curse spell is cast on it, the charmed condition is removed from it, or you use this feature again.

You can communicate telepathically with the charmed creature as long as the two of you are on the same plane of existence.', 1012, 32, 14),



('Spellbook','At 1st level, you have a spellbook containing six 1st-level wizard spells of your choice.

The spells that you add to your spellbook as you gain levels reflect the arcane research you conduct on your own, as well as intellectual breakthroughs you have had about the nature of the multiverse. You might find other spells during your adventures. You could discover a spell recorded on a scroll in an evil wizard''s chest, for example, or in a dusty tome in an ancient library.

Copying a Spell into the Book. When you find a wizard spell of 1st level or higher, you can add it to your spellbook if it is of a level for which you have spell slots and if you can spare the time to decipher and copy it.

Copying a spell into your spellbook involves reproducing the basic form of the spell, then deciphering the unique system of notation used by the wizard who wrote it. You must practice the spell until you understand the sounds or gestures required, then transcribe it into your spellbook using your own notation.

For each level of the spell, the process takes 2 hours and costs 50 gp. The cost represents material components you expend as you experiment with the spell to master it, as well as the fine inks you need to record it. Once you have spent this time and money, you can prepare the spell just like your other spells.

Replacing the Book. You can copy a spell from your own spellbook into another book-for example, if you want to make a backup copy of your spellbook. This is just like copying a new spell into your spellbook, but faster and easier, since you understand your own notation and already know how to cast the spell. You need spend only 1 hour and 10 gp for each level of the copied spell.

If you lose your spellbook, you can use the same procedure to transcribe the spells that you have prepared into a new spellbook. Filling out the remainder of your spellbook requires you to find new spells to do so, as normal. For this reason, many wizards keep backup spellbooks in a safe place.

The Book''s Appearance. Your spellbook is a unique compilation of spells, with its own decorative flourishes and margin notes. It might be a plain, functional leather volume that you received as a gift from your master, a finely bound gilt-edged tome you found in an ancient library or even a loose collection of notes scrounged together after you lost your previous spellbook in a mishap.', 1013, NULL,1 ),
('Arcane Recovery','You have learned to regain some of your magical energy by studying your spellbook. Once per day when you finish a short rest, you can choose expended spell slots to recover. The spell slots can have a combined level that is equal to or less than half your wizard level (rounded up), and none of the slots can be 6th level or higher.

For example, if you''re a 4th-level wizard, you can recover up to two levels worth of spell slots. You can recover either a 2nd-level spell slot or two 1st-level spell slots.', 1013, NULL, 1),
('Spell Mastery','At 18th level, you have achieved such mastery over certain spells that you can cast them at will. Choose a 1st-level wizard spell and a 2nd-level wizard spell that are in your spellbook. You can cast those spells at their lowest level without expending a spell slot when you have them prepared. If you want to cast either spell at a higher level, you must expend a spell slot as normal.

By spending 8 hours in study, you can exchange one or both of the spells you chose for different spells of the same levels.', 1013, NULL, 18),
('Signature Spells','When you reach 20th level, you gain mastery over two powerful spells and can cast them with little effort. Choose two 3rd-level wizard spells in your spellbook as your signature spells. You always have these spells prepared, they don''t count against the number of spells you have prepared, and you can cast each of them once at 3rd level without expending a spell slot. When you do so, you can''t do so again until you finish a short or long rest.

If you want to cast either spell at a higher level, you must expend a spell slot as normal.', 1013, NULL, 20),


('Conjuration Savant','Beginning when you select this school at 2nd level, the gold and time you must spend to copy a Conjuration spell into your spellbook is halved.', 1013, 33, 2),
('Minor Conjuration','Starting at 2nd level when you select this school, you can use your action to conjure up an inanimate object in your hand or on the ground in an unoccupied space that you can see within 10 feet of you. This object can be no larger than 3 feet on a side and weigh no more than 10 pounds, and its form must be that of a nonmagical object that you have seen. The object is visibly magical, radiating dim light out to 5 feet.

The object disappears after 1 hour, when you use this feature again, or if it takes any damage.', 1013, 33, 2),
('Benign Transportation','Starting at 6th level, you can use your action to teleport up to 30 feet to an unoccupied space that you can see. Alternatively, you can choose a space within range that is occupied by a Small or Medium creature. If that creature is willing, you both teleport, swapping places.

Once you use this feature, you can''t use it again until you finish a long rest or you cast a conjuration spell of 1st level or higher.', 1013, 33, 6),
('Focused Conjuration','Beginning at 10th level, while you are concentrating on a conjuration spell, your concentration can''t be broken as a result of taking damage.', 1013, 33, 10),
('Durable Summons','Starting at 14th level, any creature that you summon or create with a conjuration spell has 30 temporary hit points.', 1013, 33, 14),

('Divination Savant','Beginning when you select this school at 2nd level, the gold and time you must spend to copy a Divination spell into your spellbook is halved.', 1013, 34, 2),
('Portent','Starting at 2nd level when you choose this school, glimpses of the future begin to press in on your awareness. When you finish a long rest, roll two d20s and record the numbers rolled. You can replace any attack roll, saving throw, or ability check made by you or a creature that you can see with one of these foretelling rolls. You must choose to do so before the roll, and you can replace a roll in this way only once per turn.

Each foretelling roll can be used only once. When you finish a long rest, you lose any unused foretelling rolls.', 1013, 34, 2),
('Expert Divination','Beginning at 6th level, casting divination spells comes so easily to you that it expends only a fraction of your spellcasting efforts. When you cast a divination spell of 2nd level or higher using a spell slot, you regain one expended spell slot. The slot you regain must be of a level lower than the spell you cast and can''t be higher than 5th level.', 1013, 34, 6),
('The Third Eye','Starting at 10th level, you can use your action to increase your powers of perception. When you do so, choose one of the following benefits, which lasts until you are incapacitated or you take a short or long rest. You can''t use the feature again until you finish a short or long rest.

Darkvision. You gain darkvision out to a range of 60 feet.

Ethereal Sight. You can see into the Ethereal Plane within 60 feet of you.

Greater Comprehension. You can read any language.

See Invisibility. You can see invisible creatures and objects within 10 feet of you that are within line of sight.', 1013, 34, 10),
('Greater Portent','Starting at 14th level, the visions in your dreams intensify and paint a more accurate picture in your mind of what is to come. You roll three d20s for your Portent feature, rather than two.', 1013, 34, 14),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1009, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1009, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1009, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1009, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1009, NULL, 19),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1010, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1010, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1010, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1010, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1010, NULL, 19),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1011, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1011, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1011, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1011, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1011, NULL, 19),

('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1012, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1012, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1012, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1012, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1012, NULL, 19),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1013, NULL, 4),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1013, NULL, 8),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1013, NULL, 12),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1013, NULL, 16),
('Ability Score Improvement', 'You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1. As normal, you can''t increase an ability score above 20 using this feature.', 1013, NULL, 19)


INSERT INTO ClassSpellSlots
VALUES
(	1003	,	1	,	2	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	2	,	2	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	3	,	2	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	4	,	3	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	5	,	3	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	6	,	3	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	7	,	3	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	8	,	3	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	9	,	3	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	10	,	4	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1003	,	11	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1003	,	12	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1003	,	13	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1003	,	14	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1003	,	15	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1003	,	16	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1003	,	17	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	1		),
(	1003	,	18	,	4	,	4	,	3	,	3	,	3	,	3	,	1	,	1	,	1	,	1		),
(	1003	,	19	,	4	,	4	,	3	,	3	,	3	,	3	,	2	,	1	,	1	,	1		),
(	1003	,	20	,	4	,	4	,	3	,	3	,	3	,	3	,	2	,	2	,	1	,	1		)

INSERT INTO ClassSpellSlots
VALUES
(	1004	,	1	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	2	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	3	,	3	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	4	,	4	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	5	,	4	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	6	,	4	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	7	,	4	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	8	,	4	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	9	,	4	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	10	,	5	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1004	,	11	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1004	,	12	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1004	,	13	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1004	,	14	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1004	,	15	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1004	,	16	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1004	,	17	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	1		),
(	1004	,	18	,	5	,	4	,	3	,	3	,	3	,	3	,	1	,	1	,	1	,	1		),
(	1004	,	19	,	5	,	4	,	3	,	3	,	3	,	3	,	2	,	1	,	1	,	1		),
(	1004	,	20	,	5	,	4	,	3	,	3	,	3	,	3	,	2	,	2	,	1	,	1		);

INSERT INTO ClassSpellSlots
VALUES
(	1005	,	1	,	2	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	2	,	2	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	3	,	2	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	4	,	3	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	5	,	3	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	6	,	3	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	7	,	3	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	8	,	3	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	9	,	3	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	10	,	4	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1005	,	11	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1005	,	12	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1005	,	13	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1005	,	14	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1005	,	15	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1005	,	16	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1005	,	17	,	4	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	1		),
(	1005	,	18	,	4	,	4	,	3	,	3	,	3	,	3	,	1	,	1	,	1	,	1		),
(	1005	,	19	,	4	,	4	,	3	,	3	,	3	,	3	,	2	,	1	,	1	,	1		),
(	1005	,	20	,	4	,	4	,	3	,	3	,	3	,	3	,	2	,	2	,	1	,	1		);

INSERT INTO ClassSpellSlots
VALUES
(	1011	,	1	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	2	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	3	,	4	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	4	,	5	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	5	,	5	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	6	,	5	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	7	,	5	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	8	,	5	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	9	,	5	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	10	,	6	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1011	,	11	,	6	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1011	,	12	,	6	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1011	,	13	,	6	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1011	,	14	,	6	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1011	,	15	,	6	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1011	,	16	,	6	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1011	,	17	,	6	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	1		),
(	1011	,	18	,	6	,	4	,	3	,	3	,	3	,	3	,	1	,	1	,	1	,	1		),
(	1011	,	19	,	6	,	4	,	3	,	3	,	3	,	3	,	2	,	1	,	1	,	1		),
(	1011	,	20	,	6	,	4	,	3	,	3	,	3	,	3	,	2	,	2	,	1	,	1		);

INSERT INTO ClassSpellSlots
VALUES
(	1013	,	1	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	2	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	3	,	3	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	4	,	4	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	5	,	4	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	6	,	4	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	7	,	4	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	8	,	4	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	9	,	4	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	10	,	5	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1013	,	11	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1013	,	12	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	NULL	,	NULL	,	NULL		),
(	1013	,	13	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1013	,	14	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	NULL	,	NULL		),
(	1013	,	15	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1013	,	16	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	NULL		),
(	1013	,	17	,	5	,	4	,	3	,	3	,	3	,	2	,	1	,	1	,	1	,	1		),
(	1013	,	18	,	5	,	4	,	3	,	3	,	3	,	3	,	1	,	1	,	1	,	1		),
(	1013	,	19	,	5	,	4	,	3	,	3	,	3	,	3	,	2	,	1	,	1	,	1		),
(	1013	,	20	,	5	,	4	,	3	,	3	,	3	,	3	,	2	,	2	,	1	,	1		);


INSERT INTO ClassSpellSlots
VALUES
(	1008	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	2	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	3	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	4	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	5	,	NULL	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	6	,	NULL	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	7	,	NULL	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	8	,	NULL	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	9	,	NULL	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	10	,	NULL	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	11	,	NULL	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	12	,	NULL	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	13	,	NULL	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	14	,	NULL	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	15	,	NULL	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	16	,	NULL	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	17	,	NULL	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	18	,	NULL	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	19	,	NULL	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1008	,	20	,	NULL	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	2	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	3	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	4	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	5	,	NULL	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	6	,	NULL	,	4	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	7	,	NULL	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	8	,	NULL	,	4	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	9	,	NULL	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	10	,	NULL	,	4	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	11	,	NULL	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	12	,	NULL	,	4	,	3	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	13	,	NULL	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	14	,	NULL	,	4	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	15	,	NULL	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	16	,	NULL	,	4	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	17	,	NULL	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	18	,	NULL	,	4	,	3	,	3	,	3	,	1	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	19	,	NULL	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1009	,	20	,	NULL	,	4	,	3	,	3	,	3	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	1	,	2	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	2	,	2	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	3	,	2	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	4	,	3	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	5	,	3	,	NULL	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	6	,	3	,	NULL	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	7	,	3	,	NULL	,	NULL	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	8	,	3	,	NULL	,	NULL	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	9	,	3	,	NULL	,	NULL	,	NULL	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	10	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	2	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	11	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	12	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	13	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	14	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	15	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	16	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	3	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	17	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	18	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	19	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	NULL	,	NULL	,	NULL	,	NULL		),
(	1012	,	20	,	4	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	NULL	,	NULL	,	NULL	,	NULL		)


INSERT INTO ClassSpellsKnown
VALUES
(	1003	,	1	,	4	,	NULL	),
(	1003	,	2	,	5	,	NULL	),
(	1003	,	3	,	6	,	NULL	),
(	1003	,	4	,	7	,	NULL	),
(	1003	,	5	,	8	,	NULL	),
(	1003	,	6	,	9	,	NULL	),
(	1003	,	7	,	10	,	NULL	),
(	1003	,	8	,	11	,	NULL	),
(	1003	,	9	,	12	,	NULL	),
(	1003	,	10	,	14	,	NULL	),
(	1003	,	11	,	15	,	NULL	),
(	1003	,	12	,	15	,	NULL	),
(	1003	,	13	,	16	,	NULL	),
(	1003	,	14	,	18	,	NULL	),
(	1003	,	15	,	19	,	NULL	),
(	1003	,	16	,	19	,	NULL	),
(	1003	,	17	,	20	,	NULL	),
(	1003	,	18	,	22	,	NULL	),
(	1003	,	19	,	22	,	NULL	),
(	1003	,	20	,	22	,	NULL	),
(	1009	,	1	,	NULL	,	NULL	),
(	1009	,	2	,	2	,	NULL	),
(	1009	,	3	,	3	,	NULL	),
(	1009	,	4	,	3	,	NULL	),
(	1009	,	5	,	4	,	NULL	),
(	1009	,	6	,	4	,	NULL	),
(	1009	,	7	,	5	,	NULL	),
(	1009	,	8	,	5	,	NULL	),
(	1009	,	9	,	6	,	NULL	),
(	1009	,	10	,	6	,	NULL	),
(	1009	,	11	,	7	,	NULL	),
(	1009	,	12	,	7	,	NULL	),
(	1009	,	13	,	8	,	NULL	),
(	1009	,	14	,	8	,	NULL	),
(	1009	,	15	,	9	,	NULL	),
(	1009	,	16	,	9	,	NULL	),
(	1009	,	17	,	10	,	NULL	),
(	1009	,	18	,	10	,	NULL	),
(	1009	,	19	,	11	,	NULL	),
(	1009	,	20	,	11	,	NULL	),
(	1011	,	1	,	2	,	NULL	),
(	1011	,	2	,	3	,	NULL	),
(	1011	,	3	,	4	,	NULL	),
(	1011	,	4	,	5	,	NULL	),
(	1011	,	5	,	6	,	NULL	),
(	1011	,	6	,	7	,	NULL	),
(	1011	,	7	,	8	,	NULL	),
(	1011	,	8	,	9	,	NULL	),
(	1011	,	9	,	10	,	NULL	),
(	1011	,	10	,	11	,	NULL	),
(	1011	,	11	,	12	,	NULL	),
(	1011	,	12	,	12	,	NULL	),
(	1011	,	13	,	13	,	NULL	),
(	1011	,	14	,	13	,	NULL	),
(	1011	,	15	,	14	,	NULL	),
(	1011	,	16	,	14	,	NULL	),
(	1011	,	17	,	15	,	NULL	),
(	1011	,	18	,	15	,	NULL	),
(	1011	,	19	,	15	,	NULL	),
(	1011	,	20	,	15	,	NULL	),
(	1012	,	1	,	2	,	NULL	),
(	1012	,	2	,	3	,	2	),
(	1012	,	3	,	4	,	2	),
(	1012	,	4	,	5	,	2	),
(	1012	,	5	,	6	,	3	),
(	1012	,	6	,	7	,	3	),
(	1012	,	7	,	8	,	4	),
(	1012	,	8	,	9	,	4	),
(	1012	,	9	,	10	,	5	),
(	1012	,	10	,	10	,	5	),
(	1012	,	11	,	11	,	5	),
(	1012	,	12	,	11	,	6	),
(	1012	,	13	,	12	,	6	),
(	1012	,	14	,	12	,	6	),
(	1012	,	15	,	13	,	7	),
(	1012	,	16	,	13	,	7	),
(	1012	,	17	,	14	,	7	),
(	1012	,	18	,	14	,	8	),
(	1012	,	19	,	15	,	8	),
(	1012	,	20	,	15	,	8	)


