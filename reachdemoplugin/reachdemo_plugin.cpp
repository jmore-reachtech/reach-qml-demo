#include "reachdemo_plugin.h"
#include "scriptlauncher.h"

#include <qdeclarative.h>

void ReachDemoPlugin::registerTypes(const char *uri)
{
    // @uri com.reachtech.piechart
    qmlRegisterType<ScriptLauncher>(uri, 1, 0, "ScriptLauncher");
}

#if QT_VERSION < 0x050000
Q_EXPORT_PLUGIN2(ReachDemoPlugin, ReachDemoPlugin)
#endif

