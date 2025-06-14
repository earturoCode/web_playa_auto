<%@page contentType="text/html; charset=iso-8859-1"
session="true" language="java" 
import="java.util.*,java.sql.*" %>

<%
    // Configuración de la base de datos
    String url = "jdbc:mysql://localhost:3306/tu_base_de_datos"; // Cambia por tu BD
    String username = "tu_usuario"; // Cambia por tu usuario
    String password_db = "tu_password"; // Cambia por tu password
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement checkStmt = null;
    ResultSet rs = null;
    
    try {
        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre");
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String nivel = request.getParameter("nivel");
        
        // Validaciones básicas
        if (nombre == null || nombre.trim().isEmpty() ||
            login == null || login.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty() ||
            nivel == null || nivel.trim().isEmpty()) {
            
            response.sendRedirect("registro.jsp?error=Todos los campos son obligatorios");
            return;
        }
        
        // Validar que las contraseñas coincidan
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("registro.jsp?error=Las contraseñas no coinciden");
            return;
        }
        
        // Validar longitud mínima de contraseña
        if (password.length() < 6) {
            response.sendRedirect("registro.jsp?error=La contraseña debe tener al menos 6 caracteres");
            return;
        }
        
        // Validar nivel de usuario
        if (!nivel.equals("1") && !nivel.equals("2")) {
            response.sendRedirect("registro.jsp?error=Tipo de usuario no válido");
            return;
        }
        
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password_db);
        
        // Verificar si el usuario ya existe
        String checkSql = "SELECT COUNT(*) FROM usuarios WHERE login = ?";
        checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, login.trim());
        rs = checkStmt.executeQuery();
        
        if (rs.next() && rs.getInt(1) > 0) {
            response.sendRedirect("registro.jsp?error=El nombre de usuario ya existe. Elija otro.");
            return;
        }
        
        // Insertar nuevo usuario
        String insertSql = "INSERT INTO usuarios (nombre, login, password, nivel) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertSql);
        pstmt.setString(1, nombre.trim());
        pstmt.setString(2, login.trim());
        pstmt.setString(3, password); // En producción, deberías encriptar la contraseña
        pstmt.setInt(4, Integer.parseInt(nivel));
        
        int rowsAffected = pstmt.executeUpdate();
        
        if (rowsAffected > 0) {
            response.sendRedirect("registro.jsp?success=Usuario registrado exitosamente. Ahora puede iniciar sesión.");
        } else {
            response.sendRedirect("registro.jsp?error=Error al registrar usuario. Intente nuevamente.");
        }
        
    } catch (ClassNotFoundException e) {
        response.sendRedirect("registro.jsp?error=Error de conexión: Driver no encontrado");
        e.printStackTrace();
    } catch (SQLException e) {
        response.sendRedirect("registro.jsp?error=Error de base de datos: " + e.getMessage());
        e.printStackTrace();
    } catch (NumberFormatException e) {
        response.sendRedirect("registro.jsp?error=Tipo de usuario no válido");
        e.printStackTrace();
    } catch (Exception e) {
        response.sendRedirect("registro.jsp?error=Error interno del servidor");
        e.printStackTrace();
    } finally {
        // Cerrar conexiones
        try {
            if (rs != null) rs.close();
            if (checkStmt != null) checkStmt.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>