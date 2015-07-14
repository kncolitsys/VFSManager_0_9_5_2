

<cfsetting showdebugoutput="false" >
<cfajaxproxy cfc="Resources.VFSManager" jsclassname="rmFunc">
<cfajaximport tags="cfmessagebox">

<cfscript>
	if (listFirst(Server.ColdFusion.productversion) LT 9){
		abort "This application will only run on ColdFusion Server 9 or greater";
	}
	if (! IsUserInRole("admin")){
		abort "user not logged in as admin";
	}
	if (! isDefined('application.vfsm.vfsinit')){
		include "./includes/vfsinit.cfm";
	}
	
	request.vfsStatus = application.vfsm.rmfObj.vfsStats();
	include "./includes/header.cfm";
</cfscript>




<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="/CFIDE/administrator/images/contentframetopleft.png" alt="" height="23" width="16" /></td>
		<td background="/CFIDE/administrator/images/contentframetopbackground.png"><img src="/CFIDE/administrator/images/spacer.gif" alt="" height="23" width="540" /></td>
		<td><img src="/CFIDE/administrator/images/contentframetopright.png" alt="" height="23" width="16" /></td>
	</tr>
	<tr>
		<td width="16" style="background:url('/CFIDE/administrator/images/contentframeleftbackground.png') repeat-y;"><img src="/CFIDE/administrator/images/spacer.gif" alt="" width="16" height="1" /></td>
		<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="12"><img src="/CFIDE/administrator/images/cap_content_white_main_top_left.gif" alt="" width="12" height="11" /></td>
					<td bgcolor="#FFFFFF"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" width="10" alt="" height="10" /></td>
					<td width="12"><img src="/CFIDE/administrator/images/cap_content_white_main_top_right.gif" width="12" alt="" height="11" /></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="10" bgcolor="#FFFFFF"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" alt="" width="10" height="10" /></td>
					<td bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr valign="top">
								<td valign="top">
									<div style="width:810px; float:left; padding-left: 10px; padding-top: 5px;">
										<!---nav bar--->
										<div id="headerDiv" class='headerBarMain' style='width: 765px;'>
											<div style="width: 500px; float: left; overflow:hidden;">
												<cfif request.vfsStatus.enabled && min(0, request.vfsStatus.free)>
													<div class="navBtn" style="width:125px;">
														<span onclick="JAVASCRIPT: showVFSWarn();"> <img src="./Resources/Images/icon-warning.gif" align="texttop"> VFS Warning! </span> 
													</div>
												</cfif>
												<cfif IsUserInRole("admin")>
													<div class="navBtn" style="width:125px;">
														<cfif ! request.vfsStatus.enabled>
															<span onclick="JAVASCRIPT: doVFSManage(1);"> <img src="./Resources/Images/emblem-readonly_custom_16x16.png" align="texttop"> Enable VFS </span>
														<cfelse>
															<span onclick="JAVASCRIPT: doVFSManage(0);"> <img src="./Resources/Images/emblem-readonly_custom_16x16.png" align="texttop"> Disable VFS </span>
														</cfif>
													</div>
													<div class="navBtn" style="width:125px;">
														<cfif request.vfsStatus.enabled>
															<span onclick="JAVASCRIPT: doVFSManage(2);"> <img src="./Resources/Images/kedit_custom_16x16.png" align="texttop"> Set VFS Size </span>
														</cfif>
													</div>
												</cfif>
											</div>
											<div class="msgDiv" id="statusDiv" style="width: 265px;"> 
											</div>
										</div>
										<!---end nav bar--->
										
										<cfif request.vfsStatus.enabled>
											<!---left bar (graph / tree)--->
											<div id="toolsDiv" class="toolBar">
												<cfinclude template="./includes/Usage.cfm">
												<cfinclude template="./includes/VFSTree.cfm">
											</div>											
											<!---end left bar--->
											
											<!---main body--->
											<div id="mainDiv" class="mainBody">
												<cfinclude template="./includes/ContentBody.cfm">
											</div>
											<!---end main body--->
											<cfelse>
											<div style="width:650px; color:red; font-weight:bold; text-align:center; font-family:tahoma;"> <BR>
												<BR>
												VFS is not enabled. 
											</div>
										</cfif>
									</div>
								<iframe src="blank.htm" width="100" height="100" frameborder="no" id="dliframe" name="dliframe"> </iframe></td>
							</tr>
						</table></td>
					<td width="10" bgcolor="#FFFFFF"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" alt="" width="10" height="10"></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="12"><img src="/CFIDE/administrator/images/cap_content_white_main_bottom_left.gif" alt="" width="12" height="11"></td>
					<td bgcolor="#FFFFFF"><img src="/CFIDE/administrator/images/spacer_10_x_10.gif" alt="" width="10" height="10"></td>
					<td width="12"><img src="/CFIDE/administrator/images/cap_content_white_main_bottom_right.gif" alt="" width="12" height="11"></td>
				</tr>
			</table>
			<td width="10" style="background:url('/CFIDE/administrator/images/contentframerightbackground.png') repeat-y;"><img src="/CFIDE/administrator/images/spacer.gif" alt="" width="16" height="1"></td>
		</td>
	</tr>
	<tr>
		<td><img src="/CFIDE/administrator/images/contentframebottomleft.png" height="23" alt="" width="16"></td>
		<td background="/CFIDE/administrator/images/contentframebottombackground.png"><img src="/CFIDE/administrator/images/spacer.gif" alt="" height="23" width="540"></td>
		<td><img src="/CFIDE/administrator/images/contentframebottomright.png" alt="" height="23" width="16"></td>
	</tr>
</table>
</body>
</html>