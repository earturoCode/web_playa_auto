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
        
        <title>REGISTRAR AUTO</title>    
    </head>
    <body>
        <header>
            <h1>INGRESE LOS DATOS DEL NUEVO AUTO</h1>
        </header>
        
        <h1>Datos Del Auto</h1>
        <form action="sv_personales" method="POST">
            <p> <label> CODIGO </label>   <input type="text" name="cli_id" size=10  value="" /></p>
            <p> <label> MARCA </label>   <input type="text" name="cli_nom"  size=10  value="" /> <input type="text" name="cli_nom"  size=30  value="" /></p>
            <p> <label> MODELO </label> <input type="text" name="cli_ape" size=15  value=""/></p>
            <p> <label> COLOR </label>   <input type="text" name="cli_ci"  size=40  value="" /></p>
            <p> <label> VERSION </label> <input type="text" name="cli_direcc" size=15  value=""/></p>
            <p> <label> MOTOR </label>   <input type="text" name="cli_id" size=10  value="" /></p>
            <p> <label> SERIE </label>   <input type="text" name="cli_nom"  size=40  value="" /></p>
            <p> <label> PLACA </label> <input type="text" name="cli_ape" size=15  value=""/></p>
            <p> <label> KM </label>   <input type="text" name="cli_ci"  size=40  value="" /></p>
            <p> <label> ESTADO </label> <input type="text" name="cli_direcc" size=15  value=""/></p>
            <button  type="submit"> AGREGAR </button>
            <button  type="submit"> BORRAR </button>
            <button  type="submit"> GRABAR </button>
            <button  type="submit"> EDITAR </button>
            <button  type="submit"> CANCELAR </button>
            
        </form>
        <button  type="submit" > SALIR </button>
        
         <footer>
             <p>&copy; 2025 Arturo Fernandez . Todos los derechos reservados.</p>
        </footer>
        
    </body>
</html>
