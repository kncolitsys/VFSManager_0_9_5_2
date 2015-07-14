



<!--- cfdirectory search --->
<cfdirectory action="list" name="ramContent" directory="ram://" recurse="yes" type="dir"  >

<CFIF ramContent.recordcount EQ 0>
	<cfdirectory action="list" name="ramContent" directory="ram://" recurse="yes" type="file" >	
	<CFQUERY name="local.fixList" dbtype="query">
		select * from ramContent
		order by directory asc
	</CFQUERY>
	<CFSET local.noDirFound = 1>	
<cfelse>
	<CFQUERY name="local.fixList" dbtype="query">
		select * from ramContent
		where directory != 'ram:///'
		order by directory asc
	</CFQUERY>
</cfif>






<div style='width:200px; float:left;background-color:white; overflow:hidden;' id="treeDiv">
	<cfform>
		<cftree name="dataFile" width="200" height="400" format="html" completepath="true">
		    <cftreeitem bind="cfc:VFSManager.Resources.VFSManager.getTreeContent({cftreeitempath}, {cftreeitemvalue})">
		</cftree>
	</cfform>
</div>



<cffunction name='getFileCount' returntype='String' >
	<cfargument name='srcDir' required='true' type='string' >
	<CFIF arguments.srcDir EQ "ram:">
		<cfset arguments.srcDir = "ram://">
	</cfif>
	<cfdirectory action="list" name="local.thisDirContent" directory="#arguments.srcDir#" recurse="false" type="file"  >
	
	<cfif local.thisDirContent.recordcount>
		<CFRETURN '(#local.thisDirContent.recordcount#)'>
	<cfelse>
		<cfreturn ''>
	</cfif>
	
</cffunction>



