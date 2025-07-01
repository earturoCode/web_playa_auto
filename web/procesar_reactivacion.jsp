<%@ page session="true" %>
<%@ page language="java" import="java.sql.*"  %>
<%@ include file="controles/chequearsesion.jsp" %>

<jsp:useBean id="conexion" class="programas.bdconexion" scope="page" />
<jsp:useBean id="dataSource" class="programas.enviosentenciasql" scope="page"/>

<%
    String nivel = (String) sesionOk.getAttribute("nivel");
    
    // Solo administradores (nivel 1) pueden reactivar usuarios
    if (!"1".equals(nivel)) {
        response.sendRedirect("menuprincipal.jsp");
        return;
    }
    
    // Obtener el parámetro del usuario a reactivar
    String usuarioLogin = request.getParameter("usuario_login");
    
    if (usuarioLogin == null || usuarioLogin.trim().isEmpty()) {
%>
<jsp:forward page="gui_reactivar_usuario.jsp">
    <jsp:param name="error" value="Debe especificar un usuario para reactivar."/>
</jsp:forward>
<%
        return;
    }
    
    try {
        // Crear conexión
        Connection cn = conexion.crearConexion();
        dataSource.setConexion(cn);
        
        // Verificar si el usuario existe
        String sqlVerificar = "SELECT usu_id, usu_nombre, usu_estado FROM usuarios WHERE usu_login = ?";
        PreparedStatement psVerificar = cn.prepareStatement(sqlVerificar);
        psVerificar.setString(1, usuarioLogin.trim());
        ResultSet rs = psVerificar.executeQuery();
        
        if (rs.next()) {
            String estadoActual = rs.getString("usu_estado");
            String nombreUsuario = rs.getString("usu_nombre");
            
            if ("inactivo".equals(estadoActual)) {
                // Reactivar el usuario
                String sqlReactivar = "UPDATE usuarios SET usu_estado = 'activo' WHERE usu_login = ?";
                PreparedStatement psReactivar = cn.prepareStatement(sqlReactivar);
                psReactivar.setString(1, usuarioLogin.trim());
                int filasAfectadas = psReactivar.executeUpdate();
                
                if (filasAfectadas > 0) {
                    // Limpiar intentos fallidos de la sesión si existen
                    HttpSession sesion = request.getSession();
                    String keyIntentos = "intentos_" + usuarioLogin.trim();
                    sesion.removeAttribute(keyIntentos);
                    
                    psReactivar.close();
%>
<jsp:forward page="gui_reactivar_usuario.jsp">
    <jsp:param name="mensaje" value="Usuario '<%= nombreUsuario %>' (<%= usuarioLogin %>) reactivado exitosamente."/>
</jsp:forward>
<%
                } else {
%>
<jsp:forward page="gui_reactivar_usuario.jsp">
    <jsp:param name="error" value="No se pudo reactivar el usuario. Intente nuevamente."/>
</jsp:forward>
<%
                }
            } else if ("activo".equals(estadoActual)) {
%>
<jsp:forward page="gui_reactivar_usuario.jsp">
    <jsp:param name="error" value="El usuario '<%= nombreUsuario %>' ya está activo."/>
</jsp:forward>
<%
            } else {
%>
<jsp:forward page="gui_reactivar_usuario.jsp">
    <jsp:param name="error" value="El usuario '<%= nombreUsuario %>' tiene un estado no válido: <%= estadoActual %>."/>
</jsp:forward>
<%
            }
        } else {
%>
<jsp:forward page="gui_reactivar_usuario.jsp">
    <jsp:param name="error" value="No se encontró el usuario '<%= usuarioLogin %>'."/>
</jsp:forward>
<%
        }
        
        // Cerrar recursos
        rs.close();
        psVerificar.close();
        cn.close();
        
    } catch (Exception e) {
        e.printStackTrace();
%>
<jsp:forward page="gui_reactivar_usuario.jsp">
    <jsp:param name="error" value="Error del sistema: <%= e.getMessage() %>"/>
</jsp:forward>
<%
    }
%>