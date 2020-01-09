#pragma once
#include<iostream>
//associa a textura à letra
void associaLetra(int sorteia, char letra[], int i) {
	switch (sorteia) {
	case 0:
		letra[i] = 'a';
		break;
	case 1:
		letra[i] = 'c';
		break;
	case 2:
		letra[i] = 'e';
		break;
	case 3:
		letra[i] = 'g';
		break;
	case 4:
		letra[i] = 'l';
		break;
	case 5:
		letra[i] = 'o';
		break;
	case 6:
		letra[i] = 'p';
		break;
	case 7:
		letra[i] = 'r';
		break;
	case 8:
		letra[i] = 's';
		break;
	case 9:
		letra[i] = 't';
		break;
	case 10:
		letra[i] = '*';
		break;
	case 11:
		letra[i] = '%';
		break;
	case 12:
		letra[i] = 't';
		break;
	case 13:
		letra[i] = 'p';
		break;
	case 14:
		letra[i] = 'a';
		break;
	case 15:
		letra[i] = 'o';
		break;
	case 16:
		letra[i] = 'o';
		break;
	/*
	case 17:
		letra[i]= 'v';
		break;
	case 18:
		letra[i] = '*';
		break;*/
	}
}