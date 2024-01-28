#include <math.h>
#include <stdio.h>

int main() {
    double n = 10;
    double x = n / 2;
    while (fabs(n/x - x) > 0.000000001) {
        x = (n/x + x)/2;
    }
    printf("%f\n", x);
    return 0;
}
