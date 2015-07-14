// function names that start with "do" are user fired


// default values
checked=true;

// ui controls
var divHover = function(id, type) { 
 var idSplit = id.split("_");
  
 if (type == 1){
	document.getElementById(id).style.backgroundColor = 'silver'; 
	return;
  } else {
  	if (!document.getElementById('massDelItems_' + idSplit[1]).checked) {
		document.getElementById(id).style.backgroundColor = '';
	}
	return;
  }
}

var linkHover = function(id, type) {   
 if (type == 1){
	document.getElementById(id).style.color = 'red '; 
	return;
  } else {
  	document.getElementById(id).style.color = 'black';
	return;
  }
}
// end ui controls


// user fired actions

var  doLoginUser = function(){
	
	if (document.getElementById('uname').value == ''  || document.getElementById('pword').value == '' ){
		showAlertMsg('', 'Please enter both user name and password', 1);
		return false;
	}
	
	var e = new rmFunc();
	e.setCallbackHandler(userLoginRes);
	e.setErrorHandler(ajaxErrorHandler);
	e.userLogin(document.getElementById('uname').value, document.getElementById('pword').value);
	//return false;

}

var doCheckAll = function(){
	var counter = 1;
	var aa= document.getElementsByName('fileChkBoxes');	
	var mark = checked == true ? 'checked' : '';
	
	checked = checked == true ? false : true;
	counter = 1;
	for(i = 0; i < aa.length; i++){
		aa[i].checked = mark;
	}
	
	for (i = 1; i < aa.length; i++) { // start at 1 cause 0 element has no highlight
		if (mark == ''){			
			divHover('contentRow_' + counter, 0);
		} else {
			divHover('contentRow_' + counter, 1);
		}
		counter++;	
	}
	
}

var doDDAction = function(ddObj){
	var e = new rmFunc(); 
	var checkedItems = getChecked();
	var selIdx		= ddObj.selectedIndex;
	var selLabel	= ddObj.options[selIdx].innerHTML;
    var selValue 	= ddObj.options[selIdx].value;
	
	
	if (selIdx == 0){
		return;
	}
	if ((selIdx == 1 || selIdx == 4) && checkedItems.length == 0){
		showMsgDiv('There were no items selected.');
		return;		
	} 
    
	if (confirm('Are you sure you wish to ' + selLabel + '?')) {
		e.setErrorHandler(ajaxErrorHandler);
		e.setCallbackHandler(multiProcessRes);
		e.multiProcess(selIdx, checkedItems);
		if (selIdx > 2){
			ddObj.selectedIndex = 0;		
		}
				
	} else {
		ddObj.selectedIndex = 0;
	}
	
	return;
}

var doDirectoryDelete = function (){	
	if (confirm('Are you sure you wish to delete this Directory and all contents?')) {
		var e = new rmFunc(); 
	    e.setCallbackHandler(deleteDirRes); 
	    e.setErrorHandler(ajaxErrorHandler); 	
		e.delDirectory();		
	}
}

var doVFSManage = function(action){

	if (action == 0) { // disable
		if (confirm('Are you sure you wish to DISABLE VFS?')) {
			var e = new rmFunc();
			e.setCallbackHandler(VFSAdminRes);
			e.setErrorHandler(ajaxErrorHandler);
			e.VFSAdmin(0);
		}
	} else if (action == 1){ // enable
		if (confirm('Are you sure you wish to ENABLE VFS?')) {
			var e = new rmFunc();
			e.setCallbackHandler(VFSAdminRes);
			e.setErrorHandler(ajaxErrorHandler);
			e.VFSAdmin(1);		
		}				
	} else if (action == 2){ // resize VFS
		
	if (!ColdFusion.MessageBox.isMessageBoxDefined('vfsResize')) {
		ColdFusion.MessageBox.create('vfsResize', 'prompt', 'Resize VFS', 'Enter the new size of VFS (in MB)', vfsSizeUpd, {
			width: 300,
			modal: true
		})
	}
	ColdFusion.MessageBox.show('vfsResize');
	} 
}

var vfsSizeUpd = function(btn,message){
	if (btn == 'ok' && message != '') {
		var e = new rmFunc(); 
	    e.setCallbackHandler(VFSAdminRes); 
	    e.setErrorHandler(ajaxErrorHandler); 	
		e.VFSAdmin(2, message);	
	}
}


