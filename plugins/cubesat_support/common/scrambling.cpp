#include "scrambling.h"

namespace cubesat
{
    namespace scrambling
    {
        void si4462_scrambling(uint8_t *d, int len)
        {
            // Thanks https://destevez.net/2019/07/lucky-7-decoded/
            const uint8_t scrambling_seq[] = {
                0x87, 0xb8, 0x59, 0xb7, 0xa1, 0xcc, 0x24, 0x57, 0x5e, 0x4b, 0x9c, 0x0e, 0xe9, 0xea, 0x50, 0x2a, //
                0xbe, 0xb4, 0x1b, 0xb6, 0xb0, 0x5d, 0xf1, 0xe6, 0x9a, 0xe3, 0x45, 0xfd, 0x2c, 0x53, 0x18, 0x0c, //
                0xca, 0xc9, 0xfb, 0x49, 0x37, 0xe5, 0xa8, 0x51, 0x3b, 0x2f, 0x61, 0xaa, 0x72, 0x18, 0x84, 0x02, //
                0x23, 0x23, 0xab, 0x63, 0x89, 0x51, 0xb3, 0xe7, 0x8b, 0x72, 0x90, 0x4c, 0xe8, 0xfb, 0xc1, 0xff, //
            };

            for (int i = 0; i < len; i++)
                d[i] ^= scrambling_seq[i];
        }
    }
}