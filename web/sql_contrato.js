// Variables globales para manejar las cláusulas
var clausulasArray = [];
var clausulaSeleccionada = -1;

$(document).ready(function() {
    // Configurar fecha actual por defecto
    var now = new Date();
    var fechaFormateada = now.getFullYear() + '-' + 
                         String(now.getMonth() + 1).padStart(2, '0') + '-' + 
                         String(now.getDate()).padStart(2, '0') + 'T' + 
                         String(now.getHours()).padStart(2, '0') + ':' + 
                         String(now.getMinutes()).padStart(2, '0');
    $('#txtfecha').val(fechaFormateada);
    
    // Cargar datos iniciales
    get_datos('');
    
    // Event listener para selección de filas en la tabla de cláusulas
    $('#tablaClausulas tbody').on('click', 'tr', function() {
        clausulaSeleccionada = $(this).index();
        $('#tablaClausulas tbody tr').removeClass('active');
        $(this).addClass('active');
    });
});

// Función para agregar cláusula
function agregarClausula() {
    var tipoId = $('#cboTipoClausula').val();
    var tipoTexto = $('#cboTipoClausula option:selected').text();
    var descripcion = $('#txtdescripcion').val().trim();
    
    if (descripcion === '') {
        alertify.error('Debe ingresar una descripción para la cláusula');
        return;
    }
    
    // Verificar si ya existe una cláusula del mismo tipo
    var existeClausula = clausulasArray.some(function(clausula) {
        return clausula.tipo_id === tipoId;
    });
    
    if (existeClausula) {
        alertify.error('Ya existe una cláusula de este tipo');
        return;
    }
    
    // Agregar cláusula al array
    var nuevaClausula = {
        tipo_id: tipoId,
        tipo_texto: tipoTexto,
        descripcion: descripcion
    };
    
    clausulasArray.push(nuevaClausula);
    actualizarTablaClausulas();
    
    // Limpiar campos
    $('#txtdescripcion').val('');
    $('#cboTipoClausula').prop('selectedIndex', 0);
    
    alertify.success('Cláusula agregada correctamente');
}

// Función para eliminar cláusula
function eliminarClausula() {
    if (clausulaSeleccionada === -1) {
        alertify.error('Debe seleccionar una cláusula para eliminar');
        return;
    }
    
    clausulasArray.splice(clausulaSeleccionada, 1);
    actualizarTablaClausulas();
    clausulaSeleccionada = -1;
    
    alertify.success('Cláusula eliminada correctamente');
}

// Función para actualizar la tabla de cláusulas
function actualizarTablaClausulas() {
    var tbody = $('#tablaClausulas tbody');
    tbody.empty();
    
    clausulasArray.forEach(function(clausula, index) {
        var fila = '<tr>' +
                  '<td>' + clausula.tipo_texto + '</td>' +
                  '<td>' + clausula.descripcion + '</td>' +
                  '<td><button type="button" class="btn btn-sm btn-danger" onclick="eliminarClausulaDirecta(' + index + ')">Eliminar</button></td>' +
                  '</tr>';
        tbody.append(fila);
    });
    
    // Actualizar campo hidden
    $('#clausulasArray').val(JSON.stringify(clausulasArray));
}

// Función para eliminar cláusula directamente desde la tabla
function eliminarClausulaDirecta(index) {
    clausulasArray.splice(index, 1);
    actualizarTablaClausulas();
    alertify.success('Cláusula eliminada correctamente');
}

// Función para obtener datos
function get_datos(xbuscar) {
    $.ajax({
        data: { buscar: xbuscar },
        url: 'sql_contratos.jsp',
        type: 'post',
        beforeSend: function() {
            $("#grilla tbody").html('<tr><td colspan="7" class="text-center">Cargando...</td></tr>');
        },
        success: function(response) {
            $("#grilla tbody").html(response);
        },
        error: function() {
            alertify.error('Error al cargar los datos');
        }
    });
}

