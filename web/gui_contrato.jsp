<%@page import="programas.bdconexion"%>
<%@include file="controles/chequearsesion.jsp" %>
<%
    String vusuario = (String) sesionOk.getAttribute("usuario");
%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="imagenes/auto.png" rel="shortcut icon">
        
        <link rel="stylesheet" type="text/css" href="estetica/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="estetica/alertify.core.css">
        <link rel="stylesheet" type="text/css" href="estetica/alertify.default.css">
        
        <title>Registro de Contratos</title>
    </head>
    <body>
        <h1>Registro de Contratos</h1>
        <div class="container" style="padding-top: 15px;">
            <div class="row">
                <div class="col-md-12">

                    <form id="formulario" class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="codigo">ID Contrato</label> 
                            </div>
                            <div class="col-md-2">
                                <input type="text" name="txtcodigo" id="txtcodigo" class="form-control" placeholder="Autoincrementable" disabled/>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="usuario">Usuario</label> 
                            </div>
                            <div class="col-md-4">
                                <select class="form-control" id="cboUsuarios" disabled="">
                                    <option value="">Seleccione usuario</option>
                                    <%
                                        bdconexion cn = new bdconexion();
                                        cn.crearConexion();
                                        ResultSet usu = cn.consultar("select usu_id, usu_nombre from usuarios order by usu_nombre");
                                        while (usu.next()) {
                                    %>
                                    <option value="<%= usu.getString("usu_id") %>"><%= usu.getString("usu_nombre") %></option>
                                    <%
                                        }
                                    %>
                                </select>
                             </div>     
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="vendedor">Vendedor</label> 
                            </div>
                            <div class="col-md-4">
<select class="form-control" id="cboVendedores" disabled="">
    <option value="">Seleccione vendedor</option>
    <%
        ResultSet ven = cn.consultar("select ven_id, ven_nom from vendedor order by ven_nom");
        while (ven.next()) {
    %>
    <option value="<%= ven.getString("ven_id") %>"><%= ven.getString("ven_nom") %></option>
    <%
        }
    %>
</select>
                             </div>     
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="cliente">Cliente</label> 
                            </div>
                            <div class="col-md-4">
                            <select class="form-control" id="cboClientes" disabled="">
                                <option value="">Seleccione cliente</option>
                                <%
                                    ResultSet cli = cn.consultar("select cli_id, cli_nom from cliente order by cli_nom");
                                    while (cli.next()) {
                                %>
                                <option value="<%= cli.getString("cli_id") %>"><%= cli.getString("cli_nom") %></option>
                                <%
                                    }
                                %>
                            </select>
                             </div>     
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="auto">Vehículo</label> 
                            </div>
                            <div class="col-md-4">
                                <select class="form-control" id="cboAutos" disabled="">
                                    <option value="">Seleccione vehículo</option>
                                       <%
                                           ResultSet aut = cn.consultar("select a.aut_id, m.mar_nom, a.aut_modelo, a.aut_placa from autos a inner join marcas m on a.mar_id = m.mar_id order by m.mar_nom, a.aut_modelo");
                                           while (aut.next()) {
                                       %>
                                       <option value="<%= aut.getString("aut_id") %>"><%= aut.getString("mar_nom") %> <%= aut.getString("aut_modelo") %> - <%= aut.getString("aut_placa") %></option>
                                       <%
                                           }
                                       %>
                                 </select>
                             </div>     
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="precio">Precio</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="number" name="txtprecio" id="txtprecio" class="form-control" placeholder="Ingrese precio" disabled="" step="0.01"/>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="metodo">Método de Pago</label> 
                            </div>
                            <div class="col-md-4">
<select class="form-control" id="cboMetodo" disabled="">
    <option value="">Seleccione método</option>
    <option value="Efectivo">Efectivo</option>
    <option value="Transferencia">Transferencia</option>
    <option value="Tarjeta de Crédito">Tarjeta de Crédito</option>
    <option value="Cheque">Cheque</option>
    <option value="Financiamiento">Financiamiento</option>
</select>
                             </div>     
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="fecha">Fecha y Hora</label> 
                            </div>
                            <div class="col-md-4">
                                <input type="datetime-local" name="txtfecha" id="txtfecha" class="form-control" disabled=""/>
                            </div>
                        </div>
                        
                        <!-- Sección de Cláusulas -->
                        <div class="form-group">
                            <div class="col-md-12">
                                <hr>
                                <h3>Cláusulas del Contrato</h3>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="tipoclausula">Tipo de Cláusula</label> 
                            </div>
                            <div class="col-md-4">
                                <select class="form-control" id="cboTipoClausula" disabled="">
                                        <option value="">Seleccione el tipo de clausula</option>
                                       <%
                                           ResultSet tip = cn.consultar("select tip_id, tip_descrip from tipo_condi order by tip_descrip");
                                           while (tip.next()) {
                                       %>
                                       <option value="<%= tip.getString("tip_id") %>"><%= tip.getString("tip_descrip") %></option>
                                       <%
                                           }
                                       %>
                                 </select>
                             </div>     
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <label class="control-label" for="descripcion">Descripción</label> 
                            </div>
                            <div class="col-md-4">
                                <textarea name="txtdescripcion" id="txtdescripcion" class="form-control" placeholder="Ingrese descripción de la cláusula" rows="3" disabled=""></textarea>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-2">
                                <input id="btnAgregarClausula" type="button" class="form-control btn-info" value="Agregar Cláusula" disabled="" onclick="agregarClausula();"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnEliminarClausula" type="button" class="form-control btn-warning" value="Eliminar Cláusula" disabled="" onclick="eliminarClausula();"/>
                            </div>
                        </div>
                        
                        <!-- Tabla de Cláusulas -->
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-9">
                                <table class="table table-hover" id="tablaClausulas">
                                    <thead>
                                        <tr>
                                            <th class="info">Tipo</th>
                                            <th class="info">Descripción</th>
                                            <th class="info">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <!-- Botones principales -->
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
                        
                        <!-- Búsqueda -->
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-4">
                                <input type="text" name="txtbuscador" id="txtbuscador" class="form-control" placeholder="Ingrese datos a buscar"/>
                            </div>
                            <div class="col-md-2">
                                <input id="btnBuscar" type="button" class="form-control btn-primary" value="Buscar" onclick="get_datos($('#txtbuscador').val());$('#txtbuscador').val('');">
                            </div>
                        </div>
                        
                        <!-- Grilla de contratos -->
                        <div class="form-group">
                            <div class="col-md-3"></div>
                            <div class="col-md-9">
                                <table class="table table-hover" id="grilla">
                                    <thead>
                                        <tr>
                                            <th class="warning">ID</th>
                                            <th class="warning">Cliente</th>
                                            <th class="warning">Vendedor</th>
                                            <th class="warning">Vehículo</th>
                                            <th class="warning">Precio</th>
                                            <th class="warning">Método</th>
                                            <th class="warning">Fecha</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <input type="hidden" id="operacion"/>
                        <input type="hidden" id="clausulasArray" value="[]"/>
                        <input type="hidden" id="clausulaEditandoIndice" value=""/>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/jquery-1.12.2.min.js"></script> 
        <script src="js/bootstrap.min.js"></script> 
        <script src="js/alertify.js"></script> 
        
        <script src="sql_regiscontratos.js"></script>
    </body>
</html>