<?xml version="1.0" encoding="ISO-8859-1"?><Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 	xsi:noNamespaceSchemaLocation="http://www.coldboxframework.com/schema/config_1.2.0.xsd">	<Settings>		<Setting name="AppName" 					value="BlogCFC Administrator"/>		<Setting name="AppMapping"					value="coldbox/samples/applications/blogcfcv5_0/admin" />		<Setting name="DebugMode" 					value="false" />		<Setting name="DebugPassword" 				value="coldbox"/>		<Setting name="EnableDumpVar"				value="true" />				<Setting name="EnableColdfusionLogging" 	value="false" />		<Setting name="EnableColdboxLogging" 		value="false" />		<Setting name="DefaultEvent" 				value="ehAdmin.dspHome"/>		<Setting name="RequestStartHandler" 		value="ehAdmin.onRequestStart"/>		<Setting name="RequestEndHandler"			value=""/>		<Setting name="ApplicationStartHandler" 	value="ehAdmin.onAppStart" />		<Setting name="OwnerEmail"					value="myemail@email.com" />		<Setting name="EnableBugReports" 			value="false"/>		<Setting name="UDFLibraryFile" 				value="../includes/udf.cfm" />		<Setting name="CustomErrorTemplate" 		value=""/>		<Setting name="ExceptionHandler" 			value=""/>		<Setting name="onInvalidEvent" 				value="ehAdmin.dspHome"/>		<Setting name="MessageboxStyleClass" 		value=""/>		<Setting name="HandlersIndexAutoReload" 	value="false"/>		<Setting name="ConfigAutoReload" 			value="false"/>		<Setting name="HandlerCaching"				value="true" />	</Settings>		<!-- Your own custom settings -->	<YourSettings >
		<Setting name="ParentMapping"				value="coldbox/samples/applications/blogcfcv5_0" />
	</YourSettings>		<!--Optional,if blank it will use the CFMX administrator settings.-->	<MailServerSettings>		<MailServer></MailServer>		<MailUsername></MailUsername>		<MailPassword></MailPassword>	</MailServerSettings>		<!--Emails to Send bug reports-->	<BugTracerReports>			</BugTracerReports>		<!--List url dev environments, this determines your dev/pro environment-->	<DevEnvironments>		<url>localhost</url>		<url>dev</url>		<url>lmajano</url>	</DevEnvironments>		<!--Webservice declarations your use in your app, if not use, leave blank		<WebServices></WebServices>	-->	<WebServices />		<Layouts>		<DefaultLayout>Layout.Main.cfm</DefaultLayout>	</Layouts>		<i18N>
		<DefaultResourceBundle>../includes/main</DefaultResourceBundle>		<DefaultLocale>en_US</DefaultLocale>		<LocaleStorage>session</LocaleStorage>
	</i18N>		</Config>