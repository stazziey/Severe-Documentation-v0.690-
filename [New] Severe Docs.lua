# Severe 100% Documentation - Luau Version 0.690

## Table of Contents
1. [Introduction](#introduction)
2. [Global Variables and Predefined Globals](#global-variables-and-predefined-globals)
3. [General Properties](#general-properties)
4. [Predefined Globals](#predefined-globals)
5. [Miscellaneous Functions](#miscellaneous-functions)
6. [Get Functions](#get-functions)
7. [Set Functions](#set-functions)
8. [Keyboard Functions](#keyboard-functions)
9. [Mouse Functions](#mouse-functions)
10. [Network Functions](#network-functions)
11. [Drawing Library](#drawing-library)
12. [Internal Functions](#internal-functions)
13. [Crypt Library](#crypt-library)
14. [Thread Creation Library](#thread-creation-library)
15. [Shared Library](#shared-library)
16. [Namespaces](#namespaces)
17. [Engine Reference](#engine-reference)
18. [Memory Library](#memory-library)
19. [Luau Library](#luau-library)
20. [Changes from 0.679 to 0.690](#changes-from-0679-to-0690)
21. [Model Data Structures](#model-data-structures)

---

## Introduction

**Severe 100% - Luau Version 0.690**

This documentation provides comprehensive information about Severe's API, including all functions, properties, and libraries available in version 0.690. The documentation has been updated to reflect all changes from version 0.679 to 0.690.

### Important Notes:
- **DISABLE ANTI VIRUS THEN OPEN UPGRADE BEFORE OPENING SOFTWARE**
- Luau syntax follows 5.3 format
- Major performance improvements (3x faster)
- Faster print/warn functions
- Major Lua environment shift

---

## Global Variables and Predefined Globals

### General Properties

All "get" and "set" functions below are PascalCase for rlua support.

```lua
.Data - returns the userdata
.Name - returns the name
.ClassName - returns the classname
.Parent - returns the parent
```

**Example:**
```lua
print(game.Players:FindFirstChild("novice"))
game:FindService("UserInputService"):SetMouseLocation(0, 0)
print(game:FindService("Players").localPlayer.Name)
print(game:FindService("Players").localPlayer.Data) -- returns userdata
```

---

## Predefined Globals

```lua
[return: userdata] <- Game - returns datamodel
[return: table] <- game - returns datamodel [rlua only]
[return: userdata] <- Workspace - returns workspace
[return: userdata] <- workspace - returns workspace [rlua only]
```

---

## Miscellaneous Functions

```lua
[returns: tuple - fields: x, y | boolean] <- worldtoscreenpoint -> [argument: table - vector3] - this function returns the screen points of the vector3 and whether this point is within the bounds of the screen.
[return: none] <- print -> [argument: string] - prints out in white text
[return: none] <- warn -> [argument: string] - prints out in yellow text
[return: none] <- wait -> [argument: [OPTIONAL] number] - yields the current thread with specified timeout
[return: none] <- spawn -> [argument: function] - spawns in a task which is executed in the scheduler.
[return: string] <- gethwid -> [argument: none] - returns the current user SID
[return: none] <- setclipboard -> [argument: string] - sets the string argument to your clipboard.
[return: number] <- tick -> [argument: none] - returns the amount of time in seconds since the Unix epoch according to this device's time.
[return: number] <- gcinfo -> [argument: none] - returns the total memory heap size in kilobytes.
[return: number] <- time -> [argument: none] - returns the amount of time, in seconds, that has elapsed since severe started running
[return: variant] <- loadstring -> [argument: string, [OPTIONAL] [CHUNK] string] - loads lua code from the string and return it as a function.
[return: boolean] <- isrbxactive -> [argument: none] - returns a boolean indicating if roblox is focused or not
[return: none] <- destroy -> [argument: userdata] - sets the userdata parent to nothing technically destroying it
[return: none] <- makefolder -> [argument: string - foldername] - creates a folder : C:\v2\data
[return: none] <- deletefolder -> [argument: string - foldername] - deletes the folder  : C:\v2\data
[return: none] <- deletefile -> [argument: string - filename] - deletes the file  : C:\v2\data
[return:  boolean] <- checkfolder -> [argument: string - foldername] - checks if the folder exists  : C:\v2\data
[return: boolean] <- checkfile -> [argument: string - filename] - checks if the file exists : C:\v2\data
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
[return: none] <- send_notification -> [argument: string - content, string - type] - sends a notification popup request to severe
[return: boolean] <- add_model_data -> [argument: table, string - key] - creates model data with specific key and processed in model thread, returns true if success.
[return: boolean] <- edit_model_data -> [argument: table, string - key] - edits existing model data from specific key, returns true if success.
[return: boolean] <- remove_model_data -> [argument: string - key] - removes existing model data from specific key, returns true if success.
[return: none] <- SET_MEMORY_WRITE_STRENGTH -> [arguments:  number - float] - sets the memory write strength [ higher can cause thread lag from set functions ]
[return: float] <- GET_MEMORY_WRITE_STRENGTH -> [arguments:  none] - return the strength value for writing memory
[return: none] <- SET_MEMORY_READ_STRENGTH -> [arguments:  number - float] - sets the memory read strength [ higher can cause thread lag from get functions ]
[return: float] <- GET_MEMORY_READ_STRENGTH -> [arguments:  none] - return the strength value for reading memory
[return: boolean] <- clear_model_data -> [argument: none] - removes all model data, returns true if success.
[return: boolean] <- override_local_data -> [argument: table] - overrides existing or creates local data for local thread, returns true if success.
[return: boolean] <- clear_local_data -> [argument: none] - removes all created local data, returns true if success.
[return: string] <- JSONEncode-> [argument: variant] - This transforms a Luau table into a JSON object or array
[return: variant] <- JSONDecode-> [argument: string] -This transforms a JSON object or array into a Luau table
[return: tuple - Vector3  - fields: x, y, z ] <- lerpvector3 -> [arguments: table - vector3, table - vector3, number - alpha] - returns a vector3 interpolated between arg 1 and arg2 by the fraction alpha
[return: tuple - CFrame - fields: lookvector - vector3, upvector - vector3, rightvector - vector3, position - vector3 ] <- lerpcframe -> [arguments: cframe, cframe, number - alpha] - returns a cframe interpolated between arg 1 and arg2 by the fraction alpha
[return: tuple - CFrame - fields: lookvector - vector3, upvector - vector3, rightvector - vector3, position - vector3 ] <- cframelookat -> [arguments: table - cframe, table - vector3] - returns a new CFrame with the position of arg 1 [cframe] and facing towards arg 2 [vector3]
[return: table] <- pointer_to_table_data -> [argument: number - pointer] - returns the pointer as a table you can use for internals functions [! use only for rlua !]
[return: userdata] <- pointer_to_userdata -> [argument: number - pointer] - returns the pointer as a userdata you can use for internals functions
[return: number] <- getgameid -> [argument: none] - returns the game id
[return: number] <- getplaceid -> [argument: none] - returns the place id
[return: none ] <- queue_on_teleport -> [argument: none] - sends script to queue which gets executed on successful teleport
```

---

## Get Functions

```lua
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
[return: tuple - fields: x, y, z] <- getposition -> [argument: userdata] - returns the position of the given part or camera
[return: tuple - fields: x, y, z] <- getlookvector -> [argument: userdata] - returns the lookvector of the given part or camera
[return: tuple - fields: x, y, z] <- getrightvector -> [argument: userdata] - returns the rightvector of the given part or camera
[return: tuple - fields: x, y, z] <- getupvector -> [argument: userdata] - returns the upvector of the given part or camera
[return: tuple - fields: x, y, z] <- getsize -> [argument: userdata] - returns the size of the given part
[return: tuple - fields: x, y, z] <- getvelocity -> [argument: userdata] - returns the velocity of the given part
[return: userdata] <- findfirstdescendant -> [arguments: userdata, string] - returns the first descendant found with the given name
[return: userdata] <- findfirstancestor -> [arguments: userdata, string] - returns the first ancestor of the userdata whose name is equal to the given name.
[return: userdata] <- waitforchild -> [arguments: userdata, string, [OPTIONAL] number] - returns the child of the userdata with the given name. If the child does not exist, it will pause the current thread until it does. If the timeout parameter is specified, this will time out after the specified number of seconds and return nil
[return: tuple - CFrame - fields: lookvector - vector3, upvector - vector3, rightvector - vector3, position - vector3 ] <- getcframe -> [argument: userdata] - returns the cframe of the given part or camera
[return: number] <- getcancollide -> [argument: userdata -> part] - checks if the part can collide or not
```

---

## Set Functions

```lua
[return: none] <- setcframe -> [arguments: userdata, table - cframe] - sets the cframe from the userdata to the given cframe
[return: none] <- setlookvector -> [arguments: userdata, table - vector3] - sets the lookvector from the userdata to the given vector3
[return: none] <- setupvector -> [arguments: userdata, table - vector3] - sets the upvector from the userdata to the given vector3
[return: none] <- setrightvector -> [arguments: userdata, table - vector3] - sets the rightvector from the userdata to the given vector3
[return: none] <- setposition -> [arguments: userdata, table - vector3] - sets the position from the userdata to the given vector3
[return: none] <- setvelocity -> [arguments: userdata, table - vector3] - sets the velocity from the userdata to the given vector3
[return: none] <- setmouselocation -> [arguments: userdata -> MouseService, number - x, number - y] - sets roblox mouse location to specified x and y values
[return: none] <- setmouseiconenabled -> [arguments: userdata -> MouseService, bool] - sets roblox mouse icon [false = hide cursor, true = show cursor]
[return: none] <- setmousebehaviour -> [arguments: userdata -> MouseService, number] - sets roblox mouse behaviour [ 0 = Default, 1 = LockCenter, 2 = LockCurrentPosition ]
[return: none] <- setmousedeltasensitivity -> [arguments: userdata -> MouseService, number] - sets roblox mouse delta sensitivity
[return: none] <- setvalue -> [argument: userdata, int or number or table or bool or string] - set the value property of the userdata class name must include "Value" and second argument must match classname
[return: none] <- setcamerasubject -> [arguments: userdata -> Camera] - sets the camera subject
[return: none] <- setcancollide -> [arguments: userdata -> Part, boolean] - sets if the part can collide or not
[return: none] <- settransparency -> [arguments: userdata -> Part, number - float] - sets the transparency of the part
```

---

## Keyboard Functions

**IMPORTANT:** https://docs.microsoft.com/en-us/windows/desktop/inputdev/virtual-key-codes

```lua
[return: none] <- keypress -> [argument: number - keycode] - simulates a key press for the given virtual keycode
[return: none] <- keyrelease -> [argument: number - keycode] - simulates a key release for the given virtual keycode
[return: string] <- getpressedkey -> [argument: none] - returns the last pressed key name
[return: array] <- getpressedkeys -> [argument: none] - returns a list of pressed keys name
```

---

## Mouse Functions

```lua
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
```

**Example - smoothmouse_linear:**
```lua
local mouse = getmouseposition()
local point_to = {0, 0}
local sensitivity = 1
local smoothness = .5
local result = smoothmouse_linear({mouse.x, mouse.y}, point_to, sensitivity, smoothness)
print(result.x, result.y)
```

**Example - smoothmouse_exponential:**
```lua
local mouse = getmouseposition()
local point_to = {0, 0}
local speed = .5
local result = smoothmouse_exponential({mouse.x, mouse.y}, point_to, speed)
print(result.x, result.y)
```

---

## Network Functions

**Websocket Example:**
```lua
local ws = WebsocketClient.new("ws://severe-websocket-test.glitch.me") -- connects to the websocket
ws.DataReceived:Connect(function(msg, is_binary) warn(msg) end) -- fires when a message is recieved from the websocket
ws:Send("Hello World!") -- sends message to the websocket
wait(1) -- yields the thread for 1 second
ws:Disconnect() -- closes the connection to the websocket
```

```lua
[return: none] <- WebsocketClient.new -> [argument: string - URL] - connects to the websocket [URL], errors if fails.
[return: none] <- WebsocketClient:DataReceived -> [arguments: function - callback] - executes the function when a new message from the websocket is recieved
[return: none] <- WebsocketClient:Send -> [arguments: string - message, boolean - is_binary] - sends message [string] to the websocket
[return: none] <- WebsocketClient:Disconnect -> [arguments: none] - closes the connection with the websocket.
[return: string] <- httpget -> [argument: string, string - CONTENT_TYPE] - returns the contents of the given url
[return: string] <- httppost -> [arguments: string - URL, string - DATA, string - CONTENT_TYPE, string - ACCEPT,  [OPTIONAL] string - COOKIE,  [OPTIONAL] string - REFERER,  [OPTIONAL] string - ORIGIN] - sends a post request to the given url and returns the result
```

---

## Drawing Library

```lua
[return: none] <- Drawing.clear -> [argument: none] - clears and deletes all created drawing objects
[return: object] <- Drawing.new -> [argument: string - TYPE] - creates a new drawing object and returns it.
```

**TYPES:**
- Text
- Line
- Quad
- Triangle
- Circle
- Square
- Image
- Polyline

**Default METHODS:**
- `void Remove`

**Default PROPERTIES:**
- `bool Visible`
- `Vector3 Color`
- `number ZIndex` [-2147483647, 2147483647]
- `number Opacity`

**Text PROPERTIES:**
- `string Text`
- `number Size`
- `bool Center`
- `bool Outline`
- `Vector3 OutlineColor`
- `Vector2 Position`
- `Vector2 TextBounds` [readonly]
- `number Font` [0 - 31]

**Line PROPERTIES:**
- `number Thickness`
- `Vector2 From`
- `Vector2 To`

**Circle PROPERTIES:**
- `number Thickness`
- `number NumSides`
- `number Radius`
- `bool Filled`
- `Vector2 Position`

**Square PROPERTIES:**
- `number Thickness`
- `Vector2 Size`
- `Vector2 Position`
- `bool Filled`
- `number Rounding`

**Triangle PROPERTIES:**
- `number Transparency`
- `number Thickness`
- `Vector2 PointA`
- `Vector2 PointB`
- `Vector2 PointC`
- `bool Filled`

**Image PROPERTIES:**
- `string Url`
- `string Data` [used for loading from files]
- `bool Gif`
- `number Delay` [GIF Only]
- `Vector2 Position`
- `Vector2 Size`
- `number Rounding`
- `Vector2 ImageSize` [readonly]

**Quad PROPERTIES:**
- `Vector2 PointA`
- `Vector2 PointB`
- `Vector2 PointC`
- `Vector2 PointD`
- `number Thickness`
- `bool Filled`

**Polyline PROPERTIES:**
- `{Vector2} Points` - An array of Vector2 points that make up the polyline
- `number Thickness` - The thickness of the polyline
- `bool Filled` - Whether the polyline is filled or not

**Examples:**
```lua
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
```

---

## Internal Functions

**TYPES:**
- qword
- dword
- double
- float
- string
- bool

```lua
[return: qword | dword | double | float | string | bool] <- getmemoryvalue -> [argument: userdata - pointer, number - offset, string - type] - reads the value at specified offset and returns it with the type you want
[return: none] <- setmemoryvalue -> [argument: userdata - pointer, number - offset, string - type, number | string - value] - set the value at specified offset with the type you want
```

**EXAMPLES MAY BE OUTDATED!**

```lua
-- primitive offset: 0x160
-- size x offset: 0x2b0
-- size y offset: 0x2b4
-- size z offset: 0x2b8

-- [ fake headless -client sided- scroll in and out of head ] --
local head = game.Players.localPlayer.Character.Head
local primitive_ptr = head:GetMemoryValue(0x160, "qword")
local primitive_ptr_data = pointer_to_table_data(primitive_ptr)
primitive_ptr_data:SetMemoryValue(0x2ac, "float", 0) -- x
primitive_ptr_data:SetMemoryValue(0x2ac, "float", 0) -- y
primitive_ptr_data:SetMemoryValue(0x2ac, "float", 0) -- z

-- [ change localplayer username  -client sided- ] --
local localplayer = getlocalplayer()
-- get the memory value residing at offset: 0x68 with type: qword
local nameptr = getmemoryvalue(localplayer, 0x68, "qword")
-- convert the pointer to a userdata so it can be used
local nameptr_data = pointer_to_userdata(nameptr)
-- get the string value residing at offset: 0x0 which represents the name
local name = getmemoryvalue(nameptr_data, 0x0, "string")
-- print the name
print(name)
-- set the new localplayer name that you want in memory
setmemoryvalue(nameptr_data, 0x0, "string", "hello_severe")
```

---

## Crypt Library

```lua
[return: string] <- crypt.base64_encode -> [argument: string] - encodes given string using base64 algorithm and returns it
[return: string] <- crypt.base64_decode -> [argument: string] - decodes given string using base64 algorithm and returns it
[return: string] <- crypt.random -> [argument: number] - generates a random byte buffer of the given length. Returns a string of raw bytes.
[return: string] <- crypt.random_deterministic -> [argument: number, string] - generates a deterministic random buffer of given length using seed (32 bytes). Returns a string of raw bytes.
[return: string] <- crypt.hash.sha256 -> [argument: string] - computes the SHA-256 hash of the message. Returns a string of 32 bytes.
[return: string] <- crypt.hash.sha512 -> [argument: string] - computes the SHA-512 hash of the message. Returns a string of 64 bytes.
[return: string] <- crypt.hash.blake2b -> [argument: string, number?] - computes the BLAKE2b hash of the message. outlen is optional and defaults to 32; must be between 1 and 64. Returns a string of outlen bytes.
[return: string] <- crypt.pwhash -> [argument: string, number] - derives a key from the password using Argon2id. Returns a binary key of outlen bytes.
[return: string] <- crypt.pwhash_str -> [argument: string] - hashes the password into a safe string for storage.
[return: boolean] <- crypt.pwhash_str_verify -> [argument: string, string] - verifies the password against the hash. Returns true if the password matches, false otherwise.
[return: string] <- crypt.secretbox.seal -> [argument: string, string, string] - encrypts the plaintext using symmetric encryption with XSalsa20-Poly1305. nonce must be 24 bytes, key must be 32 bytes. Returns the ciphertext.
[return: string] <- crypt.secretbox.open -> [argument: string, string, string] - decrypts the ciphertext using symmetric decryption with XSalsa20-Poly1305. nonce must be 24 bytes, key must be 32 bytes. Returns the plaintext.
[return: string] <- crypt.aead.encrypt -> [argument: string, string, string, string?] - encrypts the plaintext using AEAD XChaCha20-Poly1305. nonce and key are required, ad (additional data) is optional. Returns the ciphertext.
[return: string] <- crypt.aead.decrypt -> [argument: string, string, string, string?] - decrypts the ciphertext using AEAD XChaCha20-Poly1305. nonce and key are required, ad (additional data) is optional. Returns the plaintext.
[return: table] <- crypt.box.keypair -> [argument: none] - generates a Curve25519 keypair. Returns a table with public and secret keys (both strings).
[return: string] <- crypt.box.encrypt -> [argument: string, string, string, string] - encrypts the message using public and secret keys. nonce must be 24 bytes, pub and sec are 32 bytes. Returns the ciphertext.
[return: string] <- crypt.box.decrypt -> [argument: string, string, string, string] - decrypts the ciphertext using public and secret keys. nonce must be 24 bytes, pub and sec are 32 bytes. Returns the plaintext.
[return: string] <- crypt.box.seal -> [argument: string, string] - anonymously seals the message for the receiver's public key. pub is 32 bytes. Returns the ciphertext.
[return: string] <- crypt.box.seal_open -> [argument: string, string, string] - opens the sealed message using the receiver's public and secret keys. pub and sec are 32 bytes. Returns the plaintext.
[return: string] <- crypt.box.beforenm -> [argument: string, string] - computes a shared key from public and secret keys for reuse. pub and sec are 32 bytes. Returns the shared key.
[return: table] <- crypt.sign.keypair -> [argument: none] - generates an Ed25519 signing keypair. Returns a table with public (32 bytes) and secret (64 bytes) keys.
[return: string] <- crypt.sign.sign -> [argument: string, string] - signs the message with the secret key. sec is 64 bytes. Returns the signed message.
[return: string] <- crypt.sign.open -> [argument: string, string] - verifies and extracts the message from the signed message. pub is 32 bytes. Returns the original message.
[return: string] <- crypt.sign.detached -> [argument: string, string] - creates a detached signature for the message. sec is 64 bytes. Returns the signature.
[return: boolean] <- crypt.sign.verify_detached -> [argument: string, string, string] - verifies the detached signature against the message and public key. pub is 32 bytes. Returns true if valid, false otherwise.
[return: string] <- crypt.base64.encode -> [argument: string] - base64 encodes the raw string. Returns the encoded string.
[return: string] <- crypt.base64.decode -> [argument: string] - base64 decodes the string. Returns the raw bytes.
[return: string] <- crypt.hmac.sha256 -> [argument: string, string] - computes HMAC-SHA256 of the message with the key. Returns a string of 32 bytes.
[return: string] <- crypt.hmac.sha512 -> [argument: string, string] - computes HMAC-SHA512 of the message with the key. Returns a string of 64 bytes.
[return: string] <- crypt.hkdf_sha256 -> [argument: string, string, string, number] - performs HKDF-SHA256 key derivation. Returns a binary key of outlen bytes.
[return: string] <- crypt.json.encode -> [argument: table] - encodes a table to JSON.
[return: table] <- crypt.json.decode -> [argument: string] - decodes JSON to a table.
```

---

## Thread Creation Library

```lua
[return: none] <- thread.create -> [argument: string, function] - creates a background thread, assigns it with the given name and executes the function in the thread
[return: none] <- thread.suspend -> [argument: string] - suspends the thread from the assigned name
[return: none] <- thread.resume-> [argument: string] - resumes the thread from the assigned name
[return: none] <- thread.terminate -> [argument: string] - terminates the thread from the assigned name
[return: none] <- thread.clear -> [argument: none] - terminates all created threads and it's assigned names
```

---

## Shared Library

```lua
[return: variant] <- shared.get -> [argument: string - key] - returns the value in the shared table from the specified key
[return: none] <- shared.set -> [argument: string - key, variant - value] - sets/creates the key in the shared table and assigns it with the value specified
[return: boolean] <- shared.has -> [argument: string - key] - checks if the entry exist in the shared table from the specified key
```

---

## Namespaces

### Memory Namespace

```lua
function memory.readi8(address: number): number
function memory.readi8(source: userdata, offset: number): number
function memory.readu8(address: number): number
function memory.readu8(source: userdata, offset: number): number
function memory.readi16(address: number): number
function memory.readi16(source: userdata, offset: number): number
function memory.readu16(address: number): number
function memory.readu16(source: userdata, offset: number): number
function memory.readi32(address: number): number
function memory.readi32(source: userdata, offset: number): number
function memory.readu32(address: number): number
function memory.readu32(source: userdata, offset: number): number
function memory.readi64(address: number): number
function memory.readi64(source: userdata, offset: number): number
function memory.readu64(address: number): number
function memory.readu64(source: userdata, offset: number): number
function memory.readf32(address: number): number
function memory.readf32(source: userdata, offset: number): number
function memory.readf64(address: number): number
function memory.readf64(source: userdata, offset: number): number

function memory.writei8(address: number, value: number): ()
function memory.writei8(destination: userdata, offset: number, value: number): ()
function memory.writeu8(address: number, value: number): ()
function memory.writeu8(destination: userdata, offset: number, value: number): ()
function memory.writei16(address: number, value: number): ()
function memory.writei16(destination: userdata, offset: number, value: number): ()
function memory.writeu16(address: number, value: number): ()
function memory.writeu16(destination: userdata, offset: number, value: number): ()
function memory.writei32(address: number, value: number): ()
function memory.writei32(destination: userdata, offset: number, value: number): ()
function memory.writeu32(address: number, value: number): ()
function memory.writeu32(destination: userdata, offset: number, value: number): ()
function memory.writei64(address: number, value: number): ()
function memory.writei64(destination: userdata, offset: number, value: number): ()
function memory.writeu64(address: number, value: number): ()
function memory.writeu64(destination: userdata, offset: number, value: number): ()
function memory.writef32(address: number, value: number): ()
function memory.writef32(destination: userdata, offset: number, value: number): ()
function memory.writef64(address: number, value: number): ()
function memory.writef64(destination: userdata, offset: number, value: number): ()

function memory.readbits(address: number, bitOffset: number, bitSize: number): number
function memory.readbits(source: userdata, offset: number, bitOffset: number, bitSize: number): number

function memory.writebits(address: number, bitOffset: number, bitSize: number, value: number): ()
function memory.writebits(destination: userdata, offset: number, bitOffset: number, bitSize: number, value: number): ()

function memory.readstring(address: number): string
function memory.readstring(source: userdata, offset: number): string

function memory.writestring(address: number, value: string): ()
function memory.writestring(destination: userdata, offset: number, value: string): ()

function memory.readvector(address: number): vector
function memory.readvector(source: userdata, offset: number): vector

function memory.writevector(address: number, value: vector): ()
function memory.writevector(destination: userdata, offset: number, value: vector): ()

function memory.readbuffer(address: number, size: number): buffer
function memory.readbuffer(source: userdata, offset: number, size: number): buffer

function memory.writebuffer(address: number, value: buffer): ()
function memory.writebuffer(destination: userdata, offset: number, value: buffer): ()

function memory.rtti(address: number): string?
function memory.rtti(source: userdata, offset: number): string?

function memory.changed(address: number, type: string, callback: function, iterations: number?): userdata
function memory.changed(source: userdata, offset: number, type: string, callback: function, iterations: number?): userdata

function memory.at(address: number): userdata
function memory.at(source: userdata, offset: number): userdata
```

### Luau Namespace

```lua
function luau.compile(source: string, options: {
    optimizationLevel: 0 | 1 | 2,
    coverageLevel: 0 | 1 | 2,
    debugLevel: 0 | 1 | 2
}): string

function luau.load(bytecode: string, name: string?): function
```

---

## Engine Reference

### Instance

**Properties:**
- `Instance.Name: string`
- `Instance.ClassName: string`
- `Instance.Parent: Instance`
- `Instance.Data: string` - Hexadecimal representation of the Instance's address

**Methods:**
- `function Instance:GetTags(): { string }`
- `function Instance:HasTag(name: string): boolean`
- `function Instance:AddTag(name: string): ()`
- `function Instance:RemoveTag(name: string): ()`
- `function Instance:ClearTags(): ()`
- `function Instance:GetAttribute(name: string): ()`
- `function Instance:GetAttributes(): { string }`
- `function Instance:SetAttribute(name: string, value: any): ()`
- `function Instance:FindFirstChildOfClass(name: string): Instance?`
- `function Instance:FindFirstChild(name: string): Instance?`
- `function Instance:FindFirstAncestorOfClass(name: string): Instance?`
- `function Instance:FindFirstAncestor(name: string): Instance?`
- `function Instance:GetChildren(): { Instance }`
- `function Instance:GetDescendants(): { Instance }`
- `function Instance:WaitForChild(name: string): Instance?`
- `function Instance:FindFirstDescendant(name: string): Instance?`
- `function Instance:IsAncestorOf(Object: Instance): boolean`
- `function Instance:IsDescendantOf(Object: Instance): boolean`
- `function Instance:Destroy(): ()`

### DataModel

**Properties:**
- `Instance.PlaceId: number`
- `Instance.GameId: number`
- `Instance.JobId: string`

**Methods:**
- `function DataModel:HttpGet(url: string, content: string): unknown`
- `function DataModel:HttpPost(url: string, data: string, content: string, accept: string, cookie: string?, referer: string?, origin: string?): unknown`
- `function DataModel:GetService(name: string): Instance`
- `function DataModel:GetHwid(): string`

### BillboardGui

**Properties:**
- `BillboardGui.Adornee: Instance?`

### Workspace

**Properties:**
- `Workspace.CurrentCamera: Camera?`

### Players

**Properties:**
- `Players.LocalPlayer: Player?`

### Camera

**Properties:**
- `Camera.CFrame: CFrame`
- `Camera.CameraSubject: Instance`
- `Camera.CameraType: Enum.CameraType`
- `Camera.FieldOfView: number`
- `Camera.DiagonalFieldOfView: number`
- `Camera.FieldOfViewMode: Enum.FieldOfViewMode`
- `Camera.Focus: CFrame`
- `Camera.HeadLocked: boolean`
- `Camera.HeadScale: number`
- `Camera.MaxAxisFieldOfView: number`
- `Camera.NearPlaneZ: number`
- `Camera.RollEnabled: boolean`
- `Camera.ViewportSize: Vector2`

**Methods:**
- `function Camera:GetPartsObscuringTarget(castPoints: Array, ignoreList: Instances): Instances`
- `function Camera:GetRenderCFrame(): CFrame`
- `function Camera:GetRoll(): number`
- `function Camera:ScreenPointToRay(screenPosition: Vector3, depth: number?): Ray`
- `function Camera:SetRoll(angle: number): ()`
- `function Camera:ViewportPointToRay(viewportPosition: Vector3, depth: number?): Ray`
- `function Camera:WorldToScreenPoint(worldPoint: Vector3): (Vector3, boolean)`
- `function Camera:WorldToViewportPoint(worldPoint: Vector3): (Vector3, boolean)`

**Events:**
- `Camera.Interpolated: RBXScriptSignal`

### BasePart

**Properties:**
- `BasePart.Anchored: boolean`
- `BasePart.AssemblyAngularVelocity: Vector3`
- `BasePart.AssemblyCenterOfMass: Vector3`
- `BasePart.AssemblyLinearVelocity: Vector3`
- `BasePart.AssemblyMass: number`
- `BasePart.AssemblyRootPart: BasePart`
- `BasePart.AudioCanCollide: boolean`
- `BasePart.BackSurface: Enum.SurfaceType`
- `BasePart.BottomSurface: Enum.SurfaceType`
- `BasePart.BrickColor: BrickColor`
- `BasePart.CFrame: CFrame`
- `BasePart.CanCollide: boolean`
- `BasePart.CanQuery: boolean`
- `BasePart.CanTouch: boolean`
- `BasePart.CastShadow: boolean`
- `BasePart.CenterOfMass: Vector3`
- `BasePart.CollisionGroup: string`
- `BasePart.Color: Color3`
- `BasePart.CustomPhysicalProperties: PhysicalProperties`
- `BasePart.Material: Enum.Material`
- `BasePart.MaterialVariant: MaterialVariant`
- `BasePart.Orientation: Vector3`
- `BasePart.PivotOffset: CFrame`
- `BasePart.Position: Vector3`
- `BasePart.Reflectance: number`
- `BasePart.ResizeIncrement: float`
- `BasePart.ResizeableFaces: Enum.NormalId`
- `BasePart.RightSurface: Enum.SurfaceType`
- `BasePart.RootPriority: number`
- `BasePart.Rotation: Vector3`
- `BasePart.Size: Vector3`
- `BasePart.TopSurface: Enum.SurfaceType`
- `BasePart.Transparency: number`

**Methods:**
- `function BasePart:ApplyAngularImpulse(impulse: Vector3): ()`
- `function BasePart:ApplyImpulse(impulse: Vector3): ()`
- `function BasePart:ApplyImpulseAtPosition(impulse: Vector3, position: Vector3): ()`
- `function BasePart:CanCollideWith(part: BasePart): boolean`
- `function BasePart:CanSetNetworkOwnership(): boolean`
- `function BasePart:GetConnectedParts(): { BasePart }`
- `function BasePart:GetJoints(): { JointInstance | Constraint }`
- `function BasePart:GetMass(): number`
- `function BasePart:GetNetworkOwner(): Player?`
- `function BasePart:GetNetworkOwnershipAuto(): boolean`
- `function BasePart:GetTouchingParts(): Instances`
- `function BasePart:GetVelocityAtPosition(position: Vector3): Vector3`
- `function BasePart:IntersectAsync(parts: { BasePart }): UnionOperation`
- `function BasePart:IsGrounded(): boolean`
- `function BasePart:Resize(orientation: Enum.NormalId, delta: float): ()`
- `function BasePart:SetNetworkOwner(player: Player?): ()`
- `function BasePart:SetNetworkOwnershipAuto(): ()`
- `function BasePart:SubtractAsync(parts: { BasePart }): UnionOperation`
- `function BasePart:UnionAsync(parts: { BasePart }): UnionOperation`

**Events:**
- `BasePart.TouchEnded: RBXScriptSignal<Part>`
- `BasePart.Touched: RBXScriptSignal<Part>`

### Player

**Properties:**
- `Player.AccountAge: number`
- `Player.AutoJumpEnabled: boolean`
- `Player.CameraMaxZoomDistance: number`
- `Player.CameraMinZoomDistance: number`
- `Player.CameraMode: Enum.CameraMode`
- `Player.CanLoadCharacterAppearance: boolean`
- `Player.Character: Model?`
- `Player.CharacterAppearanceId: number`
- `Player.CameraMode: Enum.CameraMode`
- `Player.DevComputerCameraMode: Enum.DevComputerCameraMode`
- `Player.DevComputerMovementMode: Enum.DevComputerMovementMode`
- `Player.DevTouchCameraMode: Enum.DevTouchCameraMode`
- `Player.DevTouchMovementMode: Enum.DevTouchMovementMode`
- `Player.DisplayName: string`
- `Player.FollowUserId: number`
- `Player.GameplayPaused: boolean`
- `Player.HasVerifiedBadge: boolean`
- `Player.HealthDisplayDistance: number`
- `Player.LocaleId: string`
- `Player.MembershipType: Enum.MembershipType`
- `Player.NameDisplayDistance: number`
- `Player.Neutral: boolean`
- `Player.PartyId: string`
- `Player.ReplicationFocus: Instance?`
- `Player.RespawnLocation: SpawnLocation?`
- `Player.Team: Team?`
- `Player.TeamColor: BrickColor`
- `Player.UserId: number`

**Methods:**
- `function Player:AddReplicationFocus(instance: Instance): ()`
- `function Player:ClearCharacterAppearance(): ()`
- `function Player:DistanceFromCharacter(position: Vector3): number`
- `function Player:GetFriendsOnline(): { { Name: string, Id: number } }`
- `function Player:GetJoinData(): { SourcePlaceId: number, SourceGameId: number, LaunchData: string }`
- `function Player:GetMouse(): Mouse`
- `function Player:GetNetworkPing(): number`
- `function Player:GetRankInGroup(groupId: number): number`
- `function Player:GetRoleInGroup(groupId: number): string`
- `function Player:HasAppearanceLoaded(): boolean`
- `function Player:IsFriendsWith(userId: number): boolean`
- `function Player:IsInGroup(groupId: number): boolean`
- `function Player:IsVerified(): boolean`
- `function Player:Kick(message: string?): ()`
- `function Player:LoadCharacter(): ()`
- `function Player:LoadCharacterWithHumanoidDescription(humanoidDescription: HumanoidDescription): ()`
- `function Player:Move(direction: Vector3): ()`
- `function Player:RemoveReplicationFocus(instance: Instance): ()`
- `function Player:RequestStreamAroundAsync(position: Vector3): ()`
- `function Player:SetAccountAge(age: number): ()`
- `function Player:SetChatFilter(filtered: boolean): ()`

**Events:**
- `Player.CharacterAdded: RBXScriptSignal<Model>`
- `Player.CharacterAppearanceLoaded: RBXScriptSignal<Model>`
- `Player.CharacterRemoving: RBXScriptSignal<Model>`
- `Player.Chatted: RBXScriptSignal<string>`
- `Player.Idled: RBXScriptSignal<number>`
- `Player.TeleportState: RBXScriptSignal`

### Model

**Properties:**
- `Model.PrimaryPart: BasePart?`
- `Model.WorldPivot: CFrame`
- `Model.WorldPosition: Vector3`

**Methods:**
- `function Model:GetBoundingBox(): (CFrame, Vector3)`
- `function Model:GetExtentsSize(): Vector3`
- `function Model:GetPersistentPlayers(): Instances`
- `function Model:GetScale(): number`
- `function Model:MoveTo(location: Vector3): ()`
- `function Model:MoveToFinished(): RBXScriptSignal`
- `function Model:SetPrimaryPartCFrame(cframe: CFrame): ()`
- `function Model:SetScale(scale: number): ()`
- `function Model:TranslateBy(delta: Vector3): ()`

### Humanoid

**Properties:**
- `Humanoid.AutoJumpEnabled: boolean`
- `Humanoid.AutoRotate: boolean`
- `Humanoid.AutomaticScalingEnabled: boolean`
- `Humanoid.BreakJointsOnDeath: boolean`
- `Humanoid.CameraOffset: Vector3`
- `Humanoid.DisplayDistanceType: Enum.HumanoidDisplayDistanceType`
- `Humanoid.DisplayName: string`
- `Humanoid.Enabled: boolean`
- `Humanoid.FloorMaterial: Enum.Material`
- `Humanoid.Health: number`
- `Humanoid.DisplayDistanceType: Enum.HumanoidDisplayDistanceType`
- `Humanoid.HealthDisplayDistance: number`
- `Humanoid.HealthDisplayType: Enum.HumanoidHealthDisplayType`
- `Humanoid.HipHeight: number`
- `Humanoid.Jump: boolean`
- `Humanoid.JumpHeight: number`
- `Humanoid.JumpPower: number`
- `Humanoid.MaxHealth: number`
- `Humanoid.MaxSlopeAngle: number`
- `Humanoid.MoveDirection: Vector3`
- `Humanoid.NameDisplayDistance: number`
- `Humanoid.NameOcclusion: Enum.NameOcclusion`
- `Humanoid.PlatformStand: boolean`
- `Humanoid.RequiresNeck: boolean`
- `Humanoid.RigType: Enum.HumanoidRigType`
- `Humanoid.RootPart: BasePart?`
- `Humanoid.SeatPart: Seat?`
- `Humanoid.Sit: boolean`
- `Humanoid.TargetPoint: Vector3`
- `Humanoid.UseJumpPower: boolean`
- `Humanoid.WalkSpeed: number`
- `Humanoid.TargetPart: BasePart?`
- `Humanoid.WalkToPoint: Vector3`
- `Humanoid.WalkToPart: BasePart?`

**Methods:**
- `function Humanoid:AddAccessory(accessory: Accessory): ()`
- `function Humanoid:ApplyDescription(humanoidDescription: HumanoidDescription): ()`
- `function Humanoid:ApplyDescriptionReset(humanoidDescription: HumanoidDescription): ()`
- `function Humanoid:BuildRigFromAttachments(): ()`
- `function Humanoid:ChangeState(state: Enum.HumanoidStateType): ()`
- `function Humanoid:EquipTool(tool: Tool): ()`
- `function Humanoid:GetAccessories(): { Accessory }`
- `function Humanoid:GetAppliedDescription(): HumanoidDescription`
- `function Humanoid:GetBodyPartR15(): Enum.BodyPartR15`
- `function Humanoid:GetLimb(part: BasePart): Enum.Limb`
- `function Humanoid:GetState(): Enum.HumanoidStateType`
- `function Humanoid:GetStateEnabled(state: Enum.HumanoidStateType): boolean`
- `function Humanoid:Move(direction: Vector3): ()`
- `function Humanoid:MoveTo(location: Vector3): ()`
- `function Humanoid:PlayEmote(emote: AnimationTrack): boolean`
- `function Humanoid:RemoveAccessories(): ()`
- `function Humanoid:ReplaceBodyPartR15(limb: Enum.BodyPartR15, part: BasePart): ()`
- `function Humanoid:SetStateEnabled(state: Enum.HumanoidStateType, enabled: boolean): ()`
- `function Humanoid:TakeDamage(amount: number): ()`
- `function Humanoid:UnequipTools(): ()`

**Events:**
- `Humanoid.Climbing: RBXScriptSignal<number>`
- `Humanoid.Died: RBXScriptSignal`
- `Humanoid.FallingDown: RBXScriptSignal<boolean>`
- `Humanoid.Freefall: RBXScriptSignal<boolean>`
- `Humanoid.GettingUp: RBXScriptSignal<boolean>`
- `Humanoid.HealthChanged: RBXScriptSignal<number>`
- `Humanoid.Jumping: RBXScriptSignal<boolean>`
- `Humanoid.MoveToFinished: RBXScriptSignal<boolean>`
- `Humanoid.PlatformStanding: RBXScriptSignal<boolean>`
- `Humanoid.Ragdoll: RBXScriptSignal<boolean>`
- `Humanoid.Running: RBXScriptSignal<number>`
- `Humanoid.Seated: RBXScriptSignal<boolean>`
- `Humanoid.StateChanged: RBXScriptSignal<Enum.HumanoidStateType, Enum.HumanoidStateType>`
- `Humanoid.StateEnabledChanged: RBXScriptSignal<Enum.HumanoidStateType, boolean>`
- `Humanoid.StrafingNoPhysics: RBXScriptSignal<boolean>`
- `Humanoid.Swimming: RBXScriptSignal<number>`
- `Humanoid.Touched: RBXScriptSignal<BasePart>`

### ValueBase

**Properties:**
- `ValueBase.Value: Variant`

### MouseService

**Properties:**
- `MouseService.IconEnabled: boolean`
- `MouseService.Location: Vector2`
- `MouseService.Behavior: Enum.MouseBehavior`
- `MouseService.DeltaSensitivity: number`

**Methods:**
- `function MouseService:SetLocation(x: number, y: number): ()`
- `function MouseService:SetIconEnabled(enabled: boolean): ()`
- `function MouseService:SetBehavior(behavior: Enum.MouseBehavior): ()`
- `function MouseService:SetDeltaSensitivity(sensitivity: number): ()`

---

## Changes from 0.679 to 0.690

### Added Functions:
- `hastag`
- `addtag`
- `gettags`
- `cleartags`
- `luau.load`
- `removetag`
- `setattribute`
- `getattribute`
- `luau.compile`
- `getattributes`
- `Instance.declare`
- `memory.rtti`
- `memory.readbool`
- `memory.readbits`
- `memory.readi8`
- `memory.readi16`
- `memory.readi32`
- `memory.readi64`
- `memory.readu8`
- `memory.readu16`
- `memory.readu32`
- `memory.readu64`
- `memory.readf32`
- `memory.readf64`
- `memory.readstring`
- `memory.at`
- `memory.readbuffer`
- `memory.writebuffer`
- `memory.readvector`
- `crypt.random`
- `crypt.random_deterministic`
- `crypt.hash.sha256`
- `crypt.hash.sha512`
- `crypt.hash.blake2b`
- `crypt.pwhash`
- `crypt.pwhash_str`
- `crypt.pwhash_str_verify`
- `crypt.secretbox.seal`
- `crypt.secretbox.open`
- `crypt.aead.encrypt`
- `crypt.aead.decrypt`
- `crypt.box.keypair`
- `crypt.box.encrypt`
- `crypt.box.decrypt`
- `crypt.box.seal`
- `crypt.box.open`
- `crypt.box.beforenm`
- `crypt.sign.keypair`
- `crypt.sign.sign`
- `crypt.sign.open`
- `crypt.sign.detached`
- `crypt.sign.verify_detached`
- `crypt.base64.encode`
- `crypt.base64.decode`
- `crypt.hmac.sha256`
- `crypt.hmac.sha512`
- `crypt.hkdf_sha256`
- `crypt.hexadecimal.encode`
- `crypt.hexadecimal.decode`
- `polyline` to drawing lib
- `setrawmetatable`
- `getrawmetatable`
- `taskscheduler` global
- `description` property for baseparts
- `tamzen` font
- `LilitaOne` font

### Changes:
- Renamed `time` to `tick`
- Renamed `checkfile` to `isfile`
- Renamed `deletefile` to `delfile`
- Renamed `deletefolder` to `delfolder`
- Faster print/warn functions
- 3x performance - optimized
- Major lua environment shift
- Renamed `checkfolder` to `isfolder`
- Renamed `SetNotification` to `send_notification`
- Renamed `pointer_to_user_data` to `pointer_to_userdata`
- Removed pre-reg standalone functions
- Removed `getmemoryvalue`/`setmemoryvalue`
- Renamed `websocket` to `WebsocketClient`
- Moved `json` to `crypt` [crypt.json]
- Upgraded luau 0.679 -> 0.690
- Removed `cframelookat`, `lerpcframe`, `lerpvector3`
- `getpostion`, `getcframe` etc now returns vector instead of table
- Full index, newindex and __namecall handling for instances
- Moved `get_read_strength`/`set_read_strength`/`get_write_strength`/`set_write_strength` to memory lib

### Important Notes:
- **DISABLE ANTI VIRUS THEN OPEN UPGRADE BEFORE OPENING SOFTWARE**
- Lua Changelog - Current Date: 2025-09-21

---

## Model Data Structures

### Model Data Structure

```lua
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
• RigType (number)             - Rig type (e.g., "R6 = 0" or "R15 = 1").
• Whitelisted (boolean)        - Whether the player is excluded from hostile logic.
• Archenemies (Boolean)         - hostile player.
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
```

### Model Edit Structure

```lua
--[[
Model Edit Structure

Defines a partial data structure intended to update specific fields of an existing model data.
Used for modifying values such as health, rig configuration, and targeting data without redefining the full model.
Fields:
• RigType (number)             - Rig type (e.g., R6 = 0, R15 = 1).
• Whitelisted (boolean)       - Whether the player is excluded from hostile checks.
• Archenemies (boolean)        - hostile player.
• Aimbot_Part (Instance)       - Target part for aimbot (usually the head).
• Aimbot_TP_Part (Instance)    - Target part for aimbot teleportation (default: head) (mouse tp).
• Triggerbot_Part (Instance)   - Target part used by triggerbot.
• Health (number)             - Updated current health.
• MaxHealth (number)           - Updated max health capacity.
• BodyHeightScale (number)     - updated height scaling value.

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
```

### Override Local Data

```lua
--[[
override_local_data

Initializes and stores local player-related data from the Lua environment into the internal Data structure. This function is typically invoked when setting up the local player context for gameplay features such as rendering UI displays, etc..

Fields:
• LocalPlayer (userdata)        - Reference to the local player object.
• Displayname (string)          - Local player's visible name.
• Username (string)             - Local player's account username.
• Userid (number)               - Unique ID for the local player (Roblox user ID).
• Character (userdata)          - Reference to the local player's character model.
• Team (userdata, optional)      - Team object the local player belongs to.
• RootPart (userdata)           - Primary part (e.g., HumanoidRootPart) of the local player.
• LeftFoot (userdata)           - LeftFoot part of the local character.
• Head (userdata)               - Head part of the local character.
• LowerTorso (userdata)         - LowerTorso part of the local character.
• Tool (userdata, optional)      - Currently equipped tool or weapon, if any.
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
```
