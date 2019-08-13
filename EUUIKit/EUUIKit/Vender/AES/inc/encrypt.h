

#ifndef GENERAL_ENCRYPT_H
#define GENERAL_ENCRYPT_H
#ifdef __cplusplus
extern "C" {
#endif

void *xencrypt(const void *plaintext, size_t plaintext_len, const char *token, size_t *dest_len);


void *decrypt(const void *cipher_text, size_t cipher_text_len, const char *token, size_t *dest_len);

int getVersion();

#ifdef __cplusplus
}
#endif
#endif
