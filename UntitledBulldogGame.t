#charset "us-ascii"

/*
 *   Copyright (c) 1999, 2002 by Michael J. Roberts.  Permission is
 *   granted to anyone to copy and use this file for any purpose.  
 */


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
    southeast=RHRO2ndFloorStairwell
;

+Decoration 'seating area/seats' 'seating area' "Two chairs and coffee table. Useful for waiting for classes.";

/*north and west halls blocked inaccessable- can go west and to the stairwell*/

RHRO2ndFloorStairwell: Room
    roomName='2nd Floor Stairwell in Rhoades Robinson'
    desc="You're in a well-used stairwell that continues both up and down. The exit to the lobby is to the northwest."
    northwest=RHRO2ndFloorLobby
    up=RHRO3rdFloorStairwell
    down=RHRO1stFloorStairwell
;

RHRO3rdFloorStairwell: Room
    roomName='3rd Floor Stairwell in Rhoades Robinson'
    desc="You're in a well-used stairwell that continues down. The exit to the 3rd floor is to the north."
    north= RHRO3rdFloor
    down=RHRO2ndFloorStairwell
;

RHRO1stFloorStairwell: Room
    '1st Floor Stairwell in Rhoades Robinson'
    "You're in a well-used stairwell that continues up. The exit to the lobby is to the north."
    north=RHRO1stFloorLobby
    up=RHRO2ndFloorStairwell
;




