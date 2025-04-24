
<%@ page session="true" %>
<%
HttpSession sesionOk = request.getSession();
if (sesionOk.getAttribute("usuario") == null) 
{
%>
<jsp:forward page="gui_acceso.jsp">
<jsp:param name="error" value="INGRESE CORRECTAMENTE SUS CREDENCIALES"/>
</jsp:forward>
<%
}
%>

