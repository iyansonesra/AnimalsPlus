//
//  Card.swift
//  SwiftApp
//
//  Created by Sonesra, Iyan M on 2/8/24.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
    var cardClass: String
    var cardHeight: String
    var cardAbout: String
    var cardFun: String
}

var cards: [Card] = [

    Card(name: "Monarch Butterfly", cardNumber: "6.2", cardImage: "butterfly", cardClass: "Insecta", cardHeight: "1/8\"", cardAbout: "You can find butterflies almost anywhere in the world except Antarctica, from hot deserts to cold mountains! They love sunny spots with flowers to sip nectar from, like gardens, meadows, and even your own backyard!", cardFun: "\u{2022} Taste with their feet: No tongues here! Butterflies sip and taste nectar with tiny sensors on their legs. \n\n \u{2022} Wings are an illusion: Those vibrant wings aren't colored, but covered in thousands of tiny scales reflecting light like a prism! \n\n \u{2022} Migratory marvels: Some species, like the Monarch, embark on epic journeys, flying thousands of miles - like going from New York to California! "),
    Card(name: "African Elephant", cardNumber: "6.2", cardImage: "elephant", cardClass: "Mammalia", cardHeight: "120\"", cardAbout: "Working", cardFun: "\u{2022} Trunky Talkers: Elephants don't trumpet with their mouths, but with their amazing trunks! \n \u{2022} Elephantine Einstein: Their memories are incredible, recognizing other elephants and even humans years later! \n \u{2022} Muddy Marvels: These water lovers take regular mud baths for sun protection and coolness."),
    Card(name: "Kangaroo", cardNumber: "6.2", cardImage: "kangaroo", cardClass: "Mammalia", cardHeight: "59\"", cardAbout: "Found primarily in Australia, kangaroos inhabit diverse environments from arid plains to lush forests. While most species prefer open areas for their powerful hops, they're surprisingly adaptable, making them widespread across the continent.", cardFun: "\u{2022} Leaps of greatness: Their powerful legs propel them up to 25 feet in a single hop! \n \u{2022} Boxing babies: Baby kangaroos, called joeys, develop in a pouch and box with tiny paws while still tiny! \n \u{2022} Social butterflies: Many kangaroo species live in groups called \"mobs\" led by an alpha female!"),
    Card(name: "Emperor Penguin", cardNumber: "6.2", cardImage: "penguin", cardClass: "Aves", cardHeight: "50\"", cardAbout: "Most penguins live on the Southern Hemisphere's beaches and rocky islands, from Antarctica's icy shores to warm, sandy spots near Australia and Africa! Even though they love swimming in cool water, no penguins live at the North Pole.", cardFun: "\u{2022} Tuxedo Time: Penguins wear their black and white \"tuxedos\" for both camouflage (blending in with water and rocks) and attracting mates! \n \u{2022} Torpedo Torso: They torpedo through water like little feathered rockets, reaching speeds of 20 mph thanks to flippers and streamlined bodies. \n \u{2022} Landlubbers, Not Lazy Bums: On land, they waddle using their beaks for balance, but don't underestimate their agility - some penguin species can jump!"),
    Card(name: "Bengal Tiger", cardNumber: "6.2", cardImage: "tiger", cardClass: "Mammalia", cardHeight: "39\"", cardAbout: "Forget zoos, imagine chilling in rainforests, snowy mountains, or even swampy jungles – that's where tigers live! These striped hunters roam across Asia, from Russia's icy lands to Indonesia's tropical islands, as long as there's food and good hiding spots for catching prey.", cardFun: "\u{2022} Silent Stalkers: Tigers roar, but they're mostly quiet hunters, using stripes as camouflage and creeping close before pouncing. They're like ninjas of the jungle! \n \u{2022} Swimming Tigers: Don't underestimate their water skills! Tigers love a cool dip and can even swim long distances. \n \u{2022} Taste the Rainbow: Although they can't see in color, tigers have over 2,000 taste buds, making their meals extra delicious."),
    Card(name: "Gray Wolf", cardNumber: "6.2", cardImage: "wolf", cardClass: "Mammalia", cardHeight: "32\"", cardAbout: "Wolves are like super adaptable camping champs! They can live in all sorts of wild places, from snowy mountains and grassy plains to thick forests and even hot deserts. As long as they have enough space to roam and hunt for food, they can make it their home!", cardFun: "\u{2022} Super sniffers: Wolves have 200 million scent receptors in their noses, 25x more than humans! They can smell prey kilometers away. \n \u{2022} Howlin' good communication: Wolves howl to stay in touch with their pack, warn others of danger, and even find mates. \n \u{2022} Master puppeteers: Alpha wolves don't physically fight for leadership. They use body language and vocalizations to keep the pack in check."),
    Card(name: "Ostrich", cardNumber: "6.2", cardImage: "ostrich", cardClass: "Aves", cardHeight: "96\"", cardAbout: "Ostriches strut their stuff across Africa's savannas and deserts, like the ultimate off-road adventurers! These flightless giants roam open grasslands and woodlands, avoiding dense forests that cramp their speedy sprinting style.  Think hot sun, dusty plains, and maybe even sharing the landscape with zebras and giraffes for a wild hangout.", cardFun: "\u{2022} Fastest land birds: Ostriches clock in at 43 mph, outrunning most predators (except maybe your car!). \n \u{2022} Can't fly, can kick: Their wings are tiny, but their powerful legs deliver kicks strong enough to break bones! \n \u{2022} Eye spy: Each ostrich eye is bigger than their brain, giving them excellent vision to spot danger."),
    Card(name: "Peregrine Falcon", cardNumber: "6.2", cardImage: "falcon", cardClass: "Aves", cardHeight: "18\"", cardAbout: "Peregrine falcons are like daredevils! They love high places, so they build their homes on tall cliffs, buildings, and even bridges in cities and mountains all over the world. Pretty cool, right?", cardFun: "\u{2022} Fastest feathered friend: Peregrine falcons dive bomb at over 200 mph, making them the fastest animal on Earth! \n \u{2022} City slickers: They love tall buildings and bridges, making them common sights in urban areas. \n \u{2022} Double vision: Each eye focuses on different parts of their prey, giving them amazing 3D hunting skills"),
//    Card(name: "Giant Panda", cardNumber: "6.2", cardImage: "panda"),
   




]