// Función para seleccionar una fila de la grilla
function seleccionar(con_id, usu_id, ven_id, cli_id, aut_id, precio, metodo, fecha) {
    $("#txtcodigo").val(con_id);
    $("#cboUsuarios").val(usu_id);
    $("#cboVendedores").val(ven_id);
    $("#cboClientes").val(cli_id);
    $("#cboAutos").val(aut_id);
    $("#txtprecio").val(precio);
    $("#cboMetodo").val(metodo);
    $("#txtfecha").val(fecha);
    
    // Cargar cláusulas del contrato
    cargarClausulas(con_id);
    
    // Activar botones de modificar y borrar
    $("#btnModificar").prop('disabled', false);
    $("#btnBorrar").prop('disabled', false);
    $("#btnAgregar").prop('disabled', true);
}

// Función para cargar cláusulas de un contrato
function cargarClausulas(con_id) {
    $.ajax({
        data: { con_id: con_id },
        url: 'sql_clausulas.jsp',
        type: 'post',
        success: function(response) {
            try {
                clausulasArray = JSON.parse(response);
                actualizarTablaClausulas();
            } catch (e) {
                clausulasArray = [];
                actualizarTablaClausulas();
            }
        },
        error: function() {
            alertify.error('Error al cargar las cláusulas');
        }
    });
}

// Función para agregar nuevo contrato
function agregar() {
    $("#operacion").val('1'); // 1 = agregar
    $("#txtcodigo").val('');
    
    // Limpiar todos los campos
    $("#cboUsuarios").prop('selectedIndex', 0);
    $("#cboVendedores").prop('selectedIndex', 0);
    $("#cboClientes").prop('selectedIndex', 0);
    $("#cboAutos").prop('selectedIndex', 0);
    $("#txtprecio").val('');
    $("#cboMetodo").prop('selectedIndex', 0);
    
    // Establecer fecha actual
    var now = new Date();
    var fechaFormateada = now.getFullYear() + '-' + 
                         String(now.getMonth() + 1).padStart(2, '0') + '-' + 
                         String(now.getDate()).padStart(2, '0') + 'T' + 
                         String(now.getHours()).padStart(2, '0') + ':' + 
                         String(now.getMinutes()).padStart(2, '0');
    $('#txtfecha').val(fechaFormateada);
    
    // Limpiar cláusulas
    clausulasArray = [];
    actualizarTablaClausulas();
    
    // Habilitar campos y botones
    habilitarCampos();
    $("#btnAgregar").prop('disabled', true);
    $("#btnModificar").prop('disabled', true);
    $("#btnBorrar").prop('disabled', true);
    $("#btnCancelar").prop('disabled', false);
    $("#btnGrabar").prop('disabled', false);
}

// Función para modificar contrato
function modificar() {
    if ($("#txtcodigo").val() === '') {
        alertify.error('Debe seleccionar un contrato para modificar');
        return;
    }
    
    $("#operacion").val('2'); // 2 = modificar
    
    // Habilitar campos
    habilitarCampos();
    $("#btnAgregar").prop('disabled', true);
    $("#btnModificar").prop('disabled', true);
    $("#btnBorrar").prop('disabled', true);
    $("#btnCancelar").prop('disabled', false);
    $("#btnGrabar").prop('disabled', false);
}

// Función para borrar contrato
function borrar() {
    if ($("#txtcodigo").val() === '') {
        alertify.error('Debe seleccionar un contrato para eliminar');
        return;
    }
    
    alertify.confirm('¿Está seguro de eliminar este contrato?', function(e) {
        if (e) {
            $("#operacion").val('3'); // 3 = borrar
            grabar();
        }
    });
}

