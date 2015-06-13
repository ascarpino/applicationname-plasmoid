project(applicationname-plasmoid)

cmake_minimum_required(VERSION 2.8.12)

find_package(ECM 0.0.8 REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

find_package(KF5 REQUIRED
    Plasma
)

plasma_install_package(package org.kde.applicationname)