var doFileDelete = function(item){	
	if (confirm('Are you sure you wish to delete this file?')) {
		var e = new rmFunc(); 
	    e.setCallbackHandler(deleteFileRes); 
	    e.setErrorHandler(ajaxErrorHandler); 	
		e.delFile(item);	
	}
}

var doViewFile = function(selectedFile, delFile){
	window.open("/VFSManager/Resources/DownloadFile.cfm?filename=" + selectedFile + '&delFile=' + delFile, "dliframe");
}

// end user fired actions

// message displays
var showMsgDiv = function(msg){	
	document.getElementById('statusDiv').innerHTML = msg;
	var t = setTimeout("clearMSG()", 5000);
	
}
var clearMSG = function(){
	document.getElementById('statusDiv').innerHTML = '';
	return;
}

var showVFSWarn = function(){
	showAlertMsg('VFS Usage Warning!!', 'VFS usage is greater than allocated.  This can be caused by an alteration to the VFS size after data has been written.<BR><BR>It is suggested to increase the VFS size via the administrator or delete some data from the VFS.<BR><BR>This also disables the multi-download function as it requires VFS space to work.', 2);	
}

var showAlertMsg = function(title, msg, iconStyle){
	var thisIcon = ''; 
	var msgTxt = msg;

	if (iconStyle == 1) {
		thisIcon = 'error';
	} else if (iconStyle == 2){
		thisIcon = 'warning';
	} else if (iconStyle == 3){
		thisIcon = 'question';
	} else {
		thisIcon = 'info';
	}
	
	
	if (! ColdFusion.MessageBox.isMessageBoxDefined('alertMB')){
		ColdFusion.MessageBox.create('alertMB', 'alert', title, msgTxt, fakeFunc, {width:400, modal:true,  icon:thisIcon});		
	} else {
		ColdFusion.MessageBox.update('alertMB', {title:title, message: msgTxt, icon: thisIcon });		
	}	
	ColdFusion.MessageBox.show('alertMB');
}
// end message displays

// ajax results
var deleteDirRes = function(res){
	if (res) {
		showMsgDiv('Delete Complete - Reloading');	
		location.reload(true);
	} else {
		showMsgDiv('There was an error deleting the directory.');
	}	
}

var deleteFileRes = function(res){
	if (res) {
		showMsgDiv('Selected file has been deleted.');		
		ColdFusion.navigate('/VFSManager/Resources/Content.cfc?method=getContent&dir=&reloadLast=1', 'bodyDiv');		
	} else {
		showMsgDiv('There was an error deleting the file.');
	}	
}

var multiProcessRes = function(res){
	if (res == 1){
		showMsgDiv('File(s) deleted.');
		ColdFusion.navigate('/VFSManager/Resources/Content.cfc?method=getContent&dir=&reloadLast=1', 'bodyDiv');
	} else if (res == 0) {
		showMsgDiv('There was an issue processing the deletes.');
	} else {
		doViewFile(res, 1);		
	}
	return;	
}

var userLoginRes = function(res){
	if (res != 0){
		window.location = '/VFSManager/index.cfm';	
	} else {
		document.getElementById('badLoginDIV').style.display = '';
	}
}



var VFSAdminRes = function(res){
	if (res) {
		showMsgDiv('VFS Update Complete - Reloading');	
		location.reload(true);
	} else {
		showMsgDiv('VFS Update did not process.');
	}	
}

// end ajax results


// ajax error handler
var ajaxErrorHandler = function(statusCode, statusMsg){
	showAlertMsg('System Error', statusMsg, 1);	
} 
// end ajax error handler


// local functions
var expandTree = function(){
	tree = ColdFusion.Tree.getTreeObject('dataFile');
	tree.getNodeByIndex(1).expand();	
}				

var getChecked = function(){
	var cntr = 0;
	var chkItems = new Array();
	var aa= document.getElementsByName('fileChkBoxes');
	for(i = 1; i < aa.length; i++){ // start at 1 because 0 element has no value
		if (aa[i].checked){
			chkItems[cntr] = aa[i].title;
			cntr++;			
		}
	}
	return chkItems;
}
// end local functions

var fakeFunc = function(){}




