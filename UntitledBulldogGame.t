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
    
    showAbout(){
        "This is a senior project intended to be both a moderately fun game and tour of the University of 
        North Carolina at Asheville's campus!";
        //flesh this out w common commands n stuff later
    }
;

gameMain: GameMainDef
    /* the initial player character is 'me' */
    initialPlayerChar = me
    
    showIntro(){
        "You wake up from the sound of a rather sturdy popping noise, which probably indicates that some absolute nonsense is on its way.
        Said nonsense rather immediately resolves itself to be a resounding lack of coffee in the room. Or, for that matter, anything with 
        which coffee could be made. You'd best go fetch some coffee, then!";
    }
;

/* 
 *   Starting location 
 */
RHRO216: Room
    roomName='room 216 in Rhoades Robinson'
    desc="You're in room 216 in the Rhoades Robinson building, the designated undergraduate research room for CSCI.
        The room is completely stuffed with furnature and computers, and a set of windows on the east wall. 
        The exit door is to the west."
    //west=RHRO2ndFloorLobby
    west : OneWayRoomConnector{
        destination=RHRO2ndFloorLobby
        canTravelerPass(traveler) { return chair.isIn(traveler); } //change so it only checks if the chair is in the room
        explainTravelBarrier(traveler) {"The furniture is blocking your path to the exit.";}
    }
    enteringRoom (traveler) {
        "You just barely manage to get into the room before bumping into a rather frazzled computer science student. They
        give you a confused look that quickly turns into joy as you hand them the bag of coffee. Thrilled with the new 
        source of caffiene, they immediately start the coffee machine to brewing. Looks like a job well done!";
        addToScore(5,'fetched coffee');
        finishGameMsg(ftVictory, [finishOptionUndo,finishOptionFullScore]); 
    }
;

+Decoration 'white board/whiteboard/board' 'whiteboard'
    "The large whiteboard covers the entire south wall. It is currently emblazioned with the phrase OUT OF COFFEE."
;
+Decoration 'window/windows' 'window'
    "The windows overlook the main quad on campus. There really isn't anything going on out there
    other than the setup for some sort of event, but the weather looks nice."
;
+Decoration 'computer/computers' 'computer'
    "An ordinary but useful desktop computer. Good for doing schoolwork between classes."
;
+table : Heavy, Surface 'table/large table' 'table' "A large, plain table.  
    It sits dead center of the room and eats up a lot of space.";
+chair : Thing 'chair' 'chair'
    "A sturdy but plain chair, servicable for all your chair-based needs.";
+ me: Actor
    pcDesc = "You're a robotic version of Rocky the Bulldog, or RoboRocky for short! And you're fully equipped with an 
        infinite inventory and a grabber claw to get things to put into said inventory. Perfect for the kind of nonsense
        you tend to deal with on a regular basis."
;

