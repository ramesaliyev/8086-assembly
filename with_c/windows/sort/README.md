# Disable SAFESEH

~~~~
Project Properties | Configuration Properties | Linker | Advanced | NO SAFESEH
~~~~


# Enable MASM on build environment

~~~~
Project Properties | Build Dependencies | Build Customizations… | Mark “masm” as selected.
~~~~


# Set MASM as BUILD ITEM TYPE for .asm

~~~~
assembly file | Right click | Properties | Item type | Change it to Microsoft Macro Assembler
~~~~

# Compare ASM vs C++

Run with line 22-23 as follows on mainer.cpp and note the time

~~~~
	SelSortASM(dizi, n);
	//SelSortC(dizi, n);
~~~~

Also run with line 22-23 as follows on mainer.cpp and note the time

~~~~
	//SelSortASM(dizi, n);
	SelSortC(dizi, n);
~~~~