// Función para cancelar operación
function cancelar() {
    // Limpiar campos
    $("#txtcodigo").val('');
    $("#cboUsuarios").prop('selectedIndex', 0);
    $("#cboVendedores").prop('selectedIndex', 0);
    $("#cboClientes").prop('selectedIndex', 0);
    $("#cboAutos").prop('selectedIndex', 0);
    $("#txtprecio").val('');
    $("#cboMetodo").prop('selectedIndex', 0);
    $("#txtfecha").val('');
    $("#txtdescripcion").val('');
    
    // Limpiar cláusulas
    clausulasArray = [];
    actualizarTablaClausulas();
    clausulaSeleccionada = -1;
    
    // Restablecer botones
    deshabilitarCampos();
    $("#btnAgregar").prop('disabled', false);
    $("#btnModificar").prop('disabled', true);
    $("#btnBorrar").prop('disabled', true);
    $("#btnCancelar").prop('disabled', true);
    $("#btnGrabar").prop('disabled', true);
}

// Función para grabar
function grabar() {
    // Validaciones
    if ($("#operacion").val() !== '3') { // Si no es borrar, validar campos
        if ($("#cboUsuarios").val() === '' || $("#cboVendedores").val() === '' || 
            $("#cboClientes").val() === '' || $("#cboAutos").val() === '' ||
            $("#txtprecio").val() === '' || $("#cboMetodo").val() === '' ||
            $("#txtfecha").val() === '') {
            alertify.error('Debe completar todos los campos obligatorios');
            return;
        }
        
        if (parseFloat($("#txtprecio").val()) <= 0) {
            alertify.error('El precio debe ser mayor a cero');
            return;
        }
    }
    
    // Preparar datos para enviar
    var datosContrato = {
        operacion: $("#operacion").val(),
        con_id: $("#txtcodigo").val(),
        usu_id: $("#cboUsuarios").val(),
        ven_id: $("#cboVendedores").val(),
        cli_id: $("#cboClientes").val(),
        aut_id: $("#cboAutos").val(),
        precio: $("#txtprecio").val(),
        metodo: $("#cboMetodo").val(),
        fecha: $("#txtfecha").val(),
        clausulas: JSON.stringify(clausulasArray)
    };
    
    $.ajax({
        data: datosContrato,
        url: 'sql_contratos_crud.jsp',
        type: 'post',
        beforeSend: function() {
            $("#btnGrabar").prop('disabled', true);
        },
        success: function(response) {
            response = response.trim();
            if (response === 'ok') {
                var mensaje = '';
                switch ($("#operacion").val()) {
                    case '1':
                        mensaje = 'Contrato agregado correctamente';
                        break;
                    case '2':
                        mensaje = 'Contrato modificado correctamente';
                        break;
                    case '3':
                        mensaje = 'Contrato eliminado correctamente';
                        break;
                }
                alertify.success(mensaje);
                cancelar();
                get_datos('');
            } else {
                alertify.error('Error: ' + response);
                $("#btnGrabar").prop('disabled', false);
            }
        },
        error: function() {
            alertify.error('Error en la comunicación con el servidor');
            $("#btnGrabar").prop('disabled', false);
        }
    });
}

// Función para habilitar campos
function habilitarCampos() {
    $("#cboUsuarios").prop('disabled', false);
    $("#cboVendedores").prop('disabled', false);
    $("#cboClientes").prop('disabled', false);
    $("#cboAutos").prop('disabled', false);
    $("#txtprecio").prop('disabled', false);
    $("#cboMetodo").prop('disabled', false);
    $("#txtfecha").prop('disabled', false);
    $("#cboTipoClausula").prop('disabled', false);
    $("#txtdescripcion").prop('disabled', false);
    $("#btnAgregarClausula").prop('disabled', false);
    $("#btnEliminarClausula").prop('disabled', false);
}

// Función para deshabilitar campos
function deshabilitarCampos() {
    $("#cboUsuarios").prop('disabled', true);
    $("#cboVendedores").prop('disabled', true);
    $("#cboClientes").prop('disabled', true);
    $("#cboAutos").prop('disabled', true);
    $("#txtprecio").prop('disabled', true);
    $("#cboMetodo").prop('disabled', true);
    $("#txtfecha").prop('disabled', true);
    $("#cboTipoClausula").prop('disabled', true);
    $("#txtdescripcion").prop('disabled', true);
    $("#btnAgregarClausula").prop('disabled', true);
    $("#btnEliminarClausula").prop('disabled', true);
}