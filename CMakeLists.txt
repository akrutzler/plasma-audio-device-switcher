project(plasma-audio-device-switcher)

cmake_minimum_required(VERSION 2.8.12)

set(PROJECT_VERSION "5.11.0")
set(PROJECT_VERSION_MAJOR 5)

set(KF5_MIN_VERSION "5.30.0")

find_package(ECM 1.8.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/)

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS Plasma)

add_subdirectory(package)
