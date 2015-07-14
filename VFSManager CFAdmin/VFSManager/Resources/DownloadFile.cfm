<CFSETTING showdebugoutput="false"> 

<cfset variables.delSource = false>

<cfset variables.filePath = session.lastdirload.dirVal & '/' & url.filename>

<cfif NOT fileExists(variables.filePath)>
	<cfset variables.filepath = "ram://#url.filename#">
	<cfif NOT fileExists(variables.filePath)>
		<cfabort >
	</cfif>	
</cfif>


<CFIF fileExists(variables.filePath)>
	<cfheader name="Content-disposition"  value="attachment;filename=#url.filename#" />
	
	<cfif url.delFile EQ 1>
		<cfset variables.delSource = true>
	</cfif>
	
	<cfcontent file="#variables.filePath#" deletefile="#variables.delSource#" type="application/unknown">
</cfif>




