# 🏗️ Compiler Construction Project: Phase 1 (Lexical Analyzer)

This repository contains the source code and documentation for **Phase 1** of the Compiler Construction Project, focusing on the implementation of a **Lexical Analyzer** (Scanner).


| [![Phase 1 Complete](https://img.shields.io/badge/Phase%201-Complete-brightgreen)](./Phase1/Compiler_Construction_project_phase_01.pdf) | [![C/C++](https://img.shields.io/badge/Language-C/C++-blue)](https://en.wikipedia.org/wiki/C_(programming_language)) | [![Flex](https://img.shields.io/badge/Tool-Flex/Lex-orange)](https://github.com/westes/flex) | [![Report & Demo](https://img.shields.io/badge/Documentation-PDF%20&%20Video-red)](./Phase1/Compiler_Construction_project_phase_01.pdf) |

---

## ✨ Description

This academic project demonstrates the implementation of the **compiler front-end's lexical analysis phase**. The core components implemented are:

* **Lexical Analyzer**: Built using **Flex/Lex** for pattern matching.
* **Token Generation**: Successfully identifies and outputs recognized tokens to a designated file.
* **Error Handling**: Catches and logs compilation or lexical errors encountered during scanning.

### 📂 Key Files and Output

| File | Description | Output/Purpose |
| :--- | :--- | :--- |
| `scanner.l` | The core Flex/Lex source file defining tokens. | Input for Flex |
| `sample.pun` | Sample source code used for testing the scanner. | Input for Scanner |
| `tokens.txt` | **Generated Output:** List of recognized tokens. | Output File |
| `errors.log` | **Generated Output:** Log of any lexical or compilation errors. | Output File |
| `Compiler_Construction_project_phase_01.pdf` | Detailed project report and documentation. | Documentation |
| `demo_video_phase_01.mp4` | Demonstration video showing the execution workflow. | Demonstration |

---

## ⚙️ Requirements

To build and run the lexical analyzer, you need the following tools installed on your system:

* **GCC / C Compiler**
* **Flex / Lex**

> **Note on Large Files**: The demonstration video (`demo_video_phase_01.mp4`) is managed using **Git LFS (Large File Storage)**.
>
> If you need the video file, ensure Git LFS is installed and active:
>
> ```bash
> git lfs install
> git lfs pull
> ```

---

## 🚀 Usage Guide

Follow these steps to clone the repository, compile the source code, and run the scanner with the sample input file.

### 1. Clone the Repository

```bash
git clone [https://github.com/TalhaMudassar/CompilorConstructionProject.git](https://github.com/TalhaMudassar/CompilorConstructionProject.git)
cd CompilorConstructionProject/Phase1/phase1_sourcecode

2. Compile the Lexical Analyzer

Use flex to generate the C source code (lex.yy.c) and then gcc to compile the final executable (scanner):
Bash

flex scanner.l
gcc lex.yy.c -o scanner

3. Run the Scanner

Run the executable, piping the test file (sample.pun) as input:
Bash

./scanner < sample.pun

4. Check Generated Output

After running, the following files will be created or updated in the phase1_sourcecode directory:

    tokens.txt: Review the complete list of tokens identified.

    errors.log: Check for any reported lexical errors.

👤 Author

Talha Mudassar

    GitHub: https://github.com/TalhaMudassar

⚖️ License

This project is submitted as part of academic coursework. Please adhere to your university's guidelines when referencing, modifying, or using this source code.


---

This README is now complete, highly organized, and optimized for GitHub presentation.

Is there anything else you would like to refine or add to the repository documentation, perhaps a separate contributing guide or a future roadmap section?
