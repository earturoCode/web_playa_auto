function agregar() 
{
    // Habilitar campos de entrada
    $("#cboUsuarios").removeAttr("disabled");
    $("#cboVendedores").removeAttr("disabled");
    $("#cboClientes").removeAttr("disabled");
    $("#cboAutos").removeAttr("disabled");
    $("#txtprecio").removeAttr("disabled");
    $("#cboMetodo").removeAttr("disabled");
    $("#txtfecha").removeAttr("disabled");
    $("#cboTipoClausula").removeAttr("disabled");
    $("#txtdescripcion").removeAttr("disabled");
    $("#btnAgregarClausula").removeAttr("disabled");
    $("#btnEliminarClausula").removeAttr("disabled");
    
    // Habilitar y deshabilitar botones  
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("1");
    
    // Limpiar los campos antes de solicitar código
    clear_text();
    
    // Solicitar código automático
    $.post("solicita_gencodigo", {campo: "con_id", tabla: "contrato"})
            .done(function (data) {
                $("#txtcodigo").val(data);
            });
    
    // Establecer fecha actual
    var now = new Date();
    var fechaActual = now.getFullYear() + '-' + 
                     String(now.getMonth() + 1).padStart(2, '0') + '-' + 
                     String(now.getDate()).padStart(2, '0') + 'T' + 
                     String(now.getHours()).padStart(2, '0') + ':' + 
                     String(now.getMinutes()).padStart(2, '0');
    $("#txtfecha").val(fechaActual);
    
    // Limpiar cláusulas
    $("#clausulasArray").val("[]");
    $("#tablaClausulas tbody").empty();
    actualizarTablaClausulas();
}

function modificar() 
{
    // Verificar si hay un registro seleccionado
    if ($("#txtcodigo").val() === "") {
        alertify.alert("Debe seleccionar un contrato para modificar");
        return;
    }
    
    // Habilitar campos de entrada para edición
    $("#cboUsuarios").removeAttr("disabled");
    $("#cboVendedores").removeAttr("disabled");
    $("#cboClientes").removeAttr("disabled");
    $("#cboAutos").removeAttr("disabled");
    $("#txtprecio").removeAttr("disabled");
    $("#cboMetodo").removeAttr("disabled");
    $("#txtfecha").removeAttr("disabled");
    $("#cboTipoClausula").removeAttr("disabled");
    $("#txtdescripcion").removeAttr("disabled");
    $("#btnAgregarClausula").removeAttr("disabled");
    $("#btnEliminarClausula").removeAttr("disabled");
    
    // Habilitar y deshabilitar botones
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("2");
    $("#txtprecio").select();
}

function borrar() 
{
    // Verificar si hay un registro seleccionado
    if ($("#txtcodigo").val() === "") {
        alertify.alert("Debe seleccionar un contrato para eliminar");
        return;
    }
    
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");
    
    $("#operacion").val("3");
    grabar();
}

function cancelar() 
{
    clear_text();
    // Deshabilitar campos de entrada
    $("#cboUsuarios").attr("disabled", "true");
    $("#cboVendedores").attr("disabled", "true");
    $("#cboClientes").attr("disabled", "true");
    $("#cboAutos").attr("disabled", "true");
    $("#txtprecio").attr("disabled", "true");
    $("#cboMetodo").attr("disabled", "true");
    $("#txtfecha").attr("disabled", "true");
    $("#cboTipoClausula").attr("disabled", "true");
    $("#txtdescripcion").attr("disabled", "true");
    $("#btnAgregarClausula").attr("disabled", "true");
    $("#btnEliminarClausula").attr("disabled", "true");
    
    // Restaurar botones
    $("#btnGrabar").attr("disabled", "true");
    $("#btnCancelar").attr("disabled", "true");
    $("#btnAgregar").removeAttr("disabled");
    $("#btnModificar").removeAttr("disabled");
    $("#btnBorrar").removeAttr("disabled");
    $("#btnSalir").removeAttr("disabled");
    
    get_datos("");
}

