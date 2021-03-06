# DM48

A dungeon exploration game with 3D first-person view for HP-48 handheld calculator of the 1900's.

TL;DR: Following request on a [hacker news thread](https://news.ycombinator.com/item?id=20112479#unv_20133342) I created this repository with the source code.

Full game description and files to download to a HP48 are available on http://amphi-gouri.org/hp48/dm48 .

## Preamble: on the relationship between HP48, binary and test files.

* The HP-48 is not a unix-ish platform (where you typically edit text files, use compilers that run programs in their own confined memory area).
  * On the HP-48, programs and data are stored, and handled in binary form in a common memory area that remains through time.  No memory protection mechanism, a corrupted object can crash the whole system (external memory cards have a hardware write protection switch, still).
  * Only proper strings are stored with their ASCII content (standard-conformant ISO-8859-1 where the unused part of the standard is filled with mathematical symbols and greek letters [ref](https://www.drehersoft.com/mapping-hp48-text-to-unicode/)).
* Data types intended for user consumptions do have a string representation, which is used for editing: system converts before, user edits text, system converts back after editing.
  * Some types visible by user are not editable, for example libraries, "Code" (opaque binary executable).
  * Fun fact, the type system allows a few parameterized types, including the "Array" type.  User can edit 1 and 2-dimensional matrices of real numbers like `[ [ 4 2 ] [ 7 0 ] ]`.  Arrays of other types can be valid objects, used in "External" but the system only shows to the user e.g. "Array of String", making them not editable.
* HP-48 can exchange files with the outer world by sending binary files (faster, round-trip-safe) or ASCII (slower, objects not editable by user cannot do a proper round-trip).
* The user is offered to program in ["RPL" (for Reverse Polish Lisp)](https://en.wikipedia.org/wiki/RPL_\(programming_language\)).
  * Programs are stored in binary forms with a lisp-ish structure, with many tricks to enable text-base editing, allowing events (alarms, battery) to get handled while programs run, etc.
  * Stripped down programs are possible.  At the cost of losing a proper binary-to-text conversion, they allow much faster processing.  They are usually named "External" because the lower level components they are shown as "External" by the clueless binary-to-text parser.
* The representation of files in the HP-48 is tied to low-level details.  For example the first 2.5 (yes, two-and-a-half) bytes if every objects is the address in ROM of the machine code that "executes" this object type.  Writing a portable decoder is possible but long.  Example: [Droid 48 Reader](https://www.drehersoft.com/droid48-reader/).

## How DM48 was developed

* All this program (assembly, graphics, packaging) was written on a real HP-48 GX, essentially between late 1993 and 1997 (maybe 1998), with some minor adjusments in 1999.
* Wall graphics were pre-generated by dedicated programs that apply maths (perspective rules, etc).
* Other graphics were hand-made with the integrated HP48 graphics editor.
* Run-time representations of graphics (gradient background, walls at various positions, pits, stairs, stabs on the floor, monsters, objects in 3D view, objects in bag view) and data (level map, objects positions, data structure that specify how to represent the same object depending on distance, etc) are represented in ways specific to this program, generated by ancillary programs (not included here).
* The main program is written in 100% Saturn assembly stored in strings.
* At compile time, the assembler includes all code and data.
* A thin wrapper is written in "External" (the text intro screen and the text that asks if you want to save).  Its source text is stored in strings, with codes interpreted by the DEV library which converts them to external.
* The result is an "External program" embedding and a big code object where the main loop is.

## Current state

* The content of this repository is an ASCII dump I did long ago from the directory on the HP-48.
* I included in this repository the files that would survive a round-trip, which is not all.

## Compilation requirements

* If you read from the beginning, you know that this repo only contains files that are readable from outside an HP48.  Technically, this is the source code.
* But this source code cannot be compiled as is on a typical machine that has git.  All compilation operations happen on a HP48 with tools that don't exist elsewhere.  Offering a fully Linux-based compilation is out of reach.
  * The best that could be done would be to instrument an HP48 emulator (e.g. x48) to automatically receive all source code, perform all compilation steps, return results.  This is possible but a work in itself.

### Hardware (or emulation) / software dependencies

You need:

* A HP48-GX with 128k extra memory card or emulator, not merged.
* (XLIB 1797) [the DEV library by Gouri & HPreg](http://amphi-gouri.org/hp48/collection/utils/external/dev322.lgc) from DEV v3.10ß by Etienne de Foras
* (XLIB 1308) [HP ASM v1.0 by J.Y Avenard](http://amphi-gouri.org/hp48/collection/utils/text&fnt/strwrt44.lsc)
* (XLIB 1467) [the CRC checking library that helps avoiding file corruption, by your humble servant](http://amphi-gouri.org/hp48/collection/utils/divers/crc199603.lgc)
* (optional, for comfort to edit files on a real HP48) (XLIB 1303) ["StringWriter" by J.Y Avenard.](http://amphi-gouri.org/hp48/collection/utils/text&fnt/strwrt44.lsc)

## How I actually managed to compile it.

* Download the full directory from the [source code as HP48 directory](http://amphi-gouri.org/hp48/dm48/index.html#telecharger), send that to an HP-48 or emulator.  [Direct link](http://amphi-gouri.org/hp48/dm48/dm48source.dir).
* Take a HP48 or emulator.
* Insert a 128k RAM card.
* Merge it: `MERGE1` so that total free memory is comfortable, else the memory is nearly full after compilation to the point you cannot edit some big filed with StringWriter.
* Send to HP48: `dm48source.dir`
* Send to HP48 the necessary libraries (see above), store them to port 0: `[0] [STO]` for each.
* Turn HP48 off then on so that the libraries get configured.
* Enter `dm48source.dir`,
* Enter `dm98v04.dir`,
* Run `COMP`.  On a real HP48 it takes about 50 seconds.  On Droid48 on a Samsung Galaxy A5 2017, it takes about 3 seconds real (wall clock) time.
* It generates a `DM48` file that you can run.

I tested it on 2019-06-13.

## Quick tour of the source directory

TODO
