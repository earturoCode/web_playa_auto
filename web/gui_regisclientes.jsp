 <%@ page session="true" %>

<%@include  file="controles/chequearsesion.jsp" %>

<%
    String usuariodelacceso = (String) sesionOk.getAttribute("usuario");
    String nivel = (String) sesionOk.getAttribute("nivel");
 %>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="graficos/printer.png" rel="shortcut icon">
        
        <!-- Vincular el archivo CSS -->
        <link rel="stylesheet" type="text/css" href="estetica/decorado.css">
        
        <title>REGISTRAR CLIENTE</title>    
    </head>
    <body>
        <header>
            <h1>INGRESE LOS DATOS DEL NUEVO CLIENTE</h1>
        </header>
        
        <h1>Datos Del Cliente</h1>
        <form action="sv_personales" method="POST">
            <p> <label> RUC </label>   <input type="text" name="cli_id" size=10  value="" /></p>
            <p> <label> NOMBRE </label>   <input type="text" name="cli_nom"  size=40  value="" /></p>
            <p> <label> APELLIDO </label> <input type="text" name="cli_ape" size=15  value=""/></p>
            <p> <label> CI </label>   <input type="text" name="cli_ci"  size=40  value="" /></p>
            <p> <label> DIRECCION </label> <input type="text" name="cli_direcc" size=15  value=""/></p>
            <button  type="submit"> AGREGAR </button>
            <button  type="submit"> BORRAR </button>
            <button  type="submit"> GRABAR </button>
            <button  type="submit"> EDITAR </button>
            <button  type="submit"> CANCELAR </button>
            <button  type="submit"> SALIR </button>
        
        </form>
        
         <footer>
            <p>&copy; 2025 ARTURO FERNANDEZ</p>
        </footer>
        
    </body>
</html>
