<%@ page session="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="controles/chequearsesion.jsp" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="programas.bdconexion" %>

<%
    String usuariodelacceso = (String) sesionOk.getAttribute("usuario");
    String nivel = (String) sesionOk.getAttribute("nivel");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MENU PLAYA DE AUTOS</title>
    <link rel="shortcut icon" href="graficos/checklist.png">
    
    <!-- CSS -->
    <link rel="stylesheet" href="estetica/bootstrap.min.css">
    <link rel="stylesheet" href="estetica/menuresponsive.css">
      <style>
    body {
      background: linear-gradient(to right, #cde9d4, #a0d1b4);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      height: 100vh;
      display: flex;
    }
    
    /* Estilos para el reloj */
    .reloj-container {
        color: white;
        font-weight: bold;
        font-size: 14px;
        margin-right: 15px;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
    }
    
    .fecha-actual {
        font-size: 11px;
        opacity: 0.9;
    }
    
    .hora-actual {
        font-size: 16px;
        font-family: 'Courier New', monospace;
    }
    
    @media (max-width: 768px) {
        .reloj-container {
            font-size: 12px;
            margin-right: 5px;
        }
        .hora-actual {
            font-size: 14px;
        }
    }
  </style>
</head>
<body>
    <div class="container">
        <header>
            <nav class="navbar" style="background-color: #0d7a34">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#menu" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="menuprincipal.jsp">
                            <img src="graficos/formenu.png" width="50" alt="Logo" />
                        </a>
                    </div>
                    <div class="collapse navbar-collapse" id="menu">
                        <!-- REFERENCIALES -->
                        <ul class="navbar-nav">
                            <li class="dropdown">
                                <a class="dropdown-toggle" href="#">
                                    <!-- <span class="glyphicon glyphicon-credit-card"></span> --> REFERENCIALES <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <% if ("1".equals(nivel)) { %>
                                    <li><a href="gui_regisclientes.jsp"><img src="graficos/Cliente.png" width="20" height="20" /> CLIENTES</a></li>
                                    <% } %>
                                    <li><a href="gui_regisvendedor.jsp"><img src="graficos/Vendedor.png" width="20" height="20" /> VENDEDORES</a></li>
                                    <li><a href="gui_regisauto.jsp"><img src="graficos/Auto.png" width="20" height="20" /> AUTOS</a></li>
                                </ul>
                            </li>
                        </ul>

                        <!-- GESTION DE VENTAS -->
                        <ul class="navbar-nav">
                            <li class="dropdown">
                                <a class="dropdown-toggle" href="#">
                                   <!-- <span class="glyphicon glyphicon-credit-card"></span> --> GESTION DE VENTAS <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <% if ("1".equals(nivel)) { %>
                                    <li><a href="gui_contrato.jsp"><img src="graficos/contract.png" width="20" height="20" />CONTRATOS</a></li>
                                    <% } %>
                                </ul>
                            </li>
                        </ul>

                        <!-- LISTADOS -->
                        <ul class="navbar-nav">
                            <li class="dropdown">
                                <a class="dropdown-toggle" href="#">
                                   <!--  <span class="glyphicon glyphicon-credit-card"></span> --> LISTADOS <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <% if ("1".equals(nivel)) { %>
                                    <li><a href="listar_clientes.jsp"><img src="graficos/listar_cliente.png" width="20" height="20" /> LISTAR CLIENTES</a></li>
                                    <% } %>
                                    <li><a href="listar_vendedor.jsp"><img src="graficos/listar_vendedor.png" width="20" height="20" /> LISTAR VENDEDORES</a></li>
                                    <li><a href="listar_autos.jsp"><img src="graficos/listar_autos.png" width="20" height="20" /> LISTAR AUTOS</a></li>
                                    <li><a href="listar_contrato.jsp"><img src="graficos/listar_contrato.png" width="20" height="20" /> LISTAR CONTRATOS</a></li>
                                </ul>
                            </li>
                        </ul>

                        <!-- AYUDA -->
                        <ul class="navbar-nav">
                            <li class="dropdown">
                                <a class="dropdown-toggle" href="#">
                                  <!--  <span class="glyphicon glyphicon-credit-card"></span> --> AYUDA <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="Playa_auto-Interactiva.chm" title="INTERACTIVA"><img src="graficos/Interactiva.png" width="20" height="20" /> Interactiva</a></li>
                                    <li><a href="Manual de Usuario.pdf" title="MANUAL"><img src="graficos/Manual.png" width="20" height="20" /> Manual</a></li>
                                </ul>
                            </li>
                        </ul>

                        <!-- RELOJ Y USUARIO -->
                        <ul class="nav navbar-nav navbar-right">
                            <!-- Reloj en tiempo real -->
                            <li class="navbar-text">
                                <div class="reloj-container">
                                    <div class="fecha-actual" id="fechaActual"></div>
                                    <div class="hora-actual" id="horaActual"></div>
                                </div>
                            </li>
                            
                            <!-- Usuario -->
                            <li class="dropdown">
                                <a class="dropdown-toggle" href="#">
                                     <%= usuariodelacceso %> <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="gui_acceso.jsp"><img src="graficos/Salir.png" width="20" height="20" /> SALIR</a></li>
                                    <% if ("1".equals(nivel)) { %>
                                    <li><a href="gui_signup.jsp"><img src="graficos/Crear_usuario.png" width="20" height="20" /> CREAR NUEVO USUARIO</a></li>
                                    <% } %>
                                </ul>
                            </li>
                        </ul>

                    </div>
                </div>
            </nav>
        </header>
    </div>

    <!-- JS -->
    <script src="js/jquery-1.12.2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/menuresponsive.js"></script>
    
    <!-- Script para el reloj en tiempo real -->
    <script>
        function actualizarReloj() {
            const ahora = new Date();
            
            // Formatear fecha
            const opcionesFecha = { 
                weekday: 'short', 
                year: 'numeric', 
                month: 'short', 
                day: 'numeric' 
            };
            const fechaFormateada = ahora.toLocaleDateString('es-PY', opcionesFecha);
            
            // Formatear hora
            const opcionesHora = { 
                hour: '2-digit', 
                minute: '2-digit', 
                second: '2-digit',
                hour12: false
            };
            const horaFormateada = ahora.toLocaleTimeString('es-PY', opcionesHora);
            
            // Actualizar elementos
            document.getElementById('fechaActual').textContent = fechaFormateada;
            document.getElementById('horaActual').textContent = horaFormateada;
        }
        
        // Actualizar cada segundo
        setInterval(actualizarReloj, 1000);
        
        // Ejecutar inmediatamente al cargar la página
        actualizarReloj();
    </script>
    
</body>
</html>