
#include <stdint.h>



#define  CHAR_MATRIX  ((uint8_t*)0x0c00)



int main ()
{
  uint8_t  y;
  uint8_t  x;

  for (y = 0;  y <= 15;  y += 1)
  {
    for (x = 0;  x <= 15;  x += 1)
    {
      CHAR_MATRIX [40 * y + x] = (y << 4) | x;
    }
  }

  return 0;
}

