Exercises of Low Level Programming with 8086 Assembly Lecture, implemented with [Emu8086](https://emu8086-microprocessor-emulator.en.softonic.com/) and [DOSBox](https://www.dosbox.com/).

# DOSBox

## Installation

- Download and install [DOSBox](https://www.dosbox.com/) under `C:\dosbox`
- Extract files of `dosbox_bin.zip` into `C:\dosbox\bin`
- Open `DOSBox <version> Options` and add following configuration end of file;

    [autoexec]
    mount c c:\dosbox
    mount b c:\dosbox\bin
    mount d c:\Users\creat\Documents\GitHub\8086-assembly
    d:
    cd exe

## Compile
Inside DOSBox;

    // this will create lst file
    c:\bin\masm.exe test.asm
    
    // this will create .exe from .obj
    c:\bin\link.exe test.obj

## Debug
Inside DOSBox;

    c:\bin\debug.exe test.exe

    -r    show registers, flags and next step
    -t    run single step
    -g    run to offset
    -g cs:1e
    -d    dump memory 
    -d ds:0

We can also run debugger without input exe.
Then debugger will allocate a DS for us.

    c:\bin\debug.exe
    
    -a    start typing assembly (Type ENTER to exit)
    -u    unassemble
    -u cs:100

Visit [here](https://docs.microsoft.com/en-us/previous-versions/tn-archive/cc722863(v=technet.10)?redirectedfrom=MSDN) for all available commands.