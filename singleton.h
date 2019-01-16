#ifndef SINGLETON_H
#define SINGLETON_H

#include <QMutex>
#include <QAtomicPointer>

#define SINGLETON_CLASS(T) static T* s_instance; \
    static T * instance() { return s_instance;} \

#define SINGLETON_CLASS_CPP(T) T* T::s_instance = nullptr;

template <typename T>
class Singleton
{

public:
    // \brief 用于获得SingleTon实例，使用单例模式。  \return SingleTon实例的引用。

    static T &instance(void)
    {

#ifndef Q_ATOMIC_POINTER_TEST_AND_SET_IS_ALWAYS_NATIVE
        if(!QAtomicPointer::isTestAndSetNative())//运行时检测
            qDebug() << "Error: TestAndSetNative not supported!";
#endif

        //使用双重检测。
        if(s_instance.testAndSetOrdered(0, 0))//第一次检测
        {
            QMutexLocker locker(&s_mutex);//加互斥锁。
            s_instance.testAndSetOrdered(0, new T);//第二次检测。
        }

        return *s_instance;
    }

    //提供释放接口
    static void release()
    {
#ifndef Q_ATOMIC_POINTER_TEST_AND_SET_IS_ALWAYS_NATIVE
        if(!QAtomicPointer::isTestAndSetNative())//运行时检测
            qDebug() << "Error: TestAndSetNative not supported!";
#endif

        //使用双重检测。
        if(!s_instance.testAndSetOrdered(0, 0))//第一次检测
        {
            QMutexLocker locker(&s_mutex);//加互斥锁。
            T* obj = s_instance.fetchAndStoreOrdered(0);
            delete obj;
        }
    }

protected:
    //Q_DISABLE_COPY(Singleton)

private:
    static QMutex s_mutex;//实例互斥锁。
    static QAtomicPointer<T> s_instance;//<使用原子指针,默认初始化为0。
};


#endif // SINGLETON_H
