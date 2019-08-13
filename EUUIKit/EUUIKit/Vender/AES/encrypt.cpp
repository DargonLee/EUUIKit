//
// Created by wangying on 19-3-25.
//
#include <iostream>
#include <cstring>
#include <cstdlib>
#include "encrypt.h"
#include "contants.h"
#include "Checksum.h"
#include "AESCrypt.h"
#include "keygen.h"


void *xencrypt(const void *plaintext, size_t plaintext_len, const char *token, size_t *dest_len) {
    uint32_t m_crcDigest = zlib::crc32(0, reinterpret_cast<const Bytef *>(plaintext),
                                       plaintext_len); //[0,4294967295]
    char crc[11];
    snprintf(crc, sizeof(crc), "%u", m_crcDigest);
    size_t crc_len = strlen(crc);
    size_t content_len = plaintext_len + crc_len + 1;
    char content[content_len];
    memcpy(content, plaintext, plaintext_len);
    memcpy(content + plaintext_len, "|", 1);
    memcpy(content + plaintext_len + 1, crc, crc_len);

    //AES
    size_t keyLength;
    unsigned char *key = getKey(token, &keyLength);
    AESCrypt crypt(key, keyLength);
    unsigned char *dest = static_cast<unsigned char *>(malloc(content_len));
    crypt.encrypt(reinterpret_cast<const unsigned char *>(content), dest, content_len);
    *dest_len = content_len;
    return dest;
}

void *decrypt(const void *cipher_text, size_t cipher_text_len, const char *token,
              size_t *dest_len) {
    size_t keyLength;
    unsigned char *key = getKey(token, &keyLength);
    AESCrypt crypt(key, keyLength);
    unsigned char dest[cipher_text_len];
    crypt.decrypt(reinterpret_cast<const unsigned char *>(cipher_text), dest, cipher_text_len);

    //dest
    int crcMaxLen = 10;
    int startIndex = -1;
    for (int i = cipher_text_len - 1; i >= 0 && crcMaxLen >= 0; --i) {
        if (dest[i] == '|') {
            startIndex = i + 1;
            break;
        }
        crcMaxLen--;
    }


    if (startIndex != -1) {
        //check
        char crc_target[11], crc_now[11];
        memset(crc_target, 0, sizeof(crc_target));
        memcpy(crc_target, &dest[startIndex], cipher_text_len - startIndex);
        crc_target[cipher_text_len - startIndex] = '\0';

        size_t plaintext_len = (size_t) startIndex - 1;
        char *buffer = static_cast<char *>(malloc(plaintext_len));
        memcpy(buffer, dest, plaintext_len);

        uint32_t m_crcDigest = zlib::crc32(0, reinterpret_cast<const Bytef *>(buffer),
                                           plaintext_len);
        sprintf(crc_now, "%u", m_crcDigest);
        if (!strcmp(crc_now, crc_target)) {
            *dest_len = plaintext_len;
            return reinterpret_cast<unsigned char *>(buffer);
        }
        return nullptr;
    } else {
        return nullptr;
    }
}


int getVersion() {
    return ENCRYPT_VERSION;
}
