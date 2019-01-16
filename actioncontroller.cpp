#include "actioncontroller.h"



#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>
#include <QNetworkInterface>

#include <QQuickItem>
#include <QQuickView>
#include <QObject>
#include "app.h"
ActionController* ActionController::s_instance = nullptr;

ActionController::ActionController()
    :QObject(nullptr)
{
    s_instance  = this;

    m_user = UserPtr(new User());
//Qt::InputMethodHint=false;
//    connect(m_websocket,SIGNAL(isNetConnected()), this,SLOT(netConected));
    count=0;
    speed=0;
    time=0;

    QList<QNetworkInterface> nets = QNetworkInterface::allInterfaces();// 获取所有网络接口列表
    int nCnt = nets.count();
    QString strMacAddr = "";
    for(int i = 0; i < nCnt; i ++)
    {
        // 如果此网络接口被激活并且正在运行并且不是回环地址，则就是我们需要找的Mac地址
        if(nets[i].flags().testFlag(QNetworkInterface::IsUp) && nets[i].flags().testFlag(QNetworkInterface::IsRunning) && !nets[i].flags().testFlag(QNetworkInterface::IsLoopBack))
        {
            strMacAddr = nets[i].hardwareAddress();

        }
    }
    deviceMacNumber=strMacAddr.mid(0,2)+strMacAddr.mid(3,2)+strMacAddr.mid(6,2)+strMacAddr.mid(9,2)+strMacAddr.mid(12,2)+strMacAddr.mid(15,2);
    qDebug()<<"mac"<<deviceMacNumber;
//    action(AT_SHOPNAME_QUERY,QJSValue());



}

void ActionController::action(ActionType type, QJSValue params)
{
   }

void ActionController::showToastMessage(QString msg)
{
    emit toastMessage(msg);
}

void ActionController::setScanTime(QString m_scanTime)
{

    ScanTime=m_scanTime.mid(0,m_scanTime.indexOf("(")).toInt();
       qDebug()<<"ScanTime2"<<ScanTime;
       QString fileName = "timeRecord.txt";
  //        QString str="0000000nnnnnnnnnnnnnnnn";
          QFile file(fileName);
          if(!file.open(QIODevice::WriteOnly  | QIODevice::Text))
          {
              qDebug()<<"打开timeRecord";
             emit toastMessage(QStringLiteral("打开timeRecord.txt文件失败"));
          }
          QTextStream in(&file);
          in<<QString::number(ScanTime)<<"\n";
          file.close();

}
int ActionController::getScanTime()
{

    QFile fileName("timeRecord.txt");
    if (!fileName.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        emit toastMessage(QStringLiteral("打开timeRecord.txt文件失败"));
    }
    QTextStream in(&fileName);
    QString line = in.readLine();
    qDebug()<<"line"<<line;
    ScanTime=line.toInt();
    fileName.close();
    return ScanTime;

}
QString ActionController::sendCmd(QString cmd)
{
    QString sendmessage=cmd;
    for(int i=cmd.length();i<100;i++)
    {
        sendmessage+=" ";
    }
//        qDebug()<<"sendmessage.length()"<<sendmessage.length();
//        qDebug()<<"sendmessage"<<sendmessage;
    return sendmessage;


}
void ActionController::setLinkProperty(QString m_produceDate,QString m_batchNumber,QString m_purchasePrice)
{
    produceDate=m_produceDate+" 00:00:00.000";
    qDebug()<<"produceDate"<<produceDate;
    batchNumber=m_batchNumber;
    qDebug()<<"batchNumber"<<batchNumber;
    purchasePrice=m_purchasePrice;
    qDebug()<<"purchasePrice"<<purchasePrice;

}

void ActionController::setConnectState(bool netstate)
{
//    m_netstate=netstate;
    emit getConnectState(netstate);
}
