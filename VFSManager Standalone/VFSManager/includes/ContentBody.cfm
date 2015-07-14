

<CFIF local.fixList.recordcount>
	<div style='width:390px; float: left;'>
		<cfif isDefined('local.noDirFound')>
			<cfdiv id="bodyDiv" bind="url:/VFSManager/Resources/Content.cfc?method=getContent&dir=" ></cfdiv>
		<cfelse>
			<cfdiv id="bodyDiv" bind="url:/VFSManager/Resources/Content.cfc?method=getContent&dir={dataFile.node}" ></cfdiv>
		</cfif>
	</div>
</cfif>