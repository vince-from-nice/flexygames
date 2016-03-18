<div id="poweredIcons" style="text-align: center;">
    <a href="http://www.grails.org"><img style="border: 0" src="${createLinkTo(dir:'images',file:'powered/powered-by-grails.gif')}" alt="grails" /></a>
    <a href="http://groovy.codehaus.org"><img style="border: 0" src="${createLinkTo(dir:'images',file:'powered/powered-by-groovy.jpg')}" alt="groovy" /></a>
    <a href="http://tomcat.apache.org"><img style="border: 0" src="${createLinkTo(dir:'images',file:'powered/powered-by-tomcat.jpg')}" alt="tomcat" /></a>
    <a href="http://www.debian.org"><img style="border: 0" src="${createLinkTo(dir:'images',file:'powered/powered-by-debian.jpg')}" alt="debian" /></a>
</div>

<hr>
<div style="text-align: center">
    <br>
    <g:if test="${request.display == 'mobile'}">
        <g:message code="layout.flavourMobile" />
    </g:if>
    <g:else>
        <g:message code="layout.flavourDesktop" />
    </g:else>
</div>

<shiro:hasRole name="Administrator">
    <br>
    <hr>
    <br>
    <div style="text-align: center">
        <b>Page statistics :</b>
    <g:set var="now" value="${System.currentTimeMillis()}" />
    <g:set var="rt" value="${java.lang.Runtime.getRuntime()}" />
    It was rendered in ${now - timeBeforeController} ms
                        (controller: ${timeAfterController - timeBeforeController} ms
                        view: ${now - timeAfterController} ms) |
                        Memory: Used: <b>${(int)((rt.totalMemory() - rt.freeMemory())/1024)} kB</b> Free: <b>${(int)(rt.freeMemory()/1024)} kB</b>
    Total: <b>${(int)(rt.totalMemory()/1024)} kB</b> Max: <b>${(int)(rt.maxMemory()/1024)} kB</b> </small>
    </div>
    <br>
</shiro:hasRole>
