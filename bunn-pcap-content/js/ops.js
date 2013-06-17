var _editObject;
var _warningObject = "";

function doTextOperation(op) {

    var t = _editObject.text;

    if (op == leftArrow) {
        t = t.toString().slice(0, -1)
        if (t.length == 0) {
            t = ""
        }
    }
    else if (op == "done")
    {
        vk.state = "inactive";
        tbName.cursorVisible = false;
        tbName.border.color = "gray";
        opaqueWindow.visible = false;
    }
    else {
        t = t + op.toString()
    }

    _editObject.text = t;
}

function doDateOperation(op) {
    var dateObject = eval(_editObject);
    dateObject.text = op;
}



function doNumericOperation(op) {
    var numEdit = eval(_editObject);

    var t = numEdit.text;

    var warningText = eval(_warningObject);
    warningText.text = "";

    if (t.indexOf(".") > 0 && op.toString() == ".")
    {
         return true;
    }
    else if (t.length > 0 && op.toString() == "-")
    {
        return true;
    }


    if (op == leftArrow) {
        t = t.toString().slice(0, -1)
        if (t.length == 0) {
            t = ""
        }
    } else {
        var result = t + op.toString();
        if (result == "-")
            t = t + op.toString()
        else if (parseFloat(result) <= numEdit.max)
        {
            t = t + op.toString()
        }
        else if (parseFloat(result) > numEdit.max)
        {
            warningText.text = "Max exceeded.";
        }
    }


    numEdit.text = t;
}
