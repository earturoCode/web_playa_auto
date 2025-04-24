 <%@ page session="true" %>

<%@include  file="controles/chequearsesion.jsp" %>

<%
    String usuariodelacceso = (String) sesionOk.getAttribute("usuario");
    String nivel = (String) sesionOk.getAttribute("nivel");
 %>
 


<%@page import="java.sql.ResultSet"%>
<%@page import="programas.bdconexion"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MENU PLAYA DE AUTO</title>
        <link href="graficos/unidad.ico" rel="shortcut icon">
        
       <link rel="stylesheet" type="text/css" href="estetica/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="estetica/menuresponsive.css"/>
             
    </head>
    
    
    <body>
        <div class="container">
            <header>
                <nav class="navbar">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#menu"  aria-expanded="false">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="menuprincipal.jsp"><img src="graficos/auto-splassh-unscreen.gif" width="90px" height="50px"/></a>
                        </div>
                        <div class="collapse navbar-collapse" id="menu">
                            <ul class="navbar-nav"> 
                                <!-- MENU DE REFERENCIALES -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span>REFERENCIALES<b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                                                               
                                             <% if(nivel.equals("1")){ %> 
                                             <li><a href="gui_regisclientes.jsp">CLIENTES</a></li> 
                                                 <% } %> 

                                             <li><a href="gui_regisvendedor.jsp">VENDEDORES</a></li>  
                                             <li><a href="gui_regisauto.jsp">AUTOS</a></li> 
                                    </ul>
                                </li>                                                                     
                            </ul>
                            <ul class="navbar-nav"> 
                              
                                <!-- MENU VENTAS -->
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span>GESTION DE VENTAS<b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                                                               
                                            <% if(nivel.equals("1")){ %> 
                                            <li><a href="gui_contrato.jsp">CONTRATOS</a></li> 
                                                 <% } %> 
                                                                  
                                    </ul>
                                </li> 
                                                                                                
                            </ul>
        
                              <!-- MENU DE LISTAS -->
                              <ul class="navbar-nav"> 
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span> LISTADOS <b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                        
                                            <% if(nivel.equals("1")){ %> 
                                            <li><a href="listacliente.jsp">LISTAR CLIENTES</a></li> 
                                                 <% } %> 

                                            <li><a href="listavendedores.jsp">LISTAR VENDEDORES</a></li> 
                                            <li><a href="listaautos.jsp">LISTAR AUTOS</a></li> 
                                            <li><a href="listacontratos.jsp">LISTAR CONTRATOS</a></li> 
                                          
                                        
                                    </ul>
                                </li>
                              </ul>  
                              
         }
                              <!-- MENU DE AYUDA -->
                              <ul class="navbar-nav"> 
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#"><span class="glyphicon glyphicon-credit-card"></span> AYUDA <b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                         <li><a title="INTERACTIVA" href="interactiva.chm"><img src="imagenes/in.png" width="20px" height="20px" background-position="left"/>Interactiva</a></li> 
                                         <li><a title="MANUAL" href="manual.pdf"><img src="imagenes/i.png" width="20px" height="20px" background-position="left"/>Manual</a></li> 
                                    </ul>
                                </li>
                              </ul>  
                              
                              
                              
                             <!-- MENU DE USUARIO Y SALIR -->                      
                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" href="#">
                                        <span class="glyphicon glyphicon-user"></span> 
                                        <%= usuariodelacceso %>
                                        <b class="caret"></b>
                                    </a>
                                        <ul class="dropdown-menu">
                                               <li><a href="gui_acceso.jsp"><span class="glyphicon glyphicon-arrow-left"> SALIR</span> </a></li>
                                               <% if(nivel.equals("1")){ %> 
                                                <li><a href="gui_acceso.jsp"><span class="glyphicon glyphicon-arrow-left"> CREAR NUEVO USUARIO</span> </a></li>
                                                <% } %>
                                        </ul>
                                </li>
                            </ul>
                            
                        </div>
                    </div>
                </nav>
            </header>
            
            <!-- -->
        </div>
                                        
        <script src="js/jquery-1.12.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/menuresponsive.js"></script>
        
    </body>
</html>
