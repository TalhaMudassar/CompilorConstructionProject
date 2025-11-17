# Compilor Construction Project

This repository contains the **Compiler Construction Project** completed as part of the academic coursework. The project includes source code, documentation, and demonstration files for **Phase 1** of the project.

---

## Project Structure

CompilorConstructionProject/
├── Phase1/
│ ├── Compiler_Construction_project_phase_01.pdf # Project report
│ ├── demo_video_phase_01.mp4 # Demo video
│ └── phase1_sourcecode/
│ ├── scanner
│ ├── scanner.l
│ ├── lex.yy.c
│ ├── tokens.txt
│ ├── sample.pun
│ ├── errors.log
│ └── .vscode/ # VS Code config files
└── README.md



## Description

This project demonstrates the implementation of a **compiler front-end**, including lexical analysis, token generation, and error handling.  

- **Lexical Analyzer**: Implemented using `.l` files and generated `.c` files.
- **Source Code Samples**: `.pun` files for testing.
- **Output Files**: `tokens.txt` and `errors.log`.
- **Documentation**: PDF report describing project design and implementation.
- **Demo Video**: Demonstrates project execution and workflow.

---

## Requirements

- GCC / C Compiler
- Flex / Lex
- VS Code (optional, for editing and running code)
- Git LFS (for large video files)

---

## Usage

1. Clone the repository:


git clone https://github.com/TalhaMudassar/CompilorConstructionProject.git
Navigate to the Phase 1 source code:


cd CompilorConstructionProject/Phase1/phase1_sourcecode
Compile the lexical analyzer:


flex scanner.l
gcc lex.yy.c -o scanner
Run the scanner with a test file:


./scanner sample.pun >tokens.txt 2>errors.log
Check generated files:

tokens.txt → List of tokens generated

errors.log → Compilation or lexical errors

Notes
Large files like demo_video_phase_01.mp4 are managed using Git LFS.

Ensure Git LFS is installed before cloning or pulling large media files:


git lfs install
git lfs pull
Author
Talha Mudassar

GitHub: https://github.com/TalhaMudassar

License
This project is for academic purposes. Modify and use according to your university guidelines.

