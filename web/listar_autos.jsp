
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
        <title>.:: Listar Autos ::.</title>
        
        <%
            bdconexion bd = new bdconexion();
            bd.crearConexion();
            bd.listar_datos(
                "SELECT " +
                "  a.aut_id AS ID, " +
                "  m.mar_nom AS Marca, " +
                "  a.aut_modelo AS Modelo, " +
                "  a.aut_placa AS Placa, " +
                "  a.aut_estado AS Estado " +
                "FROM autos a " +
                "JOIN marcas m ON a.mar_id = m.mar_id"
            );            
         %>
    </head>

    <body>

    <center>
        <h1>:. AUTOS REGISTRADOS .:</h1>
        <br>
        <table border="0" width="60%">
            
            <tr>
                
                <td>
                    <a href="menuprincipal.jsp">
                        <input type="image" src="graficos/backMenu.png">
                        Volver a Menu Principal
                    </a> 
                </td>

                <td>
                    <a href="imprimir_autos.jsp">
                        <input type="image" src="graficos/imprimir.png">
                        Imprimir Lista de Autos
                    </a> 
                </td>
            </tr>
        </table>
        
      <!--  <table border = "1" width="80%"> -->
            <div class="panel panel-success" id="panelBuscador">
                            <div class="panel-heading"><strong>Autos</strong></div>
                            <div class="panel-body">
                                
                                
                                <table class="table table-hover" id="grillabuscador">
                                    <thead>
                                        <tr class="warning">
            <tr> 
                <th>ID</th> 
                <th>Marca</th> 
                <th>Modelo</th> 
                <th>Placa</th>  
                <th>Estado</th>  
     
            </tr>
            <%
                try {
                    while (bd.rs.next()) {
                        out.println("<tr>");

                        out.println("<td>");
                        out.println(bd.rs.getString("ID"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("Marca"));
                        out.println("</td>");

                        out.println("<td>");
                        out.println(bd.rs.getString("Modelo"));
                        out.println("</td>");
                       
                        out.println("<td>");
                        out.println(bd.rs.getString("Placa"));
                        out.println("</td>");
                        
                        out.println("<td>");
                        out.println(bd.rs.getString("Estado"));
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