function clear_text()
{
    $("#txtcodigo").val("");
    $("#cboUsuarios").val("").prop('selectedIndex', 0);    // Resetear a primera opción (vacía)
    $("#cboVendedores").val("").prop('selectedIndex', 0);  // Resetear a primera opción (vacía)
    $("#cboClientes").val("").prop('selectedIndex', 0);    // Resetear a primera opción (vacía)
    $("#cboAutos").val("").prop('selectedIndex', 0);       // Resetear a primera opción (vacía)
    $("#txtprecio").val("");
    $("#cboMetodo").val("").prop('selectedIndex', 0);      // Resetear a primera opción (vacía)
    $("#txtfecha").val("");
    $("#cboTipoClausula").val("").prop('selectedIndex', 0); // Resetear a primera opción (vacía)
    $("#txtdescripcion").val("");
    $("#clausulasArray").val("[]");
    $("#clausulaEditandoIndice").val("");
    $("#tablaClausulas tbody").empty();
    
    // Resetear botón de cláusulas
    $("#btnAgregarClausula").text("Agregar Cláusula").removeClass("btn-warning").addClass("btn-info");
    
    actualizarTablaClausulas();
}

// NUEVA: Validar que no se pueda vender el mismo auto dos veces
function validarAutoDisponible() {
    var autoId = $("#cboAutos").val();
    var operacion = $("#operacion").val();
    
    if (operacion === "1" && autoId) { // Solo en agregar nuevo
        var autoTexto = $("#cboAutos option:selected").text();
        if (autoTexto.includes("(VENDIDO)") || autoTexto.includes("(NO DISPONIBLE)")) {
            alertify.alert("No se puede crear un contrato con un vehículo que ya está vendido o no disponible");
            return false;
        }
    }
    return true;
}

// NUEVA: Validar fecha no anterior a hoy
function validarFecha() {
    var fechaSeleccionada = new Date($("#txtfecha").val());
    var hoy = new Date();
    hoy.setHours(0, 0, 0, 0); // Solo comparar fechas, no horas
    
    if (fechaSeleccionada < hoy) {
        if (!confirm("La fecha seleccionada es anterior a hoy. ¿Desea continuar?")) {
            return false;
        }
    }
    return true;
}

// NUEVA: Validar precio
function validarPrecio() {
    var precio = parseFloat($("#txtprecio").val());
    if (isNaN(precio) || precio <= 0) {
        alertify.alert("El precio debe ser un número mayor a cero");
        return false;
    }
    if (precio > 1000000000) { // 1 billón como límite máximo
        alertify.alert("El precio ingresado es demasiado alto");
        return false;
    }
    return true;
}

function agregarClausula() {
    var tipoClausula = $("#cboTipoClausula").val();
    var descripcion = $.trim($("#txtdescripcion").val());
    var tipoTexto = $("#cboTipoClausula option:selected").text();
    var indiceEditando = $("#clausulaEditandoIndice").val();
    
    if (tipoClausula === "" || descripcion === "") {
        alertify.alert("Debe completar el tipo y descripción de la cláusula");
        return;
    }
    
    // Obtener array de cláusulas actual
    var clausulasArray = JSON.parse($("#clausulasArray").val() || "[]");
    
    // Verificar si estamos editando o agregando
    if (indiceEditando !== "" && indiceEditando >= 0) {
        // MODO EDICIÓN
        var indice = parseInt(indiceEditando);
        if (indice < clausulasArray.length) {
            clausulasArray[indice] = {
                tipo: tipoClausula,
                tipoTexto: tipoTexto,
                descripcion: descripcion
            };
            alertify.success("Cláusula actualizada correctamente");
        }
        
        // Resetear modo edición
        $("#clausulaEditandoIndice").val("");
        $("#btnAgregarClausula").text("Agregar Cláusula").removeClass("btn-warning").addClass("btn-info");
        
    } else {
        // MODO AGREGAR (normal)
        var nuevaClausula = {
            tipo: tipoClausula,
            tipoTexto: tipoTexto,
            descripcion: descripcion
        };
        
        clausulasArray.push(nuevaClausula);
        alertify.success("Cláusula agregada correctamente");
    }
    
    // Guardar array actualizado
    $("#clausulasArray").val(JSON.stringify(clausulasArray));
    
    // Actualizar tabla
    actualizarTablaClausulas();
    
    // Limpiar campos
    $("#cboTipoClausula").val("");
    $("#txtdescripcion").val("");
    
    // Quitar resaltado
    $("#tablaClausulas tbody tr").removeClass('table-warning');
}

function eliminarClausula() {
    var clausulasArray = JSON.parse($("#clausulasArray").val() || "[]");
    
    if (clausulasArray.length === 0) {
        alertify.alert("No hay cláusulas para eliminar");
        return;
    }
    
    // Eliminar la última cláusula
    clausulasArray.pop();
    
    // Guardar array actualizado
    $("#clausulasArray").val(JSON.stringify(clausulasArray));
    
    // Actualizar tabla
    actualizarTablaClausulas();
    
    alertify.success("Cláusula eliminada correctamente");
}

