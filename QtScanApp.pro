
QT += core qml quick concurrent multimedia   scxml
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
TEMPLATE = app

#JQQRCODEREADER_COMPILE_MODE = SRC
include( $$PWD/sharedlibrary/JQLibrary/JQLibrary.pri )
include( $$PWD/sharedlibrary/JQLibrary/JQQRCodeReader.pri )
STATECHARTS = $$PWD/scxml/statemachine.scxml
SOURCES += main.cpp \
    actioncontroller.cpp \
    app.cpp \
    user.cpp

RESOURCES += qml.qrc

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
}

HEADERS += \
    actioncontroller.h \
    app.h \
    singleton.h \
    user.h
