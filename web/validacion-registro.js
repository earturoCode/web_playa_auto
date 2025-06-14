// Validaciones para el formulario de registro
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('formRegistro');
    const nombre = document.getElementById('nombre');
    const login = document.getElementById('login');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const nivel = document.getElementById('nivel');

    // Validación del formulario al enviarlo
    form.addEventListener('submit', function(e) {
        if (!validarFormulario()) {
            e.preventDefault();
        }
    });

    // Validación en tiempo real para nombre
    nombre.addEventListener('input', function() {
        validarNombre();
    });

    // Validación en tiempo real para usuario
    login.addEventListener('input', function() {
        validarLogin();
    });

    // Validación en tiempo real para contraseña
    password.addEventListener('input', function() {
        validarPassword();
        // Re-validar confirmación si ya tiene contenido
        if (confirmPassword.value.length > 0) {
            validarConfirmPassword();
        }
    });

    // Validación en tiempo real para confirmar contraseña
    confirmPassword.addEventListener('input', function() {
        validarConfirmPassword();
    });

    function validarNombre() {
        const valor = nombre.value.trim();
        const regex = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/;
        
        if (valor.length === 0) {
            setInvalid(nombre, 'El nombre es obligatorio');
            return false;
        } else if (valor.length < 2) {
            setInvalid(nombre, 'El nombre debe tener al menos 2 caracteres');
            return false;
        } else if (valor.length > 20) {
            setInvalid(nombre, 'El nombre no puede exceder 20 caracteres');
            return false;
        } else if (!regex.test(valor)) {
            setInvalid(nombre, 'El nombre solo puede contener letras y espacios');
            return false;
        } else {
            setValid(nombre);
            return true;
        }
    }

    function validarLogin() {
        const valor = login.value.trim();
        const regex = /^[a-zA-Z0-9_]+$/;
        
        if (valor.length === 0) {
            setInvalid(login, 'El usuario es obligatorio');
            return false;
        } else if (valor.length < 3) {
            setInvalid(login, 'El usuario debe tener al menos 3 caracteres');
            return false;
        } else if (valor.length > 20) {
            setInvalid(login, 'El usuario no puede exceder 20 caracteres');
            return false;
        } else if (!regex.test(valor)) {
            setInvalid(login, 'El usuario solo puede contener letras, números y guiones bajos');
            return false;
        } else {
            setValid(login);
            return true;
        }
    }

    function validarPassword() {
        const valor = password.value;
        
        if (valor.length === 0) {
            setInvalid(password, 'La contraseña es obligatoria');
            return false;
        } else if (valor.length < 6) {
            setInvalid(password, 'La contraseña debe tener al menos 6 caracteres');
            return false;
        } else if (valor.length > 50) {
            setInvalid(password, 'La contraseña no puede exceder 50 caracteres');
            return false;
        } else {
            setValid(password);
            return true;
        }
    }

    function validarConfirmPassword() {
        const valor = confirmPassword.value;
        const passwordValor = password.value;
        
        if (valor.length === 0) {
            setInvalid(confirmPassword, 'Debe confirmar la contraseña');
            return false;
        } else if (valor !== passwordValor) {
            setInvalid(confirmPassword, 'Las contraseñas no coinciden');
            return false;
        } else {
            setValid(confirmPassword);
            return true;
        }
    }

    function validarNivel() {
        const valor = nivel.value;
        
        if (valor === '' || (valor !== '1' && valor !== '2')) {
            setInvalid(nivel, 'Debe seleccionar un tipo de usuario');
            return false;
        } else {
            setValid(nivel);
            return true;
        }
    }

    function validarFormulario() {
        const nombreValido = validarNombre();
        const loginValido = validarLogin();
        const passwordValido = validarPassword();
        const confirmPasswordValido = validarConfirmPassword();
        const nivelValido = validarNivel();

        return nombreValido && loginValido && passwordValido && confirmPasswordValido && nivelValido;
    }

    function setValid(element) {
        element.classList.remove('is-invalid');
        element.classList.add('is-valid');
        
        // Remover mensaje de error personalizado
        const feedback = element.parentNode.querySelector('.invalid-feedback');
        if (feedback) {
            feedback.remove();
        }
    }

    function setInvalid(element, message) {
        element.classList.remove('is-valid');
        element.classList.add('is-invalid');
        
        // Remover mensaje de error anterior
        const existingFeedback = element.parentNode.querySelector('.invalid-feedback');
        if (existingFeedback) {
            existingFeedback.remove();
        }
        
        // Agregar nuevo mensaje de error
        const feedback = document.createElement('div');
        feedback.classList.add('invalid-feedback');
        feedback.textContent = message;
        element.parentNode.appendChild(feedback);
    }

    // Limpiar validaciones visuales al cargar la página
    [nombre, login, password, confirmPassword, nivel].forEach(element => {
        element.classList.remove('is-valid', 'is-invalid');
    });
});