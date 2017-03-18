<!doctype html>

<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->

	<head>
		<title><g:layoutTitle default="FlexyGames"/></title>
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="viewport" content="width=1280, initial-scale=1.0" />
		
		<!--  Avoid HTTP caching from clients (and proxies) -->
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'flexygames-icon-32x32.png')}" type="image/png" />
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'flexygames-icon-32x32.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'flexygames-icon-114x114.png')}" />

		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main-20160208.css')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile-20160208.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'flexygames-v4.css')}" />

		<g:javascript library="application"/>
		<!--g:javascript library="flexygames" /-->
		<script type="text/javascript" src="${resource(dir:'js',file:'flexygames-20160508.js')}"></script>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		
		<g:layoutHead/>
        <r:layoutResources />
	</head>
	
	<body onload="${pageProperty(name:'body.onload')}; ">
		<div id="mainPage">
			<div id="mainTop">
				<a href="${createLink(controller:'site', action:'home')}">
				  <img src="${resource(dir:'images',file:'flexygames-header-766x80.png')}" alt="Grails" border="0" />
				</a>
			</div>
			<div id="mainNav">
				<div class="block">
					<h3 style="margin-top: 0.2em"><g:message code="layout.mainMenu" /></h3>
					<ul>
						<li><g:link controller="site" action="home"><g:message code="mainMenu.home" /></g:link></li>
						<li><g:link controller="teams" action="list"><g:message code="mainMenu.teams" /></g:link></li>
						<li><g:link controller="sessions" action="list"><g:message code="mainMenu.sessions" /></g:link></li>
						<li><g:link controller="player" action="list"><g:message code="mainMenu.players" /></g:link></li>
						<li><g:link controller="playgrounds" action="list"><g:message code="mainMenu.playgrounds" /></g:link></li>
						<li><g:link controller="site" action="stats"><g:message code="mainMenu.stats" /></g:link></li>
						<li><g:link controller="site" action="tutorial"><g:message code="mainMenu.tutorial" /></g:link></li>
						<li><g:link controller="site" action="about"><g:message code="mainMenu.about" /></g:link></li>
						<li><g:link controller="site" action="contact"><g:message code="mainMenu.contact" /></g:link></li>
					</ul>
				</div>
				<g:render template="/layouts/logbox" />
				<br />
				<div class="block">
					<h3 style="margin-top: 0.2em"><g:message code="layout.whoIsOnline" /></h3>
					<g:if test="${request.onlineUsers != null}">
						<g:if test="${request.onlineUsers.size() < 2}">
							<g:message code="layout.whoIsOnline.text.onePlayer" args="[request.onlineUsers.size()]" />
						</g:if>
						<g:else>
							<g:message code="layout.whoIsOnline.text.multiPlayers" args="[request.onlineUsers.size()]" />
						</g:else>
						: 
						<ul>
						<g:each in="${request.onlineUsers}" var="user">
							<g:if test="${user != null}">
								<li><g:link controller="player" action="show" id="${user.id}">${user}</g:link></li>
							</g:if>
							<g:else>
								<li>${user}</li>
							</g:else>
						</g:each>
						</ul>
					</g:if>
					<g:else>
						<g:message code="layout.whoIsOnline.text.noPlayer" />
					</g:else>
				</div>
				<br /> <br />
				<shiro:hasRole name="Administrator">
					<div class="block">
						<h3 style="margin-top: 0.2em"><g:message code="layout.adminMenu" /></h3>
						<ul style="margin-left: 20px;">
							<!--li><g:link controller="admin" action="index"><g:message code="mainMenu.admin" default="Admin" /></g:link></li-->
							<g:each var="c" in="${grailsApplication.controllerClasses.sort { it.logicalPropertyName } }">
								<g:if test="${!(['assets', 'auth', 'dbdoc', 'site', 'sessions', 'stats', 'player', 'teams', 'playgrounds', 'manager', 'myself',
												 'fileUploader', 'fileUpload', 'download', 'openFileManagerConnector'].contains(c.logicalPropertyName))}">
									<li class="controller"><g:link controller="${c.logicalPropertyName}">${c.name}</g:link></li>
								</g:if>
							</g:each>
						</ul>
					</div>
				</shiro:hasRole>
			</div>
			<div id=mainBody>
				<a href="#top"></a>
				<g:layoutBody />
				<br />
				<hr>
				<br />
				<g:render template="/layouts/footer" />
			</div>
			<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
	        <r:layoutResources />
		</div>
	</body>
	
</html>
