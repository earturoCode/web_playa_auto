
<%@page import="programas.bdconexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="estetica/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="estetica/alertify.core.css">
        <link rel="stylesheet" type="text/css" href="estetica/alertify.default.css">
        <link rel="stylesheet" type="text/css" href="estetica/chosenselect.css">
        <title>.:: Listar Vendedores ::.</title>
        
        <%
            bdconexion bd = new bdconexion();
            bd.crearConexion();
            bd.listar_datos("SELECT * FROM vendedor");
            
         %>
    </head>

    <body>

    <center>
        <h1>:. VENDEDORES REGISTRADOS.:</h1>
        <br>
        <table border="0" width="60%">
            
            <tr>
                
                <td>
                    <a href="menuprincipal.jsp">
                        <input type="image" src="graficos/printer.png">
                        Volver a Menu Principal
                    </a> 
                </td>

                <td>
                    <a href="imprimir_cliente.jsp">
                        <input type="image" src="graficos/printer.png">
                        Imprimir Lista de Vendedores
                    </a> 
                </td>
            </tr>
        </table>
        
      <!--  <table border = "1" width="80%"> -->
            <div class="panel panel-success" id="panelBuscador">
                            <div class="panel-heading"><strong>Vendedores</strong></div>
                            <div class="panel-body">
                                
                                
                                <table class="table table-hover" id="grillabuscador">
                                    <thead>
                                        <tr class="warning">
            <tr> 
                <th>ID</th> 
                <th>Nombre</th> 
                <th>Apellido</th> 
                <th>C.I</th>  
                <th>Direccion</th>  
     
            </tr>
            <%
                try {
                    while (bd.rs.next()) {
                        out.println("<tr>");

                        out.println("<td>");
                        out.println(bd.rs.getString("ven_id"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("ven_nom"));
                        out.println("</td>");

                        out.println("<td>");
                        out.println(bd.rs.getString("ven_ape"));
                        out.println("</td>");
                       
                        out.println("<td>");
                        out.println(bd.rs.getString("ven_ci"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("ven_direcc"));
                        out.println("</td>");
                        
                                                
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    out.println(e);
                }

            %>

        </table>
    </center>
<script src="js/jquery-1.12.2.min.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/alertify.js"></script> 
<script src="js/chosenselect.js"></script> 
</body>

</html>
