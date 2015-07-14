
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

</cfcomponent>