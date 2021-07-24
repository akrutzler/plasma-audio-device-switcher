project(plasma-audio-device-switcher)

cmake_minimum_required(VERSION 3.16)

set(PROJECT_VERSION "5.22.0")
set(PROJECT_VERSION_MAJOR 5)

set(KF5_MIN_VERSION "5.82")

find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/ ${ECM_MODULE_PATH})

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS Plasma)

add_subdirectory(package)
