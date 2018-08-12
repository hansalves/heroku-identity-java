<%@ page import="com.salesforce.saml.Identity,com.salesforce.util.Bag,java.util.Set,java.util.Iterator,java.util.ArrayList" %>
<%
String app = (String)request.getAttribute("app");
Identity identity = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
 for (Cookie cookie : cookies) {
   if (cookie.getName().equals("IDENTITY")) {
     identity = new Identity(cookie.getValue(),true);
    }
  }
}
%>

<html>
<head>
<link href="/css/style.css" rel="stylesheet" type="text/css">
</head>

<body>

<% if (identity != null ) { %>
<center>
<h2><%= identity.getSubject() %></h2>
<p><%= identity.getIdentityStr() %></p>
<table border="0" cellpadding="5">
<%
	Bag attributes = identity.getAttributes();
	Set keySet = attributes.keySet();
	Iterator iterator = keySet.iterator();
	while (iterator.hasNext()){
		String key = (String)iterator.next();
		%><tr><td><b><%= key %>:</b></td><td><%
		ArrayList<String> values = (ArrayList<String>)attributes.getValues(key);
		for (String value : values) {
			%><%= value %><br/><%
		}
		%></td></tr><%

	}

%>
</table>
<br>
<p>View the SAML response in the logs with <code>heroku logs -a <%= app %></code></p>
<a href="/_saml?logout=true" class="button center">Logout</a>
</center>
<% } else {  %>
 <div class="centered">
 <span class=""><a href="/_saml?RelayState=%2F" class="button center">Login</a></span>
 </div>

<% } %>


</body>
</html>