function actualizarTablaClausulas() {
    var clausulasArray = JSON.parse($("#clausulasArray").val() || "[]");
    var tbody = $("#tablaClausulas tbody");
    
    tbody.empty();
    
    if (clausulasArray.length === 0) {
        tbody.append("<tr><td colspan='3' class='text-center text-muted'>No hay cláusulas agregadas</td></tr>");
        return;
    }
    
    for (var i = 0; i < clausulasArray.length; i++) {
        var clausula = clausulasArray[i];
        var fila = "<tr class='clausula-row' style='cursor: pointer;' onclick='seleccionarClausula(" + i + ")'>" +
                   "<td><span class='badge badge-info'>" + clausula.tipoTexto + "</span></td>" +
                   "<td>" + clausula.descripcion + "</td>" +
                   "<td class='text-center'>" +
                   "<div class='btn-group'>" +
                   "<button type='button' class='btn btn-sm btn-warning' onclick='editarClausula(" + i + "); event.stopPropagation();' title='Editar'>" +
                   "<i class='glyphicon glyphicon-edit'></i>" +
                   "</button>" +
                   "<button type='button' class='btn btn-sm btn-danger' onclick='eliminarClausulaEspecifica(" + i + "); event.stopPropagation();' title='Eliminar'>" +
                   "<i class='glyphicon glyphicon-trash'></i>" +
                   "</button>" +
                   "</div>" +
                   "</td>" +
                   "</tr>";
        tbody.append(fila);
    }
}

function seleccionarClausula(indice) {
    var clausulasArray = JSON.parse($("#clausulasArray").val() || "[]");
    if (indice >= 0 && indice < clausulasArray.length) {
        var clausula = clausulasArray[indice];
        
        // Cargar datos en los campos de edición
        $("#cboTipoClausula").val(clausula.tipo);
        $("#txtdescripcion").val(clausula.descripcion);
        
        // Resaltar la fila seleccionada
        $("#tablaClausulas tbody tr").removeClass('table-warning');
        $("#tablaClausulas tbody tr").eq(indice).addClass('table-warning');
        
        alertify.success("Cláusula seleccionada para edición");
    }
}

function editarClausula(indice) {
    var clausulasArray = JSON.parse($("#clausulasArray").val() || "[]");
    if (indice >= 0 && indice < clausulasArray.length) {
        var clausula = clausulasArray[indice];
        
        // Cargar datos en los campos
        $("#cboTipoClausula").val(clausula.tipo);
        $("#txtdescripcion").val(clausula.descripcion);
        
        // Marcar que estamos editando
        $("#clausulaEditandoIndice").val(indice);
        
        // Cambiar el botón a "Actualizar"
        $("#btnAgregarClausula").text("Actualizar Cláusula").removeClass("btn-info").addClass("btn-warning");
        
        alertify.alert("Modo edición activado. Modifique los datos y presione 'Actualizar Cláusula'");
    }
}

function eliminarClausulaEspecifica(indice) {
    var clausulasArray = JSON.parse($("#clausulasArray").val() || "[]");
    
    // Eliminar cláusula específica
    clausulasArray.splice(indice, 1);
    
    // Guardar array actualizado
    $("#clausulasArray").val(JSON.stringify(clausulasArray));
    
    // Actualizar tabla
    actualizarTablaClausulas();
    
    alertify.success("Cláusula eliminada correctamente");
}

