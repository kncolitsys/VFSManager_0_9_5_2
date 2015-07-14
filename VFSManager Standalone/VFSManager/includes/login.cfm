<cfif IsDefined("Form.logout")>
	<cflogout>
	<cfset adminLogin = CreateObject('component', 'cfide.adminapi.administrator')>
	<cfset doLogin = adminLogin.logout()>
	<CFSET void = structclear(session)>
</cfif>

<!---
<cflogout>
<cfset adminLogin = CreateObject('component', 'cfide.adminapi.administrator')>
<cfset doLogin = adminLogin.logout()>	
<CFSET void = structclear(session)>--->
<cflogin>
	<cfif NOT IsDefined("cflogin")>
		
		
		<cfif IsDefined('session.loginData')>
			<cfif session.loginData.TYPE EQ 2>
				<cfset thisRole = 'cfadmin'>
			<cfelse>
				<cfset thisRole = 'admin'>
			</cfif>			
			<cfloginuser name="#session.loginData.username#" Password = "#session.loginData.USERPASS#" roles="#thisRole#">
		
		<cfelse>
			<cfinclude template="/VFSManager/includes/loginForm.cfm" />
			<cfabort />
		</cfif>		
	</cfif>
</cflogin>


