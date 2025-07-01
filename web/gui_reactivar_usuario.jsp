<%@ page session="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="controles/chequearsesion.jsp" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="programas.bdconexion" %>

<%
    String usuariodelacceso = (String) sesionOk.getAttribute("usuario");
    String nivel = (String) sesionOk.getAttribute("nivel");
    
    // Solo administradores (nivel 1) pueden acceder
    if (!"1".equals(nivel)) {
        response.sendRedirect("menuprincipal.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reactivar Usuarios - PLAYA DE AUTOS</title>
    <link rel="shortcut icon" href="graficos/checklist.png">
    <link rel="stylesheet" href="estetica/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #cde9d4, #a0d1b4);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .panel {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .panel-heading {
            background-color: #0d7a34 !important;
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <img src="graficos/Crear_usuario.png" width="25" height="25" /> 
                            REACTIVAR USUARIOS BLOQUEADOS
                        </h3>
                    </div>
                    <div class="panel-body">
                        <!-- Mostrar mensaje si existe -->
                        <% 
                        String mensaje = request.getParameter("mensaje");
                        String error = request.getParameter("error");
                        if (mensaje != null && !mensaje.isEmpty()) { 
                        %>
                            <div class="alert alert-success">
                                <strong>Éxito:</strong> <%= mensaje %>
                            </div>
                        <% } %>
                        <% if (error != null && !error.isEmpty()) { %>
                            <div class="alert alert-danger">
                                <strong>Error:</strong> <%= error %>
                            </div>
                        <% } %>

                        <!-- Formulario para reactivar usuario -->
                        <form action="procesar_reactivacion.jsp" method="post" class="form-horizontal">
                            <div class="form-group">
                                <label for="usuario_login" class="col-sm-3 control-label">Usuario a reactivar:</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="usuario_login" name="usuario_login" 
                                           placeholder="Ingrese el login del usuario" required>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <button type="submit" class="btn btn-success">
                                        <span class="glyphicon glyphicon-ok"></span> Reactivar Usuario
                                    </button>
                                    <a href="menuprincipal.jsp" class="btn btn-default">
                                        <span class="glyphicon glyphicon-arrow-left"></span> Volver al Menú
                                    </a>
                                </div>
                            </div>
                        </form>

                        <!-- Listado de usuarios inactivos -->
                        <hr>
                        <h4>Usuarios Inactivos:</h4>
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr class="info">
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Login</th>
                                        <th>Nivel</th>
                                        <th>Estado</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    try {
                                        bdconexion conexion = new bdconexion();
                                        java.sql.Connection cn = conexion.crearConexion();
                                        programas.enviosentenciasql dataSource = new programas.enviosentenciasql();
                                        dataSource.setConexion(cn);
                                        
                                        String sql = "SELECT usu_id, usu_nombre, usu_login, usu_nivel, usu_estado " +
                                                    "FROM usuarios WHERE usu_estado = 'inactivo' ORDER BY usu_nombre";
                                        ResultSet rs = dataSource.obtenerDato(sql);
                                        
                                        boolean hayUsuarios = false;
                                        while (rs.next()) {
                                            hayUsuarios = true;
                                    %>
                                    <tr>
                                        <td><%= rs.getString("usu_id") %></td>
                                        <td><%= rs.getString("usu_nombre") %></td>
                                        <td><%= rs.getString("usu_login") %></td>
                                        <td><%= rs.getString("usu_nivel").equals("1") ? "Administrador" : "Usuario" %></td>
                                        <td><span class="label label-danger">Inactivo</span></td>
                                        <td>
                                            <a href="procesar_reactivacion.jsp?usuario_login=<%= rs.getString("usu_login") %>" 
                                               class="btn btn-sm btn-success"
                                               onclick="return confirm('¿Está seguro de reactivar el usuario <%= rs.getString("usu_login") %>?')">
                                                <span class="glyphicon glyphicon-ok"></span> Reactivar
                                            </a>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                        
                                        if (!hayUsuarios) {
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">
                                            No hay usuarios inactivos
                                        </td>
                                    </tr>
                                    <%
                                        }
                                        
                                        rs.close();
                                        cn.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center text-danger">
                                            Error al cargar los datos: <%= e.getMessage() %>
                                        </td>
                                    </tr>
                                    <%
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="js/jquery-1.12.2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>