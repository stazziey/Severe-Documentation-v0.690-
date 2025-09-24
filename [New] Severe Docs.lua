LUAU VERSION: 0.690
== [ roblox lua information ] ==
! all "get" and "set" functions below are PascalCase for rlua support !
general properties:
.Data - returns the userdata
.Name - returns the name
.ClassName - returns the classname
.Parent - returns the parent

example:
print(game.Players:FindFirstChild("novice"))
game:FindService("UserInputService"):SetMouseLocation(0, 0)
print(game:FindService("Players").localPlayer.Name)
print(game:FindService("Players").localPlayer.Data) -- returns userdata
== [ predefined globals ] ==
[return: userdata] <- Game - returns datamodel
[return: table] <- game - returns datamodel [rlua only]
[return: userdata] <- Workspace - returns workspace
[return: userdata] <- workspace - returns workspace [rlua only]
[return: table] <- taskscheduler - returns task scheduler global
== [ misc functions ] ==
[returns: tuple - fields: vector, boolean] <- worldtoscreenpoint -> [argument: vector] - this function returns the screen points of the vector and whether this point is within the bounds of the screen.
[return: none] <- print -> [argument: string] - prints out in white text [optimized - 3x faster]
[return: none] <- warn -> [argument: string] - prints out in yellow text [optimized - 3x faster]
[return: none] <- wait -> [argument: [OPTIONAL] number] - yields the current thread with specified timeout
[return: none] <- spawn -> [argument: function] - spawns in a task which is executed in the scheduler.
[return: string] <- gethwid -> [argument: none] - returns the current user SID
[return: none] <- setclipboard -> [argument: string] - sets the string argument to your clipboard.
[return: number] <- tick -> [argument: none] - returns the amount of time in seconds since severe started running [renamed from time]
[return: number] <- gcinfo -> [argument: none] - returns the total memory heap size in kilobytes.
[return: variant] <- loadstring -> [argument: string, [OPTIONAL] [CHUNK] string] - loads lua code from the string and return it as a function.
[return: boolean] <- isrbxactive -> [argument: none] - returns a boolean indicating if roblox is focused or not
[return: none] <- destroy -> [argument: userdata] - sets the userdata parent to nothing technically destroying it
[return: none] <- makefolder -> [argument: string - foldername] - creates a folder : C:\v2\data
[return: none] <- delfolder -> [argument: string - foldername] - deletes the folder  : C:\v2\data [renamed from deletefolder]
[return: none] <- delfile -> [argument: string - filename] - deletes the file  : C:\v2\data [renamed from deletefile]
[return:  boolean] <- isfolder -> [argument: string - foldername] - checks if the folder exists  : C:\v2\data [renamed from checkfolder]
[return: boolean] <- isfile -> [argument: string - filename] - checks if the file exists : C:\v2\data [renamed from checkfile]
[return: table] <- listfiles -> [argument: string - FOLDERNAME OR EMPTY STRING FOR DEFAULT] - lists all files in C:\v2\data
[return: none] <- writefile -> [argument: string - filename, string - data] - creates the file and write the data into it. : C:\v2\data
[return: string] <- readfile -> [argument: string - filename] - returns the contents from the filename. : C:\v2\data
[return: none] <- block_roblox_window -> [argument: boolean] - this blocks any inputs towards roblox
[return: none] <- SET_SCHEDULER_TIMEOUT-> [argument: boolean] - makes it so the scheduler can timeout if frozen for 7 seconds or not
[return: boolean] <- ismenuopened -> [argument: none]  - returns a boolean indicating if severe menu is opened or not
[return: boolean] <- is_team_check_active -> [argument: none]  - returns a boolean indicating if team check is enabled or not
[return: boolean] <- is_forcefield_check_active -> [argument: none]  - returns a boolean indicating if force field check is enabled or not
[return: boolean] <- is_tool_check_active -> [argument: none]  - returns a boolean indicating if tool check is enabled or not
[return: boolean] <- is_local_name_check_active -> [argument: none]  - returns a boolean indicating if local name is enabled or not
[return: boolean] <- is_local_health_check_active -> [argument: none]  - returns a boolean indicating if local health is enabled or not
[return: none] <- send_notification -> [argument: string - content, string - type] - sends a notification popup request to severe [renamed from SendNotification]
[return: boolean] <- add_model_data -> [argument: table, string - key] - creates model data with specific key and processed in model thread, returns true if success.
[return: boolean] <- edit_model_data -> [argument: table, string - key] - edits existing model data from specific key, returns true if success.
[return: boolean] <- remove_model_data -> [argument: string - key] - removes existing model data from specific key, returns true if success.
[return: boolean] <- clear_model_data -> [argument: none] - removes all model data, returns true if success.
[return: boolean] <- override_local_data -> [argument: table] - overrides existing or creates local data for local thread, returns true if success.
[return: boolean] <- clear_local_data -> [argument: none] - removes all created local data, returns true if success.
[return: userdata] <- pointer_to_userdata -> [argument: number - pointer] - returns the pointer as a userdata you can use for internals functions [renamed from pointer_to_user_data]
[return: number] <- getgameid -> [argument: none] - returns the game id
[return: number] <- getplaceid -> [argument: none] - returns the place id
[return: none] <- queue_on_teleport -> [argument: string] - sends script to queue which gets executed on successful teleport
[return: any] <- getrawmetatable -> [argument: any] - gets the raw metatable of the object
[return: any] <- setrawmetatable -> [argument: any, any] - sets the raw metatable of the object

