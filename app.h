#ifndef APP_H
#define APP_H

#include <QObject>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QVariant>


#include <functional>

typedef std::function<void()> GuiRunable;

class App:public QObject
{
    Q_OBJECT
public:
    static App* instance() {
        static App app;
        return &app;
    }

    QQmlContext *qmlContext() const;
    void setQmlContext(QQmlContext *QmlContext);

    void setContextProperty(const QString &name, QObject* value) {
       qmlContext()->setContextProperty(name, value);
    }

    void runOnGui(GuiRunable closure);

    void setUserData(QString key,QVariant value);

    QVariant getUserData(QString key,QVariant defualt = QVariant());

    void init();

protected:
    App();

    Q_INVOKABLE void _runOnGui(GuiRunable closure);

private:
    QQmlContext* m_QmlContext = nullptr;
    QSettings* m_settings = nullptr;
};

#endif // APP_H