function manejarClausulas() {
    var contratoId = $("#txtcodigo").val();
    var clausulasArray = JSON.parse($("#clausulasArray").val() || "[]");
    
    // Primero eliminar todas las cláusulas existentes para este contrato
    var sqlDelete = "DELETE FROM clausulas WHERE con_id = " + contratoId;
    
    $.post("enviosqlBoot", {sql: sqlDelete, men: ""})
        .done(function() {
            // Luego insertar las nuevas cláusulas
            if (clausulasArray.length > 0) {
                var sqlInsert = "INSERT INTO clausulas (con_id, tip_id, cla_descrip) VALUES ";
                var valores = [];
                
                for (var i = 0; i < clausulasArray.length; i++) {
                    var clausula = clausulasArray[i];
                    valores.push("(" + contratoId + ", " + clausula.tipo + ", '" + clausula.descripcion.replace(/'/g, "''") + "')");
                }
                
                sqlInsert += valores.join(", ");
                
                $.post("enviosqlBoot", {sql: sqlInsert, men: ""})
                    .fail(function(xhr, status, error) {
                        alertify.alert("Error al guardar las cláusulas: " + error);
                    });
            }
        })
        .fail(function(xhr, status, error) {
            alertify.alert("Error al eliminar cláusulas anteriores: " + error);
        });
}

function grabar() 
{
    var usuario = $("#cboUsuarios").val();
    var vendedor = $("#cboVendedores").val();
    var cliente = $("#cboClientes").val();
    var auto = $("#cboAutos").val();
    var precio = $.trim($("#txtprecio").val());
    var metodo = $("#cboMetodo").val();
    var fecha = $("#txtfecha").val();

    if (usuario === "" || vendedor === "" || cliente === "" || auto === "" || 
        precio === "" || metodo === "" || fecha === "") 
    {
        alertify.alert('DEBES LLENAR TODOS LOS CAMPOS OBLIGATORIOS');
        return;
    }
    
    // VALIDACIONES MEJORADAS
    if (!validarPrecio()) return;
    if (!validarFecha()) return;
    if (!validarAutoDisponible()) return;
    
    var sql = "";
    var men = "";
    var conf = "";
    
    if ($("#operacion").val() === "1") // agregar
    {
        // Primero insertar el contrato
        sql = "INSERT INTO contrato(con_id, usu_id, ven_id, cli_id, aut_id, con_precio, con_metodo, con_fyh) VALUES(" + 
              $("#txtcodigo").val() + ", " + 
              usuario + ", " + 
              vendedor + ", " + 
              cliente + ", " + 
              auto + ", " + 
              precio + ", '" + 
              metodo + "', '" + 
              fecha + "')";
        conf = "¿DESEA GUARDAR EL NUEVO CONTRATO?";
        men = "EL CONTRATO FUE REGISTRADO CON ÉXITO";
    }
    
    if ($("#operacion").val() === "2") // editar
    {
        sql = "UPDATE contrato SET " + 
              "usu_id = " + usuario + ", " +
              "ven_id = " + vendedor + ", " +
              "cli_id = " + cliente + ", " +
              "aut_id = " + auto + ", " +
              "con_precio = " + precio + ", " +
              "con_metodo = '" + metodo + "', " +
              "con_fyh = '" + fecha + "' " +
              "WHERE con_id = " + $("#txtcodigo").val();
        conf = "¿DESEA MODIFICAR ESTE CONTRATO?";
        men = "EL CONTRATO FUE MODIFICADO CON ÉXITO";
    }
    
    if ($("#operacion").val() === "3") // borrar
    {
        conf = "¿DESEA ELIMINAR ESTE CONTRATO?";
        sql = "DELETE FROM contrato WHERE con_id = " + $("#txtcodigo").val();
        men = "EL CONTRATO FUE ELIMINADO CON ÉXITO";
    }
    
    alertify.confirm(conf, function (e) 
    {
        if (e) 
        {
            $.post("enviosqlBoot", {sql: sql, men: men})
                .done(function (data) {
                    // Si es una operación de agregar o modificar, también manejar las cláusulas
                    if ($("#operacion").val() === "1" || $("#operacion").val() === "2") {
                        manejarClausulas();
                    }
                    alertify.alert(data);
                    cancelar();
                })
                .fail(function(xhr, status, error) {
                    alertify.alert("Error al procesar la solicitud: " + error);
                });
        }
    });
}

function get_datos(filtro)
{
    var sql = "SELECT c.con_id, " +
              "u.usu_nombre, " +
              "CONCAT(v.ven_nom, ' ', v.ven_ape) as vendedor, " +
              "CONCAT(cli.cli_nom, ' ', cli.cli_ape) as cliente, " +
              "CONCAT(m.mar_nom, ' ', a.aut_modelo, ' - ', a.aut_placa) as vehiculo, " +
              "c.con_precio, " +
              "c.con_metodo, " +
              "c.con_fyh, " +
              "c.usu_id, c.ven_id, c.cli_id, c.aut_id " +
              "FROM contrato c " +
              "INNER JOIN usuarios u ON c.usu_id = u.usu_id " +
              "INNER JOIN vendedor v ON c.ven_id = v.ven_id " +
              "INNER JOIN cliente cli ON c.cli_id = cli.cli_id " +
              "INNER JOIN autos a ON c.aut_id = a.aut_id " +
              "INNER JOIN marcas m ON a.mar_id = m.mar_id " +
              "WHERE c.con_id LIKE '%" + filtro + "%' " +
              "OR u.usu_nombre LIKE '%" + filtro + "%' " +
              "OR CONCAT(v.ven_nom, ' ', v.ven_ape) LIKE '%" + filtro + "%' " +
              "OR CONCAT(cli.cli_nom, ' ', cli.cli_ape) LIKE '%" + filtro + "%' " +
              "OR a.aut_placa LIKE '%" + filtro + "%' " +
              "ORDER BY c.con_fyh DESC";

    $.post("extraer/get_contratos", {sql: sql})
        .done(function (data) {
            $("#grilla tbody").html(data);
        })
        .fail(function(xhr, status, error) {
            alertify.alert("Error al cargar los datos: " + error);
        });
}

function seleccion(parent) 
{
    // Obtener todas las celdas de la fila seleccionada
    var celdas = parent.find("td");
    
    // Asignar valores a los campos del formulario
    $("#txtcodigo").val($(celdas[0]).text().trim());           // ID contrato
    $("#txtprecio").val($(celdas[4]).text().trim().replace('$', '').replace(',', '').replace('.', ''));  // Precio (limpiar formato)
    $("#cboMetodo").val($(celdas[5]).text().trim());           // Método de pago
    
    // Formatear fecha para el input datetime-local
    var fechaTexto = $(celdas[6]).text().trim();              // Fecha
    if (fechaTexto && fechaTexto !== "N/A") {
        try {
            // Convertir de "2025-06-08 16:45" a "2025-06-08T16:45"
            var fechaFormatted = fechaTexto.replace(' ', 'T');
            $("#txtfecha").val(fechaFormatted);
        } catch (e) {
            console.log("Error formateando fecha:", e);
            $("#txtfecha").val('');
        }
    }
    
    // Campos ocultos
    $("#cboUsuarios").val($(celdas[7]).text().trim());        // usu_id
    $("#cboVendedores").val($(celdas[8]).text().trim());      // ven_id
    $("#cboClientes").val($(celdas[9]).text().trim());        // cli_id
    $("#cboAutos").val($(celdas[10]).text().trim());          // aut_id
    
    // Cargar cláusulas desde la base de datos
    cargarClausulasContrato($(celdas[0]).text().trim());
}

function cargarClausulasContrato(contratoId) {
    // USAR EL SERVLET EXISTENTE get_contratos
    $.post("extraer/get_contratos", {
        sql: "SELECT cl.tip_id, tc.tip_descrip, cl.cla_descrip FROM clausulas cl INNER JOIN tipo_condi tc ON cl.tip_id = tc.tip_id WHERE cl.con_id = " + contratoId
    })
    .done(function(data) {
        // Procesamiento del HTML recibido
        if (data && data.trim() !== "") {
            try {
                var $data = $(data);
                var $rows = $data.filter('tr').add($data.find('tr'));
                var clausulasArray = [];
                
                $rows.each(function() {
                    var $row = $(this);
                    var $cells = $row.find('td');
                    
                    if ($cells.length >= 3) {
                        var tipId = $cells.eq(0).text().trim();
                        var tipoTexto = $cells.eq(1).text().trim();
                        var descripcion = $cells.eq(2).text().trim();
                        
                        // Validar que los datos no estén vacíos
                        if (tipId && tipoTexto && descripcion && 
                            tipoTexto !== "Error" && descripcion !== "Error") {
                            clausulasArray.push({
                                tipo: tipId,
                                tipoTexto: tipoTexto,
                                descripcion: descripcion
                            });
                        }
                    }
                });
                
                $("#clausulasArray").val(JSON.stringify(clausulasArray));
                actualizarTablaClausulas();
                
                if (clausulasArray.length > 0) {
                    alertify.success("✅ Se cargaron " + clausulasArray.length + " cláusula(s)");
                }
                
            } catch (e) {
                console.error("Error procesando HTML:", e);
                $("#clausulasArray").val("[]");
                actualizarTablaClausulas();
            }
        } else {
            $("#clausulasArray").val("[]");
            actualizarTablaClausulas();
        }
    })
    .fail(function(xhr, status, error) {
        console.error("Error en petición:", status, error);
        alertify.alert("Error al cargar las cláusulas: " + error);
        $("#clausulasArray").val("[]");
        actualizarTablaClausulas();
    });
}

$(function () 
{
    // Limpiar campos al iniciar la página
    clear_text();
    
    // Cargar datos al iniciar
    get_datos("");
    
    // Agregar evento para buscar al presionar Enter en el campo de búsqueda
    $("#txtbuscador").keypress(function(e) {
        if(e.which == 13) { // Enter key
            get_datos($(this).val());
            $(this).val('');
        }
    });
    
    // Inicializar tabla de cláusulas
    actualizarTablaClausulas();
    
    console.log("📋 Sistema de contratos iniciado correctamente");
});