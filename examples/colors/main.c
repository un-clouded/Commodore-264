
#include <stdint.h>

#include <c16.h>



#define  CHAR_MATRIX  ((uint8_t*)0x0c00)


typedef enum {
  BLACK,
  WHITE,
  RED,
  CYAN,
  PURPLE,       // PLUM
  GREEN,
  BLUE,
  YELLOW,
  ORANGE,
  BROWN,        // OCHRE
  YELLOW_GREEN,
  PINK,
  BLUE_GREEN,   // MINT
  LIGHT_BLUE,   // BLUEGREY
  DARK_BLUE,    // VOILET
  LIGHT_GREEN,  // VERY similar to GREEN
}
TEDCOLOR;


int main ()
{
  uint8_t  y;
  uint8_t  x;

  for (y = 0;  y <= 7;  y += 1)
  {
    for (x = 0;  x <= 15;  x += 1)
    {
      CHAR_MATRIX [40 * y + x] = 0xa0;
      COLOR_RAM [40 * y + x] = (y << 4) | x;
    }
  }

  return 0;
}

