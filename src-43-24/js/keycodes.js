//.pragma library

var keyBackspace = "\b"
var keyEnter = "\n"
var keyUpArrow = "\u2191"
var keyDownArrow = "\u2193"

var keySrc = "../components/Key.qml";
var component = Qt.createComponent(keySrc);

function createKey(editor, parent, keyCap, keyCode, normalKeyIcon,
                   pressedlKeyIcon, keyHeight, keyWidth, keySpacing, keyTextColor)
{
    if (keyCap === 'Space')
    {
        keyWidth = (keyWidth * 5) + (control.keySpacing * 4)
    }

    if(component.status === Component.Ready){
        var dynamicObject = component.createObject(parent,
                                                   {"objectName" : 'key' + keyCode,
                                                    "keyCap": keyCap,
                                                    "keyCode": keyCode,
                                                    "normalKeyIcon": normalKeyIcon,
                                                    "pressedKeyIcon": pressedlKeyIcon,
                                                    "editor": editor,
                                                    "textColor": keyTextColor,
                                                    "font.bold": true,
                                                    "width": keyWidth,                                                       
                                                    "height": keyHeight});
        if(dynamicObject == null){
            console.log("error creating key");
            console.log(component.errorString());
            return false;
        }

        if (keyCap === '')
        {
            dynamicObject.visible = false;
        }


    }else{
        console.log("error loading key component");
        console.log(component.errorString());
        return false;
    }
}
