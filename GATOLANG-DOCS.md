# GatoLang v1 Language Specification

GatoLang is a small, Java-like language compiled by `gatoc`. Source files use the `.gw` extension.

## Quick start

Hello world:

```gw
print("Hello, GatoLang!");
```

A small program with a function:

```gw
int add(int a, int b) {
  return a + b;
}

int result = add(2, 3);
print(result);
```

---

## Program structure

A GatoLang program is a list of imports, an optional class declaration, top-level function declarations, and top-level statements.

- Files: `*.gw`
- Entry file: the file passed to `gatoc`
- Only the entry file’s top-level statements are executed.
- Imported files are loaded for their class definitions.

---

## Imports and visibility

### Imports

Use `import` with a dotted path or a simple name.

```gw
import math.Math;
```

This resolves to `math/Math.gw`.

Resolution rules:
- Dotted paths resolve relative to the compiler root directory (by default, the entry file’s directory).
- Simple names resolve relative to the importing file’s directory.

### What an import exposes

**Only classes are imported.**
- Class members and fields are accessible across files via the class name.
- Top-level functions are **file-local** and are not callable from other files.

If you want other files to call code, put it inside a class.

Example:

```gw
class SomeLibrary {
  void doSomething() {
    print("Something");
  }
}

void helper() { } // file-local only

SomeLibrary.doSomething(); // accessible from other files if imported
```

### Duplicate class names

If multiple imported files introduce the same class name, compilation fails with a duplicate class error.

---

## Lexical structure

### Comments
- Line comments: `// ...`
- Block comments: `/* ... */`

### Identifiers
Identifiers use ASCII letters, digits, and `_`, and must not start with a digit.

Examples: `foo`, `_count`, `value2`

### Keywords
```
import class new return if else while loop break final
true false
void int float bool string
```

### Literals
- Integers: `0`, `42`, `1000`
- Floats: `3.14`, `0.5` (a decimal point is required for floats)
- Strings: double-quoted, with escapes: `\n`, `\t`, `\"`, `\\`
- Booleans: `true`, `false`

---

## Types

Built-in types:
- `int` (64-bit signed integer)
- `float` (double precision)
- `bool`
- `string`
- Arrays: `int[]`, `float[]`, `bool[]`, `string[]`
- `void` (function return type only)

---

## Variables

Variables require an explicit type and initializer (except top-level globals, which may omit the initializer):

```gw
int n = 10;
string name = "cat";
bool ok = true;
```

Use `final` for read-only variables:

```gw
final int max = 100;
```

Variables can be reassigned unless declared `final`.

---

## Functions

Functions are declared with a return type, name, and typed parameters:

```gw
int sum(int a, int b) {
  return a + b;
}
```

Rules:
- No function overloading.
- Functions cannot be nested inside blocks.
- `void` functions may use `return;` but not `return expr;`.
- Non-`void` functions must return a value.

Top-level functions are visible across all loaded files (including imports).

---

## Classes

`class` defines a type with fields and initializer statements that run on every `new`.

Rules:
- At most one class declaration is allowed per file.
- Field declarations must include an initializer: `Type name = expr;`
- Initializer statements run in source order on every `new`.
- Unqualified identifiers inside initializer statements resolve to earlier fields (implicit receiver).
- Fields must be declared before use inside the class body.

Example:

```gw
class Player {
  int hp = 100;
  string name = "Hero";

  hp += 5; // runs on every new Player
}

Player p = new Player;
print(p.hp);
```

### Access model

Class members are accessed using the class name (namespace-style):

```gw
SomeLibrary.doSomething();
```

Instances created with `new` are fully isolated from other instances.

---

## Control flow

### `if` / `else`

```gw
if (x > 0) {
  print("positive");
} else {
  print("not positive");
}
```

Condition expressions must be `bool`. No truthiness exists.

### `while`

```gw
int i = 0;
while (i < 3) {
  print(i);
  i += 1;
}
```

Condition expressions must be `bool`.

### `loop`

A counted loop that repeats a fixed number of times.

```gw
loop(3) {
  print("Hello");
}

loop(int i : 5) {
  print(i);
}
```

Rules:
- Count must be an `int`.
- The index variable starts at 0 and is read-only inside the loop body.

### `break`

`break;` exits `while` and `loop`.

---

## Expressions and operators

### Operator precedence (high to low)

