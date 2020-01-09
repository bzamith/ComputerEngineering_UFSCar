// Eh soh um exemplo, nao tem a pretensao de rodar

int i,j,A[MAX];
j=5;
for(i=0; i<MAX; i++){
	j+=2;
	A[i] = big(j);
}

// O de cima vira

int i,j,A[MAX];
#pragma omp parallel for
for(i=0; i<MAX; i++){
	int j = 5 + 2*(i+1);
	A[i] = big(j);
}

// Vamos ver o proximo tb

double ave=0.0;
double A[MAX];
int i;
for(i=0; i<MAX; i++){
	ave += A[i];
}
ave = ave/MAX;

// O de cima vira

double ave=0.0;
double A[MAX];
int i;
#pragma omp parallel for reduction (+:ave)
for(i=0; i<MAX; i++){
	ave += A[i];
}
ave = ave/MAX;