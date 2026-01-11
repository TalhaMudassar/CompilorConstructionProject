# PUNJ++ Compiler – Phase 1

## Overview

**PUNJ++ (Punjabi Programming Language Plus Plus)** is a high-level programming language designed to make programming intuitive for Punjabi speakers by replacing traditional English syntax with Roman Punjabi expressions.  

Phase 1 of this compiler project focuses on the **lexical analysis** of PUNJ++ programs. The **scanner (`scanner.l`)** tokenizes source code, identifies valid identifiers, numbers, keywords, operators, punctuations, and reports lexical errors.

---

## Features

- Recognizes **Punjabi-inspired keywords** such as `fher`, `nahiTa`, `jadTak`, `likh`, `dass`, `morjaa`.
- Detects valid **identifiers, numbers, strings, and characters**.
- Supports standard **operators** (`<+>`, `<->`, `<!>`, `++>`) and **punctuations** (`:::`, `:::;`, `~>`, `<>`).
- Case-sensitive, similar to C++.
- Generates **tokens.txt** with all recognized tokens.
- Generates **errors.log** for invalid tokens or lexical errors.

---

## Repository Structure

```
CompilorConstructionProject/
├── Phase1/
│   ├── Compiler_Construction_project_phase_01.pdf   # Phase 1 project report
│   ├── demo_video_phase_01.mp4                      # Demo video
│   └── phase1_sourcecode/
│       ├── scanner                                 # Executable scanner
│       ├── scanner.l                               # Lexical analyzer (Flex source)
│       ├── lex.yy.c                                # Generated lexer source
│       ├── tokens.txt                               # Output tokens
│       ├── sample.pun                               # Sample PUNJ++ program
│       ├── errors.log                               # Lexical errors
│       └── .vscode/                                # VS Code config files
└── README.md
```

---

## Installation and Compilation

Ensure you have **Flex** and **GCC** installed.

### Step 1: Generate the lexer

```bash
flex scanner.l
```

This generates:

- `lex.yy.c` → Lexer source file

---

### Step 2: Compile the scanner

```bash
gcc lex.yy.c -o scanner
```

This produces the executable `scanner`.

---

## Usage

### Run the scanner on a PUNJ++ source file:

```bash
./scanner sample.pun
```

This will generate:

- `tokens.txt` → Contains all recognized tokens from the input file.
- `errors.log` → Contains any lexical errors detected in the input file.

---

## Example

### Sample Input (`sample.pun`)

```
int x ~>
x <+> 10 ~>
fher (x <-> 10) :::
dass << x ~>
:::
```

### Output in `tokens.txt`

```
KEYWORD int
IDENTIFIER x
PUNCTUATION ~>
IDENTIFIER x
OPERATOR <+>
NUMBER 10
PUNCTUATION ~>
KEYWORD fher
PUNCTUATION (
IDENTIFIER x
OPERATOR <->
NUMBER 10
PUNCTUATION )
PUNCTUATION :::
KEYWORD dass
OPERATOR <<
IDENTIFIER x
PUNCTUATION ~>
PUNCTUATION :::;
```

### Output in `errors.log`

```
# Empty if no lexical errors, or contains invalid tokens like:
@invalidToken
# or
#123abc
```

---

## Notes

- The **scanner** (`scanner.l`) uses regular expressions to recognize valid tokens and identify invalid ones.
- Keywords, operators, identifiers, and punctuations are all **Roman Punjabi-inspired** for ease of understanding.
- `tokens.txt` and `errors.log` allow easy verification of lexical correctness before moving to syntax parsing in Phase 2.

---

## Authors

**Talha Mudassar** – L1F22BSCS0379  

Phase 1 – Compiler Construction Project  

---

## License

This project is for **educational purposes** and can be freely used or modified for learning lexical analysis in compiler construction.
