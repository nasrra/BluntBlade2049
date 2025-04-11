global.current_ui = undefined;
global.ui_layer = "Ui";

function disable_current_ui(){
    if(global.current_ui != undefined){
        instance_destroy(global.current_ui);
    }
}

function uimanager_enable_gameplay_ui(){
    disable_current_ui();
    global.current_ui = instance_create_layer(0,0,global.ui_layer, obj_ui_gameplay);
}

function uimanager_enable_death_ui(){
    disable_current_ui();
    global.current_ui = instance_create_layer(0,0,global.ui_layer, obj_ui_death);
}