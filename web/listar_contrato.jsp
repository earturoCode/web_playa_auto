
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
        <title>.:: Listar Contratos ::.</title>
        
<%
    bdconexion bd = new bdconexion();
    bd.crearConexion();
    bd.listar_datos(
        "SELECT " +
        "  c.con_id AS ID_Contrato, " +
        "  CONCAT(v.ven_nom, ' ', v.ven_ape) AS Vendedor, " +
        "  CONCAT(cl.cli_nom, ' ', cl.cli_ape) AS Cliente, " +
        "  a.aut_modelo AS Auto, " +
        "  c.con_precio AS Precio " +
        "FROM contrato c " +
        "JOIN vendedor v ON c.ven_id = v.ven_id " +
        "JOIN cliente cl ON c.cli_id = cl.cli_id " +
        "JOIN autos a ON c.aut_id = a.aut_id"
    );
%>

    </head>

    <body>

    <center>
        <h1>:. CONTRATOS REGISTRADOS.:</h1>
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
                    <a href="imprimir_contrato.jsp">
                        <input type="image" src="graficos/imprimir.png">
                        Imprimir Lista de Contratos
                    </a> 
                </td>
            </tr>
        </table>
        
      <!--  <table border = "1" width="80%"> -->
            <div class="panel panel-success" id="panelBuscador">
                            <div class="panel-heading"><strong>Contratos</strong></div>
                            <div class="panel-body">
                                
                                
                                <table class="table table-hover" id="grillabuscador">
                                    <thead>
                                        <tr class="warning">
            <tr> 
                <th>Contrato</th> 
                <th>Vendedor</th> 
                <th>Cliente</th> 
                <th>Autos</th>  
                <th>Precio</th>  
     
            </tr>
<%
    try {
        while (bd.rs.next()) {
            out.println("<tr>");

            out.println("<td>");
            out.println(bd.rs.getString("ID_Contrato"));
            out.println("</td>");

            out.println("<td>");
            out.println(bd.rs.getString("Vendedor"));
            out.println("</td>");

            out.println("<td>");
            out.println(bd.rs.getString("Cliente"));
            out.println("</td>");

            out.println("<td>");
            out.println(bd.rs.getString("Auto"));
            out.println("</td>");

            out.println("<td>");
            out.println(bd.rs.getString("Precio"));
            out.println("</td>");

            out.println("</tr>");
        }
    } catch (Exception e) {
        out.println("Error al mostrar datos: " + e);
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
