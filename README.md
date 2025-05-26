# Maker - Automatic Makefile Generator for 42 Students

This project is a small tool designed for 42 students, tested on the latest version of Ubuntu. It helps you generate a customizable `Makefile` for your C or C++ projects.

---

## 🚀 Installation

Run the installation script:

```bash
bash install.sh
```

This script will:

* Create a `~/.maker/` directory to store the main script `maker.sh`.
* Copy the `maker.sh` script to that directory.
* Add an alias `maker` to your `.zshrc` file.
* Reload your `.zshrc` so the alias is immediately available.

---

## ⚙️ Usage

Use the alias to run the tool:

```bash
maker
```

The script will ask you the following questions:

1️⃣ **What is the program name?**
Example: `a.out`
This will be the name of the compiled binary.

2️⃣ **What is the directory containing the source files?**
Example: `src`
Provide the path to your `.c` or `.cpp` files.

3️⃣ **What is the directory containing the includes?**
Example: `include`
Provide the directory path for your header files (leave blank if none).

4️⃣ **What language? (c/cpp)**
Choose the language of your project: `c` or `cpp`.

---

## 🏗️ How it works

Once you provide the answers, the script will:

✅ Check that the directories exist.
✅ Automatically find all source files (`*.c` or `*.cpp`).
✅ Create a `Makefile` with:

* `all`, `clean`, `fclean`, and `re` rules.
* Dynamic object directory creation.
* Automatic dependency management for C++ projects.

---

## 🧹 Makefile Commands

* `make` : Compile the project.
* `make clean` : Remove the object directory.
* `make fclean` : Remove objects and the compiled binary.
* `make re` : Clean and recompile the project.

---

## 📂 Project Structure

The `maker.sh` script is installed in `~/.maker/`.
The `maker` alias lets you run it from any project.

---

## 📜 License

This project is open-source and free for 42 students.
No warranty – just have fun!

---

Enjoy coding! 🚀
