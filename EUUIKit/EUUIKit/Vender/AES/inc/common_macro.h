//
// Created by wangying on 19-3-25.
//

#ifndef GENERAL_COMMON_MACRO_H
#define GENERAL_COMMON_MACRO_H

#ifndef NELEM
#define NELEM(x) ((int) (sizeof(x) / sizeof((x)[0])))
#define MEM_FREE(p) if(p){free(p);p=0;}
#endif// end of NELEM

#endif //GENERAL_COMMON_MACRO_H
