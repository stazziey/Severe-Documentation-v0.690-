# Severe Custom Lua — Documentation — v0.690

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Installation & Environment Setup](#installation--environment-setup)
3. [Language/Syntax Overview](#languagesyntax-overview)
4. [Typechecking Notes](#typechecking-notes)
5. [Standard Library Reference](#standard-library-reference)
   - [Global Functions](#global-functions)
   - [coroutine](#coroutine)
   - [debug](#debug)
   - [math](#math)
   - [string](#string)
   - [os](#os)
   - [table](#table)
   - [utf8](#utf8)
   - [buffer](#buffer)
   - [vector](#vector)
   - [bit32](#bit32)
6. [Engine & API Reference](#engine--api-reference)
   - [Instance](#instance)
   - [DataModel](#datamodel)
   - [BillboardGui](#billboardgui)
   - [Workspace](#workspace)
   - [Players](#players)
   - [Camera](#camera)
   - [BasePart](#basepart)
   - [Player](#player)
   - [Model](#model)
   - [Humanoid](#humanoid)
   - [ValueBase](#valuebase)
   - [MouseService](#mouseservice)
7. [Namespaces & Classes Reference](#namespaces--classes-reference)
   - [crypt](#crypt)
   - [Drawing](#drawing)
   - [luau](#luau)
   - [memory](#memory)
   - [shared](#shared)
   - [thread](#thread)
   - [WebsocketClient](#websocketclient)
   - [Signal](#signal)
8. [Memory Viewer & Performance Notes](#memory-viewer--performance-notes)
9. [Migration Guide](#migration-guide)
10. [Changelog](#changelog)
11. [Appendix](#appendix)

---

## Quick Start

Severe's Custom Lua is a Luau-based scripting runtime designed for high-performance external game interaction. This quick start will get you up and running quickly.

### Basic Script Structure

```lua
-- Basic hello world
print("Hello from Severe's Custom Lua!")

-- Access game services
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

-- Create a simple drawing object
local drawing = Drawing.new("Text")
drawing.Text = "Hello World!"
drawing.Position = Vector2.new(100, 100)
drawing.Visible = true
```

### Key Concepts

- **External Runtime**: Unlike traditional executors, Severe runs externally with limited hooking capabilities
- **Memory Focus**: Strong emphasis on memory manipulation and low-level interaction
- **Luau Base**: Built on Luau with additional performance optimizations and type checking
- **Object-Oriented Engine**: Mimics Roblox's OOP patterns for familiar development

---

## Installation & Environment Setup

### Prerequisites

- License key from SBV2-WHITELIST-BOT
- Anti-virus disabled (using Defender Control or Winaero Tweaker)
- Windows operating system

### Installation Steps

1. **Download the Software**
   - Navigate to the #download channel in the buyers category
   - Download `software.exe`

2. **Disable Anti-virus**
   - Use Defender Control or Winaero Tweaker to temporarily disable anti-virus
   - This is required for the software to function properly

3. **Register the Software**
   - Run `software.exe`
   - Click "Register"
   - Enter your credentials (username and password)
   - Save your credentials securely for future use

4. **Login**
   - For subsequent uses, simply click "Login" and enter your credentials
   - If you encounter "HWID mismatch", reset your KeyAuth (note: 1-week cooldown)

### Environment Configuration

The Severe environment provides:
- **Memory Viewer**: For inspecting and modifying game memory
- **Interpreter**: For executing Luau scripts
- **Explorer**: For navigating game instances
- **External Process Model**: Limited hooking capabilities but enhanced memory access

---

## Language/Syntax Overview

Severe's Custom Lua is based on Luau, which extends Lua 5.1 with additional features and optimizations.

### Basic Syntax

```lua
-- Variable declaration
local x = 42
local y = "hello"

-- Function declaration
local function add(a, b)
    return a + b
end

-- Table creation
local person = {
    name = "John",
    age = 25,
    greet = function(self)
        print("Hello, " .. self.name)
    end
}
```

### Luau Extensions

#### Type Annotations

```lua
-- Function with type annotations
local function greet(name: string): string
    return "Hello, " .. name
end

-- Variable with type annotation
local count: number = 42

-- Table type annotation
local point: {x: number, y: number} = {x = 10, y = 20}
```

#### Compound Assignment

```lua
local x = 10
x += 5      -- x = 15
x -= 3      -- x = 12
x *= 2      -- x = 24
x /= 4      -- x = 6
```

#### Continue Statement

```lua
for i = 1, 10 do
    if i % 2 == 0 then
        continue  -- Skip even numbers
    end
    print(i)  -- Prints odd numbers only
end
```

#### String Interpolation

```lua
local name = "World"
local count = 42
print(`Hello {name}! The count is {count}.`)
```

#### If Expressions

```lua
local max = if a > b then a else b
local sign = if x < 0 then -1 elseif x > 0 then 1 else 0
```

### Number Types

Luau supports additional number formats:

```lua
-- Hexadecimal
local hex = 0xFF  -- 255

-- Binary
local bin = 0b1010  -- 10

-- Decimal separators for readability
local large = 1_000_000  -- 1000000
```

---

## Typechecking Notes

Severe's Custom Lua includes Luau's gradual type system with three modes:

### Type Checking Modes

```lua
--!nocheck      -- No type checking
--!nonstrict   -- Default mode, infers 'any' for unknown types
--!strict      -- Strict type checking
```

### Type System Features

#### Basic Types

```lua
-- Primitive types
local n: number = 42
local s: string = "hello"
local b: boolean = true
local t: table = {}
local f: function = function() end

-- Special types
local a: any = anything      -- Opt-out of type checking
local u: unknown = value    -- Requires type refinement
local n: never = error()    -- No values inhabit this type
```

#### Union Types

```lua
-- Union type
local stringOrNumber: string | number = "hello"
stringOrNumber = 42  -- OK
stringOrNumber = true  -- Type error
```

#### Intersection Types

```lua
-- Intersection type
type XCoord = {x: number}
type YCoord = {y: number}
type Point2D = XCoord & YCoord

local point: Point2D = {x = 10, y = 20}
```

#### Generic Types

```lua
-- Generic function
function first<T>(array: {T}): T?
    return array[1]
end

-- Generic type alias
type Array<T> = {[number]: T}
```

#### Table Types

```lua
-- Array-like table
local numbers: {number} = {1, 2, 3}

-- Dictionary-like table
local person: {name: string, age: number} = {
    name = "John",
    age = 25
}

-- Mixed table
local mixed: {[number]: string, name: string} = {
    "hello", "world",
    name = "table"
}
```

### Type Refinement

```lua
local value: unknown = getInput()

-- Type refinement using typeof
if typeof(value) == "string" then
    -- value is now known to be string
    print(value:upper())
end

-- Type refinement with type guards
function isString(value: any): value is string
    return typeof(value) == "string"
end

if isString(value) then
    -- value is string
end
```

---

## Standard Library Reference

### Global Functions

#### assert

```lua
function assert(value: T, message: string?): T
```

Checks if the value is truthy; raises an error if not.

**Parameters:**
- `value`: Value to check
- `message`: Optional error message

**Returns:** The value if truthy

**Example:**
```lua
local result = assert(x > 0, "x must be positive")
```

#### error

```lua
function error(obj: any, level: number?)
```

Raises an error with the specified object.

**Parameters:**
- `obj`: Error object (usually string)
- `level`: Call stack level for error attribution

**Example:**
```lua
error("Invalid input", 2)  -- Blames caller's caller
```

#### gcinfo

```lua
function gcinfo(): number
```

Returns total heap size in kilobytes.

**Returns:** Current heap consumption in KB

**Example:**
```lua
local memoryUsage = gcinfo()
print(`Memory usage: ${memoryUsage} KB`)
```

#### getfenv

```lua
function getfenv(target: (function | number)?): table
```

Returns the environment table for the target function or stack level.

**Parameters:**
- `target`: Function or stack level (defaults to 1)

**Returns:** Environment table

**Example:**
```lua
local env = getfenv(1)  -- Current function's environment
```

#### getmetatable

```lua
function getmetatable(obj: any): table?
```

Returns the metatable for the specified object.

**Parameters:**
- `obj`: Object to get metatable for

**Returns:** Metatable or nil

**Example:**
```lua
local mt = getmetatable({})
```

#### next

```lua
function next(t: { [K]: V }, i: K?): (K, V)?
```

Returns the next key-value pair in table traversal.

**Parameters:**
- `t`: Table to traverse
- `i`: Previous key (nil for first)

**Returns:** Next key-value pair or nil

**Example:**
```lua
for k, v in next, myTable do
    print(k, v)
end
```

#### newproxy

```lua
function newproxy(mt: boolean?): userdata
```

Creates a new untyped userdata object.

**Parameters:**
- `mt`: Whether to add an empty metatable

**Returns:** New userdata object

**Example:**
```lua
local proxy = newproxy(true)
```

#### print

```lua
function print(args: ...any)
```

Prints all arguments to standard output.

**Parameters:**
- `args`: Values to print

**Example:**
```lua
print("Hello", 42, true)
```

#### rawequal

```lua
function rawequal(a: any, b: any): boolean
```

Returns true if a and b have the same type and value.

**Parameters:**
- `a`: First value
- `b`: Second value

**Returns:** True if equal

**Example:**
```lua
local isEqual = rawequal(42, 42.0)  -- true
```

#### rawget

```lua
function rawget(t: { [K]: V }, k: K): V?
```

Performs table lookup without metatable calls.

**Parameters:**
- `t`: Table to search
- `k`: Key to look up

**Returns:** Value or nil

**Example:**
```lua
local value = rawget(table, "key")
```

#### rawset

```lua
function rawset(t: { [K] : V }, k: K, v: V)
```

Sets table field without metatable calls.

**Parameters:**
- `t`: Table to modify
- `k`: Key to set
- `v`: Value to set

**Example:**
```lua
rawset(table, "key", "value")
```

#### select

```lua
function select(i: string, args: ...T): number
function select(i: number, args: ...T): ...T
```

Returns subset of parameters or parameter count.

**Parameters:**
- `i`: Index or '#'
- `args`: Parameters to select from

**Returns:** Selected values or count

**Example:**
```lua
local count = select("#", 1, 2, 3)  -- 3
local second = select(2, "a", "b", "c")  -- "b"
```

#### setfenv

```lua
function setfenv(target: function | number, env: table)
```

Changes environment table for target function.

**Parameters:**
- `target`: Function or stack level
- `env`: New environment table

**Example:**
```lua
setfenv(myFunction, newEnv)
```

#### setmetatable

```lua
function setmetatable(t: table, mt: table?)
```

Changes metatable for the given table.

**Parameters:**
- `t`: Table to modify
- `mt`: New metatable (or nil)

**Example:**
```lua
setmetatable({}, {__index = {}})
```

#### tonumber

```lua
function tonumber(s: string, base: number?): number?
```

Converts string to number.

**Parameters:**
- `s`: String to convert
- `base`: Number base (default 10)

**Returns:** Number or nil if conversion fails

**Example:**
```lua
local num = tonumber("FF", 16)  -- 255
```

#### tostring

```lua
function tostring(obj: any): string
```

Converts object to string.

**Parameters:**
- `obj`: Object to convert

**Returns:** String representation

**Example:**
```lua
local str = tostring(42)  -- "42"
```

#### type

```lua
function type(obj: any): string
```

Returns the type of the object.

**Parameters:**
- `obj`: Object to check

**Returns:** Type name

**Example:**
```lua
local t = type({})  -- "table"
```

#### typeof

```lua
function typeof(obj: any): string
```

Returns detailed type information.

**Parameters:**
- `obj`: Object to check

**Returns:** Detailed type name

**Example:**
```lua
local t = typeof(Vector3.new())  -- "Vector3"
```

#### ipairs

```lua
function ipairs(t: table): 
```

Returns iterator for array portion of table.

**Parameters:**
- `t`: Table to iterate

**Returns:** Iterator triple

**Example:**
```lua
for i, v in ipairs({1, 2, 3}) do
    print(i, v)
end
```

#### pairs

```lua
function pairs(t: table): 
```

Returns iterator for all table pairs.

**Parameters:**
- `t`: Table to iterate

**Returns:** Iterator triple

**Example:**
```lua
for k, v in pairs({a = 1, b = 2}) do
    print(k, v)
end
```

#### pcall

```lua
function pcall(f: function, args: ...any): (boolean, ...any)
```

Calls function with error handling.

**Parameters:**
- `f`: Function to call
- `args`: Arguments to pass

**Returns:** Success status and function results or error

**Example:**
```lua
local success, result = pcall(function()
    return 1 / 0
end)
```

#### xpcall

```lua
function xpcall(f: function, e: function, args: ...any): (boolean, ...any)
```

Calls function with custom error handler.

**Parameters:**
- `f`: Function to call
- `e`: Error handler function
- `args`: Arguments to pass

**Returns:** Success status and function results or error

**Example:**
```lua
local success, result = xpcall(
    function() return 1 / 0 end,
    function(err) return "Division by zero" end
)
```

#### unpack

```lua
function unpack(a: {V}, f: number?, t: number?): ...V
```

Returns all values from array portion of table.

**Parameters:**
- `a`: Table to unpack
- `f`: Start index (default 1)
- `t`: End index (default #a)

**Returns:** Unpacked values

**Example:**
```lua
local a, b, c = unpack({1, 2, 3})
```

### coroutine

#### coroutine.create

```lua
function coroutine.create(f: function): thread
```

Creates a new coroutine.

**Parameters:**
- `f`: Function to run in coroutine

**Returns:** New coroutine thread

**Example:**
```lua
local co = coroutine.create(function()
    print("Coroutine running")
end)
```

#### coroutine.running

```lua
function coroutine.running(): thread?
```

Returns currently running coroutine.

**Returns:** Current coroutine or nil

**Example:**
```lua
local current = coroutine.running()
```

#### coroutine.status

```lua
function coroutine.status(co: thread): string
```

Returns status of coroutine.

**Parameters:**
- `co`: Coroutine to check

**Returns:** Status string ("running", "suspended", "normal", "dead")

**Example:**
```lua
local status = coroutine.status(co)
```

#### coroutine.wrap

```lua
function coroutine.wrap(f: function): function
```

Creates wrapped coroutine function.

**Parameters:**
- `f`: Function to wrap

**Returns:** Wrapped function

**Example:**
```lua
local wrapped = coroutine.wrap(function()
    return "Hello"
end)
print(wrapped())  -- "Hello"
```

#### coroutine.yield

```lua
function coroutine.yield(args: ...any): ...any
```

Yields current coroutine.

**Parameters:**
- `args`: Values to yield

**Returns:** Values passed to resume

**Example:**
```lua
coroutine.yield("value")
```

#### coroutine.isyieldable

```lua
function coroutine.isyieldable(): boolean
```

Checks if current coroutine can yield.

**Returns:** True if yielding is allowed

**Example:**
```lua
if coroutine.isyieldable() then
    coroutine.yield()
end
```

#### coroutine.resume

```lua
function coroutine.resume(co: thread, args: ...any): (boolean, ...any)
```

Resumes a suspended coroutine.

**Parameters:**
- `co`: Coroutine to resume
- `args`: Arguments to pass to yield

**Returns:** Success status and yielded values or error

**Example:**
```lua
local success, value = coroutine.resume(co, "arg")
```

#### coroutine.close

```lua
function coroutine.close(co: thread): (boolean, any?)
```

Closes a coroutine.

**Parameters:**
- `co`: Coroutine to close

**Returns:** Success status and optional error

**Example:**
```lua
local success, err = coroutine.close(co)
```

### debug

#### debug.info

```lua
function debug.info(co: thread, level: number, s: string): ...any
function debug.info(level: number, s: string): ...any
function debug.info(f: function, s: string): ...any
```

Returns information about stack frame or function.

**Parameters:**
- `co`: Thread (optional)
- `level/f`: Stack level or function
- `s`: Info string (s=source, l=line, n=name, f=function, a=arguments)

**Returns:** Requested information

**Example:**
```lua
local source, line, name = debug.info(2, "sln")
```

#### debug.traceback

```lua
function debug.traceback(co: thread, msg: string?, level: number?): string
function debug.traceback(msg: string?, level: number?): string
```

Returns call stack traceback.

**Parameters:**
- `co`: Thread (optional)
- `msg`: Optional message prefix
- `level`: Starting stack level

**Returns:** Traceback string

**Example:**
```lua
local trace = debug.traceback("Error occurred", 2)
```

### math

#### math.abs

```lua
function math.abs(n: number): number
```

Returns absolute value.

**Example:**
```lua
local result = math.abs(-10)  -- 10
```

#### math.acos

```lua
function math.acos(n: number): number
```

Returns arc cosine in radians [0, π].

**Example:**
```lua
local angle = math.acos(0.5)  -- π/3
```

#### math.asin

```lua
function math.asin(n: number): number
```

Returns arc sine in radians [-π/2, π/2].

**Example:**
```lua
local angle = math.asin(0.5)  -- π/6
```

#### math.atan

```lua
function math.atan(n: number): number
```

Returns arc tangent in radians [-π/2, π/2].

**Example:**
```lua
local angle = math.atan(1)  -- π/4
```

#### math.atan2

```lua
function math.atan2(y: number, x: number): number
```

Returns arc tangent of y/x in radians [-π, π].

**Example:**
```lua
local angle = math.atan2(1, 1)  -- π/4
```

#### math.ceil

```lua
function math.ceil(n: number): number
```

Rounds number up to nearest integer.

**Example:**
```lua
local result = math.ceil(3.2)  -- 4
```

#### math.cos

```lua
function math.cos(n: number): number
```

Returns cosine of angle in radians.

**Example:**
```lua
local result = math.cos(math.pi)  -- -1
```

#### math.cosh

```lua
function math.cosh(n: number): number
```

Returns hyperbolic cosine.

**Example:**
```lua
local result = math.cosh(1)  -- ~1.543
```

#### math.deg

```lua
function math.deg(n: number): number
```

Converts radians to degrees.

**Example:**
```lua
local degrees = math.deg(math.pi)  -- 180
```

#### math.exp

```lua
function math.exp(n: number): number
```

Returns e^n.

**Example:**
```lua
local result = math.exp(1)  -- ~2.718
```

#### math.floor

```lua
function math.floor(n: number): number
```

Rounds number down to nearest integer.

**Example:**
```lua
local result = math.floor(3.8)  -- 3
```

#### math.fmod

```lua
function math.fmod(x: number, y: number): number
```

Returns remainder of x/y, rounded toward zero.

**Example:**
```lua
local result = math.fmod(10, 3)  -- 1
```

#### math.frexp

```lua
function math.frexp(n: number): (number, number)
```

Splits number into significand and exponent.

**Example:**
```lua
local s, e = math.frexp(8)  -- s=0.5, e=4
```

#### math.ldexp

```lua
function math.ldexp(s: number, e: number): number
```

Returns s * 2^e.

**Example:**
```lua
local result = math.ldexp(0.5, 4)  -- 8
```

#### math.lerp

```lua
function math.lerp(a: number, b: number, t: number): number
```

Linear interpolation between a and b.

**Example:**
```lua
local result = math.lerp(0, 10, 0.5)  -- 5
```

#### math.log

```lua
function math.log(n: number, base: number?): number
```

Returns logarithm of n in specified base.

**Example:**
```lua
local result = math.log(100, 10)  -- 2
```

#### math.log10

```lua
function math.log10(n: number): number
```

Returns base-10 logarithm.

**Example:**
```lua
local result = math.log10(100)  -- 2
```

#### math.max

```lua
function math.max(list: ...number): number
```

Returns maximum of input numbers.

**Example:**
```lua
local result = math.max(1, 5, 3)  -- 5
```

#### math.min

```lua
function math.min(list: ...number): number
```

Returns minimum of input numbers.

**Example:**
```lua
local result = math.min(1, 5, 3)  -- 1
```

#### math.modf

```lua
function math.modf(n: number): (number, number)
```

Returns integer and fractional parts.

**Example:**
```lua
local int, frac = math.modf(3.14)  -- 3, 0.14
```

#### math.pow

```lua
function math.pow(x: number, y: number): number
```

Returns x^y.

**Example:**
```lua
local result = math.pow(2, 3)  -- 8
```

#### math.rad

```lua
function math.rad(n: number): number
```

Converts degrees to radians.

**Example:**
```lua
local radians = math.rad(180)  -- π
```

#### math.random

```lua
function math.random(): number
function math.random(n: number): number
function math.random(min: number, max: number): number
```

Returns random number.

**Example:**
```lua
local num1 = math.random()      -- [0, 1]
local num2 = math.random(10)     -- [1, 10]
local num3 = math.random(1, 6)   -- [1, 6]
```

#### math.randomseed

```lua
function math.randomseed(seed: number)
```

Sets random number generator seed.

**Example:**
```lua
math.randomseed(os.time())
```

#### math.sin

```lua
function math.sin(n: number): number
```

Returns sine of angle in radians.

**Example:**
```lua
local result = math.sin(math.pi/2)  -- 1
```

#### math.sinh

```lua
function math.sinh(n: number): number
```

Returns hyperbolic sine.

**Example:**
```lua
local result = math.sinh(1)  -- ~1.175
```

#### math.sqrt

```lua
function math.sqrt(n: number): number
```

Returns square root.

**Example:**
```lua
local result = math.sqrt(16)  -- 4
```

#### math.tan

```lua
function math.tan(n: number): number
```

Returns tangent of angle in radians.

**Example:**
```lua
local result = math.tan(math.pi/4)  -- 1
```

#### math.tanh

```lua
function math.tanh(n: number): number
```

Returns hyperbolic tangent.

**Example:**
```lua
local result = math.tanh(1)  -- ~0.762
```

#### math.noise

```lua
function math.noise(x: number, y: number?, z: number?): number
```

Returns 3D Perlin noise value.

**Example:**
```lua
local noise = math.noise(1, 2, 3)  -- [-1, 1]
```

#### math.clamp

```lua
function math.clamp(n: number, min: number, max: number): number
```

Clamps number between min and max.

**Example:**
```lua
local result = math.clamp(15, 0, 10)  -- 10
```

#### math.map

```lua
function math.map(x: number, inmin: number, inmax: number, outmin: number, outmax: number): number
```

Maps value from input range to output range.

**Example:**
```lua
local result = math.map(5, 0, 10, 0, 100)  -- 50
```

#### math.round

```lua
function math.round(n: number): number
```

Rounds to nearest integer.

**Example:**
```lua
local result = math.round(3.5)  -- 4
```

#### math.sign

```lua
function math.sign(n: number): number
```

Returns sign of number (-1, 0, or 1).

**Example:**
```lua
local result = math.sign(-10)  -- -1
```

### string

#### string.byte

```lua
function string.byte(s: string, f: number?, t: number?): ...number
```

Returns numeric codes of characters.

**Example:**
```lua
local code = string.byte("A")  -- 65
```

#### string.char

```lua
function string.char(args: ...number): string
```

Creates string from character codes.

**Example:**
```lua
local str = string.char(65, 66, 67)  -- "ABC"
```

#### string.find

```lua
function string.find(s: string, p: string, init: number?, plain: boolean?): (number?, number?, ...string)
```

Finds pattern in string.

**Example:**
```lua
local start, finish = string.find("hello world", "world")
```

#### string.format

```lua
function string.format(s: string, args: ...any): string
```

Formats string using printf-style format.

**Example:**
```lua
local result = string.format("Value: %d", 42)  -- "Value: 42"
```

#### string.gmatch

```lua
function string.gmatch(s: string, p: string): 
```

Returns iterator for pattern matches.

**Example:**
```lua
for word in string.gmatch("hello world", "%w+") do
    print(word)
end
```

#### string.gsub

```lua
function string.gsub(s: string, p: string, f: function | table | string, maxs: number?): (string, number)
```

Substitutes pattern matches.

**Example:**
```lua
local result = string.gsub("hello world", "world", "lua")
```

#### string.len

```lua
function string.len(s: string): number
```

Returns string length.

**Example:**
```lua
local length = string.len("hello")  -- 5
```

#### string.lower

```lua
function string.lower(s: string): string
```

Converts string to lowercase.

**Example:**
```lua
local result = string.lower("HELLO")  -- "hello"
```

#### string.match

```lua
function string.match(s: string, p: string, init: number?): ...string?
```

Matches pattern in string.

**Example:**
```lua
local result = string.match("hello123", "%d+")  -- "123"
```

#### string.rep

```lua
function string.rep(s: string, n: number): string
```

Repeats string n times.

**Example:**
```lua
local result = string.rep("ha", 3)  -- "hahaha"
```

#### string.reverse

```lua
function string.reverse(s: string): string
```

Reverses string.

**Example:**
```lua
local result = string.reverse("hello")  -- "olleh"
```

#### string.sub

```lua
function string.sub(s: string, f: number, t: number?): string
```

Returns substring.

**Example:**
```lua
local result = string.sub("hello", 2, 4)  -- "ell"
```

#### string.upper

```lua
function string.upper(s: string): string
```

Converts string to uppercase.

**Example:**
```lua
local result = string.upper("hello")  -- "HELLO"
```

#### string.split

```lua
function string.split(s: string, sep: string?): {string}
```

Splits string by separator.

**Example:**
```lua
local parts = string.split("a,b,c", ",")  -- {"a", "b", "c"}
```

#### string.pack

```lua
function string.pack(f: string, args: ...any): string
```

Packs values into binary string.

**Example:**
```lua
local packed = string.pack("i", 42)
```

#### string.packsize

```lua
function string.packsize(f: string): number
```

Returns size of packed format.

**Example:**
```lua
local size = string.packsize("i")  -- 4
```

#### string.unpack

```lua
function string.unpack(f: string, s: string): ...any
```

Unpacks values from binary string.

**Example:**
```lua
local value = string.unpack("i", packed)
```

### os

#### os.clock

```lua
function os.clock(): number
```

Returns high-precision timestamp.

**Example:**
```lua
local start = os.clock()
-- do work
local elapsed = os.clock() - start
```

#### os.date

```lua
function os.date(s: string?, t: number?): table | string
```

Returns date/time representation.

**Example:**
```lua
local now = os.date("*t")  -- Table with date fields
local str = os.date("%Y-%m-%d")  -- "2023-12-25"
```

#### os.difftime

```lua
function os.difftime(a: number, b: number): number
```

Calculates time difference.

**Example:**
```lua
local diff = os.difftime(time2, time1)
```

#### os.time

```lua
function os.time(t: table?): number
```

Returns Unix timestamp.

**Example:**
```lua
local timestamp = os.time()
```

### table

#### table.concat

```lua
function table.concat(a: {string}, sep: string?, f: number?, t: number?): string
```

Concatenates table elements.

**Example:**
```lua
local result = table.concat({"a", "b", "c"}, ", ")  -- "a, b, c"
```

#### table.foreach

```lua
function table.foreach(t: { [K]: V }, f: (K, V) -> R?): R?
```

**Deprecated:** Iterates over table elements.

**Example:**
```lua
table.foreach({a=1, b=2}, function(k, v) print(k, v) end)
```

#### table.foreachi

```lua
function table.foreachi(t: {V}, f: (number, V) -> R?): R?
```

**Deprecated:** Iterates over array portion.

**Example:**
```lua
table.foreachi({10, 20}, function(i, v) print(i, v) end)
```

#### table.getn

```lua
function table.getn(t: {V}): number
```

**Deprecated:** Returns table length.

**Example:**
```lua
local length = table.getn({1, 2, 3})  -- 3
```

#### table.maxn

```lua
function table.maxn(t: {V}): number
```

Returns maximum numeric key.

**Example:**
```lua
local max = table.maxn({[10]=1, [5]=2})  -- 10
```

#### table.insert

```lua
function table.insert(t: {V}, v: V)
function table.insert(t: {V}, i: number, v: V)
```

Inserts value into table.

**Example:**
```lua
table.insert(myTable, "value")
table.insert(myTable, 2, "middle")
```

#### table.remove

```lua
function table.remove(t: {V}, i: number?): V?
```

Removes element from table.

**Example:**
```lua
local value = table.remove(myTable, 2)
```

#### table.sort

```lua
function table.sort(t: {V}, f: ((V, V) -> boolean)?)
```

Sorts table.

**Example:**
```lua
table.sort(myTable, function(a, b) return a < b end)
```

#### table.pack

```lua
function table.pack(args: ...V): { [number]: V, n: number }
```

Packs arguments into table.

**Example:**
```lua
local packed = table.pack(1, 2, 3)  -- {1, 2, 3, n=3}
```

#### table.unpack

```lua
function table.unpack(a: {V}, f: number?, t: number?): ...V
```

Unpacks table values.

**Example:**
```lua
local a, b, c = table.unpack({1, 2, 3})
```

#### table.move

```lua
function table.move(a: {V}, f: number, t: number, d: number, tt: {V}?)
```

Moves table elements.

**Example:**
```lua
table.move(source, 1, 3, 5, target)
```

#### table.create

```lua
function table.create(n: number, v: V?): {V}
```

Creates table with n elements.

**Example:**
```lua
local t = table.create(5, 0)  -- {0, 0, 0, 0, 0}
```

#### table.find

```lua
function table.find(t: {V}, v: V, init: number?): number?
```

Finds element in table.

**Example:**
```lua
local index = table.find({10, 20, 30}, 20)  -- 2
```

#### table.clear

```lua
function table.clear(t: table)
```

Removes all elements from table.

**Example:**
```lua
table.clear(myTable)
```

#### table.freeze

```lua
function table.freeze(t: table): table
```

Freezes table to prevent modifications.

**Example:**
```lua
local frozen = table.freeze({1, 2, 3})
```

#### table.isfrozen

```lua
function table.isfrozen(t: table): boolean
```

Checks if table is frozen.

**Example:**
```lua
local isFrozen = table.isfrozen(t)
```

#### table.clone

```lua
function table.clone(t: table): table
```

Creates shallow copy of table.

**Example:**
```lua
local copy = table.clone(original)
```

### utf8

#### utf8.offset

```lua
function utf8.offset(s: string, n: number, i: number?): number?
```

Returns byte offset of nth codepoint.

**Example:**
```lua
local offset = utf8.offset("hello", 3)  -- 3
```

#### utf8.codepoint

```lua
function utf8.codepoint(s: string, i: number?, j: number?): ...number
```

Returns Unicode codepoints.

**Example:**
```lua
local code = utf8.codepoint("A")  -- 65
```

#### utf8.char

```lua
function utf8.char(args: ...number): string
```

Creates string from codepoints.

**Example:**
```lua
local str = utf8.char(65, 66, 67)  -- "ABC"
```

#### utf8.len

```lua
function utf8.len(s: string, i: number?, j: number?): number?
```

Returns number of codepoints.

**Example:**
```lua
local length = utf8.len("hello")  -- 5
```

#### utf8.codes

```lua
function utf8.codes(s: string): 
```

Returns iterator for codepoints.

**Example:**
```lua
for offset, code in utf8.codes("hello") do
    print(offset, code)
end
```

### buffer

#### buffer.create

```lua
function buffer.create(size: number): buffer
```

Creates buffer of specified size.

**Example:**
```lua
local buf = buffer.create(1024)  -- 1KB buffer
```

#### buffer.fromstring

```lua
function buffer.fromstring(str: string): buffer
```

Creates buffer from string.

**Example:**
```lua
local buf = buffer.fromstring("hello")
```

#### buffer.tostring

```lua
function buffer.tostring(b: buffer): string
```

Converts buffer to string.

**Example:**
```lua
local str = buffer.tostring(buf)
```

#### buffer.len

```lua
function buffer.len(b: buffer): number
```

Returns buffer size in bytes.

**Example:**
```lua
local size = buffer.len(buf)
```

#### buffer.readi8 / buffer.readu8 / etc.

```lua
function buffer.readi8(b: buffer, offset: number): number
function buffer.readu8(b: buffer, offset: number): number
-- ... and other types
```

Reads values from buffer.

**Example:**
```lua
local value = buffer.readi32(buf, 0)
```

#### buffer.writei8 / buffer.writeu8 / etc.

```lua
function buffer.writei8(b: buffer, offset: number, value: number): ()
function buffer.writeu8(b: buffer, offset: number, value: number): ()
-- ... and other types
```

Writes values to buffer.

**Example:**
```lua
buffer.writei32(buf, 0, 42)
```

#### buffer.readstring

```lua
function buffer.readstring(b: buffer, offset: number, count: number): string
```

Reads string from buffer.

**Example:**
```lua
local str = buffer.readstring(buf, 0, 5)
```

#### buffer.writestring

```lua
function buffer.writestring(b: buffer, offset: number, value: string, count: number?): ()
```

Writes string to buffer.

**Example:**
```lua
buffer.writestring(buf, 0, "hello")
```

#### buffer.readbits

```lua
function buffer.readbits(b: buffer, bitOffset: number, bitCount: number): number
```

Reads bits from buffer.

**Example:**
```lua
local bits = buffer.readbits(buf, 0, 4)
```

#### buffer.writebits

```lua
function buffer.writebits(b: buffer, bitOffset: number, bitCount: number, value: number): ()
```

Writes bits to buffer.

**Example:**
```lua
buffer.writebits(buf, 0, 4, 0xF)
```

#### buffer.copy

```lua
function buffer.copy(target: buffer, targetOffset: number, source: buffer, sourceOffset: number?, count: number?): ()
```

Copies data between buffers.

**Example:**
```lua
buffer.copy(target, 0, source, 0, 100)
```

#### buffer.fill

```lua
function buffer.fill(b: buffer, offset: number, value: number, count: number?): ()
```

Fills buffer with value.

**Example:**
```lua
buffer.fill(buf, 0, 0, 100)
```

### vector

#### vector.zero / vector.one

```lua
vector.zero
vector.one
```

Constant vectors.

**Example:**
```lua
local v = vector.zero
```

#### vector.create

```lua
function vector.create(x: number, y: number, z: number): vector
function vector.create(x: number, y: number, z: number, w: number): vector
```

Creates new vector.

**Example:**
```lua
local v = vector.create(1, 2, 3)
```

#### vector.magnitude

```lua
function vector.magnitude(vec: vector): number
```

Calculates vector magnitude.

**Example:**
```lua
local mag = vector.magnitude(v)
```

#### vector.normalize

```lua
function vector.normalize(vec: vector): vector
```

Normalizes vector.

**Example:**
```lua
local unit = vector.normalize(v)
```

#### vector.cross

```lua
function vector.cross(vec1: vector, vec2: vector): vector
```

Calculates cross product.

**Example:**
```lua
local cross = vector.cross(v1, v2)
```

#### vector.dot

```lua
function vector.dot(vec1: vector, vec2: vector): number
```

Calculates dot product.

**Example:**
```lua
local dot = vector.dot(v1, v2)
```

#### vector.angle

```lua
function vector.angle(vec1: vector, vec2: vector, axis: vector?): number
```

Calculates angle between vectors.

**Example:**
```lua
local angle = vector.angle(v1, v2)
```

#### vector.floor / vector.ceil / vector.abs / vector.sign

```lua
function vector.floor(vec: vector): vector
function vector.ceil(vec: vector): vector
function vector.abs(vec: vector): vector
function vector.sign(vec: vector): vector
```

Applies math function to components.

**Example:**
```lua
local floored = vector.floor(v)
```

#### vector.clamp

```lua
function vector.clamp(vec: vector, min: vector, max: vector): vector
```

Clamps vector components.

**Example:**
```lua
local clamped = vector.clamp(v, vector.zero, vector.one)
```

#### vector.max / vector.min

```lua
function vector.max(...: vector): vector
function vector.min(...: vector): vector
```

Component-wise max/min.

**Example:**
```lua
local maxVec = vector.max(v1, v2, v3)
```

### bit32

#### bit32.arshift

```lua
function bit32.arshift(n: number, i: number): number
```

Arithmetic right shift.

**Example:**
```lua
local result = bit32.arshift(0xFF, 4)  -- 0x0F
```

#### bit32.band

```lua
function bit32.band(args: ...number): number
```

Bitwise AND.

**Example:**
```lua
local result = bit32.band(0xF0, 0x0F)  -- 0x00
```

#### bit32.bnot

```lua
function bit32.bnot(n: number): number
```

Bitwise NOT.

**Example:**
```lua
local result = bit32.bnot(0xF0)  -- 0x0F
```

#### bit32.bor

```lua
function bit32.bor(args: ...number): number
```

Bitwise OR.

**Example:**
```lua
local result = bit32.bor(0xF0, 0x0F)  -- 0xFF
```

#### bit32.bxor

```lua
function bit32.bxor(args: ...number): number
```

Bitwise XOR.

**Example:**
```lua
local result = bit32.bxor(0xF0, 0xFF)  -- 0x0F
```

#### bit32.btest

```lua
function bit32.btest(args: ...number): boolean
```

Tests if bitwise AND is non-zero.

**Example:**
```lua
local result = bit32.btest(0xF0, 0x80)  -- true
```

#### bit32.extract

```lua
function bit32.extract(n: number, f: number, w: number?): number
```

Extracts bits.

**Example:**
```lua
local result = bit32.extract(0xF0, 4, 4)  -- 0x0F
```

#### bit32.lrotate / bit32.rrotate

```lua
function bit32.lrotate(n: number, i: number): number
function bit32.rrotate(n: number, i: number): number
```

Bit rotation.

**Example:**
```lua
local result = bit32.lrotate(0x80, 1)  -- 0x01
```

#### bit32.lshift / bit32.rshift

```lua
function bit32.lshift(n: number, i: number): number
function bit32.rshift(n: number, i: number): number
```

Bit shift.

**Example:**
```lua
local result = bit32.lshift(1, 4)  -- 0x10
```

#### bit32.replace

```lua
function bit32.replace(n: number, r: number, f: number, w: number?): number
```

Replaces bits.

**Example:**
```lua
local result = bit32.replace(0xF0, 0x0F, 0, 4)  -- 0xFF
```

#### bit32.countlz / bit32.countrz

```lua
function bit32.countlz(n: number): number
function bit32.countrz(n: number): number
```

Counts leading/trailing zeros.

**Example:**
```lua
local count = bit32.countlz(0x0F)  -- 28
```

#### bit32.byteswap

```lua
function bit32.byteswap(n: number): number
```

Swaps byte order.

**Example:**
```lua
local result = bit32.byteswap(0x12345678)  -- 0x78563412
```

---

## Engine & API Reference

### Instance

The base class for all objects in the Severe engine.

#### Properties

```lua
Instance.Name: string
Instance.ClassName: string
Instance.Parent: Instance
Instance.Data: string  -- Hexadecimal address
```

#### Methods

```lua
function Instance:GetTags(): { string }
function Instance:HasTag(name: string): boolean
function Instance:AddTag(name: string): ()
function Instance:RemoveTag(name: string): ()
function Instance:ClearTags(): ()
function Instance:GetAttribute(name: string): ()
function Instance:GetAttributes(): { string }
function Instance:SetAttribute(name: string, value: any): ()
function Instance:FindFirstChildOfClass(name: string): Instance?
function Instance:FindFirstChild(name: string): Instance?
function Instance:FindFirstAncestorOfClass(name: string): Instance?
function Instance:FindFirstAncestor(name: string): Instance?
function Instance:GetChildren(): { Instance }
function Instance:GetDescendants(): { Instance }
function Instance:WaitForChild(name: string): Instance?
function Instance:FindFirstDescendant(name: string): Instance?
function Instance:IsAncestorOf(Object: Instance): boolean
function Instance:IsDescendantOf(Object: Instance): boolean
function Instance:Destroy(): ()
```

**Example:**
```lua
local part = workspace:FindFirstChild("Part")
if part then
    print(part.Name, part.ClassName)
    part:Destroy()
end
```

### DataModel

Represents the game's data model.

#### Properties

```lua
DataModel.PlaceId: number
DataModel.GameId: number
DataModel.JobId: string
```

#### Methods

```lua
function DataModel:HttpGet(url: string, content: string): unknown
function DataModel:HttpPost(url: string, data: string, content: string, accept: string, cookie: string?, referer: string?, origin: string?): unknown
function DataModel:GetService(name: string): Instance
function DataModel:GetHwid(): string
```

**Example:**
```lua
local players = game:GetService("Players")
local hwid = game:GetHwid()
```

### BillboardGui

A 2D GUI that faces the camera.

#### Properties

```lua
BillboardGui.Adornee: Instance?
```

**Example:**
```lua
local billboard = Instance.new("BillboardGui")
billboard.Adornee = somePart
```

### Workspace

Contains 3D world objects.

#### Properties

```lua
Workspace.CurrentCamera: Camera?
```

**Example:**
```lua
local camera = workspace.CurrentCamera
if camera then
    print(camera.Position)
end
```

### Players

Manages player connections.

#### Properties

```lua
Players.LocalPlayer: Player?
```

**Example:**
```lua
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
```

### Camera

Represents the viewpoint camera.

#### Properties

```lua
Camera.ViewportSize: vector
Camera.FieldOfView: number?
Camera.CameraSubject: Instance?
Camera.Position: vector
Camera.UpVector: vector
Camera.LookVector: vector
Camera.RightVector: vector
Camera.CFrame: {
    Position: vector,
    UpVector: vector,
    RightVector: vector,
    LookVector: vector
}
```

#### Methods

```lua
function Camera:WorldToScreenPoint(world: vector): (vector, boolean)
```

**Example:**
```lua
local camera = workspace.CurrentCamera
if camera then
    local screenPos, onScreen = camera:WorldToScreenPoint(worldPos)
end
```

### BasePart

Base class for physical parts.

#### Properties

```lua
BasePart.Size: vector
BasePart.Position: vector
BasePart.UpVector: vector
BasePart.LookVector: vector
BasePart.RightVector: vector
BasePart.CFrame: {
    Position: vector,
    UpVector: vector,
    RightVector: vector,
    LookVector: vector
}
BasePart.CanCollide: boolean
BasePart.Transparency: number
BasePart.IsNetworkSleeping: boolean
```

**Example:**
```lua
local part = workspace:FindFirstChildOfClass("BasePart")
if part then
    print(part.Position, part.Size)
end
```

### Player

Represents a connected player.

#### Properties

```lua
Player.Team: Instance?
Player.UserId: number
Player.Character: Model?
Player.DisplayName: string
```

**Example:**
```lua
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
if localPlayer then
    print(localPlayer.DisplayName, localPlayer.UserId)
end
```

### Model

Container for multiple parts.

#### Properties

```lua
Model.PrimaryPart: BasePart?
```

**Example:**
```lua
local model = workspace:FindFirstChildOfClass("Model")
if model then
    print(model.PrimaryPart)
end
```

### Humanoid

Controls character movement and health.

#### Properties

```lua
Humanoid.MaxHealth: number
Humanoid.Health: number
```

**Example:**
```lua
local character = localPlayer.Character
if character then
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        print(humanoid.Health, humanoid.MaxHealth)
    end
end
```

### ValueBase

Base class for value objects.

#### Properties

```lua
ValueBase.Value: any
```

**Example:**
```lua
local intValue = workspace:FindFirstChildOfClass("IntValue")
if intValue then
    print(intValue.Value)
end
```

### MouseService

Provides mouse input functionality.

#### Properties

```lua
MouseService.MouseBehavior: number
MouseService.MouseDeltaSensitivity: number
MouseService.MouseIconEnabled: boolean
```

#### Methods

```lua
function MouseService:GetMouseLocation(): vector
function MouseService:SetMouseLocation(screen: vector): ()
```

**Example:**
```lua
local mouseService = game:GetService("MouseService")
local mousePos = mouseService:GetMouseLocation()
```

---

## Namespaces & Classes Reference

### crypt

Cryptographic functions and utilities.

#### crypt.random

```lua
function crypt.random(length: number): string
```

Generates random bytes.

**Example:**
```lua
local randomBytes = crypt.random(32)
```

#### crypt.random_deterministic

```lua
function crypt.random_deterministic(length: number, seed: string): string
```

Generates deterministic random bytes.

**Example:**
```lua
local bytes = crypt.random_deterministic(16, "seed123")
```

#### Hashing Functions

```lua
function crypt.hash.sha256(message: string): string
function crypt.hash.sha512(message: string): string
function crypt.hash.blake2b(message: string, outlen: number?): string
```

**Example:**
```lua
local hash = crypt.hash.sha256("hello")
```

#### Password Hashing

```lua
function crypt.pwhash(password: string, outlen: number): string
function crypt.pwhash_str(password: string): string
function crypt.pwhash_str_verify(hash: string, password: string): boolean
```

**Example:**
```lua
local hash = crypt.pwhash_str("password")
local isValid = crypt.pwhash_str_verify(hash, "password")
```

#### Encryption

```lua
function crypt.secretbox.seal(plaintext: string, nonce: string, key: string): string
function crypt.secretbox.open(ciphertext: string, nonce: string, key: string): string
function crypt.aead.encrypt(plaintext: string, nonce: string, key: string, ad: string?): string
function crypt.aead.decrypt(ciphertext: string, nonce: string, key: string, ad: string?): string
```

**Example:**
```lua
local nonce = crypt.random(24)
local key = crypt.random(32)
local encrypted = crypt.secretbox.seal("secret", nonce, key)
local decrypted = crypt.secretbox.open(encrypted, nonce, key)
```

#### Public Key Cryptography

```lua
function crypt.box.keypair(): table
function crypt.box.encrypt(message: string, nonce: string, pub: string, sec: string): string
function crypt.box.decrypt(ciphertext: string, nonce: string, pub: string, sec: string): string
function crypt.box.seal(message: string, pub: string): string
function crypt.box.seal_open(ciphertext: string, pub: string, sec: string): string
function crypt.box.beforenm(pub: string, sec: string): string
```

**Example:**
```lua
local keypair = crypt.box.keypair()
local encrypted = crypt.box.seal("message", keypair.public)
local decrypted = crypt.box.seal_open(encrypted, keypair.public, keypair.secret)
```

#### Digital Signatures

```lua
function crypt.sign.keypair(): table
function crypt.sign.sign(message: string, sec: string): string
function crypt.sign.open(signed: string, pub: string): string
function crypt.sign.detached(message: string, sec: string): string
function crypt.sign.verify_detached(sig: string, message: string, pub: string): boolean
```

**Example:**
```lua
local keypair = crypt.sign.keypair()
local signed = crypt.sign.sign("message", keypair.secret)
local message = crypt.sign.open(signed, keypair.public)
```

#### HMAC

```lua
function crypt.hmac.sha256(message: string, key: string): string
function crypt.hmac.sha512(message: string, key: string): string
```

**Example:**
```lua
local hmac = crypt.hmac.sha256("message", "key")
```

#### Key Derivation

```lua
function crypt.hkdf_sha256(ikm: string, salt: string, info: string, outlen: number): string
```

**Example:**
```lua
local derived = crypt.hkdf_sha256("secret", "salt", "info", 32)
```

#### Base64

```lua
function crypt.base64.encode(raw: string): string
function crypt.base64.decode(b64: string): string
```

**Example:**
```lua
local encoded = crypt.base64.encode("hello")
local decoded = crypt.base64.decode(encoded)
```

#### JSON

```lua
function crypt.json.encode(t: table): string
function crypt.json.decode(s: string): table
```

**Example:**
```lua
local json = crypt.json.encode({key = "value"})
local table = crypt.json.decode(json)
```

### Drawing

2D drawing functions for overlay graphics.

#### Drawing.clear

```lua
function Drawing.clear(): ()
```

Removes all drawing objects.

**Example:**
```lua
Drawing.clear()
```

#### Drawing.new

```lua
function Drawing.new(type: string): Object
```

Creates new drawing object.

**Types:** "Text", "Line", "Quad", "Triangle", "Circle", "Square", "Image", "Polyline"

**Example:**
```lua
local text = Drawing.new("Text")
text.Text = "Hello World"
text.Position = Vector2.new(100, 100)
text.Visible = true
```

#### Object Properties

```lua
Object.Visible: boolean
Object.Color: Color3
Object.ZIndex: number
Object.Opacity: number
```

#### Text Object

```lua
Object.Text: string
Object.Size: number
Object.Center: boolean
Object.Outline: boolean
Object.OutlineColor: Vector3
Object.Position: Vector2
Object.TextBounds: Vector2
Object.Font: number  -- [0, 31]
```

#### Line Object

```lua
Object.Thickness: number
Object.From: Vector2
Object.To: Vector2
```

#### Circle Object

```lua
Object.Thickness: number
Object.NumSides: number
Object.Radius: number
Object.Filled: boolean
Object.Position: Vector2
```

#### Square Object

```lua
Object.Thickness: number
Object.Size: Vector2
Object.Position: Vector2
Object.Filled: boolean
Object.Rounding: number
Object.Transparency: number
```

#### Triangle Object

```lua
Object.Thickness: number
Object.PointA: Vector2
Object.PointB: Vector2
Object.PointC: Vector2
Object.Filled: boolean
```

#### Image Object

```lua
Object.Url: string
Object.Data: string
Object.Gif: boolean
Object.Delay: number
Object.Position: Vector2
Object.Size: Vector2
Object.Rounding: number
Object.ImageSize: Vector2
```

#### Quad Object

```lua
Object.Thickness: number
Object.PointA: Vector2
Object.PointB: Vector2
Object.PointC: Vector2
Object.PointD: Vector2
Object.Filled: boolean
```

#### Polyline Object

```lua
Object.Points: { Vector2 }
Object.Thickness: number
Object.Filled: boolean
```

#### Object:Remove

```lua
function Object:Remove(): ()
```

Removes drawing object.

**Example:**
```lua
text:Remove()
```

### luau

Luau compilation and loading functions.

#### luau.compile

```lua
function luau.compile(source: string, options: {
    optimizationLevel: 0 | 1 | 2,
    coverageLevel: 0 | 1 | 2,
    debugLevel: 0 | 1 | 2
}): string
```

Compiles source to bytecode.

**Example:**
```lua
local bytecode = luau.compile("print('Hello')", {
    optimizationLevel = 2,
    coverageLevel = 0,
    debugLevel = 1
})
```

#### luau.load

```lua
function luau.load(bytecode: string, name: string?): function
```

Loads function from bytecode.

**Example:**
```lua
local func = luau.load(bytecode, "MyChunk")
func()
```

### memory

Low-level memory access functions.

#### Memory Reading Functions

```lua
function memory.readi8(address: number): number
function memory.readu8(address: number): number
function memory.readi16(address: number): number
function memory.readu16(address: number): number
function memory.readi32(address: number): number
function memory.readu32(address: number): number
function memory.readi64(address: number): number
function memory.readu64(address: number): number
function memory.readf32(address: number): number
function memory.readf64(address: number): number
```

**Example:**
```lua
local value = memory.readi32(0x12345678)
```

#### Memory Writing Functions

```lua
function memory.writei8(address: number, value: number): ()
function memory.writeu8(address: number, value: number): ()
-- ... and other types
```

**Example:**
```lua
memory.writei32(0x12345678, 42)
```

#### String Functions

```lua
function memory.readstring(address: number): string
function memory.writestring(address: number, value: string): ()
```

**Example:**
```lua
local str = memory.readstring(0x12345678)
memory.writestring(0x12345678, "new string")
```

#### Vector Functions

```lua
function memory.readvector(address: number): vector
function memory.writevector(address: number, value: vector): ()
```

**Example:**
```lua
local vec = memory.readvector(0x12345678)
memory.writevector(0x12345678, vector.create(1, 2, 3))
```

#### Buffer Functions

```lua
function memory.readbuffer(address: number, size: number): buffer
function memory.writebuffer(address: number, value: buffer): ()
```

**Example:**
```lua
local buf = memory.readbuffer(0x12345678, 100)
memory.writebuffer(0x12345678, buf)
```

#### Bit Functions

```lua
function memory.readbits(address: number, bitOffset: number, bitSize: number): number
function memory.writebits(address: number, bitOffset: number, bitSize: number, value: number): ()
```

**Example:**
```lua
local bits = memory.readbits(0x12345678, 0, 4)
memory.writebits(0x12345678, 0, 4, 0xF)
```

#### RTTI Functions

```lua
function memory.rtti(address: number): string?
```

**Example:**
```lua
local typeName = memory.rtti(0x12345678)
```

#### Memory Change Detection

```lua
function memory.changed(address: number, type: string, callback: (self: userdata, change: number | string, old: number | string) -> (), iterations: number?): userdata
```

**Example:**
```lua
local watch = memory.changed(0x12345678, "i32", function(self, newValue, oldValue)
    print(`Value changed from ${oldValue} to ${newValue}`)
end)
```

#### Memory Pointers

```lua
function memory.at(address: number): userdata
```

**Example:**
```lua
local ptr = memory.at(0x12345678)
local value = memory.readi32(ptr, 0)
```

### shared

Shared storage between scripts.

#### shared.get

```lua
function shared.get(key: string): any
```

Gets value from shared storage.

**Example:**
```lua
local value = shared.get("myKey")
```

#### shared.set

```lua
function shared.set(key: string, value: any): ()
```

Sets value in shared storage.

**Example:**
```lua
shared.set("myKey", "myValue")
```

#### shared.remove

```lua
function shared.remove(key: string): ()
```

Removes value from shared storage.

**Example:**
```lua
shared.remove("myKey")
```

#### shared.has

```lua
function shared.has(key: string): boolean
```

Checks if key exists in shared storage.

**Example:**
```lua
local exists = shared.has("myKey")
```

### thread

Thread management functions.

#### thread.create

```lua
function thread.create(name: string, callback: () -> ()): ()
```

Creates new thread.

**Example:**
```lua
thread.create("myThread", function()
    while true do
        print("Thread running")
        wait(1)
    end
end)
```

#### thread.suspend

```lua
function thread.suspend(name: string): ()
```

Suspends thread.

**Example:**
```lua
thread.suspend("myThread")
```

#### thread.resume

```lua
function thread.resume(name: string): ()
```

Resumes thread.

**Example:**
```lua
thread.resume("myThread")
```

#### thread.terminate

```lua
function thread.terminate(name: string): ()
```

Terminates thread.

**Example:**
```lua
thread.terminate("myThread")
```

#### thread.clear

```lua
function thread.clear(): ()
```

Removes all threads.

**Example:**
```lua
thread.clear()
```

### WebsocketClient

WebSocket client for network communication.

#### WebsocketClient.new

```lua
function WebsocketClient.new(url: string) -> WebsocketClient
```

Creates new WebSocket client.

**Example:**
```lua
local ws = WebsocketClient.new("ws://echo.websocket.org")
```

#### WebsocketClient:Disconnect

```lua
function WebsocketClient:Disconnect() -> ()
```

Disconnects WebSocket.

**Example:**
```lua
ws:Disconnect()
```

#### WebsocketClient:Send

```lua
function WebsocketClient:Send(message: string, is_binary: boolean?) -> ()
```

Sends message.

**Example:**
```lua
ws:Send("Hello, WebSocket!")
```

#### WebsocketClient.DataReceived

```lua
WebsocketClient.DataReceived(payload: string, is_binary: boolean?)
```

Event fired when data is received.

**Example:**
```lua
ws.DataReceived:Connect(function(payload, isBinary)
    print("Received:", payload)
end)
```

### Signal

Event signaling system.

#### Signal.new

```lua
function Signal.new(): Signal
```

Creates new signal.

**Example:**
```lua
local signal = Signal.new()
```

#### Signal:connect

```lua
function Signal:connect(callback: (...any) -> ()): Connection
```

Connects callback to signal.

**Example:**
```lua
local connection = signal:connect(function(arg1, arg2)
    print("Signal fired:", arg1, arg2)
end)
```

#### Signal:fire

```lua
function Signal:fire(... any): ()
```

Fires signal.

**Example:**
```lua
signal:fire("hello", 42)
```

#### Signal:wait

```lua
function Signal:wait(): (... any)
```

Waits for signal to fire.

**Example:**
```lua
local arg1, arg2 = signal:wait()
```

#### Signal:once

```lua
function Signal:once(callback: (...any) -> ()): Connection
```

Connects callback for single firing.

**Example:**
```lua
signal:once(function()
    print("Signal fired once")
end)
```

#### Connection:disconnect

```lua
function Connection:disconnect(): ()
```

Disconnects connection.

**Example:**
```lua
connection:disconnect()
```

---

## Memory Viewer & Performance Notes

### Memory Viewer

The Memory Viewer provides functionality similar to ReClass or Cheat Engine's structure dissect tool. It allows you to:

- View memory addresses and their values in multiple data types
- Read and write to memory offsets
- View RTTI (Run-Time Type Information) for offsets
- Navigate through the DataModel address structure

**Key Features:**
- **Offset Display**: Shows hexadecimal offset (e.g., 0x0)
- **Address Display**: Shows 64-bit hexadecimal address (e.g., 0x7ff6a1442b70)
- **Value Display**: Shows string values and numeric representations
- **Multiple Data Types**: Supports dword (int32), double (f64), float (f32), string, and boolean
- **Copy/Write**: Ability to copy addresses and write values

### Performance Notes

#### Luau Performance Characteristics

**Interpreter Optimization:**
- Highly tuned portable bytecode interpreter
- Comparable performance to LuaJIT interpreter
- Efficient bytecode design inspired by LuaJIT
- Multi-pass compiler with AST frontend and bytecode backend

**Type System Performance:**
- Type information used for optimization opportunities
- Gradual typing allows performance tuning
- Type annotations enable compiler optimizations

**Memory Access Patterns:**
- Table access optimized using inline caching and HREFs
- Best performance with:
  - Known field names at compile time
  - Direct table storage (avoid metatables for hot paths)
  - Uniform object structures

**Global Access Optimization:**
- "Imports" optimization for global chains like `math.max`
- Avoid `loadstring`, `getfenv`, `setfenv` for optimal performance
- Localize global functions when possible

**Function Call Optimization:**
- `local function` vs `function` performance difference minimized
- Interprocedural optimizations within single module
- Efficient coroutine implementation

#### Performance Best Practices

1. **Use Local Variables:**
```lua
-- Good
local max = math.max
local result = max(a, b)

-- Less optimal
local result = math.max(a, b)
```

2. **Avoid Metatables in Hot Paths:**
```lua
-- Good
function getValue(obj)
    return obj.value  -- Direct access
end

-- Less optimal in hot paths
local mt = {__index = {value = 42}}
setmetatable(obj, mt)
```

3. **Use Type Annotations:**
```lua
-- Good
local function add(a: number, b: number): number
    return a + b
end

-- Less optimal for compiler optimization
local function add(a, b)
    return a + b
end
```

4. **Prefer Arrays for Sequential Data:**
```lua
-- Good
local items = {1, 2, 3, 4, 5}
for i = 1, #items do
    process(items[i])
end

-- Less optimal for iteration
local items = {[1] = 1, [2] = 2, [3] = 3}
```

5. **Avoid Creating Tables in Loops:**
```lua
-- Good
local results = {}
for i = 1, 1000 do
    results[i] = process(i)
end

-- Less optimal
for i = 1, 1000 do
    local temp = {}
    temp.value = process(i)
    -- use temp
end
```

---

## Migration Guide

**Note:** This migration guide is based on the provided documentation for v0.690. Since specific documentation for v0.04 was not provided, this section outlines the general structure for migration notes. Please provide v0.04 documentation for a complete migration guide.

### General Migration Approach

When migrating from v0.04 to v0.690, consider the following areas:

#### 1. Language Changes

**Luau Base:**
- v0.690 is based on Luau with extended syntax features
- New type checking system with gradual typing
- Additional language constructs like `continue`, compound assignment, string interpolation

**Migration Pattern:**
```lua
-- v0.04 (hypothetical)
local x = 0
while x < 10 do
    x = x + 1
    if x % 2 == 0 then
        -- Skip even numbers (no continue in v0.04)
    else
        print(x)
    end
end

-- v0.690
for x = 1, 10 do
    if x % 2 == 0 then
        continue  -- Skip even numbers
    end
    print(x)
end
```

#### 2. Type System Changes

**New Type Checking:**
- v0.690 introduces optional type annotations
- Three type checking modes: `nocheck`, `nonstrict`, `strict`
- Support for generics, unions, intersections

**Migration Pattern:**
```lua
-- v0.04 (hypothetical)
function add(a, b)
    return a + b
end

-- v0.690 with type annotations
function add(a: number, b: number): number
    return a + b
end
```

#### 3. Library Changes

**Standard Library Extensions:**
- New `buffer` library for binary data
- Enhanced `vector` library
- Extended `bit32` functions
- New `crypt` namespace

**Migration Pattern:**
```lua
-- v0.04 (hypothetical)
-- Manual buffer handling
local data = {}
for i = 1, size do
    data[i] = read_byte(address + i - 1)
end

-- v0.690 with buffer library
local buf = buffer.create(size)
for i = 0, size - 1 do
    buffer.writeu8(buf, i, memory.readu8(address + i))
end
```

#### 4. Engine API Changes

**Object-Oriented Engine:**
- v0.690 introduces Roblox-like OOP patterns
- Instance hierarchy with methods
- Service-based architecture

**Migration Pattern:**
```lua
-- v0.04 (hypothetical)
local players = get_players()
local localPlayer = players[1]

-- v0.690
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
```

#### 5. Performance Considerations

**Optimization Changes:**
- Different performance characteristics
- New optimization opportunities with type information
- Changes in memory access patterns

**Migration Pattern:**
```lua
-- v0.04 (hypothetical)
-- Global function calls
for i = 1, 1000 do
    local val = math.max(values[i], threshold)
end

-- v0.690 optimized
local max = math.max  -- Localize for performance
for i = 1, 1000 do
    local val = max(values[i], threshold)
end
```

### Breaking Changes Summary

**Note:** The following breaking changes are inferred based on typical version migrations. Specific changes from v0.04 to v0.690 would require v0.04 documentation for accurate comparison.

1. **Language Syntax:**
   - Introduction of `continue` statement
   - New string interpolation syntax
   - Compound assignment operators
   - If expressions

2. **Type System:**
   - Introduction of gradual typing
   - Type annotations now available
   - New type checking modes

3. **Standard Library:**
   - New `buffer` library
   - Enhanced `vector` operations
   - Extended `bit32` functions
   - New `crypt` namespace

4. **Engine API:**
   - New object-oriented instance system
   - Service-based architecture
   - Different method signatures

5. **Performance:**
   - Different optimization strategies
   - New performance characteristics
   - Changes in memory access patterns

### Migration Checklist

1. **Update Language Constructs:**
   - [ ] Replace manual loop skipping with `continue`
   - [ ] Update string concatenation to use interpolation where appropriate
   - [ ] Consider using compound assignment operators
   - [ ] Update if statements to if expressions where beneficial

2. **Add Type Annotations:**
   - [ ] Add type annotations to function signatures
   - [ ] Consider adding type annotations to critical variables
   - [ ] Set appropriate type checking mode for each file

3. **Update Library Usage:**
   - [ ] Replace manual buffer handling with `buffer` library
   - [ ] Update vector operations to use new functions
   - [ ] Migrate cryptographic operations to `crypt` namespace
   - [ ] Update bit operations to use new `bit32` functions

4. **Update Engine API:**
   - [ ] Replace direct object access with service-based access
   - [ ] Update method calls to new instance methods
   - [ ] Migrate to new event system if applicable

5. **Performance Optimization:**
   - [ ] Localize frequently used global functions
   - [ ] Optimize table access patterns
   - [ ] Consider using type information for optimization
   - [ ] Update memory access patterns for new performance characteristics

---

## Changelog

**Note:** This changelog represents the features available in v0.690 based on the provided documentation. Since v0.04 documentation was not provided, this represents the current state rather than changes from v0.04.

### Version 0.690

#### New Features

**Language & Syntax:**
- Luau-based language implementation
- Support for type annotations and gradual typing
- `continue` statement for loop control
- Compound assignment operators (`+=`, `-=`, `*=`, `/=`, `//=`, `%=`, `^=`, `..=`)
- String interpolation with backtick literals
- If expressions for conditional value assignment
- Enhanced number literals (hexadecimal, binary, decimal separators)

**Type System:**
- Three type checking modes: `nocheck`, `nonstrict`, `strict`
- Support for union types (`|`)
- Support for intersection types (`&`)
- Generic types and functions
- Type refinement with `typeof`
- Table type annotations (array-like and dictionary-like)
- Special types: `any`, `unknown`, `never`

**Standard Library:**
- New `buffer` library for binary data manipulation
- Enhanced `vector` library with additional functions
- Extended `bit32` library with new operations
- New `crypt` namespace for cryptographic operations
- Enhanced `table` library with new functions (`create`, `find`, `clear`, `freeze`, `clone`)
- New string functions (`split`, `pack`, `unpack`)

**Engine API:**
- Object-oriented instance system
- Service-based architecture
- Comprehensive instance hierarchy (Instance, DataModel, Workspace, etc.)
- Drawing namespace for 2D overlay graphics
- Memory namespace for low-level memory access
- Thread management system
- WebSocket client implementation
- Signal/event system

**Performance:**
- Highly optimized bytecode interpreter
- Type-aware optimizations
- Efficient table access patterns
- Global access optimization ("imports")
- Improved coroutine performance

**Development Tools:**
- Memory Viewer for inspecting game memory
- RTTI (Run-Time Type Information) support
- Comprehensive debugging capabilities
- External process model with limited hooking

#### Breaking Changes (Inferred)

**Language:**
- Migration from custom Lua implementation to Luau
- New reserved keywords and syntax
- Changes in operator precedence

**API:**
- Complete redesign of the API structure
- New object-oriented approach
- Different method signatures and return types

**Library:**
- New library organization and namespaces
- Changes in function signatures
- Removal of deprecated functions

#### Performance Improvements

- Faster bytecode execution
- Optimized memory access patterns
- Improved type checking performance
- Better garbage collection characteristics
- Enhanced table operation performance

#### Security Enhancements

- Comprehensive cryptographic library
- Secure random number generation
- Memory protection mechanisms
- External process security model

---

## Appendix

### Source Links

The following links were used as authoritative sources for this documentation:

1. [Main Documentation](https://v-severe.gitbook.io/docs)
2. [Installation Guide](https://v-severe.gitbook.io/docs/introduction/getting-started/installation)
3. [Environment Overview](https://v-severe.gitbook.io/docs/developer-guide/introduction/environment)
4. [Memory Viewer](https://v-severe.gitbook.io/docs/features/memory-viewer)
5. [Luau Syntax](https://v-severe.gitbook.io/docs/luau/syntax)
6. [Lua 5.3 Manual](https://www.lua.org/manual/5.3/manual.html#3.1)
7. [Typechecking](https://v-severe.gitbook.io/docs/luau/typechecking)
8. [Performance](https://v-severe.gitbook.io/docs/luau/performance)
9. [Standard Library](https://v-severe.gitbook.io/docs/luau/library)
10. [coroutine Library](https://v-severe.gitbook.io/docs/luau/library/coroutine)
11. [debug Library](https://v-severe.gitbook.io/docs/luau/library/debug)
12. [math Library](https://v-severe.gitbook.io/docs/luau/library/math)
13. [string Library](https://v-severe.gitbook.io/docs/luau/library/string)
14. [os Library](https://v-severe.gitbook.io/docs/luau/library/os)
15. [table Library](https://v-severe.gitbook.io/docs/luau/library/table)
16. [utf8 Library](https://v-severe.gitbook.io/docs/luau/library/utf8)
17. [buffer Library](https://v-severe.gitbook.io/docs/luau/library/buffer)
18. [vector Library](https://v-severe.gitbook.io/docs/luau/library/vector)
19. [bit32 Library](https://v-severe.gitbook.io/docs/luau/library/bit32)
20. [Engine Reference](https://v-severe.gitbook.io/docs/reference/engine)
21. [Instance Class](https://v-severe.gitbook.io/docs/reference/engine/instance)
22. [DataModel Class](https://v-severe.gitbook.io/docs/reference/engine/datamodel)
23. [BillboardGui Class](https://v-severe.gitbook.io/docs/reference/engine/billboardgui)
24. [Workspace Class](https://v-severe.gitbook.io/docs/reference/engine/workspace)
25. [Players Class](https://v-severe.gitbook.io/docs/reference/engine/players)
26. [Camera Class](https://v-severe.gitbook.io/docs/reference/engine/camera)
27. [BasePart Class](https://v-severe.gitbook.io/docs/reference/engine/basepart)
28. [Player Class](https://v-severe.gitbook.io/docs/reference/engine/player)
29. [Model Class](https://v-severe.gitbook.io/docs/reference/engine/model)
30. [Humanoid Class](https://v-severe.gitbook.io/docs/reference/engine/humanoid)
31. [ValueBase Class](https://v-severe.gitbook.io/docs/reference/engine/valuebase)
32. [MouseService Class](https://v-severe.gitbook.io/docs/reference/engine/mouseservice)
33. [crypt Namespace](https://v-severe.gitbook.io/docs/reference/namespaces/crypt)
34. [Drawing Namespace](https://v-severe.gitbook.io/docs/reference/namespaces/drawing)
35. [luau Namespace](https://v-severe.gitbook.io/docs/reference/namespaces/luau)
36. [memory Namespace](https://v-severe.gitbook.io/docs/reference/namespaces/memory)
37. [shared Namespace](https://v-severe.gitbook.io/docs/reference/namespaces/shared)
38. [thread Namespace](https://v-severe.gitbook.io/docs/reference/namespaces/thread)
39. [WebsocketClient Class](https://v-severe.gitbook.io/docs/reference/classes/websocketclient)
40. [Signal Class](https://v-severe.gitbook.io/docs/reference/classes/signal)

### Assumptions and Limitations

1. **v0.04 Documentation:** Specific documentation for v0.04 was not provided. The migration guide and changelog are structured based on typical version migration patterns but would require v0.04 documentation for complete accuracy.

2. **API Compatibility:** This documentation assumes that v0.690 represents a significant architectural change from v0.04, moving to a Luau-based implementation with a completely redesigned API.

3. **Feature Parity:** It is assumed that v0.690 includes all features from v0.04 plus significant enhancements, but specific feature comparisons cannot be made without v0.04 documentation.

4. **Performance Characteristics:** Performance notes are based on the provided v0.690 documentation and general Luau performance characteristics.

5. **Breaking Changes:** The breaking changes section is inferred based on the architectural differences described in the v0.690 documentation.

### File Structure

For import into Google Docs, this documentation is structured as a single markdown file with:

- Clear heading hierarchy (H1, H2, H3)
- Code blocks with triple backticks
- Numbered lists for procedures
- Table of contents with anchor links
- Consistent formatting throughout

The document can be directly imported into Google Docs while preserving:
- Heading structure and TOC generation
- Code block formatting
- List formatting

- General document structure