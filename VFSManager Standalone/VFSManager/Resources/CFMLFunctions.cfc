
<cfcomponent output="false" hint="this file exists because there is no cfscript version of these functions">
	<cffunction name="BuildZip" access="package" returnFormat="plain" returntype="any" hint="Creates zip file for download">
		<cfargument name="dirPath" type="string" required="false" />
		<cfargument name="FileArray" type="any" required="false"/>
		<cfset var zipFileName = hash(now()) & '.zip' />
		<cfset var i = '' />

		<cfif (arguments.dirPath EQ "" OR NOT directoryExists(arguments.dirPath)) and (isArray(arguments.FileArray) AND arrayLen(arguments.FileArray) EQ 0)>
			<cfreturn false>		
		</cfif>

		
		<cfif arguments.dirPath NEQ "" and arrayLen(arguments.FileArray) EQ 0>
			<cfzip action="zip"  file="ram://#zipFileName#" source="#arguments.dirPath#" recurse="no" />
			<cfreturn zipFileName>
		<cfelse>
			
			<cfzip action="zip" file="ram://#zipFileName#" >
				<cfloop array="#arguments.FileArray#" index="i">									
					<cfzipparam source="#arguments.dirPath#/#i#">									
				</cfloop>				
			</cfzip>
			<cfreturn zipFileName>
		</cfif> 

	</cffunction>



	<cffunction name="loginUser" access="package" returnFormat="plain" returntype="any" hint="logs in user">
		<cfargument name="username" type="string" required="true" />
		<cfargument name="userpass" type="string" required="true"/>
		
		<CFSET var void = structclear(session)>
		
		<!---Attempt to login checking cfadmin login.--->	
		<cfif application.config['useCFAdminLogin']>		
			<cfset local.adminLogin = CreateObject('component', 'cfide.adminapi.administrator')>
			<cfset local.doLogin = adminLogin.login(adminPassword='#arguments.userpass#',adminUserId='#arguments.username#')>
			<cfif local.doLogin>
				<cfset local.doLogin = adminLogin.logout()>
				<cfset session.loginData = arguments>
				<cfset session.loginData.type = 2>
				<cfset local.ret = 2>
				<CFSET local.goodlogin = 1>
			</cfif>
		</cfif>
		
		<cfif ! isDefined('local.goodlogin')>
			<cfif arguments.username IS application.config['appUser'] AND arguments.userpass IS application.config['appPass']>
				<cfset session.loginData = arguments>
				<cfset session.loginData.type = 1>
				<cfset local.ret = 1>
			<cfelse>
				<cfset local.ret = 0>
			</cfif>
		</cfif>
		
		<cfreturn local.ret>
	</cffunction>
</cfcomponent>