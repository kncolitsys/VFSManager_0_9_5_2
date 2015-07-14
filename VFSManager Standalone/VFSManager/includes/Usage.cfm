

<div class="toolBarTop" style="width: 100px; height:110px; background-color:white; overflow:hidden; float:left;">
<cfoutput>
	<BR>
	<b style="color:navy;">Used:</b><BR>
	#NumberFormat(request.vfsStatus.used*.000001, '9999.99')# mb<BR><BR>
	<b style="color:teal;">Free:</b><BR>
	#NumberFormat(request.vfsStatus.free*.000001, '9999.99')# mb<BR><BR>
</div>

<CFSET local.freeSpace = ceiling((request.vfsStatus.free/request.vfsStatus.limit)*100)>
<CFSET local.usedSpace = 100-local.freeSpace>

<div class="toolBarTop" style="width: 125px; height:125px; background-color:white; overflow:hidden;float:left;">
	<cfchart showmarkers="false" format="png" chartHeight="120" chartwidth="120" pieslicestyle="solid"  seriesplacement="percent" show3d="true" showlegend="false" >
	
		<cfchartseries  type="pie" datalabelstyle="none" colorlist="navy,teal">
			<cfchartdata item="Free %" value="#local.freeSpace#">
			<cfchartdata item="Used %" value="#local.usedSpace#">
		</cfchartseries>
	</cfchart>
</cfoutput>
</div>