RHRO2ndFloorLobby: Room
    '2nd floor lobby in Rhoades Robinson'
    "You're in the 2nd floor lobby of Rhoades Robinson. There's a small seating area and an elevator that is currently out of order.
    Room 216 is to the east; there are hallways to the north, south, and west, and a stairwell to the southeast."
    east: OneWayRoomConnector{
        destination=RHRO216
        canTravelerPass(traveler) { return coffee.isIn(traveler); } 
        explainTravelBarrier(traveler) {"No sense going back there without any coffee.";}
    }//somehow put finishgamemsg in here? as part of a travelmessage
    southeast=RHRO2ndFloorStairwell
    north : DeadEndConnector{"You wander down the hallway a bit before running into a freshly-mopped floor, 
        forcing you to turn back."
    }
    south : DeadEndConnector{"You manage to get a few yards down the hallway before being blocked by a 
        group of freshman who clearly aren't going to move any time soon. You head back to the lobby."}
    west : DeadEndConnector{"You get most of the way down the hallway before being blocked by Atmospheric Science students
        arguing over the latest weather reports. Best to leave them be and head back to the lobby."}
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

+coffeeNotebook: Readable 'notebook/coffee-stained notebook' 'coffee-stained notebook'
    "It's a small notebook that has a number of various coffee stains on it."
    
    readDesc="You peel open the notebook and flip through it. There isn't a ton left readable by this point, 
        but you can make out a list of locations on campus- the Math Lab, Dining Hall, Library, 
        Rosetta's Kitchenette, the Down Under, and the Student Union. After figuring that 
        was the only thing of note in the notebook, you flop it shut."
    
    dobjFor(Open) asDobjFor(Read)
    
    dobjFor(Read)
    {
        action()
        {
            inherited;
            achievement.awardPointsOnce();
        }
    }
    
    cannotCloseMsg = 'It\'s already closed. '
    achievement: Achievement { +5 "reading the notebook" }
;

RHRO3rdFloorStairwell: Room
    roomName='3rd Floor Stairwell in Rhoades Robinson'
    desc="You're in a well-used stairwell that continues down. The exit to the 3rd floor is to the east."
    east= RHRO3rdFloor
    down=RHRO2ndFloorStairwell
;

RHRO1stFloorStairwell: Room
    '1st Floor Stairwell in Rhoades Robinson'
    "You're in a well-used stairwell that continues up. The exit to the lobby is to the east."
    east=RHRO1stFloorLobby
    up=RHRO2ndFloorStairwell
;

RHRO3rdFloor: Room
    '3rd Floor in Rhoades Robinson'
    "You're in a hallway that's surprisingly well traveled for all its composition of mainly offices.
    The Math Lab is at the end of the hall."
    west= RHRO3rdFloorStairwell
;

+MathLab : RoomPartItem, Decoration 'Math Lab' 'Math Lab'
    "The main place on campus for getting help with math or statistics. The employees usually have a pot of coffee going,
    but it looks like the place has been locked up for the day. "
    dobjFor(Examine)
    {
     action()
     {
       achievement.awardPointsOnce();
       inherited;
     }
   }
   achievement : Achievement { +3 "Found the Math Lab" } 
;
;//award points for examining the first time only, change to something other than decoration?

+smallBookshelf : Surface, Fixture 'small bookshelf/bookshelf/bookcase' 'small bookshelf'
    "A small bookshelf that has seen better days and more interesting contents than what it currently has."
;

++crumpledHat : Hidden, Wearable 'crumpled hat' 'crumpled hat'
    "A small festive-looking hat which has been rather crumpled."
;

RHRO1stFloorLobby: Room
    '1st Floor Lobby in Rhoades Robinson'
    "You're in the main lobby for the Rhoades Robinson building. 
    There's a couple of seating arangements and a handful of exits."
    south=RHROAtrium
    west=RHRO1stFloorStairwell
    //northwest=Quad //block off this exit for most of the game
    northwest: OneWayRoomConnector{
        destination=Quad
        canTravelerPass(traveler) { return partyFlyer.isIn(traveler); } 
        explainTravelBarrier(traveler) {"You're not going out into all that setup without knowing exactly what's going on first.";}
    }
;

RHROAtrium: Room
    'Large Glass Room in Rhoades Robinson'
    "You're in a large room with several glass-pane walls letting in lots of light. The first floor lobby is to the north;
    there's an outdoor seating area visible through the glass to the west."
    north=RHRO1stFloorLobby
    west=OutdoorSeatingArea
;

OutdoorSeatingArea: OutdoorRoom
    'An Outdoor Seating Area'
    "You're by a smallish outdoor seating area. It looks like a good place for some reading when the weather cooperates.
    To the east is the Atrium; the northwest has the Quad, and to the southeast lies the dining hall."
    east=RHROAtrium
    northwest: OneWayRoomConnector{
        destination=Quad
        canTravelerPass(traveler) { return partyFlyer.isIn(traveler); } 
        explainTravelBarrier(traveler) {"You're not going out into all that setup without knowing exactly what's going on first.";}
    }
    southeast=DiningHall
;

DiningHall: Room
    'Brown Dining Hall'
    "You're in front of the campus dining hall. The Outdoor Seating Area is to the north, the student union to the southwest,
    and the back sidewalk path runs to the north."
    north=SidewalkToZeis
    northwest=OutdoorSeatingArea
    southwest=SUBridge
;
+SidewalkToZeis: PathPassage 'Back Sidewalk Path' 'Back Sidewalk Path'
    "This longish sidewalk runs behind the Rhoades-Robinson Building. "
;
/*SidewalkToZeis: OutdoorRoom
    'Sidewalk To Zeis'
    "You're on the sidewalk connecting the dining hall to Zeis Hall."
    south=DiningHall
    west=StairwellToRocks
;*/

StairwellToRocks: OutdoorRoom
    'Top of a Stairwell by some Rocks'
    "You're at the top of a stairwell by a collection of large rocks. To the west is the front of the library;
    to the east is the back sidewalk path."
    east=SidewalkTZ
    west=FrontOfLibrary
;
+SidewalkTZ: ThroughPassage -> SidewalkToZeis 'Back Sidewalk Path' 'Back Sidewalk Path'
;
+Decoration 'large rocks/rock' 'large rocks'
    "A dozen or so very large rocks. They're all labeled with what kind of rock they are. Too bad you don't know enough
    about geology to really bother with them."
;

FrontOfLibrary: OutdoorRoom
    'Out Front of the Library'
    "You're standing right out front of the library doors. The view from here is truely a sight to behold."
    //include picture from the library steps here, possibly when player examines room
    north=LibraryLobby
    south: OneWayRoomConnector{
        destination=Quad
        canTravelerPass(traveler) { return partyFlyer.isIn(traveler); } 
        explainTravelBarrier(traveler) {"You're not going out into all that setup without knowing exactly what's going on first.";}
    }
    east=StairwellToRocks
    northwest=SidewalkToSculptures
;

LibraryLobby: Room
    'Lobby of the Library'
    "You're in the lobby of the library. It's rather impressive, if a bit dated. North will take you further into the
    building, south will take you back outside, and west takes you into Argo Tea."
    //the tea shop goes in here somewhere; probably closed
    north=LibraryInterior
    south=FrontOfLibrary//can't leave library until you obtain something from the library interior
    west: DeadEndConnector {"You try to nudge your way into Argo Tea, but you simply can't manage to get around
        the mass of students in the queue, which is by this point winding well past the door. ";}
    
;
    
LibraryInterior: Room
    'Inside Library'
    "You're inside the library proper. It's a rather lively area, with lots of students about working on various things
    and a very, very large number of bookshelves, one of which is fairly close by to you."
    south=LibraryLobby
;

+largeBookshelf: Surface,Fixture 'large bookshelf/bookshelf/bookcase' 'large bookshelf'
    "A large bookshelf containing the libarian's current themed book display."
;

Quad: OutdoorRoom
    'The Quad'
    "You're on the main quad. It's a grassy field with a flagpole in the middle, criss-crossed by sidewalks.
    There are buildings on all four sides of the quad and major exits on the corners, and quite the party going on in the middle!"
    north=FrontOfLibrary
    east=RHRO1stFloorLobby
    west=KarpenLobby
    southeast=BusStop
    northwest=SidewalkToSculptures
;

KarpenLobby: Room
    'Lobby of Karpen'
    "You're in the main lobby of Karpen Hall. It's usually a well-maintained area with some seating around the edges,
    but right now it's a bit of a mess from everything the art students are doing."
    east=Quad
;

+ Decoration 'small pile/things' 'pile of things'
    "A medium-sized pile of odds and ends that were evidently intended as art supplies <<coffee.moved ? nil :',
        including an unopened bag of coffee grounds'>>.<<coffee.discover>>"
    dobjFor(Search) asDobjFor(Examine)
;

+ coffee: Hidden 'unopened bag of coffee grounds' 'coffee'
    "An average-sized bag of coffee grounds, for use with your average coffee machine."
;//add big achievement for obtaining

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
    //add in statue of rocky; putting a hat on the statue gets an achievement
;

Rosettas: Room
    'Rosettas Kitchenette'
    "You're standing inside Rosetta's Kitchenette. It's an auxilary site for a veggie/vegan place downtown, 
    and it's usually pretty popular... when it's open at least. Looks like the employees are closing up shop for the day."
    enteringRoom(traveler)
     {       
       if(!traveler.hasSeen(self) && traveler == gPlayerChar)   
         addToScore(3, 'finding yet another location out of coffee. ');              
     } 
    east=Rocky
;

BusStop: OutdoorRoom
    'Bus Stop'
    "You're at the main bus stop on campus. Both the campus shuttles and the city bus line stops here- not that either of those are anywhere in sight."
    west=Rocky
    south=SUBridge
    northwest=Ponder
    southeast: OneWayRoomConnector{
        destination=Quad
        canTravelerPass(traveler) { return partyFlyer.isIn(traveler); } 
        explainTravelBarrier(traveler) {"You're not going out into all that setup without knowing exactly what's going on first.";}
    }
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
;


Ponder: Room
    'Ponder Hall Lobby'
    "You're in the lobby of Ponder Hall. It's got a nice mural of some mountains on one wall, plus a large staircase leading down."
    down=Dunder
    southeast=BusStop
;

+dormEntry: RoomPartItem, Decoration 'doors/dorm entry doors/dorm entry' 'Dorm Entry Doors'
    "The double doors that lead into the actual living spaces of Ponder Hall. You're not allowed past 'em, 
    not since the Potato Incident of Fall '22."
;

Dunder: Room
    'The Down Under'
    "You're in The Down Under food stop/convenience store. Most of the students shorten the name to 'Dunder."
    up=Ponder
;
//party flyer is key to getting into the quad
+partyFlyer : Thing 'flyer/party flyer' 'Party Flyer'
    "It's a flyer for the latest event Asheville Campus Entertainment is putting on. Looks like it'll be fun!"
    dobjFor(Examine)
    {
     action()
     {
       achievement.awardPointsOnce();
       inherited;
     }
   }
   achievement : Achievement { +5 "Party Time!" }
;



