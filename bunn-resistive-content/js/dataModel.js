.pragma library

var dataList = [];

var currentIndex = 0;


// declaring a global variable for storing the database instance
var _db

//
function openDB() {
    _db = openDatabaseSync("Trifecta","1.0","Trifecta Recipe Database",1000000);
    createRecipeTable();
    createSettingsTable();
}

function createRecipeTable() {
    _db.transaction(
       function(tx) {
           // Create the settings table if it doesn't already exist
           // If the table exists, this is skipped
           tx.executeSql("CREATE TABLE IF NOT EXISTS recipe (recipeId INTEGER PRIMARY KEY AUTOINCREMENT, machineRecipe BOOLEAN, recipeName TEXT UNIQUE, volume REAL,  preWet REAL, preInfusion REAL, fillPause REAL, extractionTime REAL, turbulenceOn REAL, turbulenceOff REAL, turbulencePower REAL, pressOutPower REAL, pressOutTime REAL, temp REAL)");
       });
}


function createSettingsTable(){
    _db.transaction(
       function(tx) {
           // Create the settings table if it doesn't already exist
           // If the table exists, this is skipped
           tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
       });
}


// This function is used to write a setting into the database
function setSetting(setting, value) {
   // setting: string representing the setting name (eg: “username”)
   // value: string representing the value of the setting (eg: “myUsername”)
   var res = "";
   _db.transaction(
       function(tx) {
           var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
           //console.log(rs.rowsAffected)
           if (rs.rowsAffected > 0)
           {
               res = "OK";
           }
           else
           {
               res = "Error";
           }
       });
  // The function returns “OK” if it was successful, or “Error” if it wasn't
  return res;
}

// This function is used to retrieve a setting from the database
function getSetting(setting) {
   var res="";
   _db.transaction(
       function(tx) {
           var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
           if (rs.rows.length > 0)
           {
              res = rs.rows.item(0).value;
           }
           else
           {
               res = "";
           }
       })
  // The function returns “Unknown” if the setting was not found in the database
  // For more advanced projects, this should probably be handled through error codes
  return res
}


function updateRecipe(recipe){

    var query = "Update recipe set recipeName=?, volume=?, preWet=?, preInfusion=?, fillPause=?, extractionTime=?," +
            "turbulenceOn=?, turbulenceOff=?, turbulencePower=?, pressoutPower=?, pressOutTime=?, temp=? Where recipeID=?";

     var res = 1;

    _db.transaction(
        function(tx) {
            try
            {
                tx.executeSql(query, [recipe.recipeName, recipe.volume, recipe.preWet, recipe.preInfusion, recipe.fillPause,
                                      recipe.extractionTime, recipe.turbulenceOn, recipe.turbulenceOff, recipe.turbulencePower,
                                      recipe.pressOutPower, recipe.pressOutTime, recipe.temp ,recipe.recipeId]);
            }
            catch(err)
            {
                res = err.message;
            }
        });
    return res;
}

function insertRecipe(machineRecipe, recipeName, volume,  preWet, preInfusion, fillPause, extractionTime, turbulenceOn, turbulenceOff, turbulencePower, pressOutPower, pressOutTime, temp){

    var query = "Insert into recipe (machineRecipe, recipeName, volume, preWet, preInfusion, fillPause, extractionTime, turbulenceOn, turbulenceOff, turbulencePower, pressOutPower, pressOutTime, temp) " +
            " Values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

    var res = "";
    var rs;
    _db.transaction(
       function(tx) {
           try
           {
               rs = tx.executeSql(query, [machineRecipe, recipeName, volume,  preWet, preInfusion, fillPause, extractionTime, turbulenceOn, turbulenceOff, turbulencePower, pressOutPower, pressOutTime, temp]);
               if (rs.rowsAffected > 0)
               {
                   rs = tx.executeSql("SELECT last_insert_rowid() as id FROM recipe");
                   res = rs.rows.item(0).id;
               }
           }
           catch (err)
           {
               res = err.message;
           }
       });
    return res;
}


function getRecipeCount()
{
    var query = "select count(*) as count from recipe"
    var rs;
    var res = "";
    _db.transaction(
       function(tx) {
           rs = tx.executeSql(query);
           if (rs.rows.length > 0)
           {
               res = rs.rows.item(0).count;
           }
           else
           {
               res = 0;
           }
       });
    return res;
}


function deleteRecipe(recipeId)
{
    var res = 0;
    var rs;
    _db.transaction(
       function(tx) {
           rs = tx.executeSql("DELETE from recipe where recipeId=" + recipeId);
                    if (rs.rowsAffected > 0)
                    {
                        res = 1;
                    }
       });
    return res;
}


function clearRecipeTable() {
    _db.transaction(
        function(tx) {
            tx.executeSql("DELETE FROM recipe");
        });
}


function loadRecipes()
{
    var query = "select * from recipe"
    var rs;
    _db.transaction(
        function(tx) {
            rs = tx.executeSql(query);
            if (rs.rows.length > 0)
            {
                for (var i=0; i < rs.rows.length; i++)
                {
                    dataList.append({recipeId: rs.rows.item(i).recipeId, machineRecipe: rs.rows.item(i).machineRecipe, recipeName: rs.rows.item(i).recipeName,
                        volume: rs.rows.item(i).volume, preWet: rs.rows.item(i).preWet, preInfusion: rs.rows.item(i).preInfusion,
                        fillPause: rs.rows.item(i).fillPause, extractionTime: rs.rows.item(i).extractionTime, turbulenceOn: rs.rows.item(i).turbulenceOn,
                        turbulenceOff: rs.rows.item(i).turbulenceOff, turbulencePower: rs.rows.item(i).turbulencePower,
                        pressOutPower: rs.rows.item(i).pressOutPower, pressOutTime: rs.rows.item(i).pressOutTime, temp: rs.rows.item(i).temp });
                }
            }
            else
            {
                res = "Error";
            }
        });
}
