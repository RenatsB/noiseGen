include($${PWD}/../../common.pri)

TEMPLATE = app
TARGET = clib_CPU_tests.out

OBJECTS_DIR = obj

INCLUDEPATH+= include /usr/local/include /public/devel/include

LIBS+= -L/usr/local/lib -lgtest -lpthread \
       -L/public/devel/lib/ -lgtest \
       -L../../clib -lclibs -lclibp

INCLUDEPATH+=../../clib/clibs/include
INCLUDEPATH+=../../clib/clibp/include
INCLUDEPATH+=$$PWD/../include

QMAKE_RPATHDIR += ../../clib

HEADERS +=$$files($$PWD/include/*.h)
HEADERS +=$$files($$PWD/../include/testUtils.h)
SOURCES +=$$files($$PWD/src/*.cpp)
SOURCES +=$$files($$PWD/*.cpp)
SOURCES +=$$files($$PWD/../src/testUtils.cpp)
