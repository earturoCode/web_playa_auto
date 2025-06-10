// Function to enable fields for adding a new auto
function agregar() {
    $("#aut_modelo").removeAttr("disabled");
    $("#aut_color").removeAttr("disabled");
    $("#aut_versio").removeAttr("disabled");
    $("#aut_motor").removeAttr("disabled");
    $("#aut_serie").removeAttr("disabled");
    $("#aut_placa").removeAttr("disabled");
    $("#aut_km").removeAttr("disabled");
    $("#aut_estado").removeAttr("disabled");
    $("#cbomarca").removeAttr("disabled"); // Enable the brand dropdown

    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");

    $("#operacion").val("1"); // Set operation to "add"

    // Request a new auto ID from the server
    $.post("solicita_gencodigo", {campo: "aut_id", tabla: "autos"})
        .done(function (data) {
            $("#aut_id").val(data);
        });
}

// Function to enable fields for modifying an auto
function modificar() {
    $("#aut_modelo").removeAttr("disabled");
    $("#aut_color").removeAttr("disabled");
    $("#aut_versio").removeAttr("disabled");
    $("#aut_motor").removeAttr("disabled");
    $("#aut_serie").removeAttr("disabled");
    $("#aut_placa").removeAttr("disabled");
    $("#aut_km").removeAttr("disabled");
    $("#aut_estado").removeAttr("disabled");
    $("#cbomarca").removeAttr("disabled"); // Enable the brand dropdown

    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");

    $("#operacion").val("2"); // Set operation to "modify"
    $("#aut_modelo").select(); // Focus on the model field
}

// Function to handle deleting an auto
function borrar() {
    $("#btnGrabar").removeAttr("disabled");
    $("#btnCancelar").removeAttr("disabled");
    $("#btnAgregar").attr("disabled", "true");
    $("#btnModificar").attr("disabled", "true");
    $("#btnBorrar").attr("disabled", "true");
    $("#btnSalir").attr("disabled", "true");

    $("#operacion").val("3"); // Set operation to "delete"
    grabar(); // Call grabar to execute the delete
}

// Function to cancel the current operation and reset the form
function cancelar() {
    clear_text(); // Clear input fields

    $("#aut_modelo").attr("disabled", "true");
    $("#aut_color").attr("disabled", "true");
    $("#aut_versio").attr("disabled", "true");
    $("#aut_motor").attr("disabled", "true");
    $("#aut_serie").attr("disabled", "true");
    $("#aut_placa").attr("disabled", "true");
    $("#aut_km").attr("disabled", "true");
    $("#aut_estado").attr("disabled", "true");
    $("#cbomarca").attr("disabled", "true"); // Disable the brand dropdown

    $("#btnGrabar").attr("disabled", "true");
    $("#btnCancelar").attr("disabled", "true");
    $("#btnAgregar").removeAttr("disabled");
    $("#btnModificar").removeAttr("disabled");
    $("#btnBorrar").removeAttr("disabled");
    $("#btnSalir").removeAttr("disabled");

    get_datos(""); // Reload data in the grid
}

// Function to clear all input fields
function clear_text() {
    $("#aut_id").val("");
    $("#aut_modelo").val("");
    $("#aut_color").val("");
    $("#aut_versio").val("");
    $("#aut_motor").val("");
    $("#aut_serie").val("");
    $("#aut_placa").val("");
    $("#aut_km").val("");
    $("#aut_estado").val("");
    $("#cbomarca").val(""); // Clear the brand dropdown
}

