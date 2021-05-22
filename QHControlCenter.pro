TEMPLATE = app
QT += quickcontrols2
CONFIG += c++11
SOURCES += main.cpp
RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
CONFIG+=sdk_no_version_check
# Default rules for deployment.

include(quickhub-qmlclientmodule/QHClientModule.pri)
include(deployment.pri)

DISTFILES += \
    Assets/qmldir
