<!-----------------------------------------------------------------------Author 	 :	Luis MajanoDate     :	September 25, 2005Description :	General handler for my hello application. Please remember to alter	your extends base component using the Coldfusion Mapping.	example:		Mapping: fwsample		Argument Type: fwsample.system.eventhandlerModification History:Sep/25/2005 - Luis Majano	-Created the template.-----------------------------------------------------------------------><cfcomponent name="ehGeneral" extends="baseHandler" output="false" autowire="true"><!--- Autowire Properties ---><cfproperty name="myMailSettings" type="ioc" scope="instance">	<!--- ************************************************************* --->	<cffunction name="init" access="public" returntype="any" output="false">		<cfargument name="controller" type="any" required="true">		<cfset super.init(arguments.controller)>		<!--- Any constructor code here --->		<cfreturn this>	</cffunction>	<!--- ************************************************************* --->	<cffunction name="onRequestStart" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">	</cffunction>	<!--- ************************************************************* --->		<cffunction name="onApplicationStart" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfset var isColdFusionMX7 = server.coldfusion.productname is "ColdFusion Server" and server.coldfusion.productversion gte 7>				<cfset getColdboxOCM().set("isColdfusionMX7",isColdfusionMX7,0)>				<cfif isColdfusionMX7>			<cfif not event.isProxyRequest()>				<cfset getPlugin("JavaLoader").setup( listToArray( ExpandPath("/coldbox/testharness/includes/helloworld.jar")) )>			</cfif>		</cfif>				<cfset getColdboxOCM().set("mysiteDSNBean",getDatasource("mysite"),0)>		<cfset getPlugin("logger").logEntry("information","AppStart Fired")>	</cffunction>	<!--- ************************************************************* --->		<cffunction name="onRequestEnd" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">	</cffunction>	<!--- ************************************************************* --->		<cffunction name="onSessionStart" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var logger = controller.getPlugin("logger");		logger.logEntry("information","I am in the onSessionStart baby.");		</cfscript>	</cffunction>	<!--- ************************************************************* --->		<cffunction name="onSessionEnd" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var logger = controller.getPlugin("logger");		logger.logEntry("information","I am in the onSessionEnd baby.");		</cfscript>	</cffunction>	<!--- ************************************************************* --->	<cffunction name="preHandler" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var logger = controller.getPlugin("logger");		logger.logEntry("information","I am just inside the pre-handler method. #logger.getHash()#");		</cfscript>	</cffunction>	<cffunction name="postHandler" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var logger = controller.getPlugin("logger");		logger.logEntry("information","I am inside the post-handler method. #logger.getHash()#");		</cfscript>	</cffunction>	<!--- ************************************************************* --->	<cffunction name="dspHello" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfset var logger = controller.getPlugin("logger")>	    <cfset var storage = controller.getPlugin("clientstorage")>	    <cfset var complexStruct = "">	    <cfset var complete = "">	  		<!--- <cfset Event.setValue("MailBean",getmyMailSettings())> --->		<cfset Event.setValue("MailBean",getmyMailSettings())>		<cfset getPlugin("timer").start("New Instance Creation")>		<!--- Get a new instance plugin --->		<cfset event.setValue("mylogger", getPlugin("logger",false,true) )>		<cfset event.getValue("mylogger").setLogFullPath(ExpandPath("./config/luis.log"))>		<cfset getPlugin("timer").stop("New Instance Creation")>		<!--- Create a tracer message --->		<cfset logger.tracer("Starting dspHello. Using default name")>		<cfset logger.tracer("arguments: #arguments.toString()#")>		<!--- Set the firstname Value --->		<cfset Event.setValue("firstname",getSetting("Codename", true) & getSetting("Version", true))>		<!--- Set another tracer variable --->		<cfset logger.tracer("View has been set")>		<!--- Create a simple permanent variable --->		<cfset storage.setvar("luis","Luis Majano")>		<!--- Permanent Complex Variable --->		<cfset complexStruct = structnew()>		<cfset complexStruct.today = now()>		<cfset complexStruct.message = "This is a complex variable.">		<cfset complexStruct.BitFlag = "1">		<cfset storage.setvar("complexStruct",complexStruct)>		<cfset complete = isEmail("info@coldboxframework.com")>		<!--- Java Loader --->				<cfif getColdboxOCM().lookup("isColdfusionMX7") and getColdboxOCM().get("isColdfusionMX7") eq true>			<cfset Event.setvalue("HelloWorldObj", getPlugin("JavaLoader").create("HelloWorld").init())>		</cfif>				<!--- Create an info MessageBox --->		<cfset getPlugin("messagebox").setMessage("info", "Hello and welcome to the ColdBox' message box. You can place messages here from any of your applications. You can also choose the desired image to display. You can set error message, warning messages or just plain informative messages like this one. You can do this by using the <b>messagebox</b> plugin.")>		<!--- Get view contents ---->		<cfset Event.setValue("MyQuote", renderView("vwQuote"))>				<!--- Cache for 5 minutes. --->		<cfset cacheParams.timeout = 5>				<!--- Run Private Event --->		<cfset runEvent(event="ehGeneral.myPrivateEvent",private=1)>				<!--- Set the view to render --->		<cfset Event.setView(name="vwHello",cache=true,cacheTimeout=5)>	</cffunction>	<!--- ************************************************************* --->	<cffunction name="doChangeLocale" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Change Locale --->		<cfset controller.getPlugin("i18n").setfwLocale(Event.getValue("locale"))>		<cfset dspHello(Event)>	</cffunction>	<!--- ************************************************************* --->		<cffunction name="testflash" access="public" output="false" returntype="void">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var rc = event.getCollection();		rc.lname = "majano";		rc.fname = "luis";		setNextEvent(event='ehGeneral.dspHello',persist='lname,fname');		</cfscript>	</cffunction>	<cffunction name="doLog" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var logger = getPlugin("logger");		var interceptorMetadata = structnew();				interceptorMetadata.name = "Luis Majano";		interceptorMetadata.currentDateTime = now();		announceInterception("onLog",interceptorMetadata);			logger.logEntry("error","This is an error message that I logged.","Home Portals is the best.");		logger.logEntry("information","This is an information message that I logged.");		logger.logEntry("warning","This is an warning message that I logged.");		logger.logEntry("fatal","The whole thing crashed man");		dspHello(Event);		</cfscript>	</cffunction>	<cffunction name="doClearLog" access="public" returntype="void" output="false">		<cfscript>		getPlugin("Utilities").removeFile(controller.getSetting("ColdboxLogsLocation"));		setnextevent("ehGeneral.dspHello","fwreinit=1");		</cfscript>	</cffunction>	<cffunction name="docustomplugin" access="public" returntype="void" output="false">		<cfset var stime = getTickcount()>		<cfset getMyPlugin("myclientstorage").setvar("MyCustomVariable","Custom Variable has been set by custom plugin at #timeformat(now(),"HH:MM:SS TT")#.")>		<cfset getPlugin("logger").tracer("Testing Flash Persistance", "Total Execution Time: #getTickCount()-stime#")>		<cfset setNextEvent("","usecustomplugin=true")>	</cffunction>	<cffunction name="doFormBean" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var rc = Event.getCollection();		//populate bean		rc.FormBean = controller.getPlugin("beanfactory").populateBean("#controller.getSetting("AppMapping")#.model.formBean");		Event.setView("vwFormBean");		</cfscript>	</cffunction>	<cffunction name="purgeEvents" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>			getColdboxOCM().clearAllEvents();			setNextEvent();		</cfscript>	</cffunction>		<cffunction name="dspFolderTester1" access="public" returntype="void" output="false"  cache="true" cacheTimeout="5">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var rc = Event.getCollection();		Event.setView("tags/test1");		</cfscript>	</cffunction>		<cffunction name="dspFolderTester2" access="public" returntype="void" output="false"  cache="true" cacheTimeout="5">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var rc = Event.getCollection();		Event.setView("pdf/single/test");		</cfscript>	</cffunction>		<!--- externalView --->
	<cffunction name="externalView" access="public" returntype="void" output="false" hint="">
		<cfargument name="Event" type="coldbox.system.beans.requestContext" required="yes">
	    
	    <cfset event.setView('externalview')>	     
	</cffunction>	<!------------------------------------------- PRIVATE METHDOS ------------------------------------------->		<cffunction name="getmyMailSettings" access="public" output="false" returntype="any" hint="Get myMailSettings">
		<cfreturn instance.myMailSettings/>
	</cffunction>	
	<cffunction name="setmyMailSettings" access="public" output="false" returntype="void" hint="Set myMailSettings">
		<cfargument name="myMailSettings" type="any" required="true"/>
		<cfset instance.myMailSettings = arguments.myMailSettings/>
	</cffunction>			<cffunction name="myPrivateEvent" access="private" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var rc = Event.getCollection();		/* Private */		rc.privateEventCalled = true;		</cfscript>	</cffunction>	</cfcomponent>