== [ instance functions ] ==
[return: table] <- hastag -> [argument: userdata, string] - returns true if the instance has the specified tag
[return: none] <- addtag -> [argument: userdata, string] - adds a tag to the instance
[return: table] <- gettags -> [argument: userdata] - returns all tags of the instance
[return: none] <- cleartags -> [argument: userdata] - clears all tags from the instance
[return: none] <- removetag -> [argument: userdata, string] - removes a tag from the instance
[return: none] <- setattribute -> [argument: userdata, string, any] - sets an attribute on the instance
[return: any] <- getattribute -> [argument: userdata, string] - gets an attribute from the instance
[return: table] <- getattributes -> [argument: userdata] - gets all attributes from the instance

== [ get functions ] ==
[return: number or table or bool or int or string] <- getvalue -> [argument: userdata] - returns the value property of the userdata class name must include "Value"
[return: userdata] <- findfirstchild -> [arguments: userdata, string] - returns the first child of the userdata with the given name
[return: userdata] <- findfirstchildofclass -> [arguments: userdata, string] - returns the first child of the userdata whose classname is equal to the given classname
[return: userdata] <- findfirstancestorofclass -> [arguments: userdata, string] - returns the first ancestor of the userdata whose name is equal to the given name.
[return: number] <- get_overlay_fps -> [argument: none] - returns the fps of the overlay
[return: string] <- getname -> [argument: userdata] - returns the name of the userdata
[return: string] <- getclassname -> [argument: userdata] - returns the classname of the userdata
[return: array] <- getchildren -> [argument: userdata] - returns an array containing all of the userdata direct children
[return: array] <- getdescendants [unsafe] -> [argument: userdata] - returns an array containing all children of the userdata and every child of that children
[return: userdata] <- getparent -> [argument: userdata] - returns the parent of the userdata
[return: boolean] <- isancestorof -> [arguments: userdata, userdata] - returns true if the first userdata is an ancestor of the given descendant [second userdata]
[return: boolean] <- isdescendantof -> [arguments: userdata, userdata] - returns true if the first userdata is a descendant of the given ancestor [second userdata]
[return: userdata] <- getlocalplayer -> [argument: none] - returns the localplayer
[return: userdata] <- getcharacter -> [argument: userdata -> Player] - returns the character of the given player
[return: userdata] <- findservice -> [arguments: userdata -> Game, string] - returns the service specified by the given classname.
[return: number] <- getuserid -> [argument: userdata -> Player] -  returns the player [userdata] userid
[return: number] <- getping -> [argument: none] - returns your roblox game ping
[returns: tuple - fields: x, y] <- getscreendimensions -> [argument: none] - returns the screen dimensions.
[return: userdata] <- getadornee -> [argument: userdata -> BillboardGui] - returns the adornee of the billboardgui
[return: string] <- getdisplayname -> [argument: userdata -> Player] - returns the displayname of the player [userdata]
[return: userdata] <- getprimarypart -> [argument: userdata -> Model] - returns the primarypart of the model [userdata]
[return: number] <- gethealth -> [argument: userdata -> Humanoid] - returns the health of the humanoid [userdata]
[return: number] <- getmaxhealth -> [argument: userdata -> Humanoid] - returns the maxhealth of the humanoid [userdata]
[return: userdata] <- getteam -> [argument: userdata -> Player] - returns the team of the player [userdata]
[return: string] <- gettextureid -> [argument: userdata -> MeshPart] - returns the texture id of the meshpart [userdata]
[return: string] <- getmeshid -> [argument: userdata -> MeshPart] - returns the mesh id of the meshpart [userdata]
[return: string] <- gettransparency -> [argument: userdata -> Part] - returns the transparency of the part [userdata]
[return: number] <- getcamerafov -> [argument: userdata -> Camera] - returns the fov of the camera [userdata]
[return: vector] <- getposition -> [argument: userdata] - returns the position of the given part or camera [now returns vector instead of table]
[return: vector] <- getlookvector -> [argument: userdata] - returns the lookvector of the given part or camera [now returns vector instead of table]
[return: vector] <- getrightvector -> [argument: userdata] - returns the rightvector of the given part or camera [now returns vector instead of table]
[return: vector] <- getupvector -> [argument: userdata] - returns the upvector of the given part or camera [now returns vector instead of table]
[return: vector] <- getsize -> [argument: userdata] - returns the size of the given part [now returns vector instead of table]
[return: vector] <- getvelocity -> [argument: userdata] - returns the velocity of the given part [now returns vector instead of table]
[return: userdata] <- findfirstdescendant -> [arguments: userdata, string] - returns the first descendant found with the given name
[return: userdata] <- findfirstancestor -> [arguments: userdata, string] - returns the first ancestor of the userdata whose name is equal to the given name.
[return: userdata] <- waitforchild -> [arguments: userdata, string, [OPTIONAL] number] - returns the child of the userdata with the given name. If the child does not exist, it will pause the current thread until it does. If the timeout parameter is specified, this will time out after the specified number of seconds and return nil
[return: CFrame] <- getcframe -> [argument: userdata] - returns the cframe of the given part or camera [now returns vector struct instead of table]
[return: number] <- getcancollide -> [argument: userdata -> part] - checks if the part can collide or not

