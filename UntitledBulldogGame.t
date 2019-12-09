#charset "us-ascii"

#include <adv3.h>
#include <en_us.h>


versionInfo: GameID
    IFID = 'df9a601e-71af-457d-8bee-37e42e5ae378'
    name = 'Untitled Bulldog Game'
    byline = 'by Carrie Bergstedt'
    htmlByline = 'by <a href="mailto:cbergste@unca.edu">
                  Carrie Bergstedt</a>'
    version = '1'
    authorEmail = 'Carrie Bergstedt <cbergste@unca.edu>'
    desc = 'Minimum Viable Product for my senior project'
    htmlDesc = 'Minimum Viable Product for my senior project'
;


gameMain: GameMainDef
    /* the initial player character is 'me' */
    initialPlayerChar = me
    location= RHRO216
;

RHRO216: Room
    roomName='room 216 in Rhoades Robinson'
    desc="You're in room 216 in the Rhoades Robinson building, the designated undergraduate research room for CSCI.
        The room is stuffed with desks, desktop computers, a single large table, and entirely too many chairs. 
        The exit is to the west; the east wall is covered in windows while the south wall has a single whiteboard."
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
;


+Decoration 'seating area/seats' 'seating area' "Two chairs and coffee table. Useful for waiting for classes.";
