#ifndef SCRIPTLAUNCHER_H
#define SCRIPTLAUNCHER_H

#include <QObject>
#include <QProcess>
#include <QDir>
#include <QDebug>
#include <QFile>
#include <QSettings>

class ScriptLauncher : public QObject
{
    Q_OBJECT


public:
    explicit ScriptLauncher(QObject *parent = 0) : QObject(parent)
    {
        m_process = new QProcess(this);
    }

    Q_INVOKABLE void launchScript(QString folder)
    {
        //Restart the QML viewer
        m_process->execute("/application/bin/change-app.sh " + folder);
        m_process->waitForFinished();
        //Touch translate file
        m_process->execute("touch -am /application/bin/content/translate.txt");
    }


    Q_INVOKABLE QStringList getContent()
    {
        QString path = "/application/bin";
        QDir directory(path);
        QStringList dirs = directory.entryList(QDir::AllDirs | QDir::NoDotAndDotDot | QDir::NoSymLinks);
        QStringList list;

        for (int i=0; i < dirs.count(); i++)
        {
            //Read config files here
            //Check if we have a config.ini file
            if (QFile::exists(path + "/" + dirs[i] + "/config.ini"))
            {
                QSettings settings(QString(path + "/" + dirs[i] + "/config.ini"), QSettings::IniFormat);
                QString buttonIcon = settings.value("buttonicon/file", "").toString();
                QString buttonText = settings.value("buttontext/text", "").toString();
                list.append(dirs[i] + "||" + buttonIcon + "||" + buttonText);
            }
        }

        return list;
    }

private:
    QProcess *m_process;

signals:
    
public slots:
    
};

#endif // SCRIPTLAUNCHER_H
