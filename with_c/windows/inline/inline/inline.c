#include <stdlib.h>
#include <stdio.h>

const int n = 10;

int main() {
	int dizi[10];
	int i;

	printf("Dizinin orjinal hali:\n");
	for (i = 0; i < n; i++) {
		dizi[i] = i + 1;
		printf("%08x, ", dizi[i]);
	}

	// Note that this ASM is for x86 architecture.
	__asm {
		mov ecx, n
		xor esi, esi

		L2: mov eax, dizi[esi]
			 push ecx
			 mov ecx, 32

			 L1: shr eax, 1
				  rcl ebx, 1
				  loop L1
				  mov dizi[esi], ebx
				  add esi, 4
				  pop ecx
				  loop L2
	}

	printf("\nDizinin reverse hali:\n");
	for (i = 0; i < n; i++)
		printf("%08x, ", dizi[i]);
	printf("\n");

	system("PAUSE");
	return 0;
}
