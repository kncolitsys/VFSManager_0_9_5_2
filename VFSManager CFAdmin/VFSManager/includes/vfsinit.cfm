

<cfscript>
	if (listFirst(Server.ColdFusion.productversion) LT 9){
				abort "This application will only run on ColdFusion Server 9 or greater";
	}
	application.vfsm.pathDelim = right(GetDirectoryFromPath(ExpandPath(".")), 1);
	application.vfsm.appRootDir =listDeleteAt(getBaseTemplatePath(), listLen(getBaseTemplatePath(), application.vfsm.PathDelim), application.vfsm.PathDelim) & application.vfsm.PathDelim;
	local.settingFile = FileOpen(application.vfsm.appRootDir & '/config/config.txt.cfm', "read");
	while(NOT FileisEOF(local.settingFile)) {
		x = FileReadLine(local.settingFile); // read line
			application.vfsm.config['#listFirst(x, "=")#'] = listLast(x, "=");
	}
	
	FileClose(local.settingFile);			
	application.vfsm.rmfObj = createObject('Resources.VFSManager'); 
	application.vfsm.vfsinit = true;
</cfscript>




