
<cfcomponent>


	<cffunction name="getContent" access="remote" returntype="string" output="false" returnformat="plain">
		<cfargument name="dir" type="String" required="true" >
		
		
		<cfif IsDefined('arguments.reloadLast') && isDefined('session.lastDirLoad')>
			<cfset arguments.dir = session.lastDirLoad.dirVal>		
		</cfif>
		
		<CFIF arguments.dir EQ "ram:">
			<cfset local.dir = "ram://">
		<cfelseif arguments.dir EQ ''>
			<cfset local.dir = "ram://"> <!---initial load--->
		<cfelse>
			<cfset local.dir = arguments.dir>
		</cfif>
		<CFIF directoryExists('#local.dir#')>
		
			<CFDIRECTORY action='list' directory='#local.dir#' type='file' recurse='false' name='local.thisDir'>
				
			<cfsavecontent  variable="local.theResult">
				<cfif arguments.dir EQ ''>		
					<script language="JavaScript">		
						// expands tree if viewing root level.  
						// delay is to prevent issue of tree trying to expand before it is loaded.
						setTimeout("expandTree()", 500);
					</script>
				</cfif>
						
					<cfset session.lastDirLoad = structNew()>
					<cfset session.lastDirLoad.hashVal = hash(local.dir)>
					<cfset session.lastDirLoad.dirVal = local.dir>
	            
					Viewing directory: <A title="Delete selected directory." onClick="javascript: doDirectoryDelete('<cfoutput>#hash(local.dir)#</cfoutput>');" style="cursor: pointer;"><img src="./Resources/Images/dialog-cancel_custom_16x16.png" align="top" border="0"></a>  <cfoutput><b style="color: navy;">#replace(local.dir, "///", "//")#</b></cfoutput><BR><BR> 	
				<cfif local.thisDir.recordcount>
					<div class="contentHDR" style=" padding-right:5px;">
						<div class="contentHDRColA" style="width:55px; padding-left:5px;">
						<input type="checkbox" name="fileChkBoxes" id='massDelItems_0' style="cursor: pointer;" onClick="JAVASCRIPT: doCheckAll();">
						</div>
						<div class="contentHDRColB" style="width:270px;">
						File Name
						</div>
						<div class="contentHDRColC" style="width:100px;">
						Size
						</div>
						<div class="contentHDRColD" style="width:100px;">
						Modified
						</div>
					</div>
					
						
					<cfoutput query='local.thisDir'>
						<div id="contentRow_#currentRow#" class="contentRow" onmouseover="javascript: divHover(this.id, 1);" onmouseout="javascript: divHover(this.id, 2);">
							<div class="contentRowColA" style="width:50px;">
							<input title="#name#" type="checkbox" name="fileChkBoxes" id='massDelItems_#currentRow#' style="cursor: pointer;">
							<A title="Delete file." onclick="javascript: doFileDelete('#name#');" style="cursor: pointer; padding-left: 5px;">
							<img src="./Resources/Images/gtk-delete_custom_16x16.png" border="0">
							</A>
							</div>
							<div class="contentRowColB" style="width:275px;" >
							<span id="fileNameSpan_#currentRow#" onclick="javascript: doViewFile('#name#', 0);" style="cursor: pointer;" onmouseover="javascript: linkHover(this.id, 1);" onmouseout="javascript: linkHover(this.id, 2);">#Name#</span>
							</div>
							<div class="contentRowColC" style="width:100px;">
							#setSize(Size)#
							</div>
							<div class="contentRowColD" style="width:100px;">
							#Dateformat(DATELASTMODIFIED, 'mm/dd/yy')#
							</div>
						</div>
					</cfoutput>
					
					<div class="contentHDR" style="text-align:right; padding-right:5px;">
						<div style="text-align:right;">
							Action:
							<select class="actionDD" onchange="javascript: doDDAction(this);">
								<option value="0">---------------</option>
								<option value="1">Delete Selected</option>
								<option value="2">Delete All</option>
								<cfif ! min(application.vfsm.rmfObj.vfsStats().free, 0)>
								<option value="0">---------------</option>
								<option value="3">Download Selected</option>
								<option value="4">Download All</option>
								</cfif>
							</select>
						</div>
					</div>
				<cfelse>
					<div id="contentRow_0" class="contentHDR" style="font-weight:bold; padding-left:25px;">
						Directory is empty
					</div>
				</cfif>
			</cfsavecontent>
			
			<Cfreturn theResult>
		
		</cfif>
	</cffunction>

	<cffunction  name="setSize" returntype="String" access="private" >
		<cfargument name='inSize' required='true' type='string'>
		
		<cfif arguments.inSize GT 1000000>
			<cfreturn NumberFormat(arguments.inSize*.000001, '9999.99') & 'mb'>		
		<cfelseif arguments.inSize LT 1000>
			<cfreturn '1kb'>
		<cfelse>
			<cfreturn ceiling(arguments.inSize*.001) & 'kb'>	
		</cfif>	
		
	</cffunction>
</cfcomponent>