//
// Created by wangying on 19-3-27.
//
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <stdint.h>
#include "keygen.h"

static const uint8_t g_oror[]{61, 90, 31, 2, 20, 13, 9, 16};

static const int g_oror_len = 8;

static const char *SEED1 = "5ec0dd038fdb1f46be5b8b2c29acaeb1"; //md5(zhizhangyi_general_e)
static const int SEED1_LEN = 32;

static unsigned char cachedValue[512];
static size_t cachedLength; //keyLen
static bool cached = false;


unsigned char *getKey(const char *token, size_t *keyLength) {
    if (cached) {
        *keyLength = cachedLength;
        return cachedValue;
    }
    char buffer[512];
    if (token != nullptr && strlen(token) > 0) {
        size_t tokenLen = strlen(token);
        size_t insertIndex = tokenLen % SEED1_LEN;
        memcpy(buffer, SEED1, insertIndex);
        size_t insertLen = tokenLen < 512 - SEED1_LEN ? tokenLen : (512 - SEED1_LEN);
        if (insertLen + SEED1_LEN > 507) {
            insertLen -= 4;
        }
        memcpy(buffer + insertIndex, token, insertLen);
        memcpy(buffer + insertIndex + insertLen, SEED1 + insertIndex, SEED1_LEN - insertIndex);

        uint32_t checkSum = 0;
        for (int i = 0; i < insertLen; ++i) {
            checkSum += token[i];
            checkSum &= 0xfff;
        }
        char checkSumBuffer[20];
        sprintf(checkSumBuffer, "%u", checkSum);
        size_t checkSumBufferLen = strlen(checkSumBuffer);
        memcpy(buffer + SEED1_LEN + insertLen, checkSumBuffer, checkSumBufferLen);
        buffer[SEED1_LEN + insertLen + checkSumBufferLen] = '\0';
    } else {
        sprintf(buffer, "%s", SEED1);
    }


    //xor
    size_t bufferLen = strlen(buffer);
    int i = 0;
    while (i < bufferLen) {
        for (int j = 0; j < g_oror_len; ++j, ++i) {
            buffer[i] = buffer[i] & g_oror[j];
        }
    }

    cachedLength = bufferLen;
    *keyLength = bufferLen;
    memset(cachedValue, 0, *keyLength);
    memcpy(cachedValue, buffer, *keyLength);
    cachedValue[*keyLength] = '\0';
    cached = true;
    return cachedValue;
}