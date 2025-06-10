<%@include file="controles/chequearsesion.jsp" %>
<%
    String vusuario = (String) sesionOk.getAttribute("usuario");
%>

<%@page import="programas.bdconexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="graficos/printer.png" rel="shortcut icon">

        <link rel="stylesheet" type="text/css" href="estetica/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="estetica/alertify.core.css">
        <link rel="stylesheet" type="text/css" href="estetica/alertify.default.css">
        
        <link rel="stylesheet" type="text/css" href="estetica/chosen.min.css">

        <title>Gestión de Autos</title>
    </head>
    <body>
        <h1>Gestión de Autos</h1>
        <div class="container" style="padding-top: 15px;">
            <div class="row">
                <div class="col-md-12">

                    <form id="formulario" class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_id">Código</label>
                            </div>
                            <div class="col-md-2">
                                <input type="text" name="aut_id" id="aut_id" class="form-control" placeholder="Autoincrementable" disabled/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="cbomarca">Marca</label>
                            </div>
                            <div class="col-md-4">
                                <select class="form-control chosen-select" id="cbomarca" disabled="">
                                    <%
                                        // Connect to the database and retrieve brands
                                        bdconexion cn = new bdconexion();
                                        cn.crearConexion();
                                        ResultSet marcas = cn.consultar("SELECT mar_id, mar_nom FROM marcas ORDER BY mar_nom");
                                        while (marcas.next()) {
                                    %>
                                    <option value="<%= marcas.getString("mar_id")%>"><%= marcas.getString("mar_nom")%></option>
                                    <%
                                        }
                                        // Close the connection
                                        marcas.close();
                                        cn.cerrarConexion();
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_modelo">Modelo</label>
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="aut_modelo" id="aut_modelo" class="form-control" placeholder="Ingrese modelo" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_color">Color</label>
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="aut_color" id="aut_color" class="form-control" placeholder="Ingrese color" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_versio">Versión</label>
                            </div>
                            <div class="col-md-4">
                                <input type="number" name="aut_versio" id="aut_versio" class="form-control" placeholder="Ingrese versión (año)" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_motor">Motor</label>
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="aut_motor" id="aut_motor" class="form-control" placeholder="Ingrese motor" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_serie">Serie</label>
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="aut_serie" id="aut_serie" class="form-control" placeholder="Ingrese número de serie" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_placa">Placa</label>
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="aut_placa" id="aut_placa" class="form-control" placeholder="Ingrese placa" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_km">Kilometraje</label>
                            </div>
                            <div class="col-md-4">
                                <input type="number" name="aut_km" id="aut_km" class="form-control" placeholder="Ingrese kilometraje" disabled=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="aut_estado">Estado</label>
                            </div>
                            <div class="col-md-4">
                                <input type="text" name="aut_estado" id="aut_estado" class="form-control" placeholder="Ingrese estado" disabled=""/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <input id="btnAgregar" type="button" class="form-control btn-primary" value="Agregar" onclick="agregar();"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnModificar" type="button" class="form-control btn-warning" value="Modificar" onclick="modificar();"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnBorrar" type="button" class="form-control btn-danger" value="Borrar" onclick="borrar();"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <input id="btnCancelar" type="button" class="form-control btn-info" value="Cancelar" disabled="" onclick="cancelar();"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnGrabar" type="button" class="form-control btn-success" value="Grabar" disabled="" onclick="grabar();"/>
                            </div>
                            <div class="col-md-2">
                                <a href="menuprincipal.jsp"><input id="btnSalir" type="button" class="form-control btn-default" value="Salir"></a>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-4">
                                <input type="text" name="txtbuscador" id="txtbuscador" class="form-control" placeholder="Buscar por Modelo o Placa"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnBuscar" type="button" class="form-control btn-primary" value="Buscar" onclick="get_datos($('#txtbuscador').val());$('#txtbuscador').val('');">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-6">
                                <table class="table table-hover" id="grilla">
                                    <thead>
                                        <tr>
                                            <th class="warning">Código</th>
                                            <th class="warning">Marca</th>
                                            <th class="warning">Modelo</th>
                                            <th class="warning">Color</th>
                                            <th class="warning">Versión</th>
                                            <th class="warning">Motor</th>
                                            <th class="warning">Serie</th>
                                            <th class="warning">Placa</th>
                                            <th class="warning">KM</th>
                                            <th class="warning">Estado</th>
                                            <th class="warning" style="display:none;">Marca ID</th> </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <input type="hidden" id="operacion"/>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/jquery-1.12.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/alertify.js"></script>
        <script src="js/chosen.jquery.min.js"></script>
        <script>
            // Initialize Chosen.js for the dropdown
            $(document).ready(function() {
                $(".chosen-select").chosen({no_results_text: "No se encontraron resultados para"});
            });
        </script>
        <script src="sql_autos.js"></script> </body>
</html>