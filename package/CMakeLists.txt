plasma_install_package(. org.kde.plasma.audiodeviceswitcher)

file(GLOB QML_SRCS contents/ui/*.qml)
add_custom_target(QmlFiles ALL echo SOURCES ${QML_SRCS})