== [ set functions ] ==
[return: none] <- setcframe -> [arguments: userdata, CFrame] - sets the cframe from the userdata to the given cframe
[return: none] <- setlookvector -> [arguments: userdata, vector] - sets the lookvector from the userdata to the given vector
[return: none] <- setupvector -> [arguments: userdata, vector] - sets the upvector from the userdata to the given vector
[return: none] <- setrightvector -> [arguments: userdata, vector] - sets the rightvector from the userdata to the given vector
[return: none] <- setposition -> [arguments: userdata, vector] - sets the position from the userdata to the given vector
[return: none] <- setvelocity -> [arguments: userdata, vector] - sets the velocity from the userdata to the given vector
[return: none] <- setmouselocation -> [arguments: userdata -> MouseService, number - x, number - y] - sets roblox mouse location to specified x and y values
[return: none] <- setmouseiconenabled -> [arguments: userdata -> MouseService, bool] - sets roblox mouse icon [false = hide cursor, true = show cursor]
[return: none] <- setmousebehaviour -> [arguments: userdata -> MouseService, number] - sets roblox mouse behaviour [ 0 = Default, 1 = LockCenter, 2 = LockCurrentPosition ]
[return: none] <- setmousedeltasensitivity -> [arguments: userdata -> MouseService, number] - sets roblox mouse delta sensitivity
[return: none] <- setvalue -> [argument: userdata, int or number or table or bool or string] - set the value property of the userdata class name must include "Value" and second argument must match classname
[return: none] <- setcamerasubject -> [arguments: userdata -> Camera] - sets the camera subject
[return: none] <- setcancollide -> [arguments: userdata -> Part, boolean] - sets if the part can collide or not
[return: none] <- settransparency -> [arguments: userdata -> Part, number - float] - sets the transparency of the part

== [ keyboard functions ] ==
: IMPORTANT : https://docs.microsoft.com/en-us/windows/desktop/inputdev/virtual-key-codes  : IMPORTANT :

[return: none] <- keypress -> [argument: number - keycode] - simulates a key press for the given virtual keycode
[return: none] <- keyrelease -> [argument: number - keycode] - simulates a key release for the given virtual keycode
[return: string] <- getpressedkey -> [argument: none] - returns the last pressed key name
[return: array] <- getpressedkeys -> [argument: none] - returns a list of pressed keys name

