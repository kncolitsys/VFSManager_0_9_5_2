

<CFSET void = structclear(session)>

<cfsetting showdebugoutput="false">
<cfinclude template="/VFSManager/includes/header.cfm">

<cfajaxproxy cfc="VFSManager.Resources.VFSManager" jsclassname="rmFunc">
<cfajaximport tags="cfmessagebox">


<div id='wrapper'>
	<div id="badLoginDIV" style="display:none;">	
		<div class="lfHdr" style="color:red;">
			Login Failed.  Please try again.
		</div>
	</div>
	<div class="lfHdr">
		Please Log In
	</div>
	<div class="lfSep">&nbsp;</div>
	<div class="lfSep2">&nbsp;</div>
	<div class="lfLabel" style="float:left; width:100px;">User Name:</div>
	<div style="float:left; width:250px; padding-bottom:10px;">
		<input id="uname" type="text" name="j_username" class="lfField" autocomplete="off">
	</div>
	<div class="lfLabel" style="float:left; width:100px;">Password:</div>
	<div style="float:left; width:250px; padding-bottom:10px;">
		<input id="pword" type="password" name="j_password" class="lfField" autocomplete="off">
	</div>
	
	<div class="lfBtn">
		<button class="lfBtnlbl" onclick="doLoginUser();"><img src="/VFSManager/Resources/Images/enter_custom_16x16.png" align="texttop"> Log In</button>
	</div>
</div>





</body>
</html>