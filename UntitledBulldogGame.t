#charset "us-ascii"



#include <adv3.h>
#include <en_us.h>


versionInfo: GameID
    IFID = 'ef15c3da-0d04-492a-95de-8c3f7b71b984'
    name = 'Unnamed Bulldog Game'
    byline = 'by Carrie Bergstedt'
    htmlByline = 'by <a href="mailto:cbergste@unca.edu">
                  Carrie Bergstedt</a>'
    version = '1'
    authorEmail = 'Carrie Bergstedt <cbergste@unca.edu>'
    desc = 'My senior project! '
    htmlDesc = 'My senior project! '
;

gameMain: GameMainDef
    /* the initial player character is 'me' */
    initialPlayerChar = me
;

/* 
 *   Starting location - we'll use this as the player character's initial
 *   location.  The name of the starting location isn't important to the
 *   library, but note that it has to match up with the initial location
 *   for the player character, defined in the "me" object below.
 *   
 *   Our definition defines two strings.  The first string, which must be
 *   in single quotes, is the "name" of the room; the name is displayed on
 *   the status line and each time the player enters the room.  The second
 *   string, which must be in double quotes, is the "description" of the
 *   room, which is a full description of the room.  This is displayed when
 *   the player types "look around," when the player first enters the room,
 *   and any time the player enters the room when playing in VERBOSE mode.
 *   
 *   The name "startRoom" isn't special - you can change this any other
 *   name you'd prefer.  The player character's starting location is simply
 *   the location where the "me" actor is initially located.  
 */
RHRO216: Room
    roomName='room 216 in Rhoades Robinson'
    desc="You're in room 216 in the Rhoades Robinson building, the designated undergraduate research room for CSCI.
        The room is completely stuffed with furnature and computers."
    west=RHRO2ndFloorLobby
;

+Decoration 'white board/whiteboard/board' 'whiteboard'
    "The large whiteboard covers the entire south wall. It is currently emblazioned with the phrase OUT OF COFFEE."
;
+Decoration 'window/windows' 'window'
    "The windows overlook the main quad on campus. There really isn't anything going on out there, but the weather looks nice."
;
+desk : Heavy, Surface 'desk' 'desk' "A simple, largeish desk. It's got a desktop computer on top of it.";
++desktop : Thing 'desktop/desktop computer/computer' 'desktop' 
    "A plain desktop computer. It's a few years old, but still perfectly usable.";
+table : Heavy, Surface 'table/large table' 'table' "A large, plain table.  
    It sits dead center of the room and eats up a lot of space.";

+ me: Actor
;

RHRO2ndFloorLobby: Room
    '2nd floor lobby in Rhoades Robinson'
    "You're in the 2nd floor lobby of Rhoades Robinson. There's a small seating area and an elevator that is currently out of order.
    Room 216 is to the east; there are hallways to the north, south, and west, and a stairwell to the southeast."
    east=RHRO216
    southwest=RHRO2ndFloorStairwell
;

+Decoration 'seating area/seats' 'seating area' "Two chairs and coffee table. Useful for waiting for classes.";

/*north and west halls blocked inaccessable- can go west and to the stairwell*/

RHRO2ndFloorStairwell: Room
    roomName='2nd Floor Stairwell in Rhoades Robinson'
    desc="You're in a well-used stairwell that continues both up and down. The exit to the lobby is to the northwest."
    northeast=RHRO2ndFloorLobby
    up=RHRO3rdFloorStairwell
    down=RHRO1stFloorStairwell
;

RHRO3rdFloorStairwell: Room
    roomName='3rd Floor Stairwell in Rhoades Robinson'
    desc="You're in a well-used stairwell that continues down. The exit to the 3rd floor is to the north."
    east= RHRO3rdFloor
    down=RHRO2ndFloorStairwell
;

RHRO1stFloorStairwell: Room
    '1st Floor Stairwell in Rhoades Robinson'
    "You're in a well-used stairwell that continues up. The exit to the lobby is to the north."
    east=RHRO1stFloorLobby
    up=RHRO2ndFloorStairwell
;

RHRO3rdFloor: Room
    '3rd Floor in Rhoades Robinson'
    "You're in a hallway that's surprisingly well traveled for all its composition of mainly offices.
    The campus Math Lab is at the end of the hall."
    west= RHRO3rdFloorStairwell
    //add in the math lab as a decoration? It's def closed at the least
;

RHRO1stFloorLobby: Room
    '1st Floor Lobby in Rhoades Robinson'
    "You're in the main lobby for the Rhoades Robinson building. There's a couple of seating arangements and a handful of exits."
    south=RHROAtrium
    west=RHRO1stFloorStairwell
    northwest=Quad //block off this exit for most of the game
;

RHROAtrium: Room
    'Large Glass Room in Rhoades Robinson'
    "You're in a large room with several glass-pane walls letting in lots of light."
    north=RHRO1stFloorLobby
    west=OutdoorSeatingArea
