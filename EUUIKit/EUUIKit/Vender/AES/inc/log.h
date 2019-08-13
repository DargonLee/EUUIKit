//
// Created by wangying on 19-3-25.
//

#ifndef GENERAL_LOG_H
#define GENERAL_LOG_H

#ifdef __cplusplus
extern "C" {
#endif
#define LOG_TAG "ENCRYPT"

#ifdef ANDROID
#include <android/log.h>

#define LOGD(...) __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

#define LOGI(...) __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)


#else
#define LOGD(...)
#define LOGI(...)
#define LOGE(...)
#endif

#ifdef __cplusplus
}
#endif

#endif //GENERAL_LOG_H