// Function to save (insert, update, or delete) auto data
function grabar() {
    var modelo = $.trim($("#aut_modelo").val());
    var placa = $.trim($("#aut_placa").val());
    var marca = $("#cbomarca").val();

    if (modelo === "" || placa === "" || marca === null || marca === "") {
        alertify.alert('DEBES LLENAR TODOS LOS CAMPOS O SELECCIONAR UNA MARCA.');
    } else {
        var sql = "";
        var men = "";
        var conf = "";

        var aut_id = $("#aut_id").val();
        var mar_id = $("#cbomarca").val();
        var aut_modelo = "'" + modelo + "'";
        var aut_color = "'" + $.trim($("#aut_color").val()) + "'";
        var aut_versio = $("#aut_versio").val() === "" ? "NULL" : $("#aut_versio").val();
        var aut_motor = "'" + $.trim($("#aut_motor").val()) + "'";
        var aut_serie = "'" + $.trim($("#aut_serie").val()) + "'";
        var aut_placa_val = "'" + placa + "'";
        var aut_km = $("#aut_km").val() === "" ? 0 : $("#aut_km").val();
        var aut_estado = "'" + $.trim($("#aut_estado").val()) + "'";

        if ($("#operacion").val() === "1") { // Add operation
            sql = "INSERT INTO autos(aut_id, mar_id, aut_modelo, aut_color, aut_versio, aut_motor, aut_serie, aut_placa, aut_km, aut_estado) VALUES(" + aut_id + ", " + mar_id + ", " + aut_modelo + ", " + aut_color + ", " + aut_versio + ", " + aut_motor + ", " + aut_serie + ", " + aut_placa_val + ", " + aut_km + ", " + aut_estado + ")";
            conf = "¿DESEA GUARDAR EL NUEVO AUTO?";
            men = "EL AUTO FUE REGISTRADO CON ÉXITO";
        }

        if ($("#operacion").val() === "2") { // Modify operation
            sql = "UPDATE autos SET mar_id = " + mar_id + ", aut_modelo = " + aut_modelo + ", aut_color = " + aut_color + ", aut_versio = " + aut_versio + ", aut_motor = " + aut_motor + ", aut_serie = " + aut_serie + ", aut_placa = " + aut_placa_val + ", aut_km = " + aut_km + ", aut_estado = " + aut_estado + " WHERE aut_id = " + aut_id;
            conf = "¿DESEA MODIFICAR EL AUTO?";
            men = "EL AUTO FUE MODIFICADO CON ÉXITO";
        }

        if ($("#operacion").val() === "3") { // Delete operation
            conf = "¿DESEA ELIMINAR ESTE AUTO?";
            sql = "DELETE FROM autos WHERE aut_id = " + aut_id;
            men = "EL AUTO FUE ELIMINADO CON ÉXITO";
        }

        alertify.confirm(conf, function (e) {
            if (e) {
                $.post("enviosqlBoot", {sql: sql, men: men})
                    .done(function (data) {
                        alertify.alert(data);
                        cancelar();
                    });
            }
        });
    }
}

// Function to get auto data for the grid
function get_datos(filtro) {
    // Joining autos with marcas to display brand name
    var sql = "SELECT a.aut_id, m.mar_nom, a.aut_modelo, a.aut_color, a.aut_versio, a.aut_motor, a.aut_serie, a.aut_placa, a.aut_km, a.aut_estado, a.mar_id FROM autos a JOIN marcas m ON a.mar_id = m.mar_id WHERE a.aut_modelo LIKE '%" + filtro + "%' OR a.aut_placa LIKE '%" + filtro + "%' ORDER BY a.aut_id";
    $.post("extraer/get_autos", {sql: sql}) // Adjust the URL to your data retrieval endpoint
        .done(function (data) {
            $("#grilla tbody").html(data);
        });
}

// Function to populate form fields when a row in the grid is selected
function seleccion(parent) {
    parent.find("td").each(function (index) {
        if (index === 0) { // aut_id
            $("#aut_id").val($(this).text());
        }
        if (index === 2) { // aut_modelo (index 1 is mar_nom which is not an input text)
            $("#aut_modelo").val($(this).text());
        }
        if (index === 3) { // aut_color
            $("#aut_color").val($(this).text());
        }
        if (index === 4) { // aut_versio
            $("#aut_versio").val($(this).text());
        }
        if (index === 5) { // aut_motor
            $("#aut_motor").val($(this).text());
        }
        if (index === 6) { // aut_serie
            $("#aut_serie").val($(this).text());
        }
        if (index === 7) { // aut_placa
            $("#aut_placa").val($(this).text());
        }
        if (index === 8) { // aut_km
            $("#aut_km").val($(this).text());
        }
        if (index === 9) { // aut_estado
            $("#aut_estado").val($(this).text());
        }
        if (index === 10) { // mar_id (the hidden foreign key)
             $("#cbomarca").val(parseInt($(this).text())).trigger("chosen:updated");
        }
    });
}

// Initialize on document ready
$(function () {
    get_datos("");
});