

<CFSETTING showdebugoutput="false" >

<cfajaxproxy cfc="VFSManager.Resources.VFSManager" jsclassname="rmFunc">
<cfajaximport tags="cfmessagebox">

<div style="width:810px; float:left; padding-left: 10px; padding-top: 5px;">
	<div id="headerDiv" class='headerBarMain' style='width: 765px;'>
		<div style="width: 500px; float: left; overflow:hidden;">
		
			<div class="navBtn" style="width:100px;">
				<span onclick="JAVASCRIPT: document.logoutForm.submit();">
				<img src="/VFSManager/Resources/Images/exit_custom_16x16.png" align="texttop"> Logout
				</span>
			</div>
			<cfif request.vfsStatus.enabled && min(0, request.vfsStatus.free)>
				<div class="navBtn" style="width:125px;">
					<span onclick="JAVASCRIPT: showVFSWarn();">
					<img src="/VFSManager/Resources/Images/icon-warning.gif" align="texttop"> VFS Warning!
					</span>
				</div>
			</cfif>
			<cfif IsUserInRole("cfadmin")>
				<div class="navBtn" style="width:125px;">
				
					<cfif ! request.vfsStatus.enabled>
					<span onclick="JAVASCRIPT: doVFSManage(1);">
					<img src="/VFSManager/Resources/Images/emblem-readonly_custom_16x16.png" align="texttop"> Enable VFS
					</span>
					<cfelse>
					<span onclick="JAVASCRIPT: doVFSManage(0);">
					<img src="/VFSManager/Resources/Images/emblem-readonly_custom_16x16.png" align="texttop"> Disable VFS
					</span>
					</cfif>
				</div>
				<div class="navBtn" style="width:125px;">
					<cfif request.vfsStatus.enabled>
						<span onclick="JAVASCRIPT: doVFSManage(2);">
							<img src="/VFSManager/Resources/Images/kedit_custom_16x16.png" align="texttop"> Set VFS Size
						</span>
					</cfif>
				</div>
			</cfif>
		
		</div>
		
		<div class="msgDiv" id="statusDiv" style="width: 265px;">
		
		</div>
	</div>
	<cfif request.vfsStatus.enabled>
	
		<div id="toolsDiv" class="toolBar">
			<cfinclude template="/VFSManager/includes/Usage.cfm"> 
			<cfinclude template="/VFSManager/includes/VFSTree.cfm">
		</div>
		<div id="mainDiv" class="mainBody">
				<cfinclude template="/VFSManager/includes/ContentBody.cfm">
		</div>
	<cfelse>
		<div style="width:650px; color:red; font-weight:bold; text-align:center; font-family:tahoma;">
			<BR><BR>
			VFS is not enabled. 
		</div>
	</cfif>
</div>


<iframe src="blank.htm" width="100" height="100" frameborder="no" id="dliframe" name="dliframe">
</iframe>

<form action="/VFSManager/index.cfm" method="Post" name="logoutForm">
	<input type="hidden" Name="Logout" value="Logout">
</form>
</body>
</html>
