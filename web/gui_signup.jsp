<%@page contentType="text/html; charset=iso-8859-1"
session="true" language="java" import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Registro de Usuario - Playa de Autos</title>
  <link rel="shortcut icon" href="graficos/llaves.png">
  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #cde9d4, #a0d1b4);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px 0;
    }
    .card {
      border-radius: 20px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }
    .avatar {
      width: 120px;
      border-radius: 50%;
    }
    .form-control:focus {
      border-color: #28a745;
      box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
    }
    .btn-success {
      background-color: #28a745;
      border-color: #28a745;
    }
    .btn-success:hover {
      background-color: #218838;
      border-color: #1e7e34;
    }
    .btn-outline-secondary:hover {
      background-color: #6c757d;
      border-color: #6c757d;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-6">
        <div class="card p-4">
          <div class="text-center">
            <img src="graficos/auto-splassh-unscreen.gif" alt="Logo" class="avatar mb-3">
            <h3 class="mb-4">Registro de Usuario</h3>
            <p class="text-muted">Playa De Autos 2.0</p>
          </div>
          
          <form action="sql_registro.jsp" method="post" id="formRegistro">
            <!-- Mostrar mensajes de error o éxito -->
            <div class="mb-3 text-center">
              <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                  <%= request.getParameter("error") %>
                </div>
              <% } %>
              <% if(request.getParameter("success") != null) { %>
                <div class="alert alert-success" role="alert">
                  <%= request.getParameter("success") %>
                </div>
              <% } %>
            </div>

            <!-- Nombre completo -->
            <div class="mb-3">
              <label for="nombre" class="form-label"><b>Nombre Completo</b></label>
              <input type="text" class="form-control" id="nombre" name="nombre" 
                     placeholder="Ingrese su nombre completo" maxlength="20" required>
            </div>

            <!-- Usuario/Login -->
            <div class="mb-3">
              <label for="login" class="form-label"><b>Usuario</b></label>
              <input type="text" class="form-control" id="login" name="login" 
                     placeholder="Ingrese nombre de usuario" maxlength="20" required>
              <div class="form-text">Este será su nombre de usuario para ingresar al sistema</div>
            </div>

            <!-- Contraseña -->
            <div class="mb-3">
              <label for="password" class="form-label"><b>Contraseña</b></label>
              <input type="password" class="form-control" id="password" name="password" 
                     placeholder="Ingrese su contraseña" minlength="6" required>
            </div>

            <!-- Confirmar contraseña -->
            <div class="mb-3">
              <label for="confirmPassword" class="form-label"><b>Confirmar Contraseña</b></label>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                     placeholder="Confirme su contraseña" minlength="6" required>
            </div>

            <!-- Nivel de usuario -->
            <div class="mb-3">
              <label for="nivel" class="form-label"><b>Tipo de Usuario</b></label>
              <select class="form-select" id="nivel" name="nivel" required>
                <option value="">Seleccione tipo de usuario</option>
                <option value="1">Administrador</option>
                <option value="2">Usuario Regular</option>
              </select>
            </div>

            <!-- Botones -->
            <div class="d-grid gap-2">
              <button type="submit" class="btn btn-success rounded-pill">
                <i class="fas fa-user-plus"></i> Registrar Usuario
              </button>
              <a href="gui_acceso.jsp" class="btn btn-outline-secondary rounded-pill">
                <i class="fas fa-arrow-left"></i> Volver al Login
              </a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- Script para validar contraseñas -->
  <script>
    document.getElementById('formRegistro').addEventListener('submit', function(e) {
      const password = document.getElementById('password').value;
      const confirmPassword = document.getElementById('confirmPassword').value;
      
      if (password !== confirmPassword) {
        e.preventDefault();
        alert('Las contraseñas no coinciden. Por favor, verifique.');
        document.getElementById('confirmPassword').focus();
      }
    });

    // Validación en tiempo real
    document.getElementById('confirmPassword').addEventListener('input', function() {
      const password = document.getElementById('password').value;
      const confirmPassword = this.value;
      
      if (password !== confirmPassword && confirmPassword.length > 0) {
        this.setCustomValidity('Las contraseñas no coinciden');
        this.classList.add('is-invalid');
      } else {
        this.setCustomValidity('');
        this.classList.remove('is-invalid');
      }
    });
  </script>
</body>
</html>