== [ mouse functions ] ==
[return: boolean] <- isleftclicked -> [argument: none] - returns a boolean if left mouse clicked or not
[return: boolean] <- isrightclicked -> [argument: none] - returns a boolean if right mouse clicked or not
[return: boolean] <- isleftpressed -> [argument: none] - returns a boolean if left mouse is pressed or not
[return: boolean] <- isrightpressed -> [argument: none] - returns a boolean if right mouse is pressed or not
[return: none] <- mousemoverel -> [arguments: number - x, number - y] - moves the mouse to the x and y relative coordinates
[return: none] <- mousemoveabs -> [arguments: number - x, number - y] - moves the mouse to the x and y absolute coordinates
[return: none] <- mousescroll -> [argument: number - pixels] - scrolls your mouse by the given pixels
[return: none] <- mouse1click > [argument: none] - simulate a left mouse click
[return: none] <- mouse1press > [argument: none] - simulate a left mouse press
[return: none] <- mouse1release > [argument: none] - simulate a left mouse release
[return: none] <- mouse2click > [argument: none] - simulate a right mouse click
[return: none] <- mouse2press > [argument: none] - simulate a right mouse press
[return: none] <- mouse2release > [argument: none] - simulate a right mouse release
[return: tuple - fields: x, y] <- getmouseposition > [argument: none] - returns the default mouse position
[return: boolean] <- ismouseiconenabled -> [argument: userdata -> MouseService] - returns a boolean if the mouseicon is enabled or not
[return: tuple - fields: x, y] <- getmouselocation -> [argument: userdata -> MouseService] - returns the roblox mouse location
[return: number] <- getmousebehavior -> [argument: userdata -> MouseService] - returns a number for how the mouse is behaving [ 0 = Default, 1 = LockCenter, 2 = LockCurrentPosition ]
[return: number] <- getmousedeltasensitivity -> [argument: userdata -> MouseService] - returns the roblox mouse delta sensitivity
[return: tuple - fields: x, y] <- smoothmouse_exponential -> [argument: table - x | y [ORIGIN], table - x | y [POINT], number - speed] - returns the exponential smoothing mouse results [recommended for aimbot]
[return: tuple - fields: x, y] <- smoothmouse_linear -> [argument: table - x | y [ORIGIN], table - x | y [POINT], number - sensitivity, number - smoothness] - returns the linear smoothing mouse results [recommended for aimbot]

example - smoothmouse_linear:
local mouse = getmouseposition()
local point_to = {0, 0}
local sensitivity = 1
local smoothness = .5
local result = smoothmouse_linear({mouse.x, mouse.y}, point_to, sensitivity, smoothness)
print(result.x, result.y)

example - smoothmouse_exponential:
local mouse = getmouseposition()
local point_to = {0, 0}
local speed = .5
local result = smoothmouse_exponential({mouse.x, mouse.y}, point_to, speed)
print(result.x, result.y)

== [ network functions ] ==
WebsocketClient example:
local ws = WebsocketClient.new("ws://severe-websocket-test.glitch.me") -- connects to the websocket [renamed from websocket_connect]
ws.DataReceived:Connect(function(msg) warn(msg) end) -- fires when a message is received from the websocket
ws:Send("Hello World!") -- sends message to the websocket
wait(1) -- yields the thread for 1 second
ws:Disconnect() -- closes the connection to the websocket

[return: WebsocketClient] <- WebsocketClient.new -> [argument: string - URL] - connects to the websocket [URL], errors if fails. [renamed from websocket]
[return: string] <- httpget -> [argument: string, string - CONTENT_TYPE] - returns the contents of the given url
[return: string] <- httppost -> [arguments: string - URL, string - DATA, string - CONTENT_TYPE, string - ACCEPT,  [OPTIONAL] string - COOKIE,  [OPTIONAL] string - REFERER,  [OPTIONAL] string - ORIGIN] - sends a post request to the given url and returns the result

== [ drawing library ] ==
[return: none] <- Drawing.clear -> [argument: none] - clears and deletes all created drawing objects
[return: object] <- Drawing.new -> [argument: string - TYPE] - creates a new drawing object and returns it.

TYPES
Text
Line
Quad
Triangle
Circle
Square
Image
Polyline

Default -  METHODS
void Remove

Default -  PROPERTIES
bool Visible
Vector3 Color
number ZIndex  [-2147483647, 2147483647]
number Opacity

Text -  PROPERTIES
string Text
number Size
bool Center
bool Outline
Vector3 OutlineColor
Vector2 Position
Vector2 TextBounds [readonly]
number Font : 0 - 31 (added Tamzen font and LilitaOne font)

Line -  PROPERTIES
number Thickness
Vector2 From
Vector2 To

Circle -  PROPERTIES
number Thickness
number NumSides
number Radius
bool Filled
Vector2 Position

Square -  PROPERTIES
number Thickness
Vector2 Size
Vector2 Position
bool Filled
number Rounding

Triangle -  PROPERTIES
number Transparency
number Thickness
Vector2 PointA
Vector2 PointB
Vector2 PointC
bool Filled

