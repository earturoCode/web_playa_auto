<%@ page session="true" %>
<%@ page language="java" import="java.sql.*"  %>

<jsp:useBean id="conexion" class="programas.bdconexion" scope="page" />
<jsp:useBean id="dataSource" class="programas.enviosentenciasql" scope="page"/>

<%
    // Crear objeto de conexion al DB
    Connection cn = conexion.crearConexion();
    // Asignar conexi�n al objeto manejador de datos
    dataSource.setConexion(cn);
    
    //parametros recibidos de gui_acceso y los guarda en variables
    String usu = request.getParameter("usuario") != null ? request.getParameter("usuario") : "";
    String cla = request.getParameter("clave") != null ? request.getParameter("clave") : "";   
    
    // Obtener o inicializar el contador de intentos fallidos para este usuario
    HttpSession sesion = request.getSession();
    String keyIntentos = "intentos_" + usu;
    Integer intentosFallidos = (Integer) sesion.getAttribute(keyIntentos);
    if (intentosFallidos == null) {
        intentosFallidos = 0;
    }
    
    // Verificar si el usuario ya est� bloqueado (3 o m�s intentos fallidos)
    if (intentosFallidos >= 3) {
        // Bloquear usuario en la base de datos si no est� ya bloqueado
        String sqlVerificarEstado = "SELECT usu_estado FROM usuarios WHERE usu_login = '" + usu + "'";
        ResultSet rsEstado = dataSource.obtenerDato(sqlVerificarEstado);
        
        if (rsEstado.next() && "activo".equals(rsEstado.getString("usu_estado"))) {
            // Cambiar estado a inactivo
            String sqlBloquear = "UPDATE usuarios SET usu_estado = 'inactivo' WHERE usu_login = '" + usu + "'";
            dataSource.actualizarDato(sqlBloquear);
        }
        
        if (rsEstado != null) rsEstado.close();
%>
<jsp:forward page="gui_acceso.jsp">
    <jsp:param name="error" value="Usuario bloqueado por exceso de intentos fallidos.<br>Contacte al administrador para reactivar su cuenta."/>
</jsp:forward>
<%    
        return;
    }
    
    // Intentar autenticaci�n
    String sql = "select usu_id,usu_nombre,usu_nivel,usu_estado from usuarios where usu_login = '" + usu + "' and usu_pass = '" + cla + "'";
    ResultSet rs = dataSource.obtenerDato(sql);
    
    boolean usuarioEncontrado = false;
    boolean estadoActivo = false;
    String estadoUsuario = "";
    
    if (rs.next()) {
        usuarioEncontrado = true;
        estadoUsuario = rs.getString("usu_estado");
        estadoActivo = "activo".equals(estadoUsuario);
        
        if (estadoActivo) {
            // Login exitoso - limpiar contador de intentos
            sesion.removeAttribute(keyIntentos);
            
            //variables para enviar a las diferentes paginas
            HttpSession sesionOk = request.getSession();
            sesionOk.setAttribute("usuario", rs.getString("usu_nombre"));
            sesionOk.setAttribute("nivel", rs.getString("usu_nivel")); 
            sesionOk.setAttribute("id", rs.getString("usu_id"));
            sesionOk.setAttribute("estado", "ok");
             
            response.sendRedirect("menuprincipal.jsp");
            return;
        }
    }
    
    // Si llegamos aqu�, la autenticaci�n fall�
    // Verificar si es por usuario/contrase�a incorrectos o por estado inactivo
    if (!usuarioEncontrado) {
        // Usuario no encontrado o contrase�a incorrecta
        intentosFallidos++;
        sesion.setAttribute(keyIntentos, intentosFallidos);
        
        String mensajeError;
        if (intentosFallidos >= 3) {
            // Bloquear usuario si existe
            String sqlExiste = "SELECT usu_login FROM usuarios WHERE usu_login = '" + usu + "'";
            ResultSet rsExiste = dataSource.obtenerDato(sqlExiste);
            if (rsExiste.next()) {
                String sqlBloquear = "UPDATE usuarios SET usu_estado = 'inactivo' WHERE usu_login = '" + usu + "'";
                dataSource.actualizarDato(sqlBloquear);
                mensajeError = "Usuario bloqueado por exceso de intentos fallidos.<br>Contacte al administrador.";
            } else {
                mensajeError = "Usuario y/o clave incorrectos.<br>Demasiados intentos fallidos.";
            }
            if (rsExiste != null) rsExiste.close();
        } else {
            int intentosRestantes = 3 - intentosFallidos;
            mensajeError = "Usuario y/o clave incorrectos.<br>Intentos restantes: " + intentosRestantes;
        }
%>
<jsp:forward page="gui_acceso.jsp">
    <jsp:param name="error" value="<%= mensajeError %>"/>
</jsp:forward>
<%    
    } else if (!estadoActivo) {
        // Usuario encontrado pero estado no activo
%>
<jsp:forward page="gui_acceso.jsp">
    <jsp:param name="error" value="Usuario inactivo o bloqueado.<br>Contacte al administrador para reactivar su cuenta."/>
</jsp:forward>
<%    
    }
    
    // Cerrar conexi�n
    try {
        if (rs != null) rs.close();
        if (cn != null) cn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>