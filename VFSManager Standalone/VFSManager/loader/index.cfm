

<CFLOOP index="i" from="1" to="5">
	<cfset thisDir = "ram://TempDir#randRange(1111,9999)#/samples/">
	<cfimage action="read" source="#expandPath('.')#/sample.jpg" name="tempImage">

	<cfimage action="write" destination="#thisDir#/../../#left(hash(now() & RandRange(1,99999)), 10)#.jpg" source="#tempImage#">
	<cfdirectory action="create" directory="#thisDir#">
	<cfloop index="j" from="1" to="#randRange(1, 5)#">
	<cfimage action="write" destination="#thisDir#/../#left(hash(now() & RandRange(1,99999)), 10)#.jpg" source="#tempImage#">
	<cfimage action="write" destination="#thisDir#/#left(hash(now() & RandRange(1,99999)), 10)#.jpg" source="#tempImage#">
	</cfloop>
</cfloop>

