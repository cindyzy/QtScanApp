#include "app.h"


#include <QDebug>

App::App()
    :QObject(nullptr)
{
    m_settings = new QSettings(this);

}

void App::_runOnGui(GuiRunable closure)
{
    closure();
}

void App::setUserData(QString key, QVariant value)
{
    m_settings->setValue(key,value);
}

QVariant App::getUserData(QString key,QVariant defualt)
{
    if(!m_settings){
        return QVariant();
    }
    return m_settings->value(key);
}

void App::init()
{

}

QQmlContext *App::qmlContext() const
{
    return m_QmlContext;
}

void App::setQmlContext(QQmlContext *QmlContext)
{
    m_QmlContext = QmlContext;
}

void App::runOnGui(GuiRunable closure)
{
    QMetaObject::invokeMethod(this,"_runOnGui",Qt::AutoConnection,Q_ARG(GuiRunable,closure));
}