Image -  PROPERTIES
string Url
string Data [used for loading from files]
bool Gif
number Delay [GIF Only]
Vector2 Position
Vector2 Size
number Rounding
Vector2 ImageSize [readonly]

Quad -  PROPERTIES
Vector2 PointA
Vector2 PointB
Vector2 PointC
Vector2 PointD
number Thickness
bool Filled

Polyline -  PROPERTIES
Vector2 Points [table of Vector2]
number Thickness
bool Filled

examples:
local text = Drawing.new("Text")
text.Text = "severe drawing library!"
text.Visible = true
text.ZIndex = 1
text.Position = {10, 10}
text.Color = {255, 255, 255}
text.Size = 15
wait(5) -- yield for 5 seconds
text:Remove()

local Image = Drawing.new("Image")
Image.Url = "https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExaTMzN21qODhla2pudGtlZHQ4aXpyMm5rOXlud3hkbjRmcm44MXhkdCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/VrQjb9El7JaQSFYjgJ/giphy-downsized-large.gif"
Image.Visible = true
Image.ZIndex = 1
Image.Gif = true
Image.Delay = 30
Image.Position = {400, 100}
Image.Size = {500, 500}
wait(20) -- yield for 20 seconds
Image:Remove()

local Image = Drawing.new("Image")
Image.Url = "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
Image.Visible = true
Image.ZIndex = 1
Image.Position = {1000, 100}
Image.Size = {500, 500}
wait(10) -- yield for 10 seconds
Image:Remove()

== [ luau library ] ==
[return: string] <- luau.compile -> [argument: string - source, table - options] - compiles luau source to bytecode
[return: function] <- luau.load -> [argument: string - bytecode, string - name] - loads function from bytecode

example:
local bytecode = luau.compile("print('Hello World!')", {
    optimizationLevel = 2,
    coverageLevel = 0,
    debugLevel = 1
})
local func = luau.load(bytecode, "MyChunk")
func()

== [ memory library ] ==
TYPES
bool
i8 / u8 (signed/unsigned 8-bit integers)
i16 / u16 (signed/unsigned 16-bit integers)
i32 / u32 (signed/unsigned 32-bit integers)
i64 / u64 (signed/unsigned 64-bit integers)  
f32 (32-bit float)
f64 (64-bit double)
string
buffer
vector

[return: bool] <- memory.readbool -> [argument: userdata - pointer, number - offset] - reads boolean value at specified offset
[return: number] <- memory.readbits -> [argument: userdata - pointer, number - bitOffset, number - bitSize] - reads bits at specified offset
[return: number] <- memory.readi8 -> [argument: userdata - pointer, number - offset] - reads signed 8-bit integer at specified offset
[return: number] <- memory.readi16 -> [argument: userdata - pointer, number - offset] - reads signed 16-bit integer at specified offset
[return: number] <- memory.readi32 -> [argument: userdata - pointer, number - offset] - reads signed 32-bit integer at specified offset
[return: number] <- memory.readi64 -> [argument: userdata - pointer, number - offset] - reads signed 64-bit integer at specified offset
[return: number] <- memory.readu8 -> [argument: userdata - pointer, number - offset] - reads unsigned 8-bit integer at specified offset
[return: number] <- memory.readu16 -> [argument: userdata - pointer, number - offset] - reads unsigned 16-bit integer at specified offset
[return: number] <- memory.readu32 -> [argument: userdata - pointer, number - offset] - reads unsigned 32-bit integer at specified offset
[return: number] <- memory.readu64 -> [argument: userdata - pointer, number - offset] - reads unsigned 64-bit integer at specified offset
[return: number] <- memory.readf32 -> [argument: userdata - pointer, number - offset] - reads 32-bit float at specified offset
[return: number] <- memory.readf64 -> [argument: userdata - pointer, number - offset] - reads 64-bit double at specified offset
[return: string] <- memory.readstring -> [argument: userdata - pointer, number - offset] - reads string at specified offset
[return: userdata] <- memory.at -> [argument: number - address] - returns userdata pointer at specified address
[return: buffer] <- memory.readbuffer -> [argument: userdata - pointer, number - offset, number - size] - reads buffer at specified offset
[return: none] <- memory.writebuffer -> [argument: userdata - pointer, number - offset, buffer - value] - writes buffer at specified offset
[return: vector] <- memory.readvector -> [argument: userdata - pointer, number - offset] - reads vector at specified offset
[return: string] <- memory.rtti -> [argument: userdata - pointer] - returns runtime type information for the pointer
[return: none] <- memory.set_read_strength -> [arguments: number - float] - sets the memory read strength [moved from global] 
[return: float] <- memory.get_read_strength -> [arguments: none] - return the strength value for reading memory [moved from global]
[return: none] <- memory.set_write_strength -> [arguments: number - float] - sets the memory write strength [moved from global]
[return: float] <- memory.get_write_strength -> [arguments: none] - return the strength value for writing memory [moved from global]

