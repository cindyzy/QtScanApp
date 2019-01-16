#ifndef USER_H
#define USER_H

#include <QObject>
#include <QDateTime>
#include <QSharedPointer>

class User : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString alias READ alias WRITE setAlias NOTIFY aliasChanged)
    Q_PROPERTY(QString tel READ tel WRITE setTel NOTIFY telChanged)
    Q_PROPERTY(int companyId READ companyId WRITE setCompanyId NOTIFY companyIdChanged)
    Q_PROPERTY(QString companyName READ companyName WRITE setCompanyName NOTIFY companyNameChanged)
    Q_PROPERTY(int shopId READ shopId WRITE setShopId NOTIFY shopIdChanged)
    Q_PROPERTY(QString shopName READ shopName WRITE setShopName NOTIFY shopNameChanged)
    Q_PROPERTY(QDateTime createTime READ createTime WRITE setCreateTime NOTIFY createTimeChanged)
    Q_PROPERTY(QDateTime lastLoginTime READ lastLoginTime WRITE setLastLoginTime NOTIFY lastLoginTimeChanged)
    Q_PROPERTY(QString token READ token WRITE setToken NOTIFY tokenChanged)

public:
    explicit User(QObject *parent = nullptr);

    int id() const
    {
        return m_id;
    }

    QString name() const
    {
        return m_name;
    }

    QString alias() const
    {
        return m_alias;
    }

    QString tel() const
    {
        return m_tel;
    }

    int companyId() const
    {
        return m_companyId;
    }

    QString companyName() const
    {
        return m_companyName;
    }

    int shopId() const
    {
        return m_shopId;
    }

    QString shopName() const
    {
        return m_shopName;
    }

    QDateTime createTime() const
    {
        return m_createTime;
    }

    QDateTime lastLoginTime() const
    {
        return m_lastLoginTime;
    }

    QString token() const
    {
        return m_token;
    }

signals:

    void idChanged(int id);

    void nameChanged(QString name);

    void aliasChanged(QString alias);

    void telChanged(QString tel);

    void companyIdChanged(int companyId);

    void companyNameChanged(QString companyName);

    void shopIdChanged(int shopId);

    void shopNameChanged(QString shopName);

    void createTimeChanged(QDateTime createTime);

    void lastLoginTimeChanged(QDateTime lastLoginTime);

    void tokenChanged(QString token);

    public slots:
    void setId(int id)
    {
        if (m_id == id)
            return;

        m_id = id;
        emit idChanged(m_id);
    }
    void setName(QString name)
    {
        if (m_name == name)
            return;

        m_name = name;
        emit nameChanged(m_name);
    }
    void setAlias(QString alias)
    {
        if (m_alias == alias)
            return;

        m_alias = alias;
        emit aliasChanged(m_alias);
    }
    void setTel(QString tel)
    {
        if (m_tel == tel)
            return;

        m_tel = tel;
        emit telChanged(m_tel);
    }
    void setCompanyId(int companyId)
    {
        if (m_companyId == companyId)
            return;

        m_companyId = companyId;
        emit companyIdChanged(m_companyId);
    }
    void setCompanyName(QString companyName)
    {
        if (m_companyName == companyName)
            return;

        m_companyName = companyName;
        emit companyNameChanged(m_companyName);
    }
    void setShopId(int shopId)
    {
        if (m_shopId == shopId)
            return;

        m_shopId = shopId;
        emit shopIdChanged(m_shopId);
    }
    void setShopName(QString shopName)
    {
        if (m_shopName == shopName)
            return;

        m_shopName = shopName;
        emit shopNameChanged(m_shopName);
    }
    void setCreateTime(QDateTime createTime)
    {
        if (m_createTime == createTime)
            return;

        m_createTime = createTime;
        emit createTimeChanged(m_createTime);
    }
    void setLastLoginTime(QDateTime lastLoginTime)
    {
        if (m_lastLoginTime == lastLoginTime)
            return;

        m_lastLoginTime = lastLoginTime;
        emit lastLoginTimeChanged(m_lastLoginTime);
    }
    void setToken(QString token)
    {
        if (m_token == token)
            return;

        m_token = token;
        emit tokenChanged(m_token);
    }

private:
    int m_id = -1;
    QString m_name;
    QString m_alias;
    QString m_tel;
    int m_companyId = -1;
    QString m_companyName;
    int m_shopId = -1;
    QString m_shopName;
    QDateTime m_createTime;
    QDateTime m_lastLoginTime;
    QString m_token;
};

typedef QSharedPointer<User> UserPtr;

#endif // USER_H
