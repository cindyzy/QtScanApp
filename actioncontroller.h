#ifndef ACTIONCONTROLLER_H
#define ACTIONCONTROLLER_H

#include <QObject>
#include <QJSValue>
#include <QVariantMap>

#include "user.h"

#include <QStandardItemModel>

class ActionController:public QObject
{
    Q_OBJECT
    Q_PROPERTY(int counter READ counter WRITE setCounter NOTIFY counterChanged)

public:
    ActionController();

    static ActionController* instance(){return s_instance;}
    static ActionController* s_instance;
//    User* user() const
//    {
//        return m_user;
//    }
    enum ActionType{

        AT_LOGIN, //登入
        AT_LOGOUT, //登出
        AT_UPDATE, //上传修改卷径值

    };

     Q_ENUM(ActionType)

public:
    Q_INVOKABLE void action(ActionType type,QJSValue params);

    Q_INVOKABLE void sendEpc(QString epc){
        emit epcArrived(epc);
    }

    int counter() const
    {
        return m_counter;
    }

    UserPtr getUser(){
        return m_user;
    }

public slots:

    void setCounter(int counter)
    {
        if (m_counter == counter)
            return;

        m_counter = counter;
        emit counterChanged(m_counter);
    }

    void showToastMessage(QString msg);

    void setConnectState(bool netstate);
    Q_INVOKABLE void setScanTime(QString m_scanTime);
    Q_INVOKABLE void setLinkProperty(QString m_produceDate,QString m_batchNumber,QString m_purchasePrice);
    Q_INVOKABLE int getScanTime();
//    Q_INVOKABLE bool getConnectState();

signals:
    void counterChanged(int counter);
    void epcArrived(QString epc);

    void loginSuccess();
    void loginFailed(const QString& str);
    void logoutFinished();
void getConnectState(bool netstate);
    void toastMessage(QString msg);
    void showResultMessage();
private:
    int m_counter = 0;
    UserPtr m_user;

    QDateTime current_time;
    QList<QString> EpcList;
    QList<QString> TidList;
    QList<QString> checkTidList;
    QList<QString> speedList;
    QDateTime start_time;
    int ScanTime;
    QString produceDate;
    QString purchasePrice;
    QString batchNumber;

    int count;
    double speed;
    double time;
    QString deviceMacNumber;
    QMap <QString, QString>checkName,checkType;
    QMap <QString, int>checkCount;
    int shopId;

    int companyId;
    int gateId;

//    bool m_netstate;
private slots:
    QString sendCmd(QString cmd);
//    void netConected();
};

#endif // ACTIONCONTROLLER_H
