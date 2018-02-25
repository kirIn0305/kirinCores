#include<ap_int.h>

#define ADDR_WIDTH 24
#define XYZ_WIDTH 24
#define PV_WIDTH 24
#define XZ_WIDTH 24
#define PY_WIDTH 24
#define PYK_WIDTH 24
#define Z_WIDTH 24
#define PX_WIDTH 24
#define PXK_WIDTH 24
#define PZ_WIDTH 24


void CalcAddr(ap_uint<ADDR_WIDTH> baseAddr, ap_uint<XYZ_WIDTH> xyz_size_byte, ap_int<PV_WIDTH> pv, ap_uint<XZ_WIDTH> xz_size_byte, ap_int<PY_WIDTH> py, ap_int<PYK_WIDTH> pyk, ap_uint<Z_WIDTH> z_size, ap_int<PX_WIDTH> px, ap_int<PXK_WIDTH> pxk, ap_int<PZ_WIDTH> pz, ap_uint<ADDR_WIDTH> *SRAM_ADDR){
    *SRAM_ADDR = baseAddr + xyz_size_byte * pv + xz_size_byte * (py + pyk) + (z_size * ((px+pxk) >> 3)) + pz;
}
