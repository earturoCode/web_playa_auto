<%@ page session="true" %>
<%@ page language="java" import="java.sql.*"  %>

<jsp:useBean id="conexion" class="programas.bdconexion" scope="page" />
<jsp:useBean id="dataSource" class="programas.enviosentenciasql" scope="page"/>

<%
    // Crear objeto de conexion al DB
    Connection cn = conexion.crearConexion();
    // Asignar conexin al objeto manejador de datos
    dataSource.setConexion(cn);
    
    //parametros recibidos de gui_acceso y los guarda en variables
    String usu = request.getParameter("usuario") != null ? request.getParameter("usuario") : "";
    String cla = request.getParameter("clave") != null ? request.getParameter("clave") : "";   
    //
    
    String sql = "select usu_id,usu_nombre,usu_nivel from usuarios where usu_login = '" + usu + "' and usu_pass = '" + cla + "' and usu_estado='ACTIVO'";
    ResultSet rs = dataSource.obtenerDato(sql);
    //si encuentra y contraseña es correcta y esta activo
    if (rs.next()) 
    {
        //variables para enviar a las diferentes paginas
       HttpSession sesionOk = request.getSession();
       sesionOk.setAttribute("usuario",rs.getString("usu_nombre"));
       sesionOk.setAttribute("nivel", rs.getString("usu_nivel")); 
         
        //response.sendRedirect("MenuPrincipal.jsp");// version 1
        
        response.sendRedirect("menuprincipal.jsp");// bootstrap
    } 
    else  //no encuentra, o pass esta mal o esta inactivo
    {
%>
<jsp:forward page="gui_acceso.jsp">
    <jsp:param name="error" value="Usuario y/o clave incorrectos.<br>Vuelve a intentarlo Tambien verifique el Estado del Usuario."/>
</jsp:forward>
<%    }
%>
