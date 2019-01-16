#include <QGuiApplication>
#include <QQmlApplicationEngine>

// JQLibrary lib improt
#include "JQQRCodeReaderForQml.h"

#include <QDebug>
#include "actioncontroller.h"
#include "statemachine.h"
#include "app.h"
#include <QScreen>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    JQQRCODEREADERFORQML_REGISTERTYPE( engine );
    qmlRegisterType<ActionController>("ActionController",1,0,"ActionController");
    qmlRegisterType<CalculatorStateMachine>("CalculatorStateMachine", 1, 0,
                                            "CalculatorStateMachine");
    qRegisterMetaType<GuiRunable>("GuiRunable");



    App::instance()->setQmlContext(engine.rootContext());
    App::instance()->init();
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;




    return app.exec();
}
