

component  output="false" {
	This.clientmanagement="true";
	This.sessionmanagement="True";
	This.sessiontimeout=CreateTimeSpan(0,0,30,0);
	This.applicationtimeout=CreateTimeSpan(1,0,0,0);
	This.setclientcookies="true";
	This.loginstorage="session";
	This.name="VFSManager";
	
	public void function onApplicationStart() output="false" {
		if (listFirst(Server.ColdFusion.productversion) LT 9){
			abort "This application will only run on ColdFusion Server 9 or greater";
		}
		application.pathDelim = right(GetDirectoryFromPath(ExpandPath("/")), 1);
		application.appRootDir =GetDirectoryFromPath(ExpandPath("/")) & 'VFSManager' & application.PathDelim;
		local.settingFile = FileOpen(application.appRootDir & '/config/config.txt.cfm', "read");
		while(NOT FileisEOF(settingFile)) {
			x = FileReadLine(settingFile); // read line
				application.config['#listFirst(x, "=")#'] = listLast(x, "=");
		}
	
		FileClose(local.settingFile);			
		application.rmfObj = createObject('VFSManager.Resources.VFSManager'); // change app var
	}
	
	public boolean function onSessionStart() output="false"{
		session.started = 1;
		return true;
	}
	public boolean function onRequestStart(required string thePage) output="true"{
		if (! isDefined('url.method') || (isDefined('url.method') && url.method != 'userLogin')){
			if (! IsUserLoggedIn() || isDefined('form.Logout') || isDefined('url.logout')){
				include "/VFSManager/includes/login.cfm";
			}
		}
		// prevent calling of config file
		if (arguments.thePage contains "config.txt.cfm"){
			return false;
		}
		if (arguments.thePage does not contain ".cfc") {
			request.vfsStatus = application.rmfObj.vfsStats();
			include "/VFSManager/includes/header.cfm";
		}
		return true;
	}
}
