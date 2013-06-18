#ifndef REACHDEMO_PLUGIN_H
#define REACHDEMO_PLUGIN_H

#include <QDeclarativeExtensionPlugin>

class ReachDemoPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT
#if QT_VERSION >= 0x050000
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
#endif
    
public:
    void registerTypes(const char *uri);
};

#endif // REACHDEMO_PLUGIN_H