examples:
-- primitive offset: 0x160
-- size x offset: 0x2b0
-- size y offset: 0x2b4
-- size z offset: 0x2b8

-- [ fake headless -client sided- scroll in and out of head ] --
local head = game.Players.localPlayer.Character.Head
local primitive_ptr = memory.at(tonumber(head.Data, 16))
local primitive_data = memory.readu64(primitive_ptr, 0x160)
local primitive_ptr_data = memory.at(primitive_data)
memory.writef32(primitive_ptr_data, 0x2b0, 0) -- x
memory.writef32(primitive_ptr_data, 0x2b4, 0) -- y
memory.writef32(primitive_ptr_data, 0x2b8, 0) -- z

-- [ change localplayer username  -client sided- ] --
local localplayer = getlocalplayer()
-- get the memory value residing at offset: 0x68 with type: u64
local nameptr = memory.readu64(memory.at(tonumber(localplayer.Data, 16)), 0x68)
-- convert the pointer to a userdata so it can be used
local nameptr_data = memory.at(nameptr)
-- get the string value residing at offset: 0x0 which represents the name
local name = memory.readstring(nameptr_data, 0x0)
-- print the name
print(name)
-- set the new localplayer name that you want in memory
memory.writestring(nameptr_data, 0x0, "hello_severe")

== [ Instance.declare function ] ==
[return: userdata] <- Instance.declare -> [argument: userdata - pointer] - declares a userdata pointer as an Instance for use with instance functions

example:
local ptr = memory.at(0x12345678)
local instance = Instance.declare(ptr)
print(getname(instance))

[USED CHATGPT FOR DOCUMENTATION]:

--[[
Model Data Structure

Defines the structure for storing character-related information, used for gameplay logic such as targeting, visualization, and status tracking.

Fields:
• Username (string)            - The player's in-game username.
• Displayname (string)         - The player's display name.
• Userid (number)              - Unique player identifier (Roblox UserId).
• Character (Instance)         - Reference to the character model instance.
• PrimaryPart (Instance)       - The root/base part of the character (usually HumanoidRootPart).
• Head (Instance)              - Head part of the character.
• LeftLeg (Instance)           - Left leg part.
• LeftArm (Instance)           - Left arm part.
• RightLeg (Instance)          - Right leg part.
• RightArm (Instance)          - Right arm part.
• Torso (Instance)             - Torso or central body part.
• BodyHeightScale (number)     - Height scale multiplier for the character.
• RigType (number)     - Rig type (e.g., "R6 = 0" or "R15 = 1").
• Whitelisted (boolean)        - Whether the player is excluded from hostile logic.
• Archenemies (Boolean)          - hostile player.
• Aimbot_Part (Instance)       - Preferred target part for aimbot functionality.
• Aimbot_TP_Part (Instance)    - Target part for aimbot teleportation (e.g., for mouse tp).
• Triggerbot_Part (Instance)   - Part used for triggerbot activation.
• Health (number)              - Current health value of the character.
• MaxHealth (number)           - Maximum health value.
• body_parts_data (table)      - Table for specific body parts, (typically used for chams & skeleton) format: { name = "LowerTorso", part = userdata }.
• full_body_data (table)       - Table for all relevant body parts, (typically used for closest and random body parts) format: { name = "Head", part = userdata }.

Usage Example:
local data = {
Username = "Player1",
Displayname = "CoolPlayer",
Userid = 123456,
Character = workspace.Player1.Character,
PrimaryPart = workspace.Player1.Character.HumanoidRootPart
-- additional fields...
}

• add_model_data(data, "key_1")
]]

