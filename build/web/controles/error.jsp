<%@ page language="java" isErrorPage="true" %>

<html>
<head>
  <title></title>
<link rel="stylesheet" href="css/estilos.css" type="text/css">
</head>
<body>
<h3>Error al procesar el requerimiento</h3>
Lo sentimos, pero a ocurrido un error al procesar su pedido.
<br>Por favor vuelva a intentarlo más tarde.<br>

<br>
<table class="FormularioTabla" width="100%" cellpadding="2" cellspacing="2">
  <tr>
    <td class="FormularioCabecera">
      Descripci&oacute;n del problema
    </td>
  </tr>
  <tr>
    <td class="FormularioTitulo">
      <%= exception.getMessage() %>
    </td>
  </tr>
</table>
</body>
</html>