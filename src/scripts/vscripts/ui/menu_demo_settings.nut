
global function InitDemosMenu

struct
{
	var menu
	table<var,string> buttonDescriptions
	var classicMusicSwitch
} file

void function InitDemosMenu()
{
	var menu = GetMenu( "DemosMenu" )
	file.menu = menu

	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, OnOpenDemosMenu )
	AddMenuEventHandler( menu, eUIEvent.MENU_CLOSE, OnCloseDemosMenu )

	var button

	SetupButton( Hud_GetChild( menu, "SwchEnableDemos" ), "Enable Demos", "Enable recording demos (must be set true before loading a map)." )
	SetupButton( Hud_GetChild( menu, "SwchDemosWrite" ), "Save Demos", "Demos write to a local file when recording a demo." )
	SetupButton( Hud_GetChild( menu, "SwchDemosInterpolate" ), "Interpolate Playback", "Do view interpolation during dem playback." )
	SetupButton( Hud_GetChild( menu, "SwchDemosUpdateRateSp" ), "Demo record rate Single Player", "Change the tick recording rate in Single Player" )
	SetupButton( Hud_GetChild( menu, "SwchDemosUpdateRateMp" ), "Demo record rate Multiplayer", "Change the tick recording rate in Multiplayer" )
	SetupButton( Hud_GetChild( menu, "SwchDemosAutorecord" ), "Auto Record", "Automatically record multiplayer matches as demos." )

	button = Hud_GetChild( menu, "BtnMouseKeyboardBindings" )
	SetupButton( button, "#KEY_BINDINGS", "#MOUSE_KEYBOARD_MENU_CONTROLS_DESC" )
	AddButtonEventHandler( button, UIE_CLICK, AdvanceMenuEventHandler( GetMenu( "MouseKeyboardBindingsMenu" ) ) )

	AddEventHandlerToButtonClass( menu, "RuiFooterButtonClass", UIE_GET_FOCUS, FooterButton_Focused )

	AddMenuFooterOption( menu, BUTTON_A, "#A_BUTTON_SELECT" )
	AddMenuFooterOption( menu, BUTTON_B, "#B_BUTTON_BACK", "#BACK" )
}

void function OnOpenDemosMenu()
{
	UI_SetPresentationType( ePresentationType.NO_MODELS )

}

void function OnCloseDemosMenu()
{
	SavePlayerSettings()
}

void function SetupButton( var button, string buttonText, string description )
{
	SetButtonRuiText( button, buttonText )
	file.buttonDescriptions[ button ] <- description
	AddButtonEventHandler( button, UIE_GET_FOCUS, Button_Focused )
}

void function Button_Focused( var button )
{
	string description = file.buttonDescriptions[ button ]
	SetElementsTextByClassname( file.menu, "MenuItemDescriptionClass", description )
}

void function FooterButton_Focused( var button )
{
	SetElementsTextByClassname( file.menu, "MenuItemDescriptionClass", "" )
}