--[[
Model Edit Structure

Defines a partial data structure intended to update specific fields of an existing model data.
Used for modifying values such as health, rig configuration, and targeting data without redefining the full model.
Fields:
• RigType (number)    - Rig type (e.g., R6 = 0, R15  = 1).
• Whitelisted (boolean)       - Whether the player is excluded from hostile checks.
• Archenemies (boolean)         - hostile player.
• Aimbot_Part (Instance)      - Target part for aimbot (usually the head).
• Aimbot_TP_Part (Instance)   - Target part for teleporting with aimbot (default: head) (mouse tp).
• Triggerbot_Part (Instance)  - Target part used by triggerbot.
• Health (number)             - Updated current health.
• MaxHealth (number)          - Updated max health capacity.
• BodyHeightScale (number)    - updated height scaling value.

Example usage:
local edit = {
Health = 50
-- optional fields (etc).
}

edit_model_data(edit, "key_1")

Function:
• edit_model_data(data: table, key: string)
Applies the edit changes to the model data stored under the specified key.
]]

--[[
override_local_data

Initializes and stores local player-related data from the Lua environment into the internal Data structure. This function is typically invoked when setting up the local player context for gameplay features such as rendering UI displays, etc..

Fields:
• LocalPlayer (userdata)        - Reference to the local player object.
• Displayname (string)          - Local player's visible name.
• Username (string)             - Local player's account username.
• Userid (number)               - Unique ID for the local player (Roblox user ID).
• Character (userdata)          - Reference to the local player's character model.
• Team (userdata, optional)               - Team object the local player belongs to.
• RootPart (userdata)           - Primary part (e.g., HumanoidRootPart) of the local player.
• LeftFoot (userdata)           - LeftFoot part of the local character.
• Head (userdata)               - Head part of the local character.
• LowerTorso (userdata)         - LowerTorso part of the local character.
• Tool (userdata, optional)               - Currently equipped tool or weapon, if any.
• Humanoid (userdata)           - Humanoid instance controlling the character.
• Health (number, optional)     - Current health value.
• MaxHealth (number, optional)  - Maximum health value.
• RigType (number)              - Rig type used (e.g., R6 = 0 or R15 = 1).

Example usage:
local data = {
LocalPlayer = Player
-- additional fields (etc).
}

override_local_data(data)

]]

== [ crypt library ] ==
[return: string] <- crypt.base64.encode -> [argument: string] - encodes given string using base64 algorithm and returns it [moved to crypt.base64]
[return: string] <- crypt.base64.decode -> [argument: string] - decodes given string using base64 algorithm and returns it [moved to crypt.base64]
[return: string] <- crypt.random -> [argument: number] - generates random bytes of specified length
[return: string] <- crypt.random_deterministic -> [argument: number, string] - generates deterministic random bytes with seed
[return: string] <- crypt.hash.sha256 -> [argument: string] - returns sha256 hash of the message
[return: string] <- crypt.hash.sha512 -> [argument: string] - returns sha512 hash of the message
[return: string] <- crypt.hash.blake2b -> [argument: string, number] - returns blake2b hash of the message with optional output length
[return: string] <- crypt.pwhash -> [argument: string, number] - password hashing with specified output length
[return: string] <- crypt.pwhash_str -> [argument: string] - password hashing with string format
[return: boolean] <- crypt.pwhash_str_verify -> [argument: string, string] - verifies password hash
[return: string] <- crypt.secretbox.seal -> [argument: string, string, string] - encrypts plaintext with nonce and key
[return: string] <- crypt.secretbox.open -> [argument: string, string, string] - decrypts ciphertext with nonce and key
[return: string] <- crypt.aead.encrypt -> [argument: string, string, string, string] - AEAD encryption with optional associated data
[return: string] <- crypt.aead.decrypt -> [argument: string, string, string, string] - AEAD decryption with optional associated data
[return: table] <- crypt.box.keypair -> [argument: none] - generates public/private keypair for box encryption
[return: string] <- crypt.box.encrypt -> [argument: string, string, string, string] - encrypts message with nonce and keys
[return: string] <- crypt.box.decrypt -> [argument: string, string, string, string] - decrypts ciphertext with nonce and keys
[return: string] <- crypt.box.seal -> [argument: string, string] - seals message with public key
[return: string] <- crypt.box.open -> [argument: string, string, string] - opens sealed message with keys
[return: string] <- crypt.box.beforenm -> [argument: string, string] - computes shared secret
[return: table] <- crypt.sign.keypair -> [argument: none] - generates signing keypair
[return: string] <- crypt.sign.sign -> [argument: string, string] - signs message with secret key
[return: string] <- crypt.sign.open -> [argument: string, string] - opens signed message with public key
[return: string] <- crypt.sign.detached -> [argument: string, string] - creates detached signature
[return: boolean] <- crypt.sign.verify_detached -> [argument: string, string, string] - verifies detached signature
[return: string] <- crypt.hmac.sha256 -> [argument: string, string] - HMAC-SHA256 with message and key
[return: string] <- crypt.hmac.sha512 -> [argument: string, string] - HMAC-SHA512 with message and key
[return: string] <- crypt.hkdf_sha256 -> [argument: string, string, string, number] - HKDF key derivation
[return: string] <- crypt.hexadecimal.encode -> [argument: string] - encodes string to hexadecimal
[return: string] <- crypt.hexadecimal.decode -> [argument: string] - decodes hexadecimal string
[return: string] <- crypt.json.encode -> [argument: table] - encodes table to JSON string [moved from global JSONEncode]
[return: table] <- crypt.json.decode -> [argument: string] - decodes JSON string to table [moved from global JSONDecode]

== [ thread creation library ] ==
[return: none] <- thread.create -> [argument: string, function] - creates a background thread, assigns it with the given name and executes the function in the thread
[return: none] <- thread.suspend -> [argument: string] - suspends the thread from the assigned name
[return: none] <- thread.resume-> [argument: string] - resumes the thread from the assigned name
[return: none] <- thread.terminate -> [argument: string] - terminates the thread from the assigned name
[return: none] <- thread.clear -> [argument: none] - terminates all created threads and it's assigned names

== [ shared library ] ==
[return: variant] <- shared.get -> [argument: string - key] - returns the value in the shared table from the specified key
[return: none] <- shared.set -> [argument: string - key, variant - value] - sets/creates the key in the shared table and assigns it with the value specified
[return: boolean] <- shared.has -> [argument: string - key] - checks if the entry exist in the shared table from the specified key

== [ CHANGELOG - v0.679 to v0.690 ] ==

ADDED:
- hastag, addtag, gettags, cleartags, removetag (instance tag functions)
- setattribute, getattribute, getattributes (instance attribute functions)
- luau.load, luau.compile (luau compilation functions)
- Instance.declare (declare userdata pointer as Instance)
- memory.rtti (runtime type information)
- memory.readbool, memory.readbits (memory reading functions)
- memory.readi8, memory.readi16, memory.readi32, memory.readi64 (signed integer reading)
- memory.readu8, memory.readu16, memory.readu32, memory.readu64 (unsigned integer reading)
- memory.readf32, memory.readf64 (float reading)
- memory.readstring, memory.at, memory.readbuffer, memory.writebuffer, memory.readvector (memory functions)
- crypt.random, crypt.random_deterministic (random generation)
- crypt.hash.sha256, crypt.hash.sha512, crypt.hash.blake2b (hashing functions)
- crypt.pwhash, crypt.pwhash_str, crypt.pwhash_str_verify (password hashing)
- crypt.secretbox.seal, crypt.secretbox.open (secret box encryption)
- crypt.aead.encrypt, crypt.aead.decrypt (AEAD encryption)
- crypt.box.keypair, crypt.box.encrypt, crypt.box.decrypt, crypt.box.seal, crypt.box.open, crypt.box.beforenm (public key cryptography)
- crypt.sign.keypair, crypt.sign.sign, crypt.sign.open, crypt.sign.detached, crypt.sign.verify_detached (digital signatures)
- crypt.hmac.sha256, crypt.hmac.sha512 (HMAC functions)
- crypt.hkdf_sha256 (key derivation)
- crypt.hexadecimal.encode, crypt.hexadecimal.decode (hex encoding)
- polyline to drawing lib (new drawing type)
- setrawmetatable, getrawmetatable (raw metatable functions)
- taskscheduler global
- description property for baseparts
- tamzen font, LilitaOne font (new fonts for drawing)

CHANGED:
- renamed time to tick
- renamed checkfile to isfile
- renamed deletefile to delfile
- renamed deletefolder to delfolder
- faster print/warn functions (3x performance optimized)
- major lua environment shift
- renamed checkfolder to isfolder
- renamed SendNotification to send_notification
- renamed pointer_to_user_data to pointer_to_userdata
- removed pre-reg standalone functions
- removed getmemoryvalue/setmemoryvalue (replaced with memory.* functions)
- renamed websocket to WebsocketClient
- moved json to crypt [crypt.json]
- upgraded luau 0.679 -> 0.690
- removed cframelookat, lerpcframe, lerpvector3 (replaced with built-in vector operations)
- getposition, getcframe etc now returns vector instead of table
- full index, newindex and __namecall handling for instances
- moved get_read_strength/set_read_strength/get_write_strength/set_write_strength to memory lib

PERFORMANCE:
- 3x performance optimization
- major lua environment optimizations
- faster memory operations
- optimized instance handling

Lua Changelog - 2025-09-21 - v0.690