;

OutdoorSeatingArea: OutdoorRoom
    'An Outdoor Seating Area'
    "You're by a smallish outdoor seating area. It looks like a good place for some reading when the weather cooperates."
    east=RHROAtrium
    northwest=Quad //block off this exit for most of the game
    southeast=DiningHall
;

DiningHall: Room
    'Brown Dining Hall'
    "You're in the campus's dining hall. 
    There's a handful of students about nibbling at food while working on schoolwork and projects."
    north=SidewalkToZeis
    northwest=OutdoorSeatingArea
    southwest=SUBridge
;

SidewalkToZeis: OutdoorRoom
    'Sidewalk To Zeis'
    "You're on the sidewalk connecting the dining hall to Zeis Hall."
    south=DiningHall
    west=StairwellToRocks
;

StairwellToRocks: OutdoorRoom
    'Top of a Stairwell by some Rocks'
    "You're at the top of a stairwell by a collection of large rocks."
    //include some of the rocks to look at here!
    east=SidewalkToZeis
    west=FrontOfLibrary
;

FrontOfLibrary: OutdoorRoom
    'Out Front of the Library'
    "You're standing right out front of the library doors. The view from here is truely a sight to behold."
    //include picture from the library steps here, possibly when player examines room
    north=LibraryLobby
    south=Quad
    east=StairwellToRocks
    northwest=SidewalkToSculptures
;

LibraryLobby: Room
    'Lobby of the Library'
    "You're in the lobby of the library. It's rather impressive, if a bit dated."
    //the tea shop goes in here somewhere; probably closed
    north=LibraryInterior
    south=FrontOfLibrary
;
    
LibraryInterior: Room
    'Inside Library'
    "You're inside the library proper. It's a rather lively area."
    south=LibraryLobby
;

Quad: OutdoorRoom
    'The Quad'
    "You're on the main quad. It's a grassy field with a flagpole in the middle, criss-crossed by sidewalks.
    There are buildings on all four sides of the quad and major exits on the corners."
    north=FrontOfLibrary
    east=RHRO1stFloorLobby
    west=KarpenLobby
    southeast=BusStop
    northwest=SidewalkToSculptures
;

KarpenLobby: Room
    'Lobby of Karpen'
    "You're in the main lobby of Karpen Hall. It's a well-maintained area with some seating around the edges."
    east=Quad
    //input Laurel Forum at some point?
;

SidewalkToSculptures: OutdoorRoom
    'Sidewalk to some Sculptures'
    "You're on a sidewalk that leads to a couple larger sculptures. It's obviously a bit of a back route around campus."
    northwest=Sculptures
    southeast=FrontOfLibrary
;

Sculptures: OutdoorRoom
    'Sculptures'
    "You're standing near two largish sculptures. One looks like an upside-down bird's nest; the other is a maize outlined by rocks."
    west=Rocky
    southeast=SidewalkToSculptures
;

Rocky: OutdoorRoom
    'Rocky the Bulldog the Statue'
    "You're standing by the best artwork on campus- the statue of Rocky the Bulldog!"
    south=BusStop
    east=Sculptures
    west=Rosettas
;

Rosettas: Room
    'Rosettas Kitchenette'
    "You're standing inside Rosetta's Kitchenette. It's an auxilary site for a veggie/vegan place downtown, and it's pretty popular."
    east=Rocky
;

BusStop: OutdoorRoom
    'Bus Stop'
    "You're at the main bus stop on campus. Both the campus shuttles and the city bus line stops here- not that either of those are anywhere in sight."
    west=Rocky
    south=SUBridge
    northwest=Ponder
    southeast=Quad
;

SUBridge:OutdoorRoom
    'Student Union Bridge'
    "You're standing at the foot of the skyway bridge to the student union. It's an interesting way to connect the building to the sidewalk, that's for sure."
    north=BusStop
    south=DiningHall
    west=SU2ndFloor 
;

SU2ndFloor: Room
    'Second floor of the Student Union'
    "You're on the second floor of the student union. There's plenty of little areas to sit and study, not to mention the coffee shop!"
    //impliment Roasted coffee shop
    east=SUBridge
    down=SU1stFloor
;

SU1stFloor: Room
    'First floor of the Student Union'
    "You're on the first floor of the student union. There's a handful of different seating areas, but most of the floorspace is the food court."
    //impliment food court
    up=SU2ndFloor
;

Ponder: Room
    'Ponder Hall Lobby'
    "You're in the lobby of Ponder Hall. It's got a nice mural of some mountains on one wall, plus a large staircase to downstairs."
    down=Dunder
    southeast=BusStop
;

Dunder: Room
    'The Down Under'
    "You're in The Down Under food stop/convenience store. Most of the students shorten the name to 'Dunder."
    up=Ponder
;





