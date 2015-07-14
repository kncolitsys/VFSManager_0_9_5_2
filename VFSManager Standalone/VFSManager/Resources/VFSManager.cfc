
component output="false" extends="CFMLFunctions"
{
	
	public struct function vfsStats()
	 output="false"  {	
		return getVFSMetaData("ram");
	}

	remote any function delFile(required string srcFile)
	 output="false" returnFormat="json"{	
	 	
		local.srcDir = session.lastdirload.dirVal;
		
		if (! fileExists(local.srcDir & '/' &  arguments.srcFile)){
			return false;
		}
		try {
			FileDelete(local.srcDir & '/' &  arguments.srcFile);		
		} catch (any ept){
			return false;
		}
		return true;
	}
	
	remote any function delDirectory()
	 output="false" returnFormat="json"{	
	 	
		local.srcDir = session.lastdirload.dirVal;
		
		if (! directoryExists(local.srcDir)){
			return false;
		}
		try {
			directoryDelete(local.srcDir, true);		
		} catch (any ept){
			
			// used to trap error when deleting root VFS.
			// all content should be deleted.
			if (local.srcDir IS 'ram://'){
				local.restContent = getDirContent(local.srcDir);
				if (local.restContent.recordcount){
					return false;
				} else {
					return true;
				}					
			} 
			return false;
		}
		return true;
	}
	
	remote array function getTreeContent(string path="", string value="")
	output="false" returnFormat="json"{
		
		var q = "";
		var dir = "";
		var dirQry = "";
		var entry = "";
		var result = arrayNew(1);
		var filePath = "";
		var i = "";
		
		if (arguments.value == ''){
			entry = structNew();
        	entry.value= 'ram://';
        	entry.display= 'VFS Root (' & countDirContent(entry.value) & ')';
	        entry.img="fixed";
        	ArrayAppend(result, entry);
		} else {
			dirQry = getDirContent(arguments.value);  
			
			for (i = 1; i <= dirQry.recordCount; i++){
				entry=StructNew();
				entry.value=ARGUMENTS.value & '/' & dirQry.name[i];
				entry.display=dirQry.name[i] & ' (' & countDirContent(entry.value) & ')';
				entry.img="folder";
				entry.imgopen="folder";
				ArrayAppend(result, entry);
			}
		
		}				
		return result;							
	}
	

	remote any function multiProcess(action, items) 
		output="false" returnFormat="plain" {
			var ret = true;
			var response = true;
			if (arguments.action == 1){
				for (local.k = 1; local.k LTE ArrayLen(arguments.items); local.k++){
					ret = delFile(arguments.items[local.k]);	
				}
				return ret;
			} else if (arguments.action == 2){
				local.dirQry = getDirContent(session.lastdirload.dirVal, 'file');  				
				for (local.k = 1; local.k LTE local.dirQry.recordcount; local.k++){
					ret = delFile(local.dirQry.name[k]);
					if (! ret){
						response = false;
					}
				}
				return response;
			} else if (arguments.action == 4){
				local.zipRes = buildZip(session.lastdirload.dirVal, arguments.items);
				return local.zipRes;
			}
			else if (arguments.action == 5){
				local.fakeArray = ArrayNew(1);
				local.zipRes = buildZip(session.lastdirload.dirVal, local.fakeArray);
				return local.zipRes;
			}			
	}
	
	remote any function VFSAdmin(action, size=100){
		var ret = false;
		
		adminLogin = CreateObject('component', 'cfide.adminapi.administrator');
		adminRT = CreateObject('component', 'cfide.adminapi.runtime');
		retlogin = adminLogin.login(adminPassword=session.loginData.USERPASS,adminUserId=session.loginData.USERNAME);
		if (! adminLogin.ISADMINUSER()){
			adminLogin.logout();
			return false;
		}
	
		if (arguments.action == 2){
			if (! isNumeric(arguments.size)){
				return false;
			}
			local.newSize = ceiling(arguments.size);
			adminRT.setRuntimeProperty('InMemoryFileSystemLimit', local.newSize);
			ret = true;
			
		} else if (action == 1){ // enable VFS
				
			adminRT.setRuntimeProperty('EnableInMemoryFileSystem', true);
			ret = true;
		
		} else if (action == 0){ // disable VFS
		
			adminRT.setRuntimeProperty('EnableInMemoryFileSystem', false);
			ret = true;
		
		}
		
		adminLogin.logout();
		
		return ret;
	}
	
	remote any function userLogin (required string userName, required string userPass){
	
		local.retVar = loginUser(arguments.userName, arguments.userPass);
		return local.retVar;
	
	}
	
	private numeric function countDirContent(string dirVal)
	 output="false"{	
	 	
		local.dir = DirectoryList(ARGUMENTS.dirVal, false, 'query');
		local.q = new Query();
		local.q.setAttributes(newQry = local.dir);
		local.dirQry = local.q.execute(sql="select * from newQry where lower(type) = 'file'", dbtype="query").getresult(); 
		
		return local.dirQry.recordcount;
		
		
	}
	private query function getDirContent(string dirVal, string type='dir'){
		local.dir = DirectoryList(ARGUMENTS.dirVal, false, 'query');
		local.q = new Query();
		local.q.setAttributes(newQry = local.dir);
		local.dirQry = local.q.execute(sql="select * from newQry where lower(type) = '#arguments.type#'", dbtype="query").getresult(); 
		
		return local.dirQry;
	
	}
}