1. Postfix: function call `f(...)`, member call `X.f(...)`, indexing `a[i]`
2. Unary: `!`, unary `-`
3. Multiplicative: `*`, `/`, `%`
4. Additive: `+`, `-`
5. Comparison: `<`, `<=`, `>`, `>=` (numeric only)
6. Equality: `==`, `!=`
7. Logical: `&&`, `||`
8. Assignment: `=`, `+=`, `-=`, `*=`, `/=`

### Evaluation order (defined)

- Function arguments are evaluated **left-to-right**.
- Binary operators evaluate **left operand first**, then right operand.

### Logical operators (important)

`&&` and `||` do **not** short-circuit.  
Both sides are always evaluated.

---

## Numeric operations

- `+`, `-`, `*`, `/` work on `int` and `float`.
- Mixed `int`/`float` operations promote to `float`.
- Comparisons `<`, `<=`, `>`, `>=` are numeric only; mixed promotes to `float`.
- Equality `==` / `!=` supports numeric equality across `int`/`float`.
- `%` works on `int` and returns `int`.

### Integer division

If both operands are `int`, `/` produces an `int`.

To get a `float`, use a float literal or convert:

```gw
float x = 5.0 / 4.0;
float y = float(a) / float(b);
```

---

## Booleans

- `!`, `&&`, `||` work on `bool`.
- Equality `==`/`!=` works on `bool`.
- Conditions in `if`/`while` must be `bool`.

---

## Strings

- `+` concatenates when either side is `string`.
- `+=` works on strings (`s += s2`).
- `length` returns the number of characters.
- Indexing `s[i]` returns a `string` of length 1.
- Index assignment mutates in place:

```gw
string s = "hello";
s[1] = "a";
print(s); // "hallo"
```

Rules:
- Indexes are `int`.
- Bounds are checked at runtime.
- `s[i] = "x"` requires a 1-character string RHS (runtime-checked).

### String aliasing behavior (defined)

String assignment is reference-like for mutation:

```gw
string a = "hello";
string b = a;
b[0] = "y";
print(a); // yello
```

---

## Arrays

Arrays are growable and created from literals (including nested arrays):

```gw
int[] nums = [1, 2, 3];
string[] names = ["a", "b"];
```

Empty literals are allowed only when the element type is known from context:

```gw
int[] xs = [];
```

Indexing:

```gw
int x = nums[1];
nums[0] = 10;
```

Append, remove, and length:

```gw
nums.append(4);
int removed = nums.remove(1);
print(nums.length);
```

Rules:
- All elements in a literal must share the same type.
- Empty literals require a known array type from context.
- `length` is read-only.
- `remove(index)` removes and returns the element at index.

### Array aliasing behavior (defined)

Arrays are reference-like handles:
- Assignment aliases the same array.
- Passing to functions aliases the same array.
- Mutations (element assignment, append) are visible through all aliases.

---

## Built-in functions

- `print(value)` -> `void`
- `put(value)` -> `void` (no newline)
- `input()` -> `string`
- `int(value)` -> `int`
- `float(value)` -> `float`
- `string(value)` -> `string`
- `random()` -> `float`
- `sleep(ms)` -> `void`
- `args()` -> `string[]`
- `env(name)` -> `string`
- `hasEnv(name)` -> `bool`
- `currentTimeMs()` -> `int`
- `readFile(path)` -> `string`
- `writeFile(path, data)` -> `void`
- `fileExists(path)` -> `bool`
- `httpGet(url)` -> `string[]`
- `httpPost(url, body)` -> `string[]`

Memory: GatoLang uses a generational GC (young copying + old mark-sweep); allocation is automatic and unreachable old objects are reclaimed into a free list.

---

## Errors and restrictions

- Variables must be declared before use.
- Top-level globals are accessible from any function and across imports, regardless of order.
- Types are strict; implicit conversions are limited.
- Global initializers may reference other globals; cyclic initialization is a compile-time error.
- `return` only inside functions.
- `break` only inside `while` and `loop`.
- Empty array literals require a known array type.
- Duplicate imported class names are a compile error.
- `&&` and `||` evaluate both sides (no short-circuit).

---

## Example program

```gw
import Player;

int[] values = [1, 2, 3];
loop(int i : values.length) {
  values[i] += 1;
}

Player p = new Player;
print("hp: " + string(p.hp